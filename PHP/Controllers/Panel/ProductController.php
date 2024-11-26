<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use PDO;

class ProductController extends Controller
{
    // Display a listing of the resource.
    public function index(Request $request)
    {
        $items = Product::with('crafter');
        if($request->w){
            $items = $items->where('name', 'like', '%' . $request->w . '%');
        }
        $items = $items->get();
        return view('panel.product.index', compact('items'));
    }

    // Show the form for editing the specified resource.
    public function show(Product $product)
    {
        $item = $product;
        return view('panel.product.info', compact('product', 'item'));
    }

    // Remove the specified resource from storage.
    public function destroy(Product $product)
    {
        $product->delete();
        return redirect()->route('panel.product.index')->with('success', 'Success Action.');
    }
}
