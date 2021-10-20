package br.edu.unoesc.fdj.coronapp.controller;

import javax.inject.Inject;

import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Result;

@Controller
public class Mundo {
	private final Result resultado;
	
	/**
	 * @deprecated CDI eyes only
	 */
	protected Mundo() {
		this(null);
	}

	@Inject
	public Mundo(Result result) {
		this.resultado = result;
	}
	
	@Path("/mundo/mensagem")
	public void boasVindas() {
		//return "Olá Mundo";
		resultado.include("mensagem", "Olá Mundo!"); // mapa, ex. HashMap
	}

}
