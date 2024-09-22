<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>구매 목록조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		function fncGetList(currentPage) {

			//document.getElementById("currentPage").value = currentPage;
			//document.detailForm.submit();
			$("#currentPage").val(currentPage);
			$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
		}
	
		$(function(){
			

			$( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
				//Debug..
				  var tranNo = $(this).find('input[name="tranNo"]').val();
				//alert( tranNo  );
				self.location ="/purchase/getPurchase?tranNo="+tranNo;
				
			});
			
			$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				//Debug..
				  var prodNo = $(this).find('input[name="prodNo"]').val();
				//alert( tranNo  );
				self.location ="/product/getProduct?prodNo="+prodNo+"&menu=search";
				
			});			

			$( ".ct_list_pop td:nth-child(11):contains('물건도착')" ).on("click" , function() {
				//Debug..
				
				var tranNo = $(this).find('input[name="tranNo"]').val();
				alert(  tranNo );
				self.location ="/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=003";
				
			});	
			
			//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			
			
			//==> 아래와 같이 정의한 이유는 ??
			//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");			
	});
	
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
<form name="detailForm" action="/purchase/listPurchase" method="post">
////////////////////////////////////////////////////////////////////////////////////////////////// -->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
	<!-- 수정 -->
		<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">주소</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">수령인 연락처</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value = "0"/>
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value = "${i+1}"/>		
	<tr class="ct_list_pop">
		<td align="center">
			<!-- 수정 -->
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
			<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${i} </a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			${i}
			<input type="hidden" name = "tranNo" id="tranNo" value="${purchase.tranNo}" />
		</td>
		<td></td>
		<td align="left">
			<!-- 수정 -->
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
			<a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo}&menu=search">${purchase.purchaseProd.prodName}</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			${purchase.purchaseProd.prodName}
			<input type="hidden" name = "prodNo" id="prodNo" value="${purchase.purchaseProd.prodNo}" />
		</td>
		<td></td>
		<!-- 수정 -->
		<td align="left">${purchase.divyAddr}</td>
		<td></td>
		<!-- 수정 -->
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<!-- 수정 -->
		<td align="left">현재
			${purchase.tranCode eq "001" ? "구매완료" : purchase.tranCode eq "002" ? "배송 중" : "배송완료" }
				상태 입니다.</td>
		<td></td>
		<td align="left">
			<c:if test = "${purchase.tranCode =='002'}">
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
			<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=003">물건도착</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			물건도착
			</c:if>
		</td>
	</tr>	
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>

		<jsp:include page="../common/pageNavigator.jsp"/>	
	
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>

</div>

</body>
</html>