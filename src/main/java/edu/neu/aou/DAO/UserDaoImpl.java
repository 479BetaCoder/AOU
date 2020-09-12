package edu.neu.aou.DAO;

import java.util.List;
import java.util.logging.Logger;

import javax.validation.Valid;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.User;


@Repository
public class UserDaoImpl implements UserDao {

	// need to inject the session factory
	@Autowired
	private SessionFactory sessionFactory;

	private Logger logger = Logger.getLogger(getClass().getName());

	@Override
	public User findByUserName(String theUserName) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using username
		Query<User> theQuery = currentSession.createQuery("from User where userName=:uName", User.class);
		theQuery.setParameter("uName", theUserName);
		User theUser = null;
		try {
			theUser = theQuery.getSingleResult();
		} catch (Exception e) {
			theUser = null;
		}

		return theUser;
	}

	@Override
	public void save(User theUser) {
		// get current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// create/update the user ...
		currentSession.saveOrUpdate(theUser);
	}

	/*
	 * @Override public User getUser(int theId) { Session session =
	 * sessionFactory.getCurrentSession(); return session.get(User.class, theId); }
	 */

	@Override
	public List<User> getVendorsByCatName(String categoryName) {

		Session session = sessionFactory.getCurrentSession();

		Query<User> theQuery = session.createQuery("from User where vendorCategory=:theCategory", User.class);
		theQuery.setParameter("theCategory", categoryName);

		try {
			List<User> vendors = theQuery.getResultList();
			return vendors;
		} catch (Exception e) {
			logger.info("Some exception occured :: " + e.toString());
			return null;
		}

	}

	@Override
	public List<Item> getItems() {
		Session session = sessionFactory.getCurrentSession();

		Query<Item> theQuery = session.createQuery("from Item", Item.class);
		
		try {
			List<Item> items = theQuery.getResultList();
			return items;
		} catch (Exception e) {
			logger.info("Some exception occured :: " + e.toString());
			return null;
		}
	}

	@Override
	public List<Item> getItemsByCategory(String category) {
		Session session = sessionFactory.getCurrentSession();

		Query<Item> theQuery = session.createQuery("from Item i where i.vendor.vendorCategory=:theCategory", Item.class);
		theQuery.setParameter("theCategory", category);
		try {
			List<Item> items = theQuery.getResultList();
			return items;
		} catch (Exception e) {
			logger.info("Some exception occured :: " + e.toString());
			return null;
		}
	}

	@Override
	public void save(@Valid BulkOrder theBulkOrder) {
		Session session = sessionFactory.getCurrentSession();
		session.save(theBulkOrder);
		//System.out.println("BulkOrder::" + theBulkOrder.toString());
	}

	@Override
	public List<BulkOrder> getMyBulkOrders(int id) {
		Session session = sessionFactory.getCurrentSession();

		Query<BulkOrder> theQuery = session.createQuery("from BulkOrder b where b.user.id=:theUserId order by b.eventDate desc", BulkOrder.class);
		theQuery.setParameter("theUserId", id);
		try {
			List<BulkOrder> bulkOrderList = theQuery.getResultList();
			return bulkOrderList;
		} catch (Exception e) {
			logger.info("Some exception occured :: " + e.toString());
			return null;
		}
	}

	@Override
	public User findValidUserName(String userName,int userId) {
		// get the current hibernate session
				Session currentSession = sessionFactory.getCurrentSession();

				// now retrieve/read from database using username
				Query<User> theQuery = currentSession.createQuery("from User where userName=:uName and id!=:uId", User.class);
				theQuery.setParameter("uName", userName);
				theQuery.setParameter("uId", userId);
				
				User theUser = null;
				try {
					theUser = theQuery.getSingleResult();
				} catch (Exception e) {
					theUser = null;
				}

				return theUser;
	}

	@Override
	public List<Item> getByAouCat(String category,String zipCode) {
		Session session = sessionFactory.getCurrentSession();

		Query<Item> theQuery = session.createQuery("from Item i where i.vendor.vendorCategory=:theCategory and i.vendor.zipCode=:theZipCode", Item.class);
		theQuery.setParameter("theCategory", category);
		theQuery.setParameter("theZipCode", zipCode);
		try {
			List<Item> items = theQuery.getResultList();
			return items;
		} catch (Exception e) {
			logger.info("Some exception occured :: " + e.toString());
			return null;
		}
	}

	
	

}