package edu.neu.aou.DAO;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.validation.Valid;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.Order;

@Repository
public class VendorDaoImpl implements VendorDao {

	// need to inject the session factory
	@Autowired
	private SessionFactory sessionFactory;

	private Logger logger = Logger.getLogger(getClass().getName());

	@Override
	public void save(@Valid Item theItem) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(theItem);

	}

	@Override
	public List<Item> getItems(int id) {
		Session currentSession = sessionFactory.getCurrentSession();

		List<Item> itemList = new ArrayList<Item>();

		// now retrieve/read from database using username
		Query<Item> theQuery = currentSession.createQuery("from Item where vendor.id=:theVendorId", Item.class);
		theQuery.setParameter("theVendorId", id);

		try {
			itemList = theQuery.getResultList();
			// System.out.println("length::" + itemList.size());
		} catch (Exception e) {
			System.out.println("Is this exception??..." + e.toString());
			itemList = null;
		}
		return itemList;

	}

	@SuppressWarnings("rawtypes")
	@Override
	public int deleteItem(int theItemId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		Query theQuery = currentSession.createQuery("delete from Item i where i.id =:theItemId");
		theQuery.setParameter("theItemId", theItemId);
		return theQuery.executeUpdate();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Item getItem(int theId) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		Query theQuery = currentSession.createQuery("from Item i where i.id =:theItemId");
		theQuery.setParameter("theItemId", theId);
		try {
			Item item = (Item) theQuery.getSingleResult();
			return item;
		} catch (Exception e) {
			logger.info("Some exception occured :: " + e.toString());
			return null;
		}

	}

	@Override
	public List<Order> getOrders(int id) {

		// select * from items i inner join orders o on i.iditems = o.item_id and
		// i.vendor_id=36
		Session currentSession = sessionFactory.getCurrentSession();

		List<Order> orderList = new ArrayList<Order>();

		// now retrieve/read from database using username
		Query<Order> theQuery = currentSession.createQuery("from Order o where o.orderItem.vendor.id=:theVendorId and o.bulkId.bulkOrderStatus=:theStatus",
				Order.class);
		theQuery.setParameter("theVendorId", id);
		theQuery.setParameter("theStatus", "Processing");

		try {
			orderList = theQuery.getResultList();
			System.out.println("length::" + orderList.size());
		} catch (Exception e) {
			System.out.println("Is this exception??..." + e.toString());
			orderList = null;
		}
		return orderList;

	}
}
