<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.0/jquery.validate.min.js"></script>
<title>Insert title here</title>
</head>
<style>
	table, th, td {
		border: 1px solid #909090;
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
	td {
		background-color: #ddd;
	}
	.oikealle {
		text-align: right;
</style>
<body>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin</span></th>
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
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="submit" id="tallenna" value="Hyväksy"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="vanhaetunimi" id="vanhaetunimi">
</form>
<span id="ilmo"></span>
</body>
<script>
$ (document).ready(function() {
	$("#takaisin").click(function() {
		document.location="listaaasiakkaat.jsp";
	});
	
	var etunimi = requestURLParam("etunimi");  	
	$.ajax({url:"asiakkaat/haeyksi/"+etunimi, type:"GET", dataType:"json", success:function(result){	
		$("#vanhaetunimi").val(result.etunimi);		
		$("#etunimi").val(result.etunimi);	
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);			
    }});
	
	$("#tiedot").validate({
		rules: {
			etunimi:{
				required: true,
				minlength: 2
			},
			sukunimi:{
				required: true,
				minlength: 2
			},
			puhelin:{
				required: true,
				minlength: 5
			},
			sposti:{
				required: true,
				minlength: 3
			}
		},
		messages: {
			etunimi:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sukunimi:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},
		submitHandler: function(form) {
			paivitaTiedot();
		}
	});
});

function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
      	$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
	  }
  }});	
}

</script>
</html>