import React from "react";
import { Link } from 'react-router-dom';
import logoSmall from '../../assets/logo-small.png';
import './index.css';

function Menu(){
    return(
        <nav className="navbar fixed-top navbar-expand navbar-dark bg-dark">

    <div className="container-fluid">
            
        <a className="navbar-brand" href="/#">
          <img src={logoSmall} alt="" height="28" />
        </a>

        <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span className="navbar-toggler-icon"></span>
        </button>

        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <ul className="navbar-nav col-12 d-flex flex-row-reverse">
            
            <li className="nav-item">            
              <Link to="/car/new" type="button" className="btn btn-sm btn-danger nav-link menu-link">Quero Vender</Link>                            
            </li>
            
          </ul>
        </div>    
      
    </div>
  </nav>
    )
}

export default Menu;