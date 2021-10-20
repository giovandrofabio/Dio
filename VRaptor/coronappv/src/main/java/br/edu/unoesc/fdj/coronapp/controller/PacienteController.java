package br.edu.unoesc.fdj.coronapp.controller;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;


import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.edu.unoesc.fdj.coronapp.model.Paciente;
import br.edu.unoesc.fdj.coronapp.model.Sintoma;
import br.edu.unoesc.fdj.coronapp.service.PacienteService;

@Controller
public class PacienteController {
	@Inject
	private PacienteService pacienteService;
	@Inject
	private HttpSession session;
	private final Result resultado;

	/**
	 * @deprecated CDI eyes only
	 */
	protected PacienteController() {
		this(null);
	}

	@Inject
	public PacienteController(Result result) {
		this.resultado = result;
	}
	
  
	@Get
	public void resultado() {
		Long cpf = (Long) session.getAttribute("cpf");
		if (cpf == null)
			resultado.redirectTo(IndexController.class).index();
		else {
			Paciente paciente = pacienteService.listarPorCPF(cpf);
			resultado.include("paciente", paciente);
		}
	}

	@Post
	public void buscar(Long cpf) {
		if (cpf == null)
			cpf = (Long) session.getAttribute("cpf");
		else
			session.setAttribute("cpf", cpf);

		Paciente paciente = pacienteService.listarPorCPF(cpf);

		if (paciente != null) {
			resultado.include("paciente", paciente);
		}

		List<Sintoma> sintomas = Arrays.asList(Sintoma.values());
		resultado.include("sintomas", sintomas);

		// faz o forward para método do próprio controller
		resultado.forwardTo(this).avaliacao();
	}

	@Get
	@Path("/paciente/rest/listarporresultado/{percentualResultado}")
	public void listarPorResultado(Double percentualResultado) {
		List<Paciente> pacientes = pacienteService.listarPorResultado(percentualResultado);
		resultado.use(Results.json()).indented().withoutRoot().from(pacientes).serialize();
	}

	@Get
	@Path("/paciente/rest/listarporsexo/{sexo}")
	public void listarPorSexo(String sexo) {
		List<Paciente> pacientes = pacienteService.listarPorSexo(sexo);
		resultado.use(Results.json()).indented().withoutRoot().from(pacientes).serialize();
	}
	
	@Get
	@Path("/paciente/rest/consultarcpf/{cpf}")
	public void consultacpf(Long cpf) {
		Paciente pacientes = pacienteService.ConsultaCPF(cpf);
		resultado.use(Results.json()).indented().withoutRoot().from(pacientes).serialize();
	}
	
	@Get
	@Path("/paciente/rest/getfeminino/")
	public void getFeminino() {
		List<Paciente> pacientes = pacienteService.getFeminino();
		resultado.use(Results.json()).indented().withoutRoot().from(pacientes).serialize();
	}	

	@Get
	public void avaliacao() {

	}

	private boolean validarCpf(Long cpf) {
		// pacienteService.validarCpf(cpf);
		return true;
	}

	@Post
	public void testar(Paciente paciente, String[] sintomas) {
		// calcular as chances de estar com o coronavírus
		double res = 0.0;
		for (int i = 0; i < sintomas.length; i++) {
			res += Double.parseDouble(sintomas[i]);
		}
		if (paciente.getVersion() != null)
			paciente = pacienteService.listarPorCPF(paciente.getCpf());
		paciente.setResultado(res);

		try {
			if (validarCpf(paciente.getCpf())) {
				pacienteService.salvar(paciente);
				resultado.redirectTo(this).resultado();
			} else {
				// TODO erro se não validou CPF
				session.setAttribute("erro", "CPF inválido!");
				resultado.redirectTo(this).avaliacao();
			}
		} catch (Exception e) {
			session.setAttribute("erro", "Erro ao tentar salvar teste do paciente!" + e.getMessage());
			resultado.redirectTo(this).avaliacao();
		}

	}

}