/**
 * Created by jason.kowalewski on 8/31/17.
 */

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.jpa.JpaRepositoriesAutoConfiguration;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@ComponentScan({ "api", "alto", "data" })
@EnableAutoConfiguration
@EntityScan("data")
@EnableJpaRepositories("data")
@SpringBootApplication
public class AltoApplication {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(AltoApplication.class, args);
    }
}
