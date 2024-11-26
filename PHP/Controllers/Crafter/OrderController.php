<?php

namespace App\Http\Controllers\Crafter;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use PDO;

class OrderController extends Controller
{
    // Display a listing of the resource.
    public function index()
    {
        $items = auth('crafters')->user()->orders;
        return view('crafter.order.index', compact('items'));
    }

    // Show the form for editing the specified resource.
    public function show(Order $order)
    {
        $item = $order;
        return view('crafter.order.info', compact('order', 'item'));
    }

    public function changeStatus(Order $order, Request $request)
    {
        abort_if($order->crafter?->id != auth('crafters')->user()->id, 404);
        $item = $order;
        $order->update(['status' => $request->status]);
        return redirect()->back()->with('success', 'Success Action.');

    }
}
