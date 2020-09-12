package edu.neu.aou.DAO;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import javax.validation.Valid;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.User;


@Repository
public class AdminDaoImpl implements AdminDao {

	// need to inject the session factory
	@Autowired
	private SessionFactory sessionFactory;

	private Logger logger = Logger.getLogger(getClass().getName());

	@Override
	public List<User> getVendors() {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		List<User> vendorList = new ArrayList<User>();

		// now retrieve/read from database using username
		Query<User> theQuery = currentSession.createQuery("from User u where u.vendorCategory is not null ", User.class);
		try {
			vendorList = theQuery.getResultList();
		} catch (Exception e) {
			vendorList = null;
		}
		return vendorList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int deleteVendor(int theVendorId) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		Query theQuery = currentSession.createQuery("from User where id=:theVendorId");
		theQuery.setParameter("theVendorId", theVendorId);
		User vendor = (User) theQuery.getSingleResult();
		currentSession.delete(vendor);
		return 1;
	}

	@Override
	public List<BulkOrder> getActiveBulkOrders() {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		List<BulkOrder> activeOrderList = new ArrayList<BulkOrder>();

		// now retrieve/read from database using username
		Query<BulkOrder> theQuery = currentSession
				.createQuery("from BulkOrder b where b.offerCode is null order by b.eventDate asc", BulkOrder.class);
		try {
			activeOrderList = theQuery.getResultList();
		} catch (Exception e) {
			activeOrderList = null;
		}
		return activeOrderList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public BulkOrder getBulkOrderById(int bulkOrderId) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		Query theQuery = currentSession.createQuery("from BulkOrder b where b.id =:theBulkOrderId");
		theQuery.setParameter("theBulkOrderId", bulkOrderId);
		try {
			BulkOrder bulkOrder = (BulkOrder) theQuery.getSingleResult();
			return bulkOrder;
		} catch (Exception e) {
			logger.info("Some exception occured :: " + e.toString());
			return null;
		}
	}

	@Override
	public void saveOffer(@Valid BulkOrder theBulkOrder) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		BulkOrder bulkOrder = (BulkOrder) currentSession.get(BulkOrder.class, theBulkOrder.getId());
		bulkOrder.setOfferCode(theBulkOrder.getOfferCode());
		bulkOrder.setBulkOrderStatus("Completed");
		bulkOrder.setOfferDesc(theBulkOrder.getOfferDesc());
		bulkOrder.setOfferExpiry(theBulkOrder.getOfferExpiry());

	}

	@Override
	public List<BulkOrder> getExpiredOrders() {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		List<BulkOrder> inActiveOrderList = new ArrayList<BulkOrder>();

		// now retrieve/read from database using username
		Query<BulkOrder> theQuery = currentSession.createQuery("from BulkOrder b where b.eventDate<:today ",
				BulkOrder.class);
		theQuery.setParameter("today", new Date());
		try {
			inActiveOrderList = theQuery.getResultList();
		} catch (Exception e) {
			inActiveOrderList = null;
		}
		return inActiveOrderList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deleteExpiredOrders() {
		Session currentSession = sessionFactory.getCurrentSession();
		List<BulkOrder> inActiveOrderList = getExpiredOrders();
		for (BulkOrder b : inActiveOrderList) {
			Query query = currentSession.createQuery("delete from Order o where o.bulkId.id=:theId");
			query.setParameter("theId", b.getId());
			query.executeUpdate();
		}

		// now retrieve/read from database using username
		Query theQuery = currentSession.createQuery("delete from BulkOrder b where b.eventDate<:today");
		theQuery.setParameter("today", new Date());
		theQuery.executeUpdate();

	}

}
