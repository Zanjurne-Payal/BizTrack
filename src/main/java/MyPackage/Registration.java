package MyPackage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;


/**
 * Servlet implementation class Registration
 */
@WebServlet("/Registration")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registration() {
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
		// TODO Auto-generated method stub
		

		String businessName = request.getParameter("businessName");
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		
		  if (isTrue(businessName,email,pass)) {
	            request.getSession().setAttribute("successMessage","WellCome to BizTrack !");
	            response.sendRedirect("dashbord.jsp");
	        } else {
	            request.setAttribute("errorMessage", "Registration Failed due to some reason !");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("signUp.jsp");
		        dispatcher.forward(request, response);
	        }

		doGet(request, response);
	}
	boolean isTrue(String businessName,String email,String pass)
	{
		try
		{
			//DBConnection is the user define class for connecting with database
			Connection con = DBConnection.getConnection();
			String query = "INSERT INTO  bussinesses (business_Name , email, password)values(?,?,?)";
			PreparedStatement pstm = con.prepareStatement(query);
			pstm.setString(1,businessName);
			pstm.setString(2,email);
			pstm.setString(3,pass);
			
			int rows = pstm.executeUpdate();
			if(rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}

}
