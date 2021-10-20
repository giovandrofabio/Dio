package br.edu.unoesc.fdj.coronapp.controller;

import javax.inject.Inject;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Result;

@Controller
public class IndexController {

	private final Result resultado;

	/**
	 * @deprecated CDI eyes only
	 */
	protected IndexController() {
		this(null);
	}

	@Inject
	public IndexController(Result result) {
		this.resultado = result;
	}

	@Path("/")
	public void index() {
		resultado.include("mensagem", "IndexController do VRaptor!");
		resultado.include("aviso", "Parâmetro enviado pelo Controller!");
	}
}