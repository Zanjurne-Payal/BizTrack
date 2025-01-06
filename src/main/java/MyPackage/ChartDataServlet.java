package MyPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

@WebServlet("/ChartDataServlet")
public class ChartDataServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Final JSON object to send combined data
        Map<String, Object> responseObject = new HashMap<>();

        // List for chart data
        List<Map<String, Object>> chartData = new ArrayList<>();

        // Variables for totals
        double totalIncome = 0.0;
        double totalExpense = 0.0;
        double balance = 0.0;

        try {
            // Database connection
          
            Connection conn  = DBConnection.getConnection();

            // Query for chart data (grouped by month)
            String chartQuery = "SELECT MONTH(date) as month, " +
                                "SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) as total_income, " +
                                "SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) as total_expense " +
                                "FROM transaction GROUP BY MONTH(date)";
            PreparedStatement psChart = conn.prepareStatement(chartQuery);
            ResultSet rsChart = psChart.executeQuery();

            while (rsChart.next()) {
                Map<String, Object> dataMap = new HashMap<>();
                dataMap.put("month", rsChart.getInt("month"));
                dataMap.put("total_income", rsChart.getDouble("total_income"));
                dataMap.put("total_expense", rsChart.getDouble("total_expense"));
                chartData.add(dataMap);
            }

            // Query for total income and expenses
            String totalQuery = "SELECT " +
                                "SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) AS total_income, " +
                                "SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) AS total_expense " +
                                "FROM transaction";
            PreparedStatement psTotal = conn.prepareStatement(totalQuery);
            ResultSet rsTotal = psTotal.executeQuery();

            if (rsTotal.next()) {
                totalIncome = rsTotal.getDouble("total_income");
                totalExpense = rsTotal.getDouble("total_expense");
                balance = totalIncome-totalExpense;
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Add chart data and totals to the final response object
        responseObject.put("chartData", chartData);
        responseObject.put("totalIncome", totalIncome);
        responseObject.put("totalExpense", totalExpense);
        responseObject.put("balance", balance);
        // Convert response object to JSON
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(responseObject);

        out.print(jsonResponse);
        out.flush();
   	}
}
