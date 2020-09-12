package edu.neu.aou.DAO;

import java.util.List;

import javax.validation.Valid;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.User;

public interface AdminDao {

	List<User> getVendors();

	int deleteVendor(int theVendorId);

	List<BulkOrder> getActiveBulkOrders();

	BulkOrder getBulkOrderById(int bulkOrderId);

	void saveOffer(@Valid BulkOrder theBulkOrder);

	List<BulkOrder> getExpiredOrders();

	void deleteExpiredOrders();

	}
