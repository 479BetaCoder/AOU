package edu.neu.aou.DAO;

import edu.neu.aou.Entity.Role;

public interface RoleDao {

	public Role findRoleByName(String theRoleName);
	
}