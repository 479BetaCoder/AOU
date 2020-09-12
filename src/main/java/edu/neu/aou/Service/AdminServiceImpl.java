package edu.neu.aou.Service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.neu.aou.DAO.AdminDao;
import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.User;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;
	
	@Override
	@Transactional
	public List<User> getVendors() {
		
		return adminDao.getVendors();
	}

	@Override
	@Transactional
	public int deleteVendor(int theVendorId) {
		return adminDao.deleteVendor(theVendorId);
	}

	@Override
	@Transactional
	public List<BulkOrder> getActiveBulkOrders() {
		return adminDao.getActiveBulkOrders();
	}

	@Override
	@Transactional
	public BulkOrder getBulkOrderById(int bulkOrderId) {
		return adminDao.getBulkOrderById(bulkOrderId);
	}

	@Override
	@Transactional
	public void saveOffer(@Valid BulkOrder theBulkOrder) {
		adminDao.saveOffer(theBulkOrder);
		
	}

	@Override
	@Transactional
	public List<BulkOrder> getExpiredBulkOrder() {
		return adminDao.getExpiredOrders();
	}

	@Override
	@Transactional
	public void deleteExpiredOrders() {
		
		adminDao.deleteExpiredOrders();
		
	}

	

}
