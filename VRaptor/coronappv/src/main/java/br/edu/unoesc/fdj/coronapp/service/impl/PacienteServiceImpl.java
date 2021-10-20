package br.edu.unoesc.fdj.coronapp.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import br.edu.unoesc.fdj.coronapp.dao.impl.jpa.PacienteDAOJpa;
import br.edu.unoesc.fdj.coronapp.model.Paciente;
import br.edu.unoesc.fdj.coronapp.service.PacienteService;

@Stateless
@ApplicationScoped
public class PacienteServiceImpl implements PacienteService {
	@Inject
	private PacienteDAOJpa pacienteDAO;

	@Override
	public void salvar(Paciente paciente) {
		pacienteDAO.save(paciente);
	}

	@Override
	public void excluir(Paciente paciente) {
		pacienteDAO.delete(paciente);
	}

	@Override
	public List<Paciente> listar() {
		return pacienteDAO.getAll();
	}

	@Override
	public Paciente listarPorCPF(Long cpf) {
		return pacienteDAO.getByCpf(cpf);
	}

	@Override
	public List<Paciente> listarPorResultado(Double resultado) {
		return pacienteDAO.getByResultado(resultado);
	}

	@Override
	public List<Paciente> listarPorSexo(String sexo) {
		return pacienteDAO.getBySexo(sexo);
	}

	@Override
	public Paciente ConsultaCPF(Long cpf) {
		return pacienteDAO.ConsultaCPF(cpf);
	}
	
	public ArrayList<Paciente> getFeminino(){
		return pacienteDAO.getFeminino();
	}
}
