package br.com.devmedia.cursosspring.domain;

public class Usuario {

    private long id;
    private String nome;
    private String email;
    private String login;
    private String senha;

    public Usuario(String nome, String email, String login) {
        this.nome = nome;
        this.email = email;
        this.login = login;
    }

    //métodos de acesso omitidos…
}