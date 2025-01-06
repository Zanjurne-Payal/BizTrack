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

/**
 * Servlet implementation class incomeServlet2
 */
@WebServlet("/incomeServlet2")
public class incomeServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public incomeServlet2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		response.setContentType("application/json");
		try
		{
			Connection con = DBConnection.getConnection();
			if("add".equals(action))
			{
				String customer = request.getParameter("customer");
				double amount = Double.parseDouble(request.getParameter("amount"));
				String method= request.getParameter("method");
				String date = request.getParameter("date");
				
				String query = "INSERT INTO income (customer , amount ,  payment_method , date) Values (?, ?, ?, ?)";
				PreparedStatement pstm = con.prepareStatement(query);
				pstm.setString(1, customer);
				pstm.setBigDecimal(2, new java.math.BigDecimal(amount));
				pstm.setString(3, method);
				pstm.setDate(4, java.sql.Date.valueOf(date));
				pstm.executeUpdate();
				
				String query2 = "INSERT INTO transaction (type , amount , date) Values (?, ?, ?)";
				PreparedStatement pstm2 = con.prepareStatement(query2);
				pstm2.setString(1, "income");
				pstm2.setBigDecimal(2, new java.math.BigDecimal(amount));
				pstm2.setDate(3, java.sql.Date.valueOf(date));
				pstm2.executeUpdate();
				request.getRequestDispatcher("income.jsp").forward(request,response);
				
			}
			else if("read".equals(action))
			{
				String query = "SELECT * FROM income";
				PreparedStatement pstm = con.prepareStatement(query);
				ResultSet rs = pstm.executeQuery();
				ArrayList<Income> list = new ArrayList<>();
				while(rs.next())
				{
					Income in = new Income(); 
					in.setId(rs.getInt("id"));
					in.setCustomer(rs.getString("customer"));
					in.setAmount(rs.getDouble("amount"));
					in.setpayment_method(rs.getString("payment_method"));
					in.setDate(rs.getDate("date"));
					
					list.add(in);
				}
				
				request.setAttribute("list", list);
				request.getRequestDispatcher("income.jsp").forward(request,response);
			}
			else if("update".equals(action))
			{
				int id = Integer.parseInt(request.getParameter("id"));
				String customer = request.getParameter("customer");
				String amount = request.getParameter("amount");
				String method = request.getParameter("method");
				String date = request.getParameter("date");
				
				String query = "UPDATE income SET customer = ? , amount = ? , payment_method = ? , date = ? WHERE id = ?";
				
				PreparedStatement pstm = con.prepareStatement(query);
				pstm.setString(1, customer);
				pstm.setBigDecimal(2,new java.math.BigDecimal(amount));
				pstm.setString(3, method);
				pstm.setDate(4, java.sql.Date.valueOf(date));
				pstm.setInt(5, id);
				
				pstm.executeUpdate();
				request.getRequestDispatcher("income.jsp").forward(request,response);
				
			}
			else if("delete".equals(action))
			{
				String id = request.getParameter("id");
				String query = "DELETE from income WHERE id = ?";
				
				PreparedStatement pstm = con.prepareStatement(query);
				pstm.setInt(1, Integer.parseInt(id));
				
				pstm.executeUpdate();
				request.getRequestDispatcher("income.jsp").forward(request,response);
			}
			
			
		}catch(Exception e){
			e.printStackTrace();			
	  }
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
