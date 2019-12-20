<%@ page import="java.util.Arrays" %>
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
<body >
    <%
        String data = request.getParameter("data");
        String[] dataArray = data.split(",");
        int dataNum = Integer.parseInt(dataArray[0]);
        String[] dataName = {"“境外国际合作园区产业集聚”子系统有序度", "“地方城镇化发展”子系统有序度", "系统耦合度（C）", "耦合协调度（D）", "耦合协调等级"};
        String[][] datas = new String[6][];
        String[] data1 = new String[dataNum];
        int offset = 1+dataNum;
        for (int i = 0; i < dataNum; i++) {
            data1[i] = dataArray[offset+i];
        }
        String[] data2 = new String[dataNum];
        for (int i = 0; i < dataNum; i++) {
            data2[i] = dataArray[offset+i+dataNum];
        }
        String[] data3 = new String[dataNum];
        for (int i = 0; i < dataNum; i++) {
            data3[i] = dataArray[offset+i+dataNum*2];
        }
        String[] data4 = new String[dataNum];
        for (int i = 0; i < dataNum; i++) {
            data4[i] = dataArray[offset+i+dataNum*3];
        }
        String[] data5 = new String[dataNum];
        for (int i = 0; i < dataNum; i++) {
            data5[i] = dataArray[offset+i+dataNum*4];
        }
        String[] data6 = new String[dataNum];
        for (int i = 0; i < dataNum; i++) {
            data6[i] = dataArray[1+i];
        }
        datas[0] = data1;
        datas[1] = data2;
        datas[2] = data3;
        datas[3] = data4;
        datas[4] = data5;
        datas[5] = data6;
        String[] years = new String[dataNum];
        for (int i = 0; i < dataNum; i++) {
            int j = 0;
            for (; j < data6[i].length(); j++) {
                if (data6[i].charAt(j) == '年') {
                    break;
                }
            }
            years[i] = data6[i].substring(0,j);
        }
        String yearString = "";
        for (int i = 0; i < years.length; i++) {
            yearString += "\"" + years[i] + "\"" + ',';
        }
        yearString = yearString.substring(0, yearString.length()-1);
        String yearArrayString = "[";
        for (int i = 0; i < dataNum; i++) {
            String thisYear = "";
            if (years[i].equals("X") || years[i].equals("XX")) {
                thisYear = "" + (2015+i);
            } else {
                thisYear = years[i];
            }
            if (i == dataNum -1) {
                yearArrayString += thisYear + "]";
            } else {
                yearArrayString += thisYear + ",";
            }
        }
        System.out.println(yearArrayString);
        String[] dataString = new String[4];
        for (int i = 0; i < 4; i++) {
            String init = "['chartContainer";
            init = init +  (i+1) + "'";
            init = init + "," + dataNum + ",";
            init = init + "\"" + dataName[i] + "\"" + "," + yearString;
            for (int j=0; j < dataNum; j++) {
                init = init + ',' + datas[i][j];
            }
            init += "]";
            dataString[i] = init;
            System.out.println(dataString[i]);
        }

    %>
    <button id="renderPdf">下载为PDF</button>
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
    <div id="chartContainer1" style="height: 370px; width: 30%;margin: auto auto;float: left;"></div>
    <div id="chartContainer2" style="height: 370px; width: 30%;margin: auto auto;float: left;"></div>
    <div style="clear: both;"></div>
    <div id="chartContainer3" style="height: 370px; width: 30%;margin: auto auto;float: left;"></div>
    <div id="chartContainer4" style="height: 370px; width: 30%;margin: auto auto;float: left;"></div>
    <div id="chartContainer5" style="height: 370px; width: 30%;margin-left: 5% ;float: left;"></div>
