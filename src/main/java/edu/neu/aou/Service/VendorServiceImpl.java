package edu.neu.aou.Service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.neu.aou.DAO.VendorDao;
import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.Order;

@Service
public class VendorServiceImpl implements VendorService {

	
	@Autowired
	private VendorDao vendorDao;
	
	@Override
	@Transactional
	public void save(@Valid Item theItem) {
		vendorDao.save(theItem);
		
	}

	@Override
	@Transactional
	public List<Item> getItems(int id) {
		return vendorDao.getItems(id);
	}

	@Override
	@Transactional
	public int deleteItem(int theItemId) {
		return vendorDao.deleteItem(theItemId);
	}

	@Override
	@Transactional
	public Item getItem(int theId) {
		return vendorDao.getItem(theId);
	}

	@Override
	@Transactional
	public List<Order> getOrders(int id) {
		return vendorDao.getOrders(id);
	}

}
