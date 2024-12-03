package dao;
import model.Login;

public interface LoginDAO {
	 boolean loginCheck(Login loginBean);
	    String getUserRole(String email); 
	       
	        boolean isEmailExists(String email); // 이메일 중복 확인
	    

}