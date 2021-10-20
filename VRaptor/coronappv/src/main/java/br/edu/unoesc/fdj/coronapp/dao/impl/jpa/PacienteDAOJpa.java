package br.edu.unoesc.fdj.coronapp.dao.impl.jpa;

import java.util.ArrayList;

import javax.ejb.Stateless;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.AroundCall;
import br.com.caelum.vraptor.Intercepts;
import br.com.caelum.vraptor.interceptor.SimpleInterceptorStack;
import br.edu.unoesc.fdj.coronapp.dao.PacienteDAO;
import br.edu.unoesc.fdj.coronapp.model.Paciente;

@Intercepts
@Stateless
@ApplicationScoped
public class PacienteDAOJpa implements PacienteDAO {
	@Inject
	private EntityManager em;
	
	
	@Inject
	private HttpServletRequest request;	

    @AroundCall
    public void intercept(SimpleInterceptorStack stack) {
        System.out.println("Interceptando " + request.getRequestURI());
        // código a ser executado antes da lógica

        stack.next(); // continua a execução
    }	
	

	public boolean save(final Paciente paciente) {
		try {
			em.persist(paciente);
			em.flush();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return false;
	}

	public boolean delete(final Paciente paciente) {
		try {
			em.remove(paciente);
			em.flush();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}

	public ArrayList<Paciente> getAll() {
		String strQuery = "SELECT p FROM Paciente p";
		TypedQuery<Paciente> tq = em.createQuery(strQuery, Paciente.class);
		ArrayList<Paciente> pacientes = null;

		try {
			pacientes = (ArrayList<Paciente>) tq.getResultList();
		} catch (NoResultException ex) {
			ex.printStackTrace();
		}

		return pacientes;
	}

	public Paciente getByCpf(final Long cpf) {
		String query = "SELECT p FROM Paciente p WHERE p.cpf = :cpf";

		TypedQuery<Paciente> tq = em.createQuery(query, Paciente.class);
		tq.setParameter("cpf", cpf);

		Paciente paciente = null;
		try {
			paciente = tq.getSingleResult();
		} catch (NoResultException ex) {
			ex.printStackTrace();
		}

		return paciente;
	}

	public ArrayList<Paciente> getByResultado(final Double resultado) {
		String query = "SELECT p FROM Paciente p WHERE p.resultado = :resultado";

		TypedQuery<Paciente> tq = em.createQuery(query, Paciente.class);
		tq.setParameter("resultado", resultado);

		ArrayList<Paciente> pacientes = null;

		try {
			pacientes = (ArrayList<Paciente>) tq.getResultList();
		} catch (NoResultException ex) {
			ex.printStackTrace();
		}

		return pacientes;
	}

	public ArrayList<Paciente> getBySexo(final String sexo) {
		String query = "SELECT p FROM Paciente p WHERE p.sexo = :sexo";

		TypedQuery<Paciente> tq = em.createQuery(query, Paciente.class);
		tq.setParameter("sexo", sexo);

		ArrayList<Paciente> pacientes = null;

		try {
			pacientes = (ArrayList<Paciente>) tq.getResultList();
		} catch (NoResultException ex) {
			ex.printStackTrace();
		}

		return pacientes;
	}

	public Paciente ConsultaCPF(Long cpf) {
		String query = "SELECT p FROM Paciente p WHERE p.cpf = :cpf";

		TypedQuery<Paciente> tq = em.createQuery(query, Paciente.class);
		tq.setParameter("cpf", cpf);

		Paciente paciente = null;
		try {
			paciente = tq.getSingleResult();
		} catch (NoResultException ex) {
			ex.printStackTrace();
		}

		return paciente;
	}

	public ArrayList<Paciente> getFeminino() {
		String query = "SELECT p FROM Paciente p WHERE p.resultado < 50 and p.sexo = 'F' ";
		TypedQuery<Paciente> tq = em.createQuery(query, Paciente.class);
		ArrayList<Paciente> pacientes = null;

    	try {
			pacientes = (ArrayList<Paciente>) tq.getResultList();
		} catch (NoResultException ex) {
			ex.printStackTrace();
		}

		return pacientes;
	}
	
}