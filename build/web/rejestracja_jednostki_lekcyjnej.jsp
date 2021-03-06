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
                                String query = "SELECT * FROM przedmioty";
                                PreparedStatement ps;
                                ps = context.prepareStatement(query);

                                ResultSet resultSet = ps.executeQuery(query);
                            %>

                            <form method="POST" id='form' action="rejestracja_jednostki_lekcyjnej.jsp" style="text-align: center">



                                <b>Nazwa przedmiotu: </b>   <select name="przedmiot">
                                    <%   while (resultSet.next()) {%>

                                    <option value="<%= resultSet.getString("ID_przedmiotu")%>"><%= resultSet.getString("Nazwa_przedmiotu")%></option> 



                                    <%  } %>

                                </select>
                                    <br/><br/><b>Data:</b>  <input type="date" name="data"/>
                                    <br/><br/><b>Godzina:</b> <input type="text" name="godzina"/>


                                <%
                                    context.getDbConnection().close();
                                %>
                                <br/><br/>
                                <input type="submit"  value="Przeslij" />
                                <br/><br/>
                            </form>
                        </div>
<script src="WebContent/sprawdz_formularz.js"></script>
                        <% } %>



                        <%
                            System.out.println("Request 2: " + request.getParameter("nazwa"));
                            String l = null;
                            if (request.getParameter("przedmiot") != null) {
                                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                                Teacher t = new Teacher("root", "");
                                DbContext context = new DbContext(connectionURL, t);
                                context.setConnection();

                                String query2 = "INSERT INTO jednostki_lekcyjne (ID_przedmiotu,Data,Godzina) VALUES (?,?,?)";
                                PreparedStatement ps;
                                ps = context.prepareStatement(query2);
                                ps.setString(1, request.getParameter("przedmiot"));
                                ps.setString(2, request.getParameter("data"));
                                ps.setString(3, request.getParameter("godzina"));

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