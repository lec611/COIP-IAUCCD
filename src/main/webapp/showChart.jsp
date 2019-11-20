<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图形展示</title>
</head>
<body>
    <%
        String data = request.getParameter("data");
        int dataNum = 3;
        String[] dataName = {"“中国境外产业园区产业集聚”子系统有序度", "“地方城镇化发展”子系统有序度", "系统耦合度（C）", "耦合协调度（D）", "耦合协调等级"};
        String[] data1 = {"0.4293253615435391","0.4293253615435391","0.4293253615435391"};
        String[] data2 = {"0.4293253615435391","0.4293253615435391","0.4293253615435391"};
        String[] data3 = {"0.4293253615435391","0.4293253615435391","0.4293253615435391"};
        String[] data4 = {"0.4293253615435391","0.4293253615435391","0.4293253615435391"};
        String[] data5 = {"很低","很低","很低"};
    %>

    <table style="border-collapse: collapse;border: none;" border="2">
        <tr>
            <th><%=dataName[0]%></th>
            <%
                for (int i = 0; i < dataNum; i++) {
            %>
            <th><%=data1[i]%></th>
            <%
                }
            %>
        </tr>

        <tr>
            <th><%=dataName[1]%></th>
            <%
                for (int i = 0; i < dataNum; i++) {
            %>
            <th><%=data2[i]%></th>
            <%
                }
            %>
        </tr>

        <tr>
            <th><%=dataName[2]%></th>
            <%
                for (int i = 0; i < dataNum; i++) {
            %>
            <th><%=data3[i]%></th>
            <%
                }
            %>
        </tr>

        <tr>
            <th><%=dataName[3]%></th>
            <%
                for (int i = 0; i < dataNum; i++) {
            %>
            <th><%=data4[i]%></th>
            <%
                }
            %>
        </tr>

        <tr>
            <th><%=dataName[4]%></th>
            <%
                for (int i = 0; i < dataNum; i++) {
            %>
            <th><%=data5[i]%></th>
            <%
                }
            %>
        </tr>

    </table>
</body>
<script src='./static/js/jquery/jquery.min.js'></script>
<%--<script>--%>
    <%--// var data=['2','XX年XX园区','X年X园区','0.3903616916436824','0.4293253615435391','较低','一般'];--%>
    <%--var data = ['2', 'XX年XX园区', '0.4293253615435391','0.4293253615435391','0.4293253615435391','0.4293253615435391','很低',--%>
        <%--'X年X园区','0.4293253615435391','0.4293253615435391','0.4293253615435391','0.4293253615435391','很低'];--%>
    <%--var numOfData = parseInt(data[0]);--%>
    <%--var json = {};--%>
    <%--for (i = 0; i < numOfData; i++) {--%>

    <%--}--%>
<%--</script>--%>
</html>
