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
        String[] data6 = {"2016年越南龙江工业园","2017年越南龙江工业园", "2018年越南龙江工业园"};
        String[] years = {"2016", "2017", "2018"};
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

        <tr>
            <th></th>
            <%
                for (int i = 0; i < dataNum; i++) {
            %>
            <th><%=data6[i]%></th>
            <%
                }
            %>
        </tr>
    </table> <br/>
    <div id="chartContainer1" style="height: 370px; width: 50%;margin: auto auto;"></div>
</body>
<script src='./static/js/jquery/jquery.min.js'></script>
<script src="./static/js/canvasjs.min.js"></script>
<script>
    function showBarChart(data) {
        data = ['chartContainer1', 3, '耦合协调度（D）', 2016, 2017, 2018, 0.4293253615435391, 0.4293253615435391, 0.4293253615435391];
        var charData = [];
        var num = data[0];
        for (i = 0; i < num; i++) {
            charData.push({x:data[i+2], y:data[i+2+num]});
        }

        var chart = new CanvasJS.Chart("chartContainer", {
            animationEnabled: true,
            exportEnabled: true,
            theme: "light1", // "light1", "light2", "dark1", "dark2"
            title:{
                text: data[1]
            },
            data: [{
                type: "column", //change type to bar, line, area, pie, etc
                //indexLabel: "{y}", //Shows y value on all Data Points
                indexLabelFontColor: "#5A5757",
                indexLabelPlacement: "outside",
                dataPoints: charData
            }]
        });
        chart.render();
    }
</script>
</html>
