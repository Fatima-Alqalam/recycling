<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\Crafter;
use App\Models\Customer;
use App\Models\Product;
use Illuminate\Http\Request;

class AllReportController extends Controller
{
    public function products()
    {
        $products =     Product::withCount('orders')
                        ->orderBy('orders_count', 'desc')
                        ->take(10)
                        ->get();
        $handle = ['names' => [], 'num' => [], 'colors' => []];
        foreach ($products as $key => $value) {
            $handle['names'][]  = $value->name;
            $handle['num'][]    = $value->orders_count;
            $handle['colors'][] = random_color();
        }
        return view('panel.numbers.report_product', compact('products', 'handle'));
    }

    public function customers()
    {
        $customers = Customer::withCount('orders')
        ->orderBy('orders_count', 'desc')
        ->limit(10) // Get top 10 customers
        ->get();
        $handle = ['names' => [], 'num' => [], 'colors' => []];
        foreach ($customers as $key => $value) {
            $handle['names'][]  = $value->name;
            $handle['num'][]    = $value->orders_count;
            $handle['colors'][] = random_color();
        }
        return view('panel.numbers.report_customer', compact('customers', 'handle'));
    }

}
