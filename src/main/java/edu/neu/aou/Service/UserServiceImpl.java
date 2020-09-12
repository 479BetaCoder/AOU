package edu.neu.aou.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.neu.aou.DAO.RoleDao;
import edu.neu.aou.DAO.UserDao;
import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.Role;
import edu.neu.aou.Entity.User;

@Service
public class UserServiceImpl implements UserService {

	// need to inject user dao
	@Autowired
	private UserDao userDao;

	@Autowired
	private RoleDao roleDao;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	@Transactional
	public User findByUserName(String userName) {
		// check the database if the user already exists
		return userDao.findByUserName(userName);
	}

	@Override
	@Transactional
	public void save(User theUser, Object existingUser) {

		if (existingUser == null) {
			theUser.setRole(roleDao.findRoleByName("ROLE_USER"));
			if (theUser.getVendorCategory() != null) {
				theUser.setRole(roleDao.findRoleByName("ROLE_VENDOR"));
			}
		}
		theUser.setPassword(passwordEncoder.encode(theUser.getPassword()));
		// save user in the database
		userDao.save(theUser);
	}

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		User user = userDao.findByUserName(userName);

		if (user == null) {
			throw new UsernameNotFoundException("Invalid username or password.");
		}

		List<Role> roles = new ArrayList<>();
		roles.add(user.getRole());

		return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getPassword(),
				mapRolesToAuthorities(roles));
	}

	private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
		return roles.stream().map(role -> new SimpleGrantedAuthority(role.getName())).collect(Collectors.toList());
	}

	/*
	 * @Override
	 * 
	 * @Transactional public User getUser(int theId) {
	 * 
	 * return userDao.getUser(theId); }
	 */

	@Override
	@Transactional
	public List<User> getVendorsByCategory(String categoryName) {

		return userDao.getVendorsByCatName(categoryName);
	}

	@Override
	@Transactional
	public List<Item> getItems() {
		return userDao.getItems();
	}

	@Override
	@Transactional
	public List<Item> getByCategory(String category) {
		return userDao.getItemsByCategory(category);
	}

	@Override
	@Transactional
	public void save(@Valid BulkOrder theBulkOrder) {
		userDao.save(theBulkOrder);

	}

	@Override
	@Transactional
	public List<BulkOrder> getMyOrderHist(int id) {

		return userDao.getMyBulkOrders(id);
	}

	@Override
	@Transactional
	public User findValidUserName(String userName, int id) {
		return userDao.findValidUserName(userName, id);
	}

	@Override
	@Transactional
	public List<Item> getByAouCat(String category, String zipCode) {
		return userDao.getByAouCat(category,zipCode);
	}

	

}
