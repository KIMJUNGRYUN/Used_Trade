package controller;

import model.Product;
import dao.ProductDAOImpl;
import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/EditProductController") // URL 매핑 확인
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class EditProductController extends HttpServlet {

    private static final String UPLOAD_DIR = "C:\\02Workspaces\\Used_Trade\\src\\main\\webapp\\images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 세션 검증
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // 상품 정보 가져오기
            int productId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String categoryId = request.getParameter("categoryId");
            String status = request.getParameter("status");

            // DAO를 통해 기존 상품 가져오기
            ProductDAOImpl productDAO = new ProductDAOImpl();
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                response.sendRedirect("main.jsp?status=product_not_found");
                return;
            }

            // 업데이트할 값 설정
            product.setTitle(title);
            product.setDescription(description);
            product.setPrice(price);
            product.setCategoryId(categoryId);
            product.setStatus(status);

            // 이미지 처리
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                String filePath = UPLOAD_DIR + File.separator + fileName;

                // 디렉토리 확인
                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imagePart.write(filePath); // 파일 저장
                product.setImage(fileName); // 이미지 경로 업데이트
            }

            // 상품 업데이트 처리
            boolean isUpdated = productDAO.updateProduct(product);

            if (isUpdated) {
                response.sendRedirect("product_detail.jsp?id=" + productId + "&status=update_success");
            } else {
                response.sendRedirect("edit_product.jsp?id=" + productId + "&status=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_product.jsp?status=error");
        }
    }
}
