<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoronApp</title>
<style type="text/css">
body {
	font-family: Arial, Helvetica, sans-serif;
	margin: 0;
}

html {
	box-sizing: border-box;
}

*, *:before, *:after {
	box-sizing: inherit;
}

.resultado {
	padding: 50px;
	text-align: center;
	background-color: #474e5d;
	color: white;
}
.resultado-verde {	
	background-color: #4D9332;	
}

.resultado-laranja {	
	background-color: #DFA305;	
}

.resultado-vermelho {	
	background-color: #DF0505;	
}

</style>
</head>
<body>
<c:if test="${paciente.resultado < 50}">
   <div class="resultado resultado-verde">
</c:if>
<c:if test="${paciente.resultado >= 50 && paciente.resultado < 70}">
   <div class="resultado resultado-laranja">
</c:if>
<c:if test="${paciente.resultado >= 70 }">
   <div class="resultado resultado-vermelho">
</c:if>

		<h1>Sr.: ${paciente.nome}</h1>
		<p>Seu resultado é: ${paciente.resultado}%</p>
	</div>
	<div style="margin: auto; padding: 10px; text-align: center;"><button onclick="location.href='/'" type="button">
         Novo Teste</button></div>
</body>
</html>