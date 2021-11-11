import React, { useEffect, useState } from "react";
import Menu from "../Menu";
import CardCar from "../CardCar";
import './index.css';
import { api } from '../../services/api';

function Home(){
    const [carros, setCarros] = useState([]);
    const [texto, setTexto] = useState('');
    const [pesquisa, setPesquisa] = useState('');

    useEffect(() => {
        api.get('/carros', {
            auth:{username: 'imotors', password: '102030'},
            params: {busca: pesquisa}
        })
        .then(response => {
            setCarros(response.data);
        })
    }, [pesquisa]);

    return(<>
        <Menu />
        
        <div className="pagina-home">
            <div className="container-fluid">
                
                <div className="row">
                    <div className="col-md-5">
                        <h5>Encontre o seu carro</h5>
                    </div>

                    <div className="col-md-7">
                        <div className="input-group mb-3">
                        <input onChange={(e) => setTexto(e.target.value)} type="text" className="form-control" placeholder="Digite marca ou modelo" aria-describedby="button-addon2" />
                        <button onClick={(e) => setPesquisa(texto)} className="btn btn-outline-danger" type="button" id="button-busca"><i className="fas fa-search"></i> Pesquisar</button>
                        </div>
                    </div>
                </div> 


                <div className="row">
                    {
                        carros.map((carro) => {
                            return <div className="col-lg-2 col-md-4 col-sm-12" key={carro.id_carro}>
                                    <CardCar 
                                        id_carro={carro.id_carro}
                                        fabricante={carro.fabricante}
                                        modelo={carro.modelo}
                                        detalhes={carro.detalhes}
                                        cidade={carro.cidade}
                                        uf={carro.uf}
                                        valor={carro.valor}
                                        url={carro.url_foto}
                                        />    
                                </div>;
                        })                    
                    }   
                </div>

                                                
            </div>
        </div>        
        </>
    );
}

export default Home;