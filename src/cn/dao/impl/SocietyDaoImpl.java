package cn.dao.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import cn.entity.Society;

//Spring和Hibernate集成，只需要将dao类继承自Spring提供的HibernateDaoSupport
@Repository("SocietyDao")
public class SocietyDaoImpl extends GenericDaoImpl<Society> implements SocietyDao{
	@Autowired
	@Qualifier("sessionFactory")
	public void setMySessionFactory(SessionFactory sessionFactory){
		super.setMySessionFactory(sessionFactory);
	}
}
