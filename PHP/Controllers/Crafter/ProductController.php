<?php

namespace App\Http\Controllers\Crafter;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Traits\UploadImages;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use PDO;

class ProductController extends Controller
{
    use UploadImages;

    // Display a listing of the resource.
    public function index(Request $request)
    {
        $items = auth('crafters')->user()->products();
        if($request->w){
            $items = $items->where('name', 'like', '%' . $request->w . '%');
        }
        $items = $items->get();
        return view('crafter.products.index', compact('items'));
    }

    // Show the form for creating a new resource.
    public function create()
    {
        return view('crafter.products.new');
    }

    // Store a newly created resource in storage.
    public function store(Request $request)
    {
        $data = $request->validate([
            'name'                      => 'required|string|max:255',
            'description'               => 'required',
            'plastic_type'              => 'required',
            'required_plastic_quantity' => 'required|numeric|min:1',
            'image'                     => 'nullable|image',
            'requirements'              => 'required|array',
            'requirements.*.quantity'   => 'required|numeric|min:1',
        ]);

        $totalQuantity = collect($request->requirements)->sum('quantity');

        if ($totalQuantity != $request->required_plastic_quantity) {
            return redirect()->back()
                ->withErrors(['required_plastic_quantity' => 'The required plastic quantity must equal the sum of the quantities in the requirements.'])
                ->withInput();
        }
        $data['price']  = 0;
        $data['image']  = $request->hasFile('image') && $request->image != null ? $this->upload($request->image) : null;
        $product = auth('crafters')->user()->products()->create($data);
        foreach ($request->requirements as $requirement) {
            $product->requirements()->create($requirement);
        }

        return redirect()->route('crafter.products.index')->with('success', 'Success Action.');
    }

    // Show the form for editing the specified resource.
    public function edit(Product $product)
    {
        abort_if($product->crafter_id != auth('crafters')->user()->id, 404);
        $item = $product;
        return view('crafter.products.update', compact('product', 'item'));
    }

    // Update the specified resource in storage.
    public function update(Request $request, Product $product)
    {
        abort_if($product->crafter_id != auth('crafters')->user()->id, 404);
        $data = $request->validate([
            'name'                          => 'required|string|max:255',
            'description'                   => 'required',
//            'plastic_type'                  => 'required',
            'required_plastic_quantity'     => 'required|numeric|min:1',
            'image'                         => 'nullable|image',
            'requirements'                  => 'required|array',
            'stock_quantity'                  => 'required|numeric|min:1',
            'requirements.*.quantity'       => 'required|numeric|min:1',
        ]);
        $totalQuantity = collect($request->requirements)->sum('quantity');

        if ($totalQuantity != $request->required_plastic_quantity) {
            return redirect()->back()
                ->withErrors(['required_plastic_quantity' => 'The required plastic quantity must equal the sum of the quantities in the requirements.'])
                ->withInput();
        }

        $data['image']  = $request->hasFile('image') && $request->image != null ? $this->upload($request->image) : $product->image;

        $product->update($data);
        $product->requirements()->delete();
        foreach ($request->requirements as $requirement) {
            $product->requirements()->create($requirement);
        }

        return redirect()->route('crafter.products.index')->with('success', 'Success Action.');
    }

    // Remove the specified resource from storage.
    public function destroy(Product $product)
    {
        $product->delete();
        return redirect()->route('crafter.products.index')->with('success', 'Success Action.');
    }
}
