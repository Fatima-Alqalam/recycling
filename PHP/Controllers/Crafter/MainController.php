<?php

namespace App\Http\Controllers\Crafter;

use App\Http\Controllers\Controller;
use App\Traits\UploadImages;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class MainController extends Controller
{
    use UploadImages;

    public function index()
    {
        $stats = [
            'orders'    => auth('crafters')->user()->orders->count(),
            'products'  => auth('crafters')->user()->products->count(),
            'cus'       => auth('crafters')->user()->orders()->distinct('customer_id')->count('customer_id')
        ];
        $orders = auth('crafters')->user()->orders()->take(5)->get();
        $ordersByDate = auth('crafters')->user()->orders()
            ->selectRaw('DATE(order_date) as date, COUNT(*) as count')
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // Extract dates and counts for chart data
        $dates = $ordersByDate->pluck('date')->toArray();
        $orderCounts = $ordersByDate->pluck('count')->toArray();

        return view('crafter.main.index', compact('stats', 'orders', 'dates', 'orderCounts'));
    }

    public function getProfile()
    {
        $user = auth('crafters')->user();
        return view('crafter.profile.update_data', compact('user'));
    }

    public function postProfile(Request $request)
    {
        $user = auth('crafters')->user();
        $data = $request->validate([
                'name'              => 'required|string|max:255',
                'email'             => 'required|string|email|max:255|unique:crafter,email,' . $user->id . ',id',
                'phone'             => 'required|saudi_phone|unique:crafter,phone,' . $user->id . ',id',
                'address'             => 'required',
            ]);

        $user->update($data);
        return redirect()->back()->with('success', 'Success Action');
    }

    public function getPassword()
    {
        $user = auth('crafters')->user();
        return view('crafter.profile.update_password', compact('user'));
    }

    public function postPassword(Request $request)
    {
        // Validate the old and new passwords
        $request->validate([
            'old_password' => 'required',
            'new_password' => 'required|min:8|confirmed', // Ensure new password has a confirmation field (new_password_confirmation)
        ]);

        $user = auth('crafters')->user(); // Get the currently authenticated user

        // Check if the old password matches the current password
        if (!Hash::check($request->old_password, $user->password)) {
            return back()->withInput()->withErrors(['old_password' => ['The old password does not match our records.']]);
        }

        // Update to the new password (hash it before saving)
        $user->password = Hash::make($request->new_password);
        $user->save();
        return redirect()->back()->with('success', 'Success Action');

    }

}
