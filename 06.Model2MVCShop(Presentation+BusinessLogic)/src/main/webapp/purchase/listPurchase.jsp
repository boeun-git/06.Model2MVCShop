<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>���� �����ȸ</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
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

			$( ".ct_list_pop td:nth-child(11):contains('���ǵ���')" ).on("click" , function() {
				//Debug..
				
				var tranNo = $(this).find('input[name="tranNo"]').val();
				alert(  tranNo );
				self.location ="/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=003";
				
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

<div style="width: 98%; margin-left: 10px;">

<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
<form name="detailForm" action="/purchase/listPurchase" method="post">
////////////////////////////////////////////////////////////////////////////////////////////////// -->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
	<!-- ���� -->
		<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�ּ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">������ ����ó</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value = "0"/>
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value = "${i+1}"/>		
	<tr class="ct_list_pop">
		<td align="center">
			<!-- ���� -->
			<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
			<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${i} </a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			${i}
			<input type="hidden" name = "tranNo" id="tranNo" value="${purchase.tranNo}" />
		</td>
		<td></td>
		<td align="left">
			<!-- ���� -->
			<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
			<a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo}&menu=search">${purchase.purchaseProd.prodName}</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			${purchase.purchaseProd.prodName}
			<input type="hidden" name = "prodNo" id="prodNo" value="${purchase.purchaseProd.prodNo}" />
		</td>
		<td></td>
		<!-- ���� -->
		<td align="left">${purchase.divyAddr}</td>
		<td></td>
		<!-- ���� -->
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<!-- ���� -->
		<td align="left">����
			${purchase.tranCode eq "001" ? "���ſϷ�" : purchase.tranCode eq "002" ? "��� ��" : "��ۿϷ�" }
				���� �Դϴ�.</td>
		<td></td>
		<td align="left">
			<c:if test = "${purchase.tranCode =='002'}">
			<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
			<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=003">���ǵ���</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			���ǵ���
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