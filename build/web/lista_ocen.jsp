<%-- 
    Document   : kalkulator
    Created on : 2017-11-06, 16:25:06
    Author     : Kacper-PC
--%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dziennik.DbContext"%>
<%@page import="dziennik.Teacher"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="WebContent/basic.css" />
        <link rel="stylesheet" type="text/css" href="WebContent/register_style.css" />

        <!-- Bootstrap CSS -->

    </head>
    <body>




        <div class="container-fluid">

            <jsp:include page="menu.jspf"/>


            <div class="container">


                <div class="row row-custom">

                    <div class="col-md-6 col-md-6-custom" style="margin-top:15px">
                        <%
                            if (session.getAttribute("login") != null) {

                                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";
                                String query = null;
                                Teacher t = new Teacher("root", "");
                                DbContext context = new DbContext(connectionURL, t);
                                context.setConnection();
                                PreparedStatement ps=null;
                               ResultSet resultSet=null;
                                if (session.getAttribute("id_nauczyciela") != null) {
                                    query = "SELECT uczniowie.Imie, uczniowie.Nazwisko,przedmioty.Nazwa_przedmiotu ,oceny.Ocena,oceny.ID_oceny FROM oceny LEFT JOIN przedmioty ON oceny.ID_przedmiotu = przedmioty.ID_przedmiotu LEFT JOIN uczniowie ON oceny.ID_ucznia = uczniowie.ID_ucznia";
                                  ps = context.prepareStatement(query);  
                                    resultSet = ps.executeQuery(query);
                                    
                                    %>
                                      <input type="text" id="myInput" onkeyup="search(0)" placeholder="Szukaj po nazwie przedmiotu." title="Podaj nazwę przedmiotu"><br/><br/>
                        <table class="table table-striped table-responsive table-bordered" id="myTable">
                            <tr class='info'><th onclick="sortTable(0)">Przedmiot</th><th onclick="sortTable(1)">Imie</th><th onclick="sortTable(2)" >Nazwisko</th><th onclick="sortTable(3)">Ocena</th></tr>
                                    <%   while (resultSet.next()) {%>
                            <tr>
                                <td><%= resultSet.getString("przedmioty.Nazwa_przedmiotu")%> </td>
                                <td><%= resultSet.getString("uczniowie.Imie")%> </td>
                                <td><%= resultSet.getString("uczniowie.Nazwisko")%> </td>
                                <td><%= resultSet.getString("oceny.Ocena")%> </td>
                                <td style="text-align: center"><a class="glyphicon glyphicon-edit" href="edycja_oceny.jsp?id=<%= resultSet.getString("ID_oceny")%>"></a> </td>
                                <td style="text-align: center"><a class="glyphicon glyphicon-remove" href="usun_ocene.jsp?id=<%= resultSet.getString("ID_oceny")%>"></a> </td>
                            </tr>
                            <%  } %>
                            </tr>   
                        </table>
                                    
                           <%     } %>

                             <%   if (session.getAttribute("id_ucznia") != null) {
                                    query = "SELECT * FROM oceny LEFT JOIN przedmioty ON oceny.ID_przedmiotu = przedmioty.ID_przedmiotu LEFT JOIN uczniowie ON oceny.ID_ucznia = uczniowie.ID_ucznia WHERE oceny.ID_ucznia= ?";
                                    ps = context.prepareStatement(query);
                                    String x = (String)session.getAttribute("id_ucznia");
                                  ps.setString(1, x);
                                    
                                    resultSet = ps.executeQuery();
                                   
                                    %>
                                    
                                      <input type="text" id="myInput" onkeyup="search(0)" placeholder="Szukaj po nazwie przedmiotu." title="Podaj nazwę przedmiotu"><br/><br/>
                        <table class="table table-striped table-responsive table-bordered" id="myTable">
                            <tr class='info'><th onclick="sortTable(0)">Przedmiot</th><th onclick="sortTable(1)">Imie</th><th onclick="sortTable(2)" >Nazwisko</th><th onclick="sortTable(3)">Ocena</th></tr>
                                    <% while (resultSet.next()) {%>
                           
                                 <tr>
                                <td><%= resultSet.getString("przedmioty.Nazwa_przedmiotu")%> </td>
                                <td><%= resultSet.getString("uczniowie.Imie")%> </td>
                                <td><%= resultSet.getString("uczniowie.Nazwisko")%> </td>
                                <td><%= resultSet.getString("oceny.Ocena")%> </td>
                                <td style="text-align: center"><a class="glyphicon glyphicon-edit" href="edycja_oceny.jsp?id=<%= resultSet.getString("ID_oceny")%>"></a> </td>
                                <td style="text-align: center"><a class="glyphicon glyphicon-remove" href="usun_ocene.jsp?id=<%= resultSet.getString("ID_oceny")%>"></a> </td>
                            </tr>
                            <%  } %>
                            </tr>   
                        </table>
                                <%} %>

                                
                        

                      
                        <%
                                context.getDbConnection().close();
                            }%>

                    </div>




                    <br/>




                </div>
                <div class="row row-custom2">
                    <div class="footer">
                        Wszystkie prawa zastrzeżone. <address>a.kowalski@wwx.pl</address>	
                    </div>

                </div>
            </div>
            <script src="WebContent/sortowanie.js"></script>
            <script src="WebContent/wyszukiwanie.js"></script>
    </body>
</html>
