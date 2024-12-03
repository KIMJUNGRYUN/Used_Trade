package util;

import java.io.File;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/ImageUploadServlet")
public class ImageUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";

        // 디렉토리 없으면 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // 파일 처리
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // 이미지 파일 이름 중복 처리 (파일명에 타임스탬프 추가)
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

        filePart.write(uploadPath + File.separator + uniqueFileName);

        // 업로드 성공 메시지
        response.getWriter().println("File uploaded to: " + uploadPath + File.separator + uniqueFileName);
    }
}

