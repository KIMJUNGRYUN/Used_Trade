package dao;

import model.Customer;
import java.util.List;

public interface CustomerDAO {
    List<Customer> getAllCustomers();  // 모든 고객 목록 조회
    boolean deleteCustomerById(int id);  
    List<Customer> getCustomersByPage(int pageNumber, int pageSize);
    int getTotalCustomerCount();
}
