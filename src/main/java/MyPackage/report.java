package MyPackage;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import java.util.Date;

/**
 * Servlet implementation class report
 */
@WebServlet("/report")
public class report extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public report() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String month = request.getParameter("month"); // Format: YYYY-MM
        if (month == null || month.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Month parameter is required (format: YYYY-MM)");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Monthly_Report_" + month + ".pdf");

        try (OutputStream out = response.getOutputStream()) {
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Add Title and Header
            document.add(new Paragraph("Monthly Transaction Report: " + month, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16)));
            document.add(new Paragraph("Generated on: " + new Date().toString()));
            document.add(Chunk.NEWLINE);

            // Create Table with Headers
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);
            table.setWidths(new int[]{1, 2, 2, 2});

            addTableHeader(table, "ID", "Date", "Type", "Amount");

            // Fetch Data from Database
            fetchDataForMonth(month, table);

            // Add Table to Document
            document.add(table);
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to generate the PDF report");
        }
    }

    private void addTableHeader(PdfPTable table, String... headers) {
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            table.addCell(cell);
        }
    }

    private void fetchDataForMonth(String month, PdfPTable table) {
        
        String query = "SELECT * FROM transaction WHERE DATE_FORMAT(date, '%Y-%m') = ?";

        try  {
        	Connection conn  = DBConnection.getConnection();;
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, month);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
            	System.out.println(rs.getString("date"));
                table.addCell(rs.getString("id"));
                table.addCell(rs.getString("date"));
                table.addCell(rs.getString("type"));
                table.addCell(String.format("%.2f", rs.getDouble("amount")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
