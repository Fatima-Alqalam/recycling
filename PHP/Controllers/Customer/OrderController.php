<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Models\OrderProduct;
use App\Models\Product;
use App\Models\Revenue;
use App\Models\ShippingCompany;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Hash;
use Illuminate\Support\Facades\Cache;
use Mail;
use Illuminate\Support\Facades\DB;

class OrderController extends Controller
{
   public function index(Product $product, Request $request)
   {
      $user = auth('customers')->user();
      $companies = ShippingCompany::all();
      return view('customer.products.order', compact('user', 'product', 'companies'));
   }

    public function save(Request $request)
    {
        $user = auth('customers')->user();
        $cart = session()->get('cart', []); // Retrieve the cart from session
        $point = 30;
        $totalPlasticRequired = 0;
        $hasFreeProduct = false; // Flag to check if a free product is applied
        if (empty($cart)) {
            return redirect()->back()->with('fail', 'Your cart is empty.');
        }
        DB::beginTransaction();
        try {
            $isPickup = $request->company === 'pickup';
            $proID  = null;
            foreach ($cart as $item) {
                $proID = $item['id'];
                if ($user->reward_points >= 80 && !$hasFreeProduct) {
                    $hasFreeProduct = true; // Set flag so only one product is free
                    continue; // Skip adding this product's plastic requirement
                }
                $totalPlasticRequired += $item['required_plastic_quantity'] * $item['quantity'];
            }
            $pr = Product::find($proID);
            // Create a new order for the user
            $order = $user->orders()->create([
                'order_date'     => date('Y-m-d'),
                'status'         => $isPickup ? 'pickup' : 'shipping',
                'plactic_amount' => $totalPlasticRequired,
                'points_earned'  => $point,
                'crafter_id'  => $pr->crafter_id,
                'payment_status' => $isPickup ? 'not_required' : 'paid',
            ]);

            // If a shipping company is selected, create shipping and payment entries
            if (!$isPickup) {
                $company = ShippingCompany::find($request->company);
                if (!$company) {
                    return redirect()->back()->with('fail', 'Invalid shipping company.');
                }

                $order->payment()->create([
                    'amount'         => $company->shipping_price,
                    'payment_date'   => date('Y-m-d'),
                    'payment_method' => $request->paymentMethod,
                ]);

                $order->shipping()->create([
                    'shipping_company_id' => $company->id,
                    'shipping_date'       => date('Y-m-d'),
                    'delivery_date'       => Carbon::now()->endOfMonth()->toDateString(),
                    'address'             => $user->address,
                    'phone'               => $user->phone,
                    'email'               => $user->email,
                    'shipping_price'      => $company->shipping_price,
                ]);
            }

            // Process each item in the cart
            foreach ($cart as $item) {
                $product = Product::find($item['id']);
                if (!$product) {
                    return redirect()->back()->with('fail', 'One or more products are invalid.');
                }
                $rev = $product->crafter->revenue ?? $product->crafter->revenue()->create([
                    'system_share'   => 0,
                    'crafter_share'  => 0,
                    'total_revenue'  => 0,
                ]);

                $rev->update([
                    'system_share'  => $rev->system_share + 1,
                    'crafter_share' => $rev->crafter_share + ($item['required_plastic_quantity'] - 1),
                    'total_revenue' => $rev->total_revenue + $item['required_plastic_quantity'],
                ]);

                // Add the product as an order item
               OrderProduct::create([
                    'order_id'       => $order->id,
                    'product_id'       => $item['id'],
                    'quantity'       => $item['quantity'],
                    'plactic_amount' => $item['required_plastic_quantity'],
                ]);

                // Update user rewards and plastic collection
                $user->rewards()->create([
                    'reward_points'     => $point,
                    'reward_date'       => date('Y-m-d'),
                    'order_id' => $order->id,
                ]);
                $user->update([
                        'reward_points' => $user->reward_points + $point - ($hasFreeProduct ? 80 : 0)

                ]);
            }

            $user->plasticCollections()->update([
                'quantity'        => ($user->balance - $totalPlasticRequired),
                'collection_date' => date('Y-m-d'),
            ]);

            DB::commit();

            // Clear the cart after successful order
            session()->forget('cart');

            return redirect()->route('customer.account.orders')->with('success', 'Thank you for your order. Your order has been received.');

        } catch (\Throwable $th) {
            dd($th->getMessage());
            DB::rollback();
            return redirect()->back()->with('fail', 'Something went wrong.');
        }
    }

}
