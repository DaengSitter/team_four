<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			.table_main  {border-collapse:collapse;
				  					 width: 700px;
				  					 height: 500px;}
				  					 
			.table_sub {border-collapse:collapse;}
				  		
		 	.table_reply{border-collapse:collapse;
				  		width: 700px;
				  		height: 200px;}
		</style>
    	
		<script src="/project/resources/js/httpRequest.js"></script>
		
		
		<script>
			window.onload = function(){
				commList();
			}
			
			function commList(){
				let url = "adminOneCommentList.do";
				let param = "oneinquiry_idx=" + ${vo.oneinquiry_idx};
				sendRequest(url, param, commListFn, "post");
			}
			function commListFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText; //comment_list.do -> oneComment_list.jsp 갔다가 콜백으로 옴 가지고 온 스트링은 json도 아니라 div에 바로 뿌릴 수 있음
					console.log(data);
					document.getElementById("comment_disp").innerHTML = data;
				}
			}
			
			
			/* 1:1 답변 등록 및 1:1문의 테이블 '답변완료'로 변경 */
			function oneCommSubmit(f){
				
				 let content = f.onecomment_content.value;
					
				    if(content == null || content == ''){
				        alert("내용을 입력하세요");
				        return;
				    }
				
				    let url = 'oneCommentInsert.do';
				    let param = new FormData(f);
		
				    // FormData 데이터 확인
				    for (let pair of param.entries()) {
				        console.log(pair[0] + ', ' + pair[1]);
				    }
		
				    // XMLHttpRequest 객체 생성
				    var xhr = new XMLHttpRequest();
				    xhr.open("POST", url, true);
		
				    // 작업이 완료된 후 호출될 콜백메서드 지정
				    xhr.onreadystatechange = function() {
				        if (xhr.readyState === 4 && xhr.status === 200) {
				            let data = xhr.responseText;
				            let json = (new Function('return ' + data))();
				            
				            if(json[0].result === 'yes'){
				                alert("1:1 답변이 등록되었습니다");
				                location.href="adminOneInquiryView.do?oneinquiry_idx=" + ${vo.oneinquiry_idx };
				               // commList();
				            } else {
				                alert("등록실패");
				            }
				        }
				    };
		
				    // 요청 전송
				    xhr.send(param);
			}
			
			/* 1:1문의 삭제 (업데이트) 및 1:1문의 테이블 '답변대기'로 다시 변경*/
			function oneCommDel(onecomment_idx, onecomment_oneinquiry_idx){
				let url = "oneCommentAdminDelete.do";
				let param = "onecomment_idx=" + onecomment_idx + "&onecomment_oneinquiry_idx=" + onecomment_oneinquiry_idx;
				sendRequest(url, param, resCommDel, "post");
			}
			function resCommDel(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert("답변이 삭제되었습니다");
						commList();
					}else{
						alert("삭제실패");
					}
				}
			}
			
		</script>
	</head>
	
	<body>
		<div>1:1문의 상세보기</div>
		<table class="table_main" border="1" align="center">
			<tr>
				<td>문의번호</td>
				<td>${vo.oneinquiry_idx }</td>
			</tr>
			
			<tr>
				<td>고객번호</td>
				<td>${vo.oneinquiry_user_idx }</td>
			</tr>
			
			<tr>
				<td>카테고리</td>
				<td>${vo.oneinquiry_category }</td>
			</tr>
			
			<tr>
				<td>제목</td>
				<td>${vo.oneinquiry_title }</td>
			</tr>
			
			<tr>
				<td>작성일</td>
				<td>${vo.oneinquiry_regdate }</td>
			</tr>
			
			<tr>
				<td>내용</td>
				<td>${vo.oneinquiry_content }</td>
			</tr>
			
			<tr>
				<td>첨부파일</td>
				<td>
				<c:if test="${vo.oneinquiry_filename ne 'no_file'}">
				<c:choose>
					<c:when test="${vo.oneinquiry_filetype.startsWith('image/')}">
						<img src="${pageContext.request.contextPath}/resources/upload/${vo.oneinquiry_filename}" width="700">
					</c:when>
					<c:otherwise> <!-- 그림 이외의 파일 다운로드 링크 띄우기 -->
						<a href="${pageContext.request.contextPath}/resources/upload/${vo.oneinquiry_filename}" download>download: ${vo.oneinquiry_filename }</a>
					</c:otherwise>
				</c:choose>
				</c:if>
				</td>
				
			</tr>
		</table>	
		
		<hr width="700">
		<div id="comment_disp"></div>
		

<!-- 답변 영역  -->	
		<hr width="700">	
		<div>
		<form>
			<table class="table_sub" border="1" align="center" width="700">
				<tr>
					<td>관리자</td>
					<input type="hidden" name="onecomment_admin_idx" value="${sessionScope.admin.admin_idx }">
					<input type="hidden" name="onecomment_oneinquiry_idx" value="${vo.oneinquiry_idx }">
					<td><input name="onecomment_admin_name" value="${sessionScope.admin.admin_name }" readonly></td>
					<td><input type="button" value="등록" onclick="oneCommSubmit(this.form);"></td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td colspan="2"><textarea name="onecomment_content" rows="5" cols="80" style="resize:none" wrap="on"></textarea></td>
				</tr>
			</table>
		</form>
		
		<input type="button" value="목록보기" onclick="location.href='admin_go_board.do?page=${param.page}'">
		</div>

	</body>
</html>