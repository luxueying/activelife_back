<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<div class="left_foot">共有 ${page.totalSize}条记录，当前第${page.page}页</div>
<div class="right_foot">
    <a href="${page.url}=1" <c:if test="${page.page<=1}"> disabled="disabled" onclick="return false" </c:if>><img class="first_page" /></a> 
    <a href="${page.url}=${page.page-1}" <c:if test="${page.page<=1}"> disabled="disabled" onclick="return false" </c:if>><img class="back_page" /></a> 
    <a href="${page.url}=${page.page+1}" <c:if test="${page.page>=page.totalPages}"> disabled="disabled" onclick="return false" </c:if>><img class="next_page" /></a> 
    <a href="${page.url}=${page.totalPages}" <c:if test="${page.page>=page.totalPages}"> disabled="disabled" onclick="return false" </c:if>><img class="last_page" /></a>
    <div class="jump_label">转到第<input name="page" type="text" />页</div>
    <input type="image" class="jump_page" src="images/go.gif">
</div>
