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
                    <H1 style="text-align: center">Rejestracja obecnosci ucznia</H1>
                    <div class="col-md-12 col-md-12-custom">


                        <% if (session.getAttribute("login") != null) { %>
                        <div class="col-md-12 col-md-12-custom">

                            <%

                                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                                Teacher t = new Teacher("root", "");
                                DbContext context = new DbContext(connectionURL, t);
                                context.setConnection();
                                String query = "SELECT jednostki_lekcyjne.Data,jednostki_lekcyjne.ID_planu, przedmioty.ID_przedmiotu, przedmioty.Nazwa_przedmiotu, jednostki_lekcyjne.Godzina FROM jednostki_lekcyjne LEFT JOIN przedmioty on jednostki_lekcyjne.ID_przedmiotu = przedmioty.ID_przedmiotu";
                                String query2 = "SELECT * FROM uczniowie";
                                PreparedStatement ps;
                                PreparedStatement ps2;
                                ps = context.prepareStatement(query);
                                ResultSet resultSet = ps.executeQuery(query);

                                ps2 = context.prepareStatement(query2);
                                ResultSet resultSet2 = ps2.executeQuery(query2);
                            %>

                            <form method="POST" action="rejestracja_obecnosci.jsp" style="text-align: center">



                                <b>Nazwa przedmiotu: </b>   <select name="przedmiot">
                                    <%   while (resultSet.next()) {%>

                                    <option value="<%= resultSet.getString("przedmioty.ID_przedmiotu")%>"><%= resultSet.getString("przedmioty.Nazwa_przedmiotu")%></option> 



                                    <%  }
             resultSet.first(); %>

                                </select>
                                <br/><br/>
                                <b>Uczeń: </b><select name="uczen">
                                    <%   while (resultSet2.next()) {%>

                                    <option value="<%= resultSet2.getString("ID_ucznia")%>"><%= resultSet2.getString("Imie")%> <%= resultSet2.getString("Nazwisko")%></option> 



                                    <%  } %>

                                </select>
                                <br/><br/>
                                <b>Data: </b>   <select name="data">
                                    <%   while (resultSet.next()) {%>

                                    <option value="<%= resultSet.getString("jednostki_lekcyjne.ID_planu")%>"><%= resultSet.getString("jednostki_lekcyjne.Data")%> <%= resultSet.getString("jednostki_lekcyjne.godzina")%></option> 



                                    <%  }
             resultSet.first();%>

                                </select>

                                <br/><br/>
                                <b>Obecny </b>   <select name="obecny">


                                    <option value="tak">tak</option>
                                    <option value="nie">nie</option>

                                </select>
                                <input type="hidden" name="id" value="<%= request.getParameter("id")%>"/>
                                <% context.getDbConnection().close();
             } %>
                                <%

                                    System.out.println("Request 2: " + request.getParameter("nazwa"));
                                    String l = null;
                                    if (request.getParameter("przedmiot") != null) {
                                        String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                                        Teacher t = new Teacher("root", "");
                                        DbContext context = new DbContext(connectionURL, t);
                                        context.setConnection();

                                        String query2 = "UPDATE obecnosci SET ID_planu=?,ID_ucznia=?,Obecny=? WHERE ID_obecnosci=?";
                                        PreparedStatement ps;
                                        ps = context.prepareStatement(query2);
                                        ps.setString(1, request.getParameter("data"));
                                        ps.setString(2, request.getParameter("uczen"));
                                        ps.setString(3, request.getParameter("obecny"));
                                        ps.setString(4, request.getParameter("id"));

                                        ps.executeUpdate();

                                        ps.clearParameters();
                                        context.getDbConnection().close();

                                    }

                                %>       


                                <br/><br/>
                                <input type="submit" value="Przeslij" />
                                <br/><br/>
                            </form>
                        </div>






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