package MyPackage;

import jakarta.servlet.RequestDispatcher;
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
 * Servlet implementation class expensesServlet
 */
@WebServlet("/expensesServlet")
public class expensesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public expensesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		response.setContentType("application/json");
		try
		{
			Connection con = DBConnection.getConnection();;
			if("add".equals(action))
			{
				String expense = request.getParameter("expense");
				String catagory= request.getParameter("catagory");
				double amount = Double.parseDouble(request.getParameter("amount"));
				String date = request.getParameter("date");
				
				String query = "INSERT INTO expenses (expense, catagory, amount , date) Values (?, ?, ?, ?)";
				PreparedStatement pstm = con.prepareStatement(query);
				pstm.setString(1, expense);
				pstm.setString(2, catagory);
				pstm.setBigDecimal(3, new java.math.BigDecimal(amount));
				pstm.setDate(4, java.sql.Date.valueOf(date));
				pstm.executeUpdate();
				
				
				String query2 = "INSERT INTO transaction (type , amount , date) Values (?, ?, ?)";
				PreparedStatement pstm2 = con.prepareStatement(query2);
				pstm2.setString(1, "expense");
				pstm2.setBigDecimal(2, new java.math.BigDecimal(amount));
				pstm2.setDate(3, java.sql.Date.valueOf(date));
				pstm2.executeUpdate();
				
				request.getRequestDispatcher("expenses.jsp").forward(request,response);;
			}
			else if("read".equals(action))
			{
				String query = "SELECT * FROM expenses";
				PreparedStatement pstm = con.prepareStatement(query);
				ResultSet rs = pstm.executeQuery();
				ArrayList<expences> list = new ArrayList<>();
				while(rs.next())
				{
					expences ex = new expences(); 
					ex.setId(rs.getInt("id"));
					ex.setExpense(rs.getString("expense"));
					ex.setCatagory(rs.getString("catagory"));
					ex.setAmount(rs.getDouble("amount"));
					ex.setDate(rs.getDate("date"));
					
					list.add(ex);
				}
				request.setAttribute("AddMessage", "Expense Added Sucessfully!");
				request.setAttribute("list", list);
				request.getRequestDispatcher("expenses.jsp").forward(request,response);
			}
			else if("update".equals(action))
			{
				int id = Integer.parseInt(request.getParameter("id"));
				String expense = request.getParameter("expense");
				String catagory = request.getParameter("catagory");
				String amount = request.getParameter("amount");
				String date = request.getParameter("date");
				
				String query = "UPDATE expenses SET expense = ? , catagory = ? , amount = ? , date = ? WHERE id = ?";
				
				PreparedStatement pstm = con.prepareStatement(query);
				pstm.setString(1, expense);
				pstm.setString(2, catagory);
				pstm.setBigDecimal(3,new java.math.BigDecimal(amount));
				pstm.setDate(4, java.sql.Date.valueOf(date));
				pstm.setInt(5, id);
				
				pstm.executeUpdate();
				request.setAttribute("UpdateMessage", "Expense Updated Sucessfully!");
				request.getRequestDispatcher("expenses.jsp").forward(request,response);
			}
			else if("delete".equals(action))
			{
				String id = request.getParameter("id");
				String query = "DELETE from expenses WHERE id = ?";
				
				PreparedStatement pstm = con.prepareStatement(query);
				pstm.setInt(1, Integer.parseInt(id));
				
				pstm.executeUpdate();
				request.setAttribute("DeleteMessage", "Expense Deleted");
				request.getRequestDispatcher("expenses.jsp").forward(request,response);
			}
			
			
		}catch(Exception e){
			e.printStackTrace();			
	  }
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
