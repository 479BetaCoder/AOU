package edu.neu.aou.DAO;

import java.util.List;

import javax.validation.Valid;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.User;


public interface UserDao {

    User findByUserName(String userName);
    
    void save(User user);

	//User getUser(int theId);

	List<User> getVendorsByCatName(String categoryName);

	List<Item> getItems();

	List<Item> getItemsByCategory(String category);

	void save(@Valid BulkOrder theBulkOrder);

	List<BulkOrder> getMyBulkOrders(int id);

	User findValidUserName(String userName, int id);

	List<Item> getByAouCat(String category, String zipCode);

	
    
}