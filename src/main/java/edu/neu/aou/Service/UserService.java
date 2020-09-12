package edu.neu.aou.Service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.security.core.userdetails.UserDetailsService;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.User;


public interface UserService extends UserDetailsService {

	User findByUserName(String userName);

	void save(@Valid User theUser, Object object);

	//User getUser(int theId);

	List<User> getVendorsByCategory(String categoryName);

	List<Item> getItems();

	List<Item> getByCategory(String category);

	void save(@Valid BulkOrder theBulkOrder);

	List<BulkOrder> getMyOrderHist(int id);

	User findValidUserName(String userName, int i);

	List<Item> getByAouCat(String category, String string);

	

}