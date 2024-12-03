package model;

import java.sql.Timestamp;

public class Customer {
    private int id;             // 고객 ID
    private String email;
    private String username;    // 사용자명
    private String password;    // 비밀번호
    private String role;        // 권한 (관리자, 일반 사용자 등)
    private Timestamp createdAt; // 가입일

    // 기본 생성자
    public Customer() {}

    // Getter와 Setter 메서드
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