</body>
<script src='./static/js/jquery/jquery.min.js'></script>
<script src="./static/js/canvasjs.min.js"></script>
<script src="./static/js/html2canvas.js"></script>
<script src="./static/js/jsPdf.debug.js"></script>
<script>
    $(function () {
        var dataNum = <%=dataNum%>;
        var years = <%=yearArrayString%>;
        var chart1Data = <%=dataString[0]%>;
        var chart2Data = <%=dataString[1]%>;
        var chart3Data = <%=dataString[2]%>;
        var chart4Data = <%=dataString[3]%>;
        var charDatas = [chart1Data, chart2Data, chart4Data];

        showBarChart(chart1Data);
        showBarChart(chart2Data);
        showBarChart(chart3Data);
        showBarChart(chart4Data);
        showLineChart(dataNum, charDatas, years);
    });
    
    function showBarChart(data) {
        // data = ['chartContainer1', 3, '耦合协调度（D）', 2016, 2017, 2018, 0.4293253615435391, 0.4293253615435391, 0.4293253615435391];
        var charData = [];
        var num = data[1];
        for (i = 0; i < num; i++) {
            charData.push({y:data[i+3+num], label:data[i+3]});
        }

        var chart = new CanvasJS.Chart(data[0], {
            animationEnabled: true,
            theme: "light2", // "light1", "light2", "dark1", "dark2"
            title:{
                text: data[2]
            },
            data: [{
                type: "column",
                dataPoints: charData
            }]
        });
        chart.render();
    }

    function showLineChart(dataNum, charDatas, years) {

        var lineTitle = ["“境外国际合作园区产业集聚”子系统有序度", "“地方城镇化发展”子系统有序度", "耦合协调度（D）"];
        var charData = [];
        for (var i = 0; i < 3; i++) {
            var dataPts = [];
            for (var j = 0; j < dataNum; j++) {
                var pts = {x:new Date(years[j],0,0),y:charDatas[i][3+dataNum+j]};
                dataPts.push(pts);
            }

            var line = {
                type: "line",
                name: lineTitle[i],
                showInLegend: true,
                dataPoints: dataPts
            };
            charData.push(line);
        }

        var chart = new CanvasJS.Chart("chartContainer5", {
            title:{
                text: "综合对比"
            },
            axisX: {
                valueFormatString: "YYYY"
            },
            toolTip: {
                shared: true
            },
            legend: {
                cursor: "pointer",
                itemclick: toggleDataSeries
            },
            data: charData
        });
        chart.render();

        function toggleDataSeries(e) {
            if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                e.dataSeries.visible = false;
            } else {
                e.dataSeries.visible = true;
            }
            e.chart.render();
        }
    }
</script>

<script>
    var downPdf = document.getElementById("renderPdf");

    downPdf.onclick = function() {
        html2canvas(document.body, {
            background: '#FFFFFF',
            onrendered: function (canvas) {

                var contentWidth = canvas.width;
                var contentHeight = canvas.height;

                //一页pdf显示html页面生成的canvas高度;
                var pageHeight = contentWidth / 592.28 * 841.89;
                //未生成pdf的html页面高度
                var leftHeight = contentHeight;
                //pdf页面偏移
                var position = 0;
                //a4纸的尺寸[595.28,841.89]，html页面生成的canvas在pdf中图片的宽高
                var imgWidth = 595.28;
                var imgHeight = 592.28 / contentWidth * contentHeight;

                var pageData = canvas.toDataURL('image/jpeg', 1.0);

                var pdf = new jsPDF('', 'pt', 'a4');

                //有两个高度需要区分，一个是html页面的实际高度，和生成pdf的页面高度(841.89)
                //当内容未超过pdf一页显示的范围，无需分页
                if (leftHeight < pageHeight) {
                    pdf.addImage(pageData, 'JPEG', 0, 0, imgWidth, imgHeight);
                } else {
                    while (leftHeight > 0) {
                        pdf.addImage(pageData, 'JPEG', 0, position, imgWidth, imgHeight)
                        leftHeight -= pageHeight;
                        position -= 841.89;
                        //避免添加空白页
                        if (leftHeight > 0) {
                            pdf.addPage();
                        }
                    }
                }

                pdf.save('content.pdf');
            }
        })

    }
</script>
</html>
