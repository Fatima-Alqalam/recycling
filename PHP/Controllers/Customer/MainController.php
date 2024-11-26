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

class MainController extends Controller
{
   public function index()
   {
       session()->forget('reward_popup');

       $products = Product::withCount('orders')
      ->orderBy('orders_count', 'desc')
      ->take(6)
      ->get();
      return view('customer.main.index', compact('products'));
   }

   public function about()
   {
      return view('customer.internal_pages.about_us');
   }

   public function contact()
   {
      return view('customer.internal_pages.get_contact');
   }
}
