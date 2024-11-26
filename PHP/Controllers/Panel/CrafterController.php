<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\Crafter;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use PDO;

class CrafterController extends Controller
{
    // Display a listing of the resource.
    public function index()
    {
        $items = Crafter::get();
        return view('panel.crafter.index', compact('items'));
    }

    // Show the form for creating a new resource.
    public function create()
    {
        return view('panel.crafter.new');
    }

    // Store a newly created resource in storage.
    public function store(Request $request)
    {
        $data = $request->validate([
                'name'          => 'required|string|max:255',
                'email'         => 'required|string|email|max:255|unique:crafter,email',
                'password'                  => 'required|string|min:8',
                'phone'         => 'required|numeric|saudi_phone|unique:crafter,phone',
                'address' => 'required'
            ]);

        $data['password']       = Hash::make($request->password);

        Crafter::create($data);

        return redirect()->route('panel.crafters.index')->with('success', 'Success Action.');
    }

    // Show the form for editing the specified resource.
    public function edit(Crafter $crafter)
    {
        $item = $crafter;
        return view('panel.crafter.update', compact('crafter', 'item'));
    }

    // Update the specified resource in storage.
    public function update(Request $request, Crafter $crafter)
    {
        $data = $request->validate([
                'name'        => 'required|string|max:255',
                'email'       => 'required|string|email|max:255|unique:crafter,email,' . $crafter->id . ',id',
                'password'          => 'nullable|string|min:8',
                'phone'       => 'required|numeric|saudi_phone|unique:crafter,phone,' . $crafter->id . ',id',
                'address' => 'required'
            ]);
        $data['password']       = $request->password ? Hash::make($request->password) : $crafter->password;
        $crafter->update($data);

        return redirect()->route('panel.crafters.index')->with('success', 'Success Action.');
    }

    // Remove the specified resource from storage.
    public function destroy(Crafter $crafter)
    {
        $crafter->delete();
        return redirect()->route('panel.crafters.index')->with('success', 'Success Action.');
    }
}
