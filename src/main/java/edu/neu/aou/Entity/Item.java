package edu.neu.aou.Entity;

import java.io.IOException;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "items")
public class Item {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "iditems")
	private int id;

	@Column(name = "item_name")
	@NotNull(message = "�s Required")
	@Size(min = 1, message = "is required")
	private String itemName;

	@Column(name = "item_description")
	@NotNull(message = "�s Required")
	@Size(min = 1, message = "is required")
	private String itemDescription;

	@Column(name = "item_price")
	@NotNull(message = "�s Required")
	private double itemPrice;

	@Transient
	private MultipartFile itemPhoto;

	@Column(name = "item_pic")
	private byte[] itemPic;

	@JoinColumn(name = "vendor_id")
	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	private User vendor;

	public Item() {

	}

	public Item(String itemName, String itemDescription, double itemPrice, int itemQuantity, byte[] itemPic) {
		this.itemName = itemName;
		this.itemDescription = itemDescription;
		this.itemPrice = itemPrice;
		this.itemPic = itemPic;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemDescription() {
		return itemDescription;
	}

	public void setItemDescription(String itemDescription) {
		this.itemDescription = itemDescription;
	}

	public double getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(double itemPrice) {
		this.itemPrice = itemPrice;
	}

	public User getVendor() {
		return vendor;
	}

	public void setVendor(User vendor) {
		this.vendor = vendor;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public MultipartFile getItemPhoto() {
		return itemPhoto;
	}

	public void setItemPhoto(MultipartFile itemPhoto) {

		this.itemPhoto = itemPhoto;
		try {

			if (itemPhoto.getBytes().length == 0) {
				setItemPic(null);
			} else {
				setItemPic(itemPhoto.getBytes());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public byte[] getItemPic() {
		return itemPic;
	}

	public void setItemPic(byte[] itemPic) {
		this.itemPic = itemPic;
	}

	@Override
	public String toString() {
		return "Item [id=" + id + ", itemName=" + itemName + ", itemDescription=" + itemDescription + ", itemPrice="
				+ itemPrice + ", itemPicLocation=" + itemPic + ", vendor=" + vendor + "]";
	}

}
