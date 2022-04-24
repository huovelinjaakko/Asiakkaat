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
	/*tr:hover {background-color: coral;}*/
	tr:nth-child(even) {background-color: #f2f2f2;}
</style>
<body>
<input type="text" id="haku" onkeyup="haeTietoa()" placeholder="Search for names..">
<table id="listaus">
	<thead>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
function haeTietoa() {
  // Declare variables
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("haku");
  filter = input.value.toUpperCase();
  table = document.getElementById("listaus");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
</script>
<script>
$ (document).ready(function() {
	$.ajax({url:"asiakkaat", type: "GET", dataType:"json", success:function(result){ 
		$.each(result.asiakkaat, function(i, field) {
			var htmlStr;
			htmlStr+="<tr>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puhelin+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="</tr>";
			$ ("#listaus tbody").append(htmlStr);
		});
	}});
});
</script>
</body>
</html>