/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dziennik;

/**
 *
 * @author Kacper-PC
 */
public class Teacher {
private String teacherLogin;
private String teacherPassword;

public Teacher(String login, String password){
    teacherLogin = login;
    teacherPassword = password;
}
public String getTeacherLogin(){
   return teacherLogin;
}

public String getTeacherPassword(){
    return teacherPassword;
}
}
