<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use PDO;

class CustomerController extends Controller
{
    // Display a listing of the resource.
    public function index()
    {
        $items = Customer::get();
        return view('panel.customer.index', compact('items'));
    }

    // Show the form for creating a new resource.
    public function create()
    {
        return view('panel.customer.new');
    }

    // Store a newly created resource in storage.
    public function store(Request $request)
    {
        $data = $request->validate([
                'name'              => 'required|string|max:255',
                'email'             => 'required|string|email|max:255|unique:customer,email',
                'password'                  => 'required|string|min:8',
                'phone'             => 'required|numeric|saudi_phone|unique:customer,phone',
                'address'             => 'required'
            ]);

        $data['password']       = Hash::make($request->password);

        Customer::create($data);

        return redirect()->route('panel.customers.index')->with('success', 'Success Action.');
    }

    // Show the form for editing the specified resource.
    public function edit(Customer $customer)
    {
        $item = $customer;
        return view('panel.customer.update', compact('customer', 'item'));
    }

    public function editBalance(Customer $customer)
    {
        $item = $customer;
        return view('panel.customer.balance', compact('customer', 'item'));
    }

    // Update the specified resource in storage.
    public function update(Request $request, Customer $customer)
    {
        $data = $request->validate([
                'name'        => 'required|string|max:255',
                'email'       => 'required|string|email|max:255|unique:customer,email,' . $customer->id . ',id',
                'password'          => 'nullable|string|min:8',
                'phone'       => 'required|numeric|saudi_phone|unique:customer,phone,' . $customer->id . ',id',
                'address'             => 'required',
            ]);
        
        $data['password']       = $request->password ? Hash::make($request->password) : $customer->password;

        $customer->update($data);

        return redirect()->route('panel.customers.index')->with('success', 'Success Action.');
    }

    public function updateBalance(Request $request, Customer $customer)
    {
        $data = $request->validate([
                'balance'        => 'required|integer',
            ]);
        

        $customer->plasticCollections()->update([
            'quantity'  => ($customer->balance + $request->balance),
            'collection_date'   => date('Y-m-d')
        ]);

        return redirect()->route('panel.customers.index')->with('success', 'Success Action.');
    }

    // Remove the specified resource from storage.
    public function destroy(Customer $customer)
    {
        $customer->delete();
        return redirect()->route('panel.customers.index')->with('success', 'Success Action.');
    }
}
