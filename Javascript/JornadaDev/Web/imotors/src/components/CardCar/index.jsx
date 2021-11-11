import React from "react";
import { Link } from "react-router-dom";
import './index.css';

function CardCar(props){
    return(
    <div className="card">            
                
        <img className="card-img-top card-foto" alt="Carro" src={props.url} />

        <div className="card-body">
            <h5 className="card-title">{props.fabricante} - {props.modelo}</h5>
            <p className="card-text card-detalhe">{props.detalhes}</p>
            <p className="card-text card-cidade"><i className="fas fa-map-marker-alt"></i> {props.cidade} - {props.uf}</p>
            <h6>{props.valor}</h6>
            <div className="d-grid text-end">
                <Link to={'/car/info/' + props.id_carro} className="btn btn-danger" ><i className="fas fa-info-circle"></i> Detalhes</Link>                                                
                
            </div>                
        </div>
    </div>        
    );
}

export default CardCar;