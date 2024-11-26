<?php

namespace App\Http\Controllers\Crafter;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReportController extends Controller
{
    public function topProductsReport(Request $request)
    {
        $crafter = Auth::guard('crafters')->user();

        // Query to get top products with total quantity and revenue
        $query = $crafter->products()
            ->select('product.id', 'product.name')
            ->selectRaw('SUM(order_product.quantity) as total_quantity')
            ->selectRaw('SUM(order_product.plactic_amount * order_product.quantity) as total_revenue')
            ->join('order_product', 'product.id', '=', 'order_product.product_id')
            ->groupBy('product.id', 'product.name')
            ->orderByDesc('total_quantity');

        // Apply date filter if provided
        if ($request->has('start_date') && $request->has('end_date')) {
            $query->whereHas('orders', function ($q) use ($request) {
                $q->whereBetween('order_date', [$request->start_date, $request->end_date]);
            });
        }

        $topProducts = $query->get();

        return view('crafter.reports.top_products_report', compact('topProducts'));
    }

    public function monthlyRevenueReport(Request $request)
    {
        $crafter = Auth::guard('crafters')->user();

        // Query to get monthly revenue breakdown
        $query = $crafter->revenue()
            ->selectRaw('YEAR(order_date) as year, MONTH(order_date) as month')
            ->selectRaw('SUM(system_share) as total_system_share')
            ->selectRaw('SUM(crafter_share) as total_crafter_share')
            ->join('order', 'revenue.crafter_id', '=', 'order.crafter_id')
            ->groupBy('year', 'month')
            ->orderBy('year')
            ->orderBy('month');

        // Apply date filter if provided
        if ($request->has('start_date') && $request->has('end_date')) {
            $query->whereBetween('order_date', [$request->start_date, $request->end_date]);
        }

        $monthlyRevenues = $query->get();

        return view('crafter.reports.monthly_revenue_report', compact('monthlyRevenues'));
    }

}
