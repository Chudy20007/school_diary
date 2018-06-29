$(document).ready(function(){

function timer()
{
var zegar = new Date();
var godzina = zegar.getHours();
var minuta = zegar.getMinutes();
var sekunda = zegar.getSeconds();

if (godzina<10)
	godzina="0"+godzina;

if (minuta<10)
	minuta="0"+minuta;

if (sekunda<10)
	sekunda="0"+sekunda;

document.getElementById("xxx").innerHTML = 
		 godzina+":"+minuta+":"+sekunda;
		 
		 setTimeout("timer()",1000);	
	
}

});