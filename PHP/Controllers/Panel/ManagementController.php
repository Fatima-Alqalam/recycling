<?php

namespace App\Http\Controllers\Panel;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use PDO;

class ManagementController extends Controller
{
    // Display a listing of the resource.
    public function index()
    {
        $admins = Admin::get();
        return view('panel.management.index', compact('admins'));
    }

    // Show the form for creating a new resource.
    public function create()
    {
        return view('panel.management.new');
    }

    // Store a newly created resource in storage.
    public function store(Request $request)
    {
        $data = $request->validate([
            'name'        => 'required|string|max:255',
            'email'       => 'required|string|email|max:255|unique:admin,email',
            'password'          => 'required|string|min:8',
            'phone'       => 'required|numeric|saudi_phone|unique:admin,phone',
            'role'          => 'required'
        ]);

        $data['password'] = Hash::make($request->password);

        Admin::create($data);

        return redirect()->route('panel.admins.index')->with('success', 'Success Action.');
    }

    // Show the form for editing the specified resource.
    public function edit(Admin $admin)
    {
        $item = $admin;
        return view('panel.management.update', compact('admin', 'item'));
    }

    // Update the specified resource in storage.
    public function update(Request $request, Admin $admin)
    {
        $data = $request->validate([
            'name'        => 'required|string|max:255',
//            'email'       => 'required|string|email|max:255|unique:admin,email,' . $admin->id . ',id',
            'password'          => 'nullable|string|min:8',
//            'phone'       => 'required|numeric|saudi_phone|unique:admin,phone,' . $admin->id . ',id',
            'role'        => 'required'
        ]);
        $data['password'] = $request->password ? Hash::make($request->password) : $admin->password;
        $admin->update($data);

        return redirect()->back()->with('success', 'Success Action');
    }

    // Remove the specified resource from storage.
    public function destroy(Admin $admin)
    {
        abort_if(in_array($admin->id, [1]), 404);
        $admin->delete();
        return redirect()->route('panel.admins.index')->with('success', 'Success Action.');
    }
}
