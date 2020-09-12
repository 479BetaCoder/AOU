package edu.neu.aou;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication(exclude = HibernateJpaAutoConfiguration.class)
@ComponentScan("edu.*")
public class AouApplication extends SpringBootServletInitializer {

	public static void main(final String[] args) {
		SpringApplication.run(AouApplication.class, args);
	}

	@Override
  	protected SpringApplicationBuilder configure(final SpringApplicationBuilder application) {
    return application.sources(AouApplication.class);
  }

}
