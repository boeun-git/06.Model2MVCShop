<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상품목록조회/상품관리 페이지 -->
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>상품 목록조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- CDN(Content Delivery Network) 호스트 사용 <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>-->
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  	<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
	
	<script type="text/javascript">
		
		//=====기존Code 주석 처리 후  jQuery 변경 ======//
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetList(currentPage){
			//document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
		   	//document.detailForm.submit();
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
		}
		
		$(function(){
			
				$('#searchCondition').on("change" , function() {
					//Debug..
					//alert(  $( ".searchCondition" ).html() );

					var searchCondition=$('#searchCondition').val();
					
					if (searchCondition == 2){
						$("input[name='searchKeyword']").attr("type" , "hidden");
						$("input[name='searchPriceStart']").attr("type" , "text");
						$("input[name='searchPriceEnd']").attr("type" , "text");
			
					}else{
						$("input[name='searchKeyword']").attr("type" , "text");
						$("input[name='searchPriceStart']").attr("type" , "hidden");
						$("input[name='searchPriceEnd']").attr("type" , "hidden");				
					}
					
				});
				
				
				$('#searchSorting').on("change" , function() {
					//Debug..
					//alert(  $( ".searchSorting" ).html() );

					//document.getElementById("currentPage").value = 1;
					//document.detailForm.submit();
					fncGetList(1);
				});				
				 
				 
				 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
						//Debug..
						//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
						fncGetList(1);
					});

				$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
					//Debug..
					  var prodNo = $(this).find('input[name="prodNo"]').val();
					
					//////////////////////////// 추가 , 변경된 부분 ///////////////////////////////////
					self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${menu}";
					////////////////////////////////////////////////////////////////////////////////////////////  
					
				});
				
				
				$( ".ct_list_pop td:nth-child(11)" ).on("click" , function() {
					//Debug..
					  var prodNo = $(this).parent().children().find('input[name="prodNo"]').val();
					
						$.ajax( 
								{
									url : "/product/json/getProduct/"+prodNo ,
									method : "GET" ,
									dataType : "json" ,
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(JSONData , status) {

										//Debug...
										//alert(status);
										//Debug...
										//alert("JSONData : \n"+JSONData);
										
										var displayValue = "<h3>"
																	+"상품명 : "+JSONData.prodName+"<br/>"
																	+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
																	+"제조일자 : "+JSONData.manuDate+"<br/>"
																	+"가격 : "+JSONData.price+"<br/>"
																	+"등록일 : "+JSONData.regDate+"<br/>"
																	+"</h3>";
										//Debug...									
										//alert(displayValue);
										$("h3").remove();
										$( "#"+prodNo+"" ).html(displayValue);
									}
							});
				});
				
				
				$( ".ct_list_pop td:nth-child(9):contains('배송하기')" ).on("click" , function() {
					//Debug..
					//alert(  $( this ).text().trim() );
					var proTranNo = $(this).find('input[name="proTranNo"]').val();
					self.location ="/purchase/updateTranCodeByProd?tranNo="+proTranNo+"&tranCode=002";
					
				});	
				
				//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
				$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
				
				
				//==> 아래와 같이 정의한 이유는 ??
				//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
				$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");		
				

				
				
				
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				$("#searchKeyword").autocomplete({
			        source: function(request, response) {
					
						if ($("#searchCondition").val() == "1"){
							$.ajax({
								url : "/product/json/getProductAutocomplete/"+ encodeURIComponent(request.term),
								method : "GET" ,
								dataType: "json",
								success : function(JSONData) {
			   
								    response(JSONData);
								}
							});
						}	
					}	
				});
				
				
				
		});
		
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<!-- 수정 -->
						<c:if test = "${menu == 'search'}">
							상품 목록 조회
						</c:if>
						<c:if test = "${menu == 'manage'}">
							상품 관리
						</c:if>					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<!-- 수정 시작 -->
		<td align="right">
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
			<select name="searchSorting" class="ct_input_g" style="width:80px"  onchange="fncSort()">
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<select id = "searchSorting" name="searchSorting" class="ct_input_g" style="width:80px" >
				<option value="0" ${!empty search.searchSorting && search.searchSorting == "0" ? "selected" ? empty search.searchSorting : "selected" : ""}>신상품순</option>
				<option value="1" ${!empty search.searchSorting && search.searchSorting == "1" ? "selected" : ""}>가격 낮은 순</option>
				<option value="2" ${!empty search.searchSorting && search.searchSorting == "2" ? "selected" : ""}>가격 높은 순</option>
			</select>
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
			<select name="searchCondition" class="ct_input_g" style="width:80px"  onchange="fncHide()">
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<select id = "searchCondition" name="searchCondition" class="ct_input_g" style="width:80px" >
				<option value="0" ${!empty search.searchCondition && search.searchCondition == "0" ? "selected" : ""}>상품번호</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition == "1" ? "selected" : ""}>상품명</option>
				<option value="2" ${!empty search.searchCondition && search.searchCondition == "2" ? "selected" : ""}>상품가격</option>
			</select>
			<input type="text" id = "searchKeyword" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" value="${search.searchKeyword}" />
			<input type="hidden" id="searchPriceStart" name="searchPriceStart"  style="width:100px; height:19px" value="" /> 
 			<input type="hidden" id="searchPriceEnd" name="searchPriceEnd"   style="width:100px; height:19px" value="" />
		</td>
		<!-- 수정 끝-->
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
						<a href="javascript:fncGetList('1');">검색</a>
						////////////////////////////////////////////////////////////////////////////////////////////////// -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<!-- 수정 -->
		<td colspan="11" >전체 ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage } 페이지</td>				
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">미리보기</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<!-- 수정 시작 -->
	<c:set var="i" value = "0" />
	<c:forEach var = "product" items="${list }">
		<c:set var="i" value="${i+1 }"/>
		<tr class="ct_list_pop">
			<td align="center">${i }</td>
			<td></td>
			<td align="left">
				<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
				<a href="/product/getProduct?prodNo=${product.prodNo}&menu=${menu}">${product.prodName}</a></td>
				////////////////////////////////////////////////////////////////////////////////////////////////// -->
				${product.prodName}
				<input type="hidden" name = "prodNo" value = "${product.prodNo}" />
				
			</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>
			<td></td>
			<td align="left">
				<c:if test="${menu == 'search'}" >
					<c:if test="${!empty product.proTranNo && product.proTranNo != '' }" >
						재고없음
					</c:if>
					<c:if test="${empty product.proTranNo || product.proTranNo == '' }" >
						판매 중
					</c:if>
				</c:if>
				<c:if test="${menu != 'search'}" >
					<c:if test="${! empty product.proTranNo && product.proTranNo != '' }" >
						<c:choose>
							<c:when test = "${product.proTranCode eq '001'}" >
								구매완료<br/>
								 <!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
								<a href="/purchase/updateTranCodeByProd?tranNo=${product.proTranNo}&tranCode=002">배송하기</a>
								////////////////////////////////////////////////////////////////////////////////////////////////// -->
								배송하기
								<input type="hidden" name="proTranNo" value="${product.proTranNo}"/>
							</c:when>
							<c:when test = "${product.proTranCode eq '002'}" >
								배송 중
							</c:when>
							<c:when test = "${product.proTranCode eq '003'}" >
								배송 완료
							</c:when>
						</c:choose>
					</c:if>
					<c:if test="${empty product.proTranCode || product.proTranCode == '' }" >
						판매 중
					</c:if>
				</c:if>
			</td>	
			<td></td>
			<td>메롱</td>
		</tr>
		<tr>
			<!-- //////////////////////////// 추가 , 변경된 부분 /////////////////////////////
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			////////////////////////////////////////////////////////////////////////////////////////////  -->
			<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>	
			
	</c:forEach>
	<!-- 수정 끝 -->
	<tr>
	<td id="auto"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<!-- 수정 시작 -->
		   	<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>
		<!-- 수정 끝 -->
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>





