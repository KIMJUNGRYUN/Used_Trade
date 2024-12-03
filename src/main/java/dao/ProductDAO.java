package dao;

import java.util.List;
import model.Product;

public interface ProductDAO {
    List<Product> getAllProducts();
	List<Product> getAllProducts(int pageNumber, int pageSize);
	int getTotalProductCount();
	
	boolean addProduct(Product product);
	boolean updateProduct(Product product);  // 상품 수정
    boolean deleteProduct(int productId);   // 상품 삭제
    Product getProductById(int productId); 
    List<Product> searchProducts(String keyword);
    boolean isEmailExists(String email);
    boolean deleteProductsByCustomerId(int customerId);
}
