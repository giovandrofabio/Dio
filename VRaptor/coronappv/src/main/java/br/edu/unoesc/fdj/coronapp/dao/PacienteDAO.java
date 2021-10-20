package br.edu.unoesc.fdj.coronapp.dao;

import java.util.ArrayList;

import br.edu.unoesc.fdj.coronapp.model.Paciente;

public interface PacienteDAO {
	public boolean save(final Paciente paciente);

	public boolean delete(final Paciente paciente);

	public ArrayList<Paciente> getAll();

	public Paciente getByCpf(final Long cpf);
	
	public ArrayList<Paciente> getByResultado(final Double resultado);
	
	public ArrayList<Paciente> getBySexo(final String sexo);
	
	public Paciente ConsultaCPF(final Long cpf);
	
	public ArrayList<Paciente> getFeminino();
}