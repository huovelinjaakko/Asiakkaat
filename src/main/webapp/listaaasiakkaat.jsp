<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<style>
	table, th, td {
		border: 1px solid #ddd;
		border-collapse: collapse;
		
			
	}
	th {
  		height: 25px;
  		text-align: left;
  		background-color: #00C301;
  		color: white;
	}
	th, td {
		padding: 7px;
	}
	.oikealle {
		text-align: right;
	}
	/*tr:hover {background-color: coral;}*/
	tr:nth-child(even) {background-color: #f2f2f2;}
</style>
<body>

<table id="listaus">
	<thead>
		<tr>
			<th><a id="linkki" href="login?logout=1">Kirjaudu ulos (<%out.print(session.getAttribute("kayttaja"));%>)</a></th>
			<th colspan="5" class="oikealle"><span id="uusiAsiakas">Lisää asiakas</span></th>
		</tr>
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="hakunappi"></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<script>
$ (document).ready(function() {
	
	$("#uusiAsiakas").click(function() {
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function() {
		console.log($("#hakusana").val());
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event) {
		if(event.which==13) {
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus();
});

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type: "GET", dataType:"json", success:function(result){ 
		$.each(result.asiakkaat, function(i, field) {
			var htmlStr;
			htmlStr+="<tr>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puhelin+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="<td><a href='muutaasiakas.jsp?etunimi="+field.etunimi+"'>Muuta</a>&nbsp;";
			htmlStr+="<span class='poista' onclick=poista('"+field.etunimi+"')>Poista</span></td>";
			htmlStr+="</tr>";
			$ ("#listaus tbody").append(htmlStr);
		});
	}});
}
function poista(etunimi) {
	if(confirm("Poista asiakas " + etunimi + "?")) {
		$.ajax({url:"asiakkaat/"+etunimi, type:"DELETE", dataType:"json", success:function(result){
			if(result.response==0){
				$("#ilmo").html("Asiakkaan poisto epäonnistui.");
			}else if(result.response==1){
				alert("Asiakkaan " + etunimi +" poisto onnistui.");
				haeAsiakkaat();
			}
			}
		});
	}
}
</script>
</body>
</html>