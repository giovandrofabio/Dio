import React, { useState, useEffect } from "react";
import { Link, useParams } from "react-router-dom";
import { api } from "../../services/api";
import Menu from "../Menu";
import './index.css';

function InfoCar(){

    const { id } = useParams();

    const [contato, setContato] = useState('');
    const [telefone, setTelefone] = useState('');
    const [cidade, setCidade] = useState('');
    const [uf, setUF] = useState('');
    const [fabricante, setFabricante] = useState('');
    const [modelo, setModelo] = useState('');
    const [detalhes, setDetalhes] = useState('');
    const [ano_fabricacao, setAno_fabricacao] = useState(0);
    const [ano_modelo, setAno_modelo] = useState(0);
    const [cor, setCor] = useState('');
    const [km, setKm] = useState(0);
    const [cambio, setCambio] = useState('');
    const [combustivel, setCombustivel] = useState('');
    const [valor, setValor] = useState(0);
    const [ind_troca, setInd_troca] = useState('N');
    const [url_foto, setUrl_Foto] = useState('');

    useEffect(() => {
        api.get('/carros/' + id, {
            auth:{username: 'imotors', password: '102030'}
        })
        .then(response => {
            setContato(response.data[0].contato);
            setTelefone(response.data[0].telefone);
            setCidade(response.data[0].cidade);
            setUF(response.data[0].uf);
            setFabricante(response.data[0].fabricante);
            setModelo(response.data[0].modelo);
            setDetalhes(response.data[0].detalhes);
            setAno_fabricacao(response.data[0].ano_fabricacao);
            setAno_modelo(response.data[0].ano_modelo);
            setCor(response.data[0].cor);
            setKm(response.data[0].km);
            setCambio(response.data[0].cambio);
            setCombustivel(response.data[0].combustivel);
            setValor(response.data[0].valor);
            setInd_troca(response.data[0].ind_troca);
            setUrl_Foto(response.data[0].url_foto);
        });
    }, [id]);


    return (<div className="contanier-fluid">
        <Menu />
        
        <div className="pagina-info-car row">
                       
            <div className="offset-md-2 col-md-8 mb-5 text-center">

                <div>
                    <h2>{fabricante} {modelo}</h2>
                </div>
                
                <div className="mt-4">
                    <img src={url_foto} className="foto" alt="Insira a URL da foto acima"></img>
                </div>
            
                <div className="mt-2">
                    <h3>{new Intl.NumberFormat('pt-BR', {
                                    style: 'currency',
                                    currency: 'BRL'
                                }).format(valor)}</h3>
                </div>

                <div className="mt-2">
                    <p className="badge badge-pill badge-secondary">{cidade} / {uf}</p>
                </div>

                <div className="mt-2">
                    <p className="">{detalhes}</p>
                </div>

                <div className="row">
                    <div className="offset-md-2 col-md-4 mt-2">
                        <div className="card text-white bg-secondary">
                            <div className="card-header">
                                Ano
                            </div>
                            <div className="card-body">                            
                                <h5 className="card-text">{ano_fabricacao} / {ano_modelo}</h5>
                            </div>
                        </div>
                    </div>

                    <div className="col-md-4 mt-2">
                        <div className="card text-white bg-secondary">
                            <div className="card-header">
                                Cor
                            </div>
                            <div className="card-body">                            
                                <h5 className="card-text">{cor}</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="row">
                    <div className="offset-md-2 col-md-4 mt-2">
                        <div className="card text-white bg-secondary">
                            <div className="card-header">
                                Km
                            </div>
                            <div className="card-body">                            
                                <h5 className="card-text">{km}</h5>
                            </div>
                        </div>
                    </div>

                    <div className="col-md-4 mt-2">
                        <div className="card text-white bg-secondary">
                            <div className="card-header">
                                Combustível
                            </div>
                            <div className="card-body">                            
                                <h5 className="card-text">{combustivel}</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="row">
                    <div className="offset-md-2 col-md-4 mt-2">
                        <div className="card text-white bg-secondary">
                            <div className="card-header">
                                Câmbio
                            </div>
                            <div className="card-body">                            
                                <h5 className="card-text">{cambio}</h5>
                            </div>
                        </div>
                    </div>

                    <div className="col-md-4 mt-2">
                        <div className="card text-white bg-secondary">
                            <div className="card-header">
                                Aceita Troca
                            </div>
                            <div className="card-body">                            
                                <h5 className="card-text">
                                    {ind_troca === "S" ? <i className="far fa-thumbs-up"></i> : <i className="far fa-thumbs-down"></i>}</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="row">
                    <div className="offset-md-2 col-md-8 mt-2">
                        <div className="card text-white bg-secondary">
                            <div className="card-header">
                                Nome do Vendedor
                            </div>
                            <div className="card-body">                            
                                <h5 className="card-text">{contato}</h5>
                            </div>
                        </div>
                    </div>                    
                </div>

                <div className="col-12 mt-2 text-center">
                    <Link to="/" className="btn btn-outline-success btn-acao">Voltar</Link>
                    <a target="_blank" rel="noreferrer" 
                    href={"https://web.whatsapp.com/send?phone=55" + telefone + "&text=Gostaria+de+mais+detalhes+sobre+o+" + fabricante + "+" + modelo} 
                    type="button" className="btn btn-success btn-acao"><i className="fab fa-whatsapp"></i> Entrar em Contato</a>
                </div>

            </div>
                        
                        
        </div>
        
    </div>);
    
}

export default InfoCar;