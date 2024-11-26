<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Hash;
use Illuminate\Support\Facades\Cache;
use Mail;
use Illuminate\Support\Facades\DB;

class AccountController extends Controller
{

   public function index()
   {
      $user = auth('customers')->user();
      return view('customer.profile.account', compact('user'));
   }

   public function updateData()
   {
      $user = auth('customers')->user();
      return view('customer.profile.info', compact('user'));
   }

   public function orders()
   {
      $user = auth('customers')->user();
      return view('customer.profile.order', compact('user'));
   }

   public function postProfile(Request $request)
    {
        $user = auth('customers')->user();
        $data = $request->validate([
          'name'        => 'required|string|max:255',
          'email'       => 'required|string|email|max:255|unique:customer,email,' . $user->id . ',id',
          'address'          => 'required',
          'phone'       => 'required|numeric|saudi_phone|unique:customer,phone,' . $user->id . ',id',
      ]);

      $user->update($data);
      return redirect()->back()->with('success', 'Your account info has been updated.');
    }

    public function getPassword()
    {
        $user = auth('customers')->user();
        return view('customer.profile.update_password', compact('user'));
    }

    public function postPassword(Request $request)
    {
        // Validate the old and new passwords
        $request->validate([
            'old_password' => 'required',
            'new_password' => 'required|min:8|confirmed', // Ensure new password has a confirmation field (new_password_confirmation)
        ]);

        $user = auth('customers')->user(); // Get the currently authenticated user

        // Check if the old password matches the current password
        if (!Hash::check($request->old_password, $user->password)) {
            return back()->withInput()->withErrors(['old_password' => ['The old password does not match our records.']]);
        }

        // Update to the new password (hash it before saving)
        $user->password = Hash::make($request->new_password);
        $user->save();
        return redirect()->back()->with('success', 'Your paassword has been changed.');

    }



    public function updateBalance(Request $request)
    {
        $request->validate([
            'quantity' => 'required|numeric|min:0',
        ]);

        $customer = auth('customers')->user();
        $customer->plasticCollections()->updateOrCreate(
            ['customer_id' => $customer->id],
            ['quantity' => $request->input('quantity'), 'collection_date' => now()]
        );

        return redirect()->back()->with('success', 'Balance updated successfully!');
    }


}
