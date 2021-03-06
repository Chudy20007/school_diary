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

            <jsp:include page="menu.jspf" flush="true"/>
            <div class="container">


                <div class="row row-custom">

                    <div class="col-md-6 col-md-6-custom" style="margin-top:15px">
                        <%
                            if (session.getAttribute("login") != null) {

                                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                                Teacher t = new Teacher("root", "");
                                DbContext context = new DbContext(connectionURL, t);
                                context.setConnection();
                                String query = "SELECT * FROM uczniowie";
                                PreparedStatement ps;
                                ps = context.prepareStatement(query);

                                ResultSet resultSet = ps.executeQuery(query);

                        %>
                        <input type="text" id="myInput" onkeyup="search(2)" placeholder="Szukaj po nazwisku ucznia." title="Podaj nazwisko"><br/><br/>
                        <table class="table table-striped table-responsive table-bordered" id="myTable">

                            <tr class='info'><th onclick="sortTable(0)">Numer ucznia</th><th onclick="sortTable(1)">Imie</th><th onclick="sortTable(2)">Nazwisko</th></tr>
                                    <%   while (resultSet.next()) {%>
                            <tr>
                                <td><%= resultSet.getString("ID_ucznia")%> </td>
                                <td><%= resultSet.getString("Imie")%> </td>
                                <td><%= resultSet.getString("Nazwisko")%> </td>
                                <td style="text-align: center"><a class="glyphicon glyphicon-edit" href="edycja_ucznia.jsp?id=<%= resultSet.getString("ID_ucznia")%>"></a> </td>
                                <td style="text-align: center"><a class="glyphicon glyphicon-remove" href="usun_ucznia.jsp?id=<%= resultSet.getString("ID_ucznia")%>"></a> </td>
                            </tr>
                            <%  } %>
                            </tr>   
                        </table>
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
