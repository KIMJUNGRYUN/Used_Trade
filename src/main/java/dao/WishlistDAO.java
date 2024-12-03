package dao;

import model.Product;
import model.Wishlist;
import java.util.List;

public interface WishlistDAO {
    void addToWishlist(int userId, int productId); // 찜 추가
 // 사용자 ID로 찜 목록 조회
    boolean isProductInWishlist(int userId, int productId); // 이미 찜했는지 확인
    void removeFromWishlist(int userId, int productId); // 찜 삭제
    List<Product> getWishlistByUserId(int userId);
}
