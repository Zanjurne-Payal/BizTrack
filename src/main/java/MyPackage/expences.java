package MyPackage;

import java.sql.*;
public class expences {
	private int id;
	private String expense;
	private String catagory;
	private Double amount;
	private Date date;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getExpense() {
		return expense;
	}
	public void setExpense(String expense) {
		this.expense = expense;
	}
	public String getCatagory() {
		return catagory;
	}
	public void setCatagory(String catagory) {
		this.catagory = catagory;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}

}
