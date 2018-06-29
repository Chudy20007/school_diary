<%-- 
    Document   : kalkulator
    Created on : 2017-11-06, 16:25:06
    Author     : Kacper-PC
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="dziennik.Teacher"%>
<%@page import="dziennik.DbContext"%>
<%@page import="java.sql.PreparedStatement"%>
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
                    <H1 style="text-align: center">Rejestracja jednostki lekcyjnej</H1>
                    <div class="col-md-12 col-md-12-custom">


                        <% if (session.getAttribute("login") != null) { %>
                        <div class="col-md-12 col-md-12-custom">

                            <%

                                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                                Teacher t = new Teacher("root", "");
                                DbContext context = new DbContext(connectionURL, t);
                                context.setConnection();
                                String query = "SELECT przedmioty.ID_przedmiotu, przedmioty.Nazwa_przedmiotu, uczniowie.ID_ucznia, uczniowie.Imie,uczniowie.Nazwisko FROM oceny LEFT JOIN przedmioty ON oceny.ID_przedmiotu =  przedmioty.ID_przedmiotu LEFT JOIN uczniowie ON oceny.ID_ucznia = uczniowie.ID_ucznia";

                                PreparedStatement ps;

                                ps = context.prepareStatement(query);
                                ResultSet resultSet = ps.executeQuery();


                            %>

                            <form method="POST" id='form' action="edycja_oceny.jsp" style="text-align: center">



                                <b>Nazwa przedmiotu: </b>   <select name="przedmiot">
                                    <%   while (resultSet.next()) {%>

                                    <option value="<%= resultSet.getString("przedmioty.ID_przedmiotu")%>"><%= resultSet.getString("przedmioty.Nazwa_przedmiotu")%></option> 



                                    <%  }
             resultSet.first(); %>

                                </select>
                                <br/><br/>
                                <b>Uczeń: </b><select name="uczen">
                                    <%   while (resultSet.next()) {%>

                                    <option value="<%= resultSet.getString("uczniowie.ID_ucznia")%>"><%= resultSet.getString("Imie")%> <%= resultSet.getString("Nazwisko")%></option> 



                                    <%  }%>

                                </select>
                                <br/><br/>
                                <b>Ocena:</b> <input type="number" min="1" max="6" name="ocena" value=""/>

                                <br/><br/>
                                <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
                                <input type="submit" onclick="return sprawdz();" value="Przeslij" />
                                <br/><br/>
                            </form>
                                <script src="WebContent/sprawdz_formularz.js"></script>
                        </div>

                        <% } %>



                        <%
                            System.out.println("Request 2: " + request.getParameter("nazwa"));
                            String l = null;
                            if (request.getParameter("przedmiot") != null) {
                                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                                Teacher t = new Teacher("root", "");
                                DbContext context = new DbContext(connectionURL, t);
                                context.setConnection();
                                if (!context.checkDecimal(request.getParameter("ocena"))) {
                                    return;
                                }
                                String query2 = "UPDATE oceny SET ID_przedmiotu=?, ID_Ucznia=?,Ocena=? WHERE ID_oceny =?";
                                PreparedStatement ps;
                                ps = context.prepareStatement(query2);
                                ps.setString(1, request.getParameter("przedmiot"));
                                ps.setString(2, request.getParameter("uczen"));
                                ps.setString(3, request.getParameter("ocena"));
                                ps.setString(4, request.getParameter("id"));

                                ps.executeUpdate();

                                ps.clearParameters();
                                context.getDbConnection().close();

                            }

                        %>
                    </div>
                </div>
                <div class="row row-custom2">
                    <div class="footer">
                        Wszystkie prawa zastrzeżone. <address>a.kowalski@wwx.pl</address>	
                    </div>

                </div>
            </div>

    </body>
</html>