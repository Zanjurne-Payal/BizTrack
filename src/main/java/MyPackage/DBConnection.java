package MyPackage;

import java.sql.*;

public class DBConnection {
	static final String url = "jdbc:mysql://localhost:3306/FirstProject";
	static final String userName = "root";
	static final String password = "zanjurnesp@1572";
//	String url = "jdbc:mysql://localhost:3306/student";
//    static String userName = "root";
//    static String password = "zanjurnesp@1572";
//	
	public static Connection getConnection() 
	{
		try {
			 Class.forName("com.mysql.cj.jdbc.Driver");
			
			 return DriverManager.getConnection(url,userName,password);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new RuntimeException("Failed to connect");
		}
	}

}
