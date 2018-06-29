<%-- 
    Document   : usun_jednostke_lekcyjna
    Created on : 2017-11-09, 21:46:04
    Author     : Kacper-PC
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dziennik.Teacher"%>
<%@page import="dziennik.DbContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if (request.getParameter("id") != null && session.getAttribute("login") != null) {
                String connectionURL = "jdbc:mysql://127.0.0.1/dziennik";
                Teacher t = new Teacher("root", "");
                DbContext context = new DbContext(connectionURL, t);
                context.setConnection();
                String query = "DELETE FROM jednostki_lekcyjne WHERE ID_planu = ? ";
                PreparedStatement ps2;
                ps2 = context.prepareStatement(query);
                ps2.setString(1, request.getParameter("id"));
                ps2.executeUpdate();
                response.sendRedirect("lista_jednostek.jsp");
            }

        %>
    </body>
</html>
