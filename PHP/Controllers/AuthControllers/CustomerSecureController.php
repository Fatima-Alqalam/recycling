<?php

namespace App\Http\Controllers\AuthControllers;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use App\Traits\UploadImages;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class CustomerSecureController extends Controller
{
    use UploadImages;

    public function getLoginForm(Request $request)
    {
        $isAuth = true;
        return view('secure.customer.login', compact('isAuth'));
    }

    public function postLoginForm(Request $request)
    {
        $credentials = $request->validate([
            'email'         => ['required', 'email'],
            'password'      => ['required']
        ]);
        if (auth('customers')->attempt($credentials)) {
            $request->session()->regenerate();
//            session()->forget('cart');
            return redirect()->intended(route('customer.account'));
        }
        return back()->withInput()->withErrors(['email' => ['Email or Password not correct']]);
    }

    public function getRegisterForm(Request $request)
    {
        $isAuth = true;
        return view('secure.customer.register', compact('isAuth'));
    }

    public function postRegisterForm(Request $request)
    {
        $data = $request->validate([
            'name'              => 'required|string|max:255',
            'email'             => 'required|string|email|max:255|unique:customer,email',
            'password' => [
                'required',
                'string',
                'min:8',
                'confirmed',
                'regex:/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/',
            ],
            'phone'             => 'required|numeric|saudi_phone|unique:customer,phone',
            'address'             => 'required',
        ]);

        $data['password']       = Hash::make($request->password);
        $data['reward_points']       = 30;

        $user = Customer::create($data);
        $user->plasticCollections()->create(['quantity' => 30, 'collection_date' => date('Y-m-d')]);
        auth('customers')->login($user);
        session()->forget('cart');
        return redirect()->intended(route('customer.account'));
    }

    public function logout()
    {
        auth('customers')->logout();
        session()->forget('cart');
        return redirect(route('customer.login'));
    }
}
