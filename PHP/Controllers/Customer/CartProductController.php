<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\ShippingCompany;
use Illuminate\Http\Request;
use App\Models\Product;

class CartProductController extends Controller
{
    // Add product to cart
    public function addToCart(Request $request, $productId)
    {
        $cart = session()->get('cart', []);

        if (isset($cart[$productId])) {
            $cart[$productId]['quantity'] += $request->input('quantity', 1);
        } else {
            $product = Product::find($productId);
            if ($product) {
                $cart[$productId] = [
                    "id" => $product->id,
                    "name" => $product->name,
                    "quantity" => $request->input('quantity', 1),
                    "required_plastic_quantity" => $product->required_plastic_quantity, // Store grams required
                    "image" => $product->img,
                ];
            }
        }

        session()->put('cart', $cart);
        return redirect()->back()->with('success', 'Product added to cart successfully!');
    }


    // Remove product from cart
    public function removeFromCart($productId)
    {
        $cart = session()->get('cart', []);

        if (isset($cart[$productId])) {
            unset($cart[$productId]);
            session()->put('cart', $cart);
        }

        return redirect()->back()->with('success', 'Product removed from cart successfully!');
    }

    // Update cart
    public function updateCart(Request $request, $productId)
    {
        $cart = session()->get('cart', []);

        if (isset($cart[$productId])) {
            $cart[$productId]['quantity'] = $request->input('quantity', 1);
            session()->put('cart', $cart);
        }

        return redirect()->back()->with('success', 'Cart updated successfully!');
    }

    // Get all products from cart
    public function getCart()
    {
        $cart = session()->get('cart', []);
        $user = auth('customers')->user();
        $companies = ShippingCompany::all();
        return view('customer.products.order', compact('cart', 'user', 'companies'));
    }
}
