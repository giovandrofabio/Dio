package br.com.devmedia.cursosspring;

import br.com.devmedia.cursosspring.domain.Pessoa;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan
public class Programa {

    public static void main(String[] args) {
        ApplicationContext context = new AnnotationConfigApplicationContext(Programa.class);

        Pessoa pessoa = context.getBean(Pessoa.class);

        pessoa.setNome("Eduardo");
        pessoa.setIdade(32);
        System.out.println(pessoa);
    }
}
