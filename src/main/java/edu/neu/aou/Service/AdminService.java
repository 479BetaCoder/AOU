package edu.neu.aou.Service;

import java.util.List;

import javax.validation.Valid;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.User;


public interface AdminService {

    List<User> getVendors();

	int deleteVendor(int theVendorId);

	List<BulkOrder> getActiveBulkOrders();

	BulkOrder getBulkOrderById(int bulkOrderId);

	void saveOffer(@Valid BulkOrder theBulkOrder);

	List<BulkOrder> getExpiredBulkOrder();

	void deleteExpiredOrders();

}