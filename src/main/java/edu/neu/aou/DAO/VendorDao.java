package edu.neu.aou.DAO;

import java.util.List;

import javax.validation.Valid;

import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.Order;

public interface VendorDao {

	void save(@Valid Item theItem);

	List<Item> getItems(int id);

	int deleteItem(int theItemId);

	Item getItem(int theId);

	List<Order> getOrders(int id);
}
