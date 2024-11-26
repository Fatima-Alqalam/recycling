<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use ParagonIE\Sodium\Compat;
use PDO;

class CompanyController extends Controller
{
    // Display a listing of the resource.
    public function index()
    {
        $items = Company::all();
        return view('panel.company.index', compact('items'));
    }

    // Show the form for editing the specified resource.
    public function edit(Company $company)
    {
        $item = $company;
        return view('panel.company.update', compact('company', 'item'));
    }

    public function update(Company $company, Request $request)
    {
        $data = $request->validate([
            'name'      => 'required',
            'email'     => 'required|email',
            'phone'     => 'required|saudi_phone',
            'address'   => 'required',
            'plastic_recycling_capacity' => 'required|numeric',
        ]);
        $item = $company;
        $company->update($data);
        return redirect()->route('panel.companies.index')->with('success', 'Success Action.');

    }

}
