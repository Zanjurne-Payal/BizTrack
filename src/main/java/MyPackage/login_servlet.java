package MyPackage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Servlet implementation class MyServlet
 */
@WebServlet("/login_servlet")
public class login_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login_servlet() {
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
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		
		 if (isTrue(email,pass)) {
	            request.getSession().setAttribute("successMessage","WellCome to BizTrack!");
	            response.sendRedirect("dashbord.jsp");
	        } else {
	            request.setAttribute("errorMessage", "Sorry Something is missing!");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		        dispatcher.forward(request, response);
	        }
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	boolean isTrue(String email , String pass)
	{
		try
		{
			//DBConnection is the user define class for connecting with database
			Connection con = DBConnection.getConnection();
			String query = "select email,password from  bussinesses;";
			Statement st= con.createStatement();
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next())
			{
				String email2 = rs.getString("email");
				String password = rs.getString("password");
				if(email.equals(email2) && pass.equals(password))
				{
					return true;
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}

}
