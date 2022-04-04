package jpa.utils;

import java.io.File;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {

	public static final SessionFactory HIBERNATE_SF;

	static {
		HIBERNATE_SF = new Configuration().configure(new File("src/main/resources/hibernate.cfg.xml")).buildSessionFactory();

		// Register JVM shutdown hook
		Runtime.getRuntime().addShutdownHook(new Thread() {

			@Override
			public void run() {

				HIBERNATE_SF.close();
			}
		});

	}
}
