<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Hash;
use Illuminate\Support\Facades\Cache;
use Mail;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
   public function index(Request $request)
   {
      $items = Product::query();
      if($request->q){
         $items = $items->where('name', 'like', '%' . $request->q . '%');
      }
      if($request->plastic){
         $pp = explode('-', $request->plastic);
         $pf = isset($pp[0]) ? $pp[0] : 0;
         $pt = isset($pp[1]) ? $pp[1] : 0;
         $items = $pt ? $items->where('required_plastic_quantity', '>=', $pf)->where('required_plastic_quantity', '<=', $pt) : $items->where('required_plastic_quantity', '>=', $pf);
      }
      $items = $items->get();
      return view('customer.products.index', compact('items'));
   }

   public function product(Product $product)
   {
      $products = Product::where('id', '!=', $product->id)->inRandomOrder()->limit(7)->get();   
      return view('customer.products.single', compact('products', 'product'));
   }
}