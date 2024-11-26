<?php

namespace App\Http\Controllers\AuthControllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PanelLoginController extends Controller
{
    public function getForm(Request $request)
    {
        $isAuth = true;
        return view('secure.panel.login', compact('isAuth'));
    }

    public function postForm(Request $request)
    {
        $credentials = $request->validate([
            'email'         => ['required', 'email'],
            'password'      => ['required']
        ]);
        
        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();

            return redirect()->intended(route('panel.home'));
        }
        return back()->withInput()->withErrors(['email' => ['Email or Password not correct']]);
    }

    public function logout()
    {
        Auth::logout();
        return redirect(route('panel.login'));
    }
}
