package br.edu.unoesc.fdj.coronapp.service;

import java.util.ArrayList;
import java.util.List;

import br.edu.unoesc.fdj.coronapp.model.Paciente;

public interface PacienteService {
	public void salvar(Paciente paciente);

	public void excluir(Paciente paciente);

	public List<Paciente> listar();

	public Paciente listarPorCPF(Long cpf);

	public List<Paciente> listarPorResultado(Double resultado);

	public List<Paciente> listarPorSexo(String sexo);
	
	public Paciente ConsultaCPF(Long cpf);
	
	public ArrayList<Paciente> getFeminino();
}
