package MyPackage;

import java.sql.*;
public class Income {
	private int id;
	private String customer;
	private Double amount;
	private String payment_method;
	private Date date;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String expense) {
		this.customer = expense;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public String getpayment_method () {
		return payment_method ;
	}
	public void setpayment_method (String catagory) {
		this.payment_method  = catagory;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}

}