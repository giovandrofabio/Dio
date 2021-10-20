<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoronApp - Testes Rápido de Sintomas</title>
<style>
* {
	box-sizing: border-box
}

/* Add padding to containers */
.container {
	padding: 2px;
}

/* Full-width input fields */
input[type=text], input[type=date], input[type=number], select {
	width: 100%;
	padding: 15px;
	margin: 3px 0 10px 0;
	display: inline-block;
	border: none;
	background: #f1f1f1;
}
</style>
<script>
	function showPosition() {
		if (navigator.geolocation) {
			navigator.geolocation
					.getCurrentPosition(function(position) {
						document.getElementById("paciente.latitude").value = position.coords.latitude
								.toFixed(8);
						document.getElementById("paciente.longitude").value = position.coords.longitude
								.toFixed(8);
					});
		} else {
			alert("Navegador não tem suporte ou permite geolocalização!");
		}
	}
</script>
</head>
<body>
	<c:if test="${not empty sessionScope.erro}"><h3 style="color: red">${sessionScope.erro}</h3><c:remove var="erro" scope="session" /></c:if>
	
	<form action="/paciente/testar" method="post" enctype="multipart/form-data">
		<input type="hidden" name="paciente.version" value="${not empty paciente.version ? paciente.version : ''}"/>
		<div class="container">
			<h1>Teste Rápido</h1>
			<hr>
			<label for="paciente.cpf"><b>CPF: </b></label> <input type="number"
				name="paciente.cpf" required="required" value="${sessionScope.cpf}" readonly="readonly"
				placeholder="CPF sem pontuações">
			
			<br /> <label for="paciente.nome"><b>Nome: </b></label> 
			<input type="text"
				name="paciente.nome" 
				required="required" 
				autofocus="autofocus" 
				maxlength="40"
				size="40" placeholder="Nome" 
				value="${empty paciente.nome ? '' : paciente.nome}">
						
			<fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${paciente.dataNascimento}" var="dataNascimento"/>
			
			<br /> <label for="paciente.dataNascimento"><b>Data de Nascimento: </b></label> <input
				type="text" name="paciente.dataNascimento" required="required"
				placeholder="dd/mm/aaaa" value="${empty dataNascimento ? '' : dataNascimento}">
			
			
			<label for="paciente.sexo"><b>Sexo: </b></label> Masculino <input type="radio"
				name="paciente.sexo" value="M" required="required" ${((not empty paciente.sexo) && (paciente.sexo eq 'M')) ? 'checked' : ''}> Feminino <input
				type="radio" name="paciente.sexo" value="F" required="required" ${((not empty paciente.sexo) && (paciente.sexo eq 'F')) ? "checked" : ""}>
			
			<br />
			<br /> <label for="paciente.latitude"><b>Latitude: </b></label> <input
				type="number" id="paciente.latitude" name="paciente.latitude" step="0.00000001"
				placeholder="Latitude" value="${empty paciente.latitude ? '' : paciente.latitude}">
			

			<label for="paciente.longitude"><b>Longitude: </b></label> <input
				type="number" id="paciente.longitude" name="paciente.longitude" required="required"
				step="0.00000001" placeholder="Longitude" value="${empty paciente.longitude ? '' : paciente.longitude}">
			
			<button name="capturar"
				onclick="javascript: showPosition(); return false;">Capturar</button>
			<br /> <br /> <label for="sintomas"><b>Selecione os
					sintomas: </b></label> <select name="sintomas" multiple="multiple" 
				required="required">
				<c:forEach items="${sintomas}" var="sintoma">
					<option value="${sintoma.percentual}">
						${sintoma.descricao}</option>
				</c:forEach>
			</select>
			<br /> <label for="imagem"><b>Foto Paciente: </b></label> 
				   <input type="file" id="imagem" name="filepaciente">			

			<br><button type="Submit">Testar</button>
		</div>
	</form>
</body>
</html>