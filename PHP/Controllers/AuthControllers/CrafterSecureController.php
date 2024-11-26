<?php

namespace App\Http\Controllers\AuthControllers;

use App\Http\Controllers\Controller;
use App\Models\Crafter;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class CrafterSecureController extends Controller
{
    public function getLoginForm(Request $request)
    {
        $isAuth = true;
        return view('secure.crafter.login', compact('isAuth'));
    }

    public function postLoginForm(Request $request)
    {
        $credentials = $request->validate([
            'email'         => ['required', 'email'],
            'password'      => ['required']
        ]);

        if (auth('crafters')->attempt($credentials)) {
            $request->session()->regenerate();

            return redirect()->intended(route('crafter.home'));
        }
        return back()->withInput()->withErrors(['email' => ['Email or Password not correct']]);
    }

    public function getRegisterForm(Request $request)
    {
        $isAuth = true;
        return view('secure.crafter.register', compact('isAuth'));
    }

    public function postRegisterForm(Request $request)
    {
        $data = $request->validate([
            'name'      => 'required|string|min:2|max:80',
            'email'     => 'required|email|unique:crafter,email',
            'password'  => 'required|string|confirmed|min:8',
            'address'     => 'required',
            'phone'     => 'required|numeric|saudi_phone|unique:crafter,phone' 
        ]);
        $data['password'] = Hash::make($data['password']);

        $user = Crafter::create($data);
        $user->revenue()->create(['system_share' => 0, 'crafter_share' => 0, 'total_revenue' => 0]);
        auth('crafters')->login($user);
        return redirect()->intended(route('crafter.home'));
    }

    public function logout()
    {
        auth('crafters')->logout();
        return redirect(route('crafter.login'));
    }
}
