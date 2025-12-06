

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #workspace{
        width 100%;
        height: 100vh;
        position: relative;
        boder: 1px solid #ccc;
    }
    .word{
    cursor: grab;
    background: #f5f5f5;
    padding: 5px;
    border-radius: 5px;
    display: inline-block;
    position: absolute;
    }
</style>
</head>
<body>



<div id = "workspace">
    <c:forEach var="w" items="${words}">
    <div class="word"
        data-id="${w.wordId}"
        style="left:${w.posX}px; top:${w.posY}px;">
        <a href="readword.jsp?word_id=${w.wordId}">
            ${w.text}
        </a>
    </div>
    </c:forEach>
</div>

<script>

document.querySelectorAll('.word').forEach(el => {
	el.onmousedown = function(e){
		let offsetX = e.clientX - el.offsetLeft;
		let offsetY = e.clientY - el.offsetTop;
		
		document.onmousemove = function(e){
			el.style.left = (e.clientX - offsetX) + "px";
			el.style.top = (e.clientY - offsetY) + "px";
		};
		
		document.onmouseup = function(){
			document.onmousemove = null;
			document.onmouseup = null;
			
			savePos(el.dataset.id, el.style.left, el.style.top);
		};
	};
});
function savePos(wordId, x, y){
	fetch("updatePosition", {
		method: "POST",
		headers:{"Content-Type": "application/x-www-form-urlencoded"},
		body: `word_id=${wordId}&x=${parseInt(x)}&y=${parseInt(y)}`
	});
}

</script>

</body>
</html>
