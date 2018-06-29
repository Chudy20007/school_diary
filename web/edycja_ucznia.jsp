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
                    <H1 style="text-align: center">Edycja ucznia:</H1>
                    <div class="col-md-12 col-md-12-custom">


                        <% if (session.getAttribute("login") != null) { %>
                        <%         String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                            Teacher t = new Teacher("root", "");
                            DbContext context = new DbContext(connectionURL, t);
                            context.setConnection();

                            String query = "SELECT * FROM uczniowie WHERE ID_ucznia=?";
                            PreparedStatement ps;
                            ps = context.prepareStatement(query);
                            ps.setString(1, request.getParameter("id"));
                            ResultSet resultSet = ps.executeQuery();

                        %>
                        <% while (resultSet.next()) {%>
                        <div class="col-md-12 col-md-12-custom">
                            <form method="POST" id='form' action="edycja_ucznia.jsp" style="text-align: center">
                                <b>Imie:</b> <input type="text" name="imie" value="<%= resultSet.getString("Imie")%>" placeholder="min. 4 znaki" /><br/><br/>
                                <b>Nazwisko:</b> <input type="text" name="nazwisko" value="<%= resultSet.getString("Nazwisko")%>" placeholder="min. 4 znaki" /><br/>
                                <input type="hidden" name="id" value="<%= request.getParameter("id")%>"/>
                                <input type="submit" onclick="return sprawdz();" value="Przeslij" />
                                <br/><br/>
                            </form>
                        </div>
<script src="WebContent/sprawdz_formularz.js"></script>
                        <% } %>
                        <%  ps.clearParameters();
        context.getDbConnection().close();
    } %>



                        <%
                            System.out.println("Request 2: " + request.getParameter("imie"));
                            String l = null;
                            if (request.getParameter("imie") != null) {
                                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                                Teacher t = new Teacher("root", "");
                                DbContext context = new DbContext(connectionURL, t);
                                context.setConnection();
                                String query = "UPDATE uczniowie SET Imie=?,Nazwisko=? WHERE ID_ucznia=?";
                                PreparedStatement ps;
                                ps = context.prepareStatement(query);
                                ps.setString(1, request.getParameter("imie"));
                                ps.setString(2, request.getParameter("nazwisko"));
                                ps.setString(3, request.getParameter("id"));

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