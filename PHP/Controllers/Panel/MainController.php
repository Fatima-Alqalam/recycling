<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\Crafter;
use App\Models\Customer;
use App\Models\Product;
use Illuminate\Http\Request;

class MainController extends Controller
{
    public function index()
    {
        $stats = [
            'mng'   => Admin::count(),
            'cus'   => Customer::count(),
            'crf'   => Crafter::count(),
            'pro'   => Product::count()
        ];
        return view('panel.main.index', compact('stats'));
    }

}
