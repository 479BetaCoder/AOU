package edu.neu.aou.Entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import edu.neu.aou.Validations.ValidEmail;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idusers")
	private int id;

	@Column(name = "user_name")
	@NotNull(message = "is required")
	@Size(min = 1, message = "is required")
	private String userName;

	@Column(name = "password")
	@NotNull(message = "is required")
	@Size(min = 1, message = "is required")
	private String password;

	@Column(name = "email")
	@ValidEmail
	@NotNull(message = "is required")
	@Size(min = 1, message = "is required")
	private String email;

	@Transient
	private MultipartFile photo;

	@Lob
	@Column(name = "user_dp")
	private byte[] userDp;

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "role_id")
	private Role role;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = { CascadeType.DETACH, CascadeType.MERGE,
			CascadeType.PERSIST, CascadeType.REFRESH })
	private List<BulkOrder> bulkOrderList;

	
	@Column(name = "vendor_category")
	private String vendorCategory;
	
	@Column(name = "zipcode")
	@Pattern(regexp = "^[0-9]{5}(?:-[0-9]{4})?$",message = "invalid zipcode")
	private String zipCode;
	
	@OneToMany(mappedBy = "vendor",cascade = CascadeType.ALL)
	private List<Item> itemList;

	public User() {
	}

	public User(String userName, String password, String email) {
		this.userName = userName;
		this.password = password;
		this.email = email;
	}

	public User(String userName, String password, String email, Role role) {
		this.userName = userName;
		this.password = password;
		this.email = email;
		this.role = role;
	}

	// Convinience method to add bulkOrder
	public void addBulkOrder(BulkOrder bulkOrder) {

		if (bulkOrderList == null) {
			bulkOrderList = new ArrayList<>();
		}
		bulkOrderList.add(bulkOrder);
		bulkOrder.setUser(this); // bi-directional
	}
	
	// Convinience method to add items
		public void addItem(Item item) {
			
			if(itemList == null) {
				itemList = new ArrayList<>();
			}
			itemList.add(item);
			item.setVendor(this); // bi-directional
		}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public MultipartFile getPhoto() {
		return photo;
	}

	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
		try {

			if (photo.getBytes().length == 0) {
				setUserDp(null);
			} else {
				setUserDp(photo.getBytes());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public byte[] getUserDp() {
		return userDp;
	}

	public void setUserDp(byte[] userDp) {
		this.userDp = userDp;
	}

	public List<BulkOrder> getBulkOrderList() {
		return bulkOrderList;
	}

	public void setBulkOrderList(List<BulkOrder> bulkOrderList) {
		this.bulkOrderList = bulkOrderList;
	}

	public String getVendorCategory() {
		return vendorCategory;
	}

	public void setVendorCategory(String vendorCategory) {
		this.vendorCategory = vendorCategory;
	}

	public List<Item> getItemList() {
		return itemList;
	}

	public void setItemList(List<Item> itemList) {
		this.itemList = itemList;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", password=" + password + ", email=" + email + ", photo="
				+ photo + ", userDp=" + Arrays.toString(userDp) + ", role=" + role + ", bulkOrderList=" + bulkOrderList
				+ ", vendorCategory=" + vendorCategory + ", zipCode=" + zipCode + ", itemList=" + itemList + "]";
	}

	

	

}