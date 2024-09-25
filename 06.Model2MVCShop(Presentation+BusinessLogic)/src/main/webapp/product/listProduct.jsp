<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ��ǰ�����ȸ/��ǰ���� ������ -->
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>��ǰ �����ȸ</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		//=====����Code �ּ� ó�� ��  jQuery ���� ======//
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
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
				 
				 
				 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
						//Debug..
						//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
						fncGetList(1);
					});

				$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
					//Debug..
					  var prodNo = $(this).find('input[name="prodNo"]').val();
					
					//////////////////////////// �߰� , ����� �κ� ///////////////////////////////////
					//self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${menu}";
					////////////////////////////////////////////////////////////////////////////////////////////  
					
					if(${user != null && user.role == 'user'}){
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
																	+"��ǰ�� : "+JSONData.prodName+"<br/>"
																	+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
																	+"�������� : "+JSONData.manuDate+"<br/>"
																	+"���� : "+JSONData.price+"<br/>"
																	+"����� : "+JSONData.regDate+"<br/>"
																	+"</h3>";
										//Debug...									
										//alert(displayValue);
										$("h3").remove();
										$( "#"+prodNo+"" ).html(displayValue);
									}
							});

					}
				});
				$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
					//Debug..
					  var prodNo = $(this).find('input[name="prodNo"]').val();
					
					//////////////////////////// �߰� , ����� �κ� ///////////////////////////////////
					self.location ="/product/getProduct?prodNo="+prodNo+"&menu=${menu}";
					////////////////////////////////////////////////////////////////////////////////////////////  
				/*	
					if(${user != null && user.role == 'user'}){
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
																	+"��ǰ�� : "+JSONData.prodName+"<br/>"
																	+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
																	+"�������� : "+JSONData.manuDate+"<br/>"
																	+"���� : "+JSONData.price+"<br/>"
																	+"����� : "+JSONData.regDate+"<br/>"
																	+"</h3>";
										//Debug...									
										//alert(displayValue);
										$("h3").remove();
										$( "#"+prodNo+"" ).html(displayValue);
									}
							});

					}*/
				});
				$( ".ct_list_pop td:nth-child(9):contains('����ϱ�')" ).on("click" , function() {
					//Debug..
					//alert(  $( this ).text().trim() );
					var proTranNo = $(this).find('input[name="proTranNo"]').val();
					self.location ="/purchase/updateTranCodeByProd?tranNo="+proTranNo+"&tranCode=002";
					
				});	
				
				//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
				$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
				
				
				//==> �Ʒ��� ���� ������ ������ ??
				//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
				$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");			
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
						<!-- ���� -->
						<c:if test = "${menu == 'search'}">
							��ǰ ��� ��ȸ
						</c:if>
						<c:if test = "${menu == 'manage'}">
							��ǰ ����
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
		<!-- ���� ���� -->
		<td align="right">
			<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
			<select name="searchSorting" class="ct_input_g" style="width:80px"  onchange="fncSort()">
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<select id = "searchSorting" name="searchSorting" class="ct_input_g" style="width:80px" >
				<option value="0" ${!empty search.searchSorting && search.searchSorting == "0" ? "selected" ? empty search.searchSorting : "selected" : ""}>�Ż�ǰ��</option>
				<option value="1" ${!empty search.searchSorting && search.searchSorting == "1" ? "selected" : ""}>���� ���� ��</option>
				<option value="2" ${!empty search.searchSorting && search.searchSorting == "2" ? "selected" : ""}>���� ���� ��</option>
			</select>
			<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
			<select name="searchCondition" class="ct_input_g" style="width:80px"  onchange="fncHide()">
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			<select id = "searchCondition" name="searchCondition" class="ct_input_g" style="width:80px" >
				<option value="0" ${!empty search.searchCondition && search.searchCondition == "0" ? "selected" : ""}>��ǰ��ȣ</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition == "1" ? "selected" : ""}>��ǰ��</option>
				<option value="2" ${!empty search.searchCondition && search.searchCondition == "2" ? "selected" : ""}>��ǰ����</option>
			</select>
			<input type="text" id = "searchKeyword" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" value="${search.searchKeyword}" />
			<input type="hidden" id="searchPriceStart" name="searchPriceStart"  style="width:100px; height:19px" value="" /> 
 			<input type="hidden" id="searchPriceEnd" name="searchPriceEnd"   style="width:100px; height:19px" value="" />
		</td>
		<!-- ���� ��-->
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
						<a href="javascript:fncGetList('1');">�˻�</a>
						////////////////////////////////////////////////////////////////////////////////////////////////// -->
						�˻�
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
		<!-- ���� -->
		<td colspan="11" >��ü ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage } ������</td>				
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<!-- ���� ���� -->
	<c:set var="i" value = "0" />
	<c:forEach var = "product" items="${list }">
		<c:set var="i" value="${i+1 }"/>
		<tr class="ct_list_pop">
			<td align="center">${i }</td>
			<td></td>
			<td align="left">
				<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
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
						������
					</c:if>
					<c:if test="${empty product.proTranNo || product.proTranNo == '' }" >
						�Ǹ� ��
					</c:if>
				</c:if>
				<c:if test="${menu != 'search'}" >
					<c:if test="${! empty product.proTranNo && product.proTranNo != '' }" >
						<c:choose>
							<c:when test = "${product.proTranCode eq '001'}" >
								���ſϷ�<br/>
								 <!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
								<a href="/purchase/updateTranCodeByProd?tranNo=${product.proTranNo}&tranCode=002">����ϱ�</a>
								////////////////////////////////////////////////////////////////////////////////////////////////// -->
								����ϱ�
								<input type="hidden" name="proTranNo" value="${product.proTranNo}"/>
							</c:when>
							<c:when test = "${product.proTranCode eq '002'}" >
								��� ��
							</c:when>
							<c:when test = "${product.proTranCode eq '003'}" >
								��� �Ϸ�
							</c:when>
						</c:choose>
					</c:if>
					<c:if test="${empty product.proTranCode || product.proTranCode == '' }" >
						�Ǹ� ��
					</c:if>
				</c:if>
			</td>	
		</tr>
		<tr>
			<!-- //////////////////////////// �߰� , ����� �κ� /////////////////////////////
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			////////////////////////////////////////////////////////////////////////////////////////////  -->
			<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>	
			
	</c:forEach>
	<!-- ���� �� -->
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<!-- ���� ���� -->
		   	<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>
		<!-- ���� �� -->
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
