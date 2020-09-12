package edu.neu.aou.Entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "orders")
public class Order {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idorders")
	private int id;
	
	@Column(name = "order_quantity")
	private int orderQuantity;
	
	@OneToOne
	@JoinColumn(name = "item_id")
	private Item orderItem;
	
	@ManyToOne(cascade = {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinColumn(name = "bulko_id")
	private BulkOrder bulkId;
	
	@Transient
	private double orderCost;
	 
	
	public Order() {
		
	}


	public Order(int orderQuantity, Item orderItem) {
		super();
		this.orderQuantity = orderQuantity;
		this.orderItem = orderItem;
	}


	public int getOrderQuantity() {
		return orderQuantity;
	}


	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}


	public Item getOrderItem() {
		return orderItem;
	}


	public void setOrderItem(Item orderItem) {
		this.orderItem = orderItem;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public BulkOrder getBulkId() {
		return bulkId;
	}


	public void setBulkId(BulkOrder bulkId) {
		this.bulkId = bulkId;
	}


	public double getOrderCost() {
		return orderCost;
	}


	public void setOrderCost(double orderCost) {
		this.orderCost = orderCost;
	}


	@Override
	public String toString() {
		return "Order [id=" + id + ", orderQuantity=" + orderQuantity + ", orderItem=" + orderItem + ", bulkId="
				+ bulkId + "]";
	}


	
	
	
	
	
	
	
	

}
