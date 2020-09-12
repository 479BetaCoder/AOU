package edu.neu.aou.Configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import edu.neu.aou.Service.UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	/*
	 * @Autowired private DataSource CMSDataSource;
	 */

	// add a reference to our security data source
	@Autowired
	private UserService userService;

	@Autowired
	private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.csrf().disable();
		
		http.authorizeRequests()
		.antMatchers("/dashboard").hasAnyRole("USER","ADMIN","VENDOR")
		.antMatchers("/Admin/**").hasRole("ADMIN")
		.antMatchers("/User/**").hasRole("USER")
		.antMatchers("/Vendor/**").hasRole("VENDOR")
		.antMatchers("/register/imageDisplay").hasAnyRole("USER","ADMIN","VENDOR")
		.antMatchers("/register/updateMyInfo").hasAnyRole("USER","ADMIN","VENDOR")
		.and().formLogin().loginPage("/Login")
		.loginProcessingUrl("/authenticateTheUser").successHandler(customAuthenticationSuccessHandler)
		.permitAll().and().logout().invalidateHttpSession(true).permitAll().and().exceptionHandling().accessDeniedPage("/UnAuthorized");

	}

	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	// authenticationProvider bean definition
	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider auth = new DaoAuthenticationProvider();
		auth.setUserDetailsService(userService); // set the custom user details service
		auth.setPasswordEncoder(passwordEncoder()); // set the password encoder - bcrypt
		return auth;
	}
	
	

}
