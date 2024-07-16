<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세페이지</title>
    
    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="/project/resources/css/notice/notice_view.css"> 
    
    <!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">

    <script src="/bbs/resources/js/httpRequest.js"></script>
    
    <script>
        function del() {
            let c_pwd = document.getElementById("c_pwd").value;

            if (!confirm("삭제 하시겠습니까?")) {
                return;
            }
            if (c_pwd != '${vo.notice_pwd}') {
                alert("비밀번호 불일치");
                return;
            }

            let url = "del.do";
            let param = "idx=${vo.notice_idx}";
            sendRequest(url, param, resultFn, "POST");
        }

        function resultFn() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let data = xhr.responseText;
                let json = (new Function('return ' + data))();

                if (json[0].result == 'yes') {
                    alert("삭제성공");
                    location.href = "list.do?page=${param.page}";
                } else {
                    alert("삭제실패");
                }
            }
        }

        function modify() {
            location.href = "modify.do?idx=${vo.notice_idx}&page=${param.page}";
        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>

<header>
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
</header>

<!-- main -->
<main>
    <form name="f" method="post">
        <h2>${vo.notice_title}</h2><!-- 글 제목 -->
        
        <div class="content-container">
            <div class="content-item">
                <span class="content-label">작성자</span>
                <span class="content-value">${vo.notice_name}</span>
            </div>
            <div class="content-item">
                <span class="content-label">작성일</span>
                <span class="content-value">${vo.notice_regdate}</span>
            </div>
        </div>
        <hr>
            <div class="content-box">
                <span class="content-label">내용</span><br>
                <pre class="content-val">${vo.notice_content}</pre>
            </div>
            <div class="button-container">
                <input type="button" value="목록으로" onclick="history.go(-1)">
            </div>
    </form>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</footer>
</body>
</html>
