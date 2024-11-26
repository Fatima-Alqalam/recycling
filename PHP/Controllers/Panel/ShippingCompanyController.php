<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\ShippingCompany;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use ParagonIE\Sodium\Compat;
use PDO;

class ShippingCompanyController extends Controller
{
    // Display a listing of the resource.
    public function index()
    {
        $items = ShippingCompany::all();
        return view('panel.shipping_company.index', compact('items'));
    }

    public function create()
    {
        return view('panel.shipping_company.new');
    }

    public function edit(ShippingCompany $shipping)
    {
        $item = $shipping;
        return view('panel.shipping_company.update', compact('shipping', 'item'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'company_name'      => 'required',
            'phone'     => 'required|saudi_phone|unique:shipping_company,phone',
            'address'   => 'required',
            'commercial_register'   => 'required|unique:shipping_company,commercial_register',
            'shipping_price' => 'required|numeric',
        ]);
        ShippingCompany::create($data);
        return redirect()->route('panel.shippings.index')->with('success', 'Success Action.');

    }

    public function update(ShippingCompany $shipping, Request $request)
    {
        $data = $request->validate([
            'company_name'      => 'required',
            'phone'     => 'required|saudi_phone|unique:shipping_company,phone,' . $shipping->id . ',id',
            'address'   => 'required',
            'commercial_register'   => 'required|unique:shipping_company,commercial_register,' . $shipping->id . ',id',
            'shipping_price' => 'required|numeric',
        ]);
        $shipping->update($data);
        return redirect()->route('panel.shippings.index')->with('success', 'Success Action.');

    }

    public function destroy(ShippingCompany $shipping, Request $request)
    {
        $shipping->delete();
        return redirect()->route('panel.shippings.index')->with('success', 'Success Action.');

    }

}
