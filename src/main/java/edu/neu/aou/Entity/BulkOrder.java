package edu.neu.aou.Entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "bulk_order")
public class BulkOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idbulk_order")
	private int id;

	@Column(name = "event_date")
	@NotNull
	private Date eventDate;

	@Column(name = "bulkorder_desc")
	private String bulkOrderDesc;
	
	
	public static double bulkOrderCost;
	
	@Column(name="bulk_order_cost")
	@NotNull
	private double cartValue;
	
	
	@Column(name = "bulkorder_status")
	private String bulkOrderStatus;

	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	@JoinColumn(name = "user_id")
	private User user;

	@OneToMany(fetch=FetchType.EAGER, mappedBy = "bulkId", cascade = CascadeType.ALL)
	private List<Order> orderList = new ArrayList<Order>();
	
	@Column(name = "offer_code")
	private String offerCode;
	
	@Column(name = "offer_desc")
	private String offerDesc;
	
	@Column(name = "offer_expiry")
	private Date offerExpiry;
	
	public BulkOrder() {

	}

	public BulkOrder(Date eventDate, String bulkOrderDesc, String bulkOrderStatus) {
		super();
		this.eventDate = eventDate;
		this.bulkOrderDesc = bulkOrderDesc;
		this.bulkOrderStatus = bulkOrderStatus;
	}

	public BulkOrder(Date eventDate, String bulkOrderDesc, String bulkOrderStatus, User user) {
		super();
		this.eventDate = eventDate;
		this.bulkOrderDesc = bulkOrderDesc;
		this.bulkOrderStatus = bulkOrderStatus;
		this.user = user;
	}

	// Convinience method to add Orders
	public void addOrders(Order order) {

		if (orderList == null) {
			orderList = new ArrayList<>();
		}
		orderList.add(order);
		order.setBulkId(this); // bidirectional

	}
	
	// Convinience method to add Orders
	public void deleteOrder(int index) {
		orderList.remove(index);
	}

	public Date getEventDate() {
		return eventDate;
	}

	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}

	public String getBulkOrderDesc() {
		return bulkOrderDesc;
	}

	public void setBulkOrderDesc(String bulkOrderDesc) {
		this.bulkOrderDesc = bulkOrderDesc;
	}

	public String getBulkOrderStatus() {
		return bulkOrderStatus;
	}

	public void setBulkOrderStatus(String bulkOrderStatus) {
		this.bulkOrderStatus = bulkOrderStatus;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
		for(Order order:orderList) {
			order.setBulkId(this);
		}
		
	}

	public int getId() {
		return id;
	}

	public String getOfferCode() {
		return offerCode;
	}

	public void setOfferCode(String offerCode) {
		this.offerCode = offerCode;
	}

	public String getOfferDesc() {
		return offerDesc;
	}

	public void setOfferDesc(String offerDesc) {
		this.offerDesc = offerDesc;
	}

	public Date getOfferExpiry() {
		return offerExpiry;
	}

	public void setOfferExpiry(Date offerExpiry) {
		this.offerExpiry = offerExpiry;
	}
	public void setId(int id) {
		this.id = id;
	}

	public double getBulkOrderCost() {
		return bulkOrderCost;
	}

	public double getCartValue() {
		return cartValue;
	}

	public void setCartValue(double cartValue) {
		this.cartValue = cartValue;
	}

	@Override
	public String toString() {
		return "BulkOrder [id=" + id + ", eventDate=" + eventDate + ", bulkOrderDesc=" + bulkOrderDesc + ", cartValue="
				+ cartValue + ", bulkOrderStatus=" + bulkOrderStatus + ", user=" + user + ", orderList=" + orderList
				+ ", offerCode=" + offerCode + ", offerDesc=" + offerDesc + ", offerExpiry=" + offerExpiry + "]";
	}

	
	
	

}
