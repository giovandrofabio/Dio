import React, {useState} from "react";
import {Link, Navigate} from 'react-router-dom';
import { api } from '../../services/api';
import Menu from '../Menu';
import './index.css';

function NewCar(){
    const [sucesso, setSucesso] = useState(false);

    const [contato, setContato] = useState('');
    const [telefone, setTelefone] = useState('');
    const [cidade, setCidade] = useState('');
    const [uf, setUF] = useState('SP');
    const [fabricante, setFabricante] = useState('');
    const [modelo, setModelo] = useState('');
    const [detalhes, setDetalhes] = useState('');
    const [ano_fabricacao, setAno_fabricacao] = useState(0);
    const [ano_modelo, setAno_modelo] = useState(0);
    const [cor, setCor] = useState('');
    const [km, setKm] = useState(0);
    const [cambio, setCambio] = useState('Automático');
    const [combustivel, setCombustivel] = useState('FLEX');
    const [valor, setValor] = useState(0);
    const [ind_troca, setInd_troca] = useState('N');
    const [url_foto, setUrl_Foto] = useState('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaXAHXtOe_jI_atSCf7wma1_P_WHsM7oSPSiQMoIZSit0zanMzXX2uEXsCr-nq9ASxmC8&usqp=CAU');

    function handleNewCar(){
        const data = ({
            contato,
            telefone,
            cidade,
            uf,
            fabricante,
            modelo,
            detalhes,
            ano_fabricacao,
            ano_modelo,
            cor,
            km,
            cambio,
            combustivel,
            valor,
            ind_troca,
            url_foto        
        });

        api.post('/carros', data, {
            auth: {username: 'imotors', password: '102030'}
        })
        .then(response => {
           setSucesso(true);
        })
        .catch(error => {
            alert(error.response.data.erro);
            // {"erro": "Informe o valor"}
        });
    }

    return (<div className="contanier-fluid">
                <div className="pagina-new-car offset-lg-3 col-lg-6 mb-5">
                    <Menu />
                    <h2>Cadastrar Veículo</h2>

                    <input className="form-control mt-4" placeholder="Nome completo" onChange={(e) => setContato(e.target.value)} />
                    <input className="form-control mt-2" placeholder="WhatsApp" onChange={(e) => setTelefone(e.target.value)} />
                    <input className="form-control mt-2" placeholder="Cidade" onChange={(e) => setCidade(e.target.value)} />

                    <select className="form-select mt-2" id="cmbUF" onChange={(e) => setUF(e.target.value)} >
                        <option value="AL">AL</option>
                        <option value="AP">AP</option>
                        <option value="AM">AM</option>
                        <option value="BA">BA</option>
                        <option value="CE">CE</option>
                        <option value="DF">DF</option>
                        <option value="ES">ES</option>
                        <option value="GO">GO</option>
                        <option value="MA">MA</option>
                        <option value="MT">MT</option>
                        <option value="MS">MS</option>
                        <option value="MG">MG</option>
                        <option value="PA">PA</option>
                        <option value="PB">PB</option>
                        <option value="PR">PR</option>
                        <option value="PE">PE</option>
                        <option value="PI">PI</option>
                        <option value="RJ">RJ</option>
                        <option value="RN">RN</option>
                        <option value="RS">RS</option>
                        <option value="RO">RO</option>
                        <option value="RR">RR</option>
                        <option value="SC">SC</option>
                        <option selected value="SP">SP</option>
                        <option value="SE">SE</option>
                        <option value="TO">TO</option>     
                    </select>

                    <input className="form-control mt-2" placeholder="Fabricante" onChange={(e) => setFabricante(e.target.value)} />
                    <input className="form-control mt-2" placeholder="Modelo"  onChange={(e) => setModelo(e.target.value)} />
                    <input className="form-control mt-2" placeholder="Detalhes"  onChange={(e) => setDetalhes(e.target.value)} />
                    <input className="form-control mt-2" placeholder="Ano Fabricação" type="number"  onChange={(e) => setAno_fabricacao(e.target.value)}/>
                    <input className="form-control mt-2" placeholder="Ano Modelo" type="number"  onChange={(e) => setAno_modelo(e.target.value)}/>
                    <input className="form-control mt-2" placeholder="Cor"  onChange={(e) => setCor(e.target.value)} />
                    <input className="form-control mt-2" placeholder="Km" type="number"  onChange={(e) => setKm(e.target.value)}/>

                    <select className="form-select mt-2" id="cmbCambio" onChange={(e) => setCambio(e.target.value)} >
                        <option selected value="Manual">Câmbio Manual</option>
                        <option value="Automático">Câmbio Automático</option>     
                    </select>

                    <select className="form-select mt-2" id="cmbCombustivel" onChange={(e) => setCombustivel(e.target.value)}>
                        <option selected value="FLEX">Flex</option>
                        <option value="GASOLINA">Gasolina</option>
                        <option value="ÁLCOOL">Álcool</option>
                        <option value="DIESEL">Diesel</option>
                        <option value="GNV">GNV</option>
                        <option value="ELÉTRICO">Elétrico</option>
                    </select>

                    <input className="form-control mt-2" placeholder="Valor" type="number" onChange={(e) => setValor(e.target.value)}/>

                    <div className="form-group mt-2">
                        <div className="form-check">
                            <input className="form-check-input" type="checkbox" id="gridCheck" onChange={(e) => setInd_troca(e.target.checked ? 'S' : 'N')}/>
                            <label className="form-check-label" for="gridCheck">Aceita troca</label>
                        </div>
                    </div>

                    <div className="input-group mt-2">                    
                        <input type="text" className="form-control" placeholder="URL da foto (Ex: http://site.com/foto.png)" 
                               aria-label="" aria-describedby="basic-addon1" onChange={(e) => setUrl_Foto(e.target.value)}/>
                        
                        <div className="col-12 text-center">
                            <img src={url_foto} className="car-image" alt="Insira a URL da foto acima"></img>
                        </div>
                    </div>

                    <div className="text-center mt-4">
                        <Link to="/" className="btn btn-outline-success btn-acao">Cancelar</Link>
                        <button type="submit" onClick={handleNewCar} className="btn btn-success btn-acao">Salvar Dados</button>
                    </div>

                    { sucesso ? <Navigate to="/" /> : null}

                </div>
            </div>
        )
}

export default NewCar;