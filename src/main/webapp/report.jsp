<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monthly Data Download</title>
</head>
<body>
    <h2>Download Monthly Transaction Data</h2>
    <form action="report" method="get">
        <label for="month">Select Month:</label>
        <input type="month" id="month" name="month" required>
        <button type="submit">Download PDF</button>
    </form>
</body>
</html>