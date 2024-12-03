<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Naver Map</title>
    <script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=pvq8ffxucz"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        #map {
            width: 100%;
            height: 500px;
        }
        .container {
            text-align: center;
            padding: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        #address {
            margin-top: 10px;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>내 위치 표시</h1>
        <button class="btn" id="showLocation">내 위치</button>
        <p id="address">현재 위치: 서울시청</p>
    </div>
    <div id="map"></div>

    <script>
        let map, marker;

        // 네이버 지도 초기화
        function initMap(latitude, longitude) {
            const position = new naver.maps.LatLng(latitude, longitude);
            map = new naver.maps.Map('map', {
                center: position,
                zoom: 15
            });

            marker = new naver.maps.Marker({
                position: position,
                map: map
            });
        }

        // 지도와 텍스트 업데이트
        function showSeomyeon() {
            const seomyeonLat = 35.1575; // 서면역 위도
            const seomyeonLng = 129.0597; // 서면역 경도

            const position = new naver.maps.LatLng(seomyeonLat, seomyeonLng);

            // 지도와 마커 위치 업데이트
            map.setCenter(position);
            marker.setPosition(position);

            // 텍스트 업데이트
            document.getElementById("address").innerText = "현재 위치: 서면역 부근";

            // 서버로 위치 데이터 전송
            fetch("<%= request.getContextPath() %>/SaveLocationServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    latitude: seomyeonLat,
                    longitude: seomyeonLng
                }),
            })
            .then(response => response.text())
            .then(data => {
                if (data.includes("success")) {
                    alert("위치가 저장되었습니다.");
                    // 저장 완료 후 main.jsp로 이동
                    window.location.href = "<%= request.getContextPath() %>/main.jsp";
                } else {
                    alert("위치 저장에 실패했습니다.");
                }
            })
            .catch(err => {
                console.error("Error saving location:", err);
                alert("위치 저장 중 오류가 발생했습니다.");
            });
        }

        // 초기 지도 로드 (서울 시청 위치)
        window.onload = function () {
            initMap(37.5665, 126.9780); // 서울시청 위치
        };

        // 버튼 클릭 시 서면역 표시 및 저장
        document.getElementById("showLocation").addEventListener("click", showSeomyeon);
    </script>
</body>
</html>
