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


                    <%

                        if (request.getParameter("wyl") != null) {
                            session.removeAttribute("login");
                            session.removeAttribute("id_nauczyciela");
                            session.removeAttribute("id_ucznia");
                            
                        }
                    %>
                    <%
                        if (session.getAttribute("login") == null) {

                    %>    


                    <%      System.out.println("Request: " + request.getParameter("login"));
                        String l = null;
                        if (request.getParameter("login") != null) {
                            String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";

                            Teacher t = new Teacher("root", "");
                            DbContext context = new DbContext(connectionURL, t);
                            context.setConnection();
                            String query = "SELECT ID_nauczyciela,Login, Haslo FROM nauczyciele WHERE Login=? AND Haslo=?";
                            PreparedStatement ps;
                            ps = context.prepareStatement(query);
                            ps.setString(1, request.getParameter("login"));
                            ps.setString(2, request.getParameter("haslo"));
                            ResultSet resultSet = ps.executeQuery();
                           
                            while (resultSet.next()) {
                                session.setAttribute("login", resultSet.getString("Login"));
                                session.setAttribute("id_nauczyciela", resultSet.getString("ID_nauczyciela"));
                    %>
                    <% }
                            query = "SELECT ID_ucznia ,Login, Haslo FROM uczniowie WHERE Login=? AND Haslo=?";
                            
                            ps = context.prepareStatement(query);
                            ps.setString(1, request.getParameter("login"));
                            ps.setString(2, request.getParameter("haslo"));
                            resultSet = ps.executeQuery();
   while (resultSet.next()) {
                                session.setAttribute("login", resultSet.getString("Login"));
                                session.setAttribute("id_ucznia", resultSet.getString("ID_ucznia"));
                    %>
                    <% }
                            context.getDbConnection().close();
                        }%>

                    <%

                        }
                        String x = "brak";
                    %> 
                    <h2 style="text-align: center"> Zalogowany użytkownik: <%= session.getAttribute("login")%> </h2>  

                    <% if (session.getAttribute("login") == null) { %>
                    <jsp:include page="loginForm.jspf" flush="true"/>

                    <% } else { %>

                    <form action="logowanie.jsp" method="POST" style='text-align:center'>
                        <input type="hidden" name="wyl" value='wyloguj'/>
                        <input type='submit' value="Wyloguj"/>

                    </form>

                    <% }
                    %>


                    <br/>




                </div>
                <div class="row row-custom2">
                    <div class="footer">
                        Wszystkie prawa zastrzeżone. <address>a.kowalski@wwx.pl</address>	
                    </div>

                </div>
            </div>

    </body>
</html>
