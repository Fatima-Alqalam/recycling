<?php

namespace App\Http\Controllers\Panel;

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
        $items = Order::with(['customer'])->get();
        return view('panel.order.index', compact('items'));
    }

    // Show the form for editing the specified resource.
    public function show(Order $order)
    {
        $item = $order;
        return view('panel.order.info', compact('order', 'item'));
    }

    public function changeStatus(Order $order, Request $request)
    {
        $item = $order;
        $order->update(['status' => $request->status]);
        return redirect()->route('panel.orders.index')->with('success', 'Success Action.');

    }

    // Remove the specified resource from storage.
    public function destroy(Order $order)
    {
        $order->delete();
        return redirect()->route('panel.orders.index')->with('success', 'Success Action.');
    }
}
