package controller;

import model.Product;
import dao.ProductDAOImpl;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AddProductController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddProductController extends HttpServlet {

    private static final String UPLOAD_DIR = "C:\\02Workspaces\\Used_Trade\\src\\main\\webapp\\images";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. 로그인한 사용자의 ID 가져오기
            HttpSession session = request.getSession(false); // 세션 가져오기
            Integer sellerId = (Integer) session.getAttribute("userId"); // 로그인한 사용자의 ID

            if (sellerId == null) {
                response.sendRedirect("index.jsp?status=unauthorized");
                return; // 로그인하지 않은 사용자는 상품 등록 불가
            }

            // 2. 상품 정보 가져오기
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");

            // 3. 이미지 파일 처리
            Part imagePart = request.getPart("image");
            String fileName = imagePart.getSubmittedFileName();

            // 저장 경로 설정
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // 디렉토리 생성
            }
            String filePath = UPLOAD_DIR + File.separator + fileName;

            imagePart.write(filePath); // 파일 저장

            // 4. Product 객체 생성 및 데이터 설정
            Product product = new Product();
            product.setTitle(title);
            product.setDescription(description);
            product.setPrice(price);
            product.setCategoryId(category);
            product.setImage(fileName);
            product.setSellerId(sellerId); // 세션에서 가져온 사용자 ID
            product.setStatus("Available");
            product.setCreatedAt(new Date());

            // 5. DAO 호출하여 DB에 저장
            ProductDAOImpl productDAO = new ProductDAOImpl();
            boolean isAdded = productDAO.addProduct(product);

            if (isAdded) {
                response.sendRedirect("main.jsp?status=success");
            } else {
                response.sendRedirect("add_product.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add_product.jsp?status=error");
        }
    }
}
