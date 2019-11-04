<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; Charset=gb2312">
    <meta http-equiv="Content-Language" content="zh-CN">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <title>COIP: IAUCCD</title>
    <link rel="shortcut icon" href="" type="image/x-icon">
    <!--Layui-->
    <link href="./static/plug/layui/css/layui.css" rel="stylesheet"/>
    <!--font-awesome-->
    <link href="./static/plug/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
    <!--全局样式表-->
    <link href="./static/css/global.css" rel="stylesheet"/>
    <!-- 本页样式表 -->
    <link href="./static/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="./static/css/formSelects-v4.css" rel="stylesheet" type="text/css"/>
    <style>
        th {
            font-size: 18px !important;
            text-align: center !important;
        }

        td {
            font-size: 17px !important;
        }

        span {
            color: red;
        }

        .input-result-right {
            font-size: 17px;
        }
    </style>
</head>
<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <a href="${ctx}/index.jsp">
            <div class="layui-logo" style="font-weight: bold">COIP: IAUCCD</div>
        </a>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item">
                <a href="javascript:;">文件</a>
                <dl class="layui-nav-child"> <!-- 二级菜单 -->
                    <dd><a href="javascript:;">打开</a></dd>
                    <dd><a href="javascript:;">关闭</a></dd>
                    <dd><a href="javascript:;">保存</a></dd>
                    <dd><a href="javascript:;">另存为</a></dd>
                    <dd><a href="javascript:;">导出</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">编辑</a>
                <dl class="layui-nav-child"> <!-- 二级菜单 -->
                    <dd><a href="javascript:;">撤销</a></dd>
                    <dd><a href="javascript:;">清除</a></dd>
                    <dd><a href="javascript:;">字体</a></dd>
                    <dd><a href="javascript:;">字号</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">管理员</a>
                <dl class="layui-nav-child"> <!-- 二级菜单 -->
                    <dd><a href="javascript:;">内置数据组预设</a></dd>
                    <dd><a href="javascript:;">处理上载申请</a></dd>
                    <dd><a href="javascript:;">联系管理员</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <button data-method="notice" class="layui-btn" id="help" style="background-color: #23262E">帮助</button>
            </li>
        </ul>
        <!-- 注册 -->
        <ul class="layui-nav layui-layout-right head-nav-right" lay-filter="nav">
            <li class="layui-nav-item">
                <a href="javascript:;">登录&nbsp;/&nbsp;注册</a>
            </li>
        </ul>
        <!-- 手机和平板的导航开关 -->
        <a class="index-navicon" href="javascript:;" style="display: none;">
            <i class="fa fa-navicon"></i>
        </a>
    </div>
    <!-- 主体（一般只改变这里的内容） -->
    <div class="layui-body share-body" style="margin-left: -180px;">
        <!-- 这个一般才是真正的主体内容 -->
        <div class="index-main">
            <!--页面左边-->
            <div class="index-main-left">
                <div>
                    <form class="layui-form" action="">
                        <fieldset class="layui-elem-field layui-field-title" style="">
                            <legend>数据录入</legend>
                            <div class="layui-fluid">
                                <div class="layui-form layui-col-md12">
                                    <div class="layui-form-item">
                                        <div class="layui-col-md12">
                                            <label class="layui-form-label"
                                                   style="font-size: 17px;">数据组<span>*</span></label>
                                            <div class="layui-input-block">
                                                <select name="select_data_group" id="select_data_group"
                                                        lay-filter="" xm-select="select_data_group" xm-select-type="1">
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="layui-form">
                            <table class="layui-table">
                                <colgroup>
                                    <col width="25%">
                                    <col width="30%">
                                    <col width="32%">
                                    <col width="13%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>指标</th>
                                    <th>指标数值</th>
                                    <th>（单位）</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td rowspan="4">园区产业集聚相关数据</td>
                                    <td>园区就业总人数<span>*</span></td>
                                    <td>
                                        <input type="text" id="total-employment" name="total-employment"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>个</td>
                                </tr>
                                <tr>
                                    <td>实际实现营业收入<span>*</span></td>
                                    <td>
                                        <input type="text" id="actual-operating-income" name="actual-operating-income"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>亿美元</td>
                                </tr>
                                <tr>
                                    <td>实际入园企业总数<span>*</span></td>
                                    <td>
                                        <input type="text" id="actual-total-enterprises" name="actual-total-enterprises"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>个</td>
                                </tr>
                                <tr>
                                    <td>园区已开发工业用地面积<span>*</span></td>
                                    <td>
                                        <input type="text" id="site-area" name="site-area" placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>公顷</td>
                                </tr>
                                </tbody>
                            </table>

                            <table class="layui-table">
                                <colgroup>
                                    <col width="25%">
                                    <col width="30%">
                                    <col width="32%">
                                    <col width="13%">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td rowspan="5">城镇发展相关数据</td>
                                    <td>城镇人口数<span>*</span></td>
                                    <td>
                                        <input type="text" id="urban-population" name="urban-population"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>人</td>
                                </tr>
                                <tr>
                                    <td>人口城镇化率<span>*</span></td>
                                    <td>
                                        <input type="text" id="urbanization-rate" name="urbanization-rate"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>%</td>
                                </tr>
                                <tr>
                                    <td>城镇工业部门从业人数<span>*</span></td>
                                    <td>
                                        <input type="text" id="industrial-employment" name="industrial-employment"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>人</td>
                                </tr>
                                <tr>
                                    <td>二三产业增加值占GDP比重<span>*</span></td>
                                    <td>
                                        <input type="text" id="gdp-proportion" name="gdp-proportion"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>%</td>
                                </tr>
                                <tr>
                                    <td>人均GDP<span>*</span></td>
                                    <td>
                                        <input type="text" id="gdp-per-capita" name="gdp-per-capita"
                                               placeholder="请输入..."
                                               lay-verify="required|number" autocomplete="off" class="layui-input">
                                    </td>
                                    <td>美元/人/年</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
                <div>
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                        <legend>文件输入</legend>
                    </fieldset>
                    <div style="float: right;margin-bottom: 20px;">
                        <div style="text-align: center;margin-left:30px;position: relative">
                            <input type="file" id="inputFile" class="form-control" name="inputFile" style="width: 80%;float: left">
                        </div>
                        <br><br>
                        <div class="layui-inline">
                            <button class="layui-btn" lay-submit="" lay-filter="formSearch" id="2" ><a href="${ctx}/main/templateDownload" style="color:white"> 文件输入模板</a></button>
                        </div>
                        <div class="layui-inline">
                            <button class="layui-btn" lay-submit="" lay-filter="formSearch" onclick="uploadTemplateFile()" id="1" style="color:white">上传数据文件</button>
                           <!-- <button class="layui-btn" lay-submit="" lay-filter="formSearch" id="2"><a href="${ctx}/main/templateUpload" style="color: white"> 上传输入的文件</a></button>-->
                        </div>
                    </div>
                </div>
            </div>

            <!--页面右边-->
            <div class="index-main-right">
                <div style="margin: 100px 0 80px 0;">
                    <div class="layui-form-item">
                        <div class="layui-input-block submit-btn">
                            <button class="layui-btn" lay-submit="" lay-filter="submit" style="margin-right: 30px;">
                                运行计算
                            </button>
                            <button class="layui-btn" lay-submit="" lay-filter="reset">重置数据</button>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="input-result-right">
                    <fieldset class="layui-elem-field layui-field-title">
                        <legend>输出结果</legend>
                    </fieldset>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 50%;text-align: left;font-weight: bold">指标输出：</label>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"
                               style="width: 40%;text-align: left">该中国境外产业园区产业聚集与城镇化的耦合协调度为：</label>
                        <div class="layui-input-block degree-of-coupling" style="font-size: 20px;padding-top: 25px"></div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 40%;text-align: left">耦合协调等级为：</label>
                        <div class="layui-input-block level-of-coupling" style="font-size: 20px"></div>
                    </div>
                    <div class="layui-form-item" style="margin-top: 50px">
                        <label class="layui-form-label" style="width: 40%;text-align: left;font-weight: bold">文件输出：</label>
                        <div class="layui-input-block">
                            <button class="layui-btn">下载输出文件</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="clear"></div>
        </div>
    </div>
    <!-- 底部固定区域 -->
    <%--<div class="layui-footer" style="margin-left: -200px;">

    </div>--%>
    <!--分享窗体-->
    <div class="index-share layui-hide">
        <div class="index-share-body">
            <div style="width: 200px;height:100%;">
                <div class="bdsharebuttonbox">
                    <a class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                    <a class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                    <a class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                    <a class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
                </div>
            </div>
        </div>
    </div>
    <!--遮罩, 不能删除-->
    <div class="index-mask animated layui-hide"></div>
</div>
</body>
<!-- layui.js -->
<script src="./static/plug/layui/layui.js"></script>
<script src='./static/js/jquery/jquery.min.js'></script>
<%--本页脚本--%>
<script src="./static/js/index.js"></script>
<script>
    function uploadTemplateFile(){
        var formData = new FormData();
        formData.append('file', $('#inputFile')[0].files[0]); // 固定格式

        $.ajax({
            url:'${ctx}/main/templateUpload',	//后台接收数据地址
            data:formData,
            type: "POST",
            dataType: "json",
            cache: false,			//上传文件无需缓存
            processData: false,		//用于对data参数进行序列化处理 这里必须false
            contentType: false,
            success: function(result){
                if(result === "success"){
                    alert("说明文件上传成功！");
                }else if(result === "error"){
                    alert("非管理员用户无上传权限！");
                }else{
                    alert("注意：上传文件格式必须为Excel！");
                }
            },
            failure: function (data) {
                alert(data+"\n文件传输出错！");
            }
        });
    }

    //全局定义一次, 加载formSelects
    layui.config({
        base: './static/js/' // fromSelects-v4所在的目录
    }).extend({
        formSelects: 'formSelects-v4'
    });

    layui.use(['formSelects', 'layer', 'util', 'form', 'upload','element'], function () {
        var form = layui.form;
        var $ = layui.jquery;
        var layer = layui.layer;
        var upload = layui.upload;
        var formSelects = layui.formSelects;
        var element = layui.element;

        //帮助按钮内容
        var active = {
            notice: function(){
                //示范一个公告层
                layer.open({
                    type: 1
                    ,title: false //不显示标题栏
                    ,closeBtn: false
                    ,area: '500px;'
                    ,shade: 0.8
                    ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                    ,btn: ['知道了']
                    ,btnAlign: 'c'
                    ,moveType: 1 //拖拽模式，0或者1
                    ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">1、用户可选择“数据录入”和“文件输入”两种数据输入方式；<br>2、“数据录入”部分，用户根据“指标”栏中列出的某年“园区产业集聚”与“城镇发展”的指标条目进行输入；<br>3、“文件输入”部分，用户点击“文件输入模板”可下载模板。填写指南：“文件输入”模板为excel格式，前n列为各指标不同年份的具体数值，数值对应指标必须从上到下按照“园区就业总人数、实际实现营业收入、实际入园企业总数、园区已开发工业用地面积、城镇人口数、人口城镇化率、城镇工业部门从业人数、二三产业增加值占GDP比重、人均GDP”的顺序排列；在输入“XX年XX园区”时，建议用户按照一定逻辑顺序输入，如某一园区的逐年数据或某年多个园区数据；需要输入多个园区多年数据时，建议按照某园区逐年数据，后继续列出另一园区逐年数据，如“2016年越南龙江工业园”、“2017年越南龙江工业园”、“2018年越南龙江工业园”、“2015年中白工业园”、“2016年中白工业园”、“2017年中白工业园”……。<br>4、在数据录入或数据文件上载完成后，点击“运行计算”即可得到评价结果；<br>5、用户可在“指标输出”框中获得评价结果，也可通过文件输出的方式获得评估结果。</div>'
                });
            }
        }

        $('#help').on('click', function () {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

        form.on('submit(reset)', function (data) {
            $(".layui-input").val("");
        });

        form.on('submit(submit)', function (data) {
            var totalEmployment = $('#total-employment').val();
            var actualOperatingIncome = $('#actual-operating-income').val();
            var actualTotalEnterprises = $('#actual-total-enterprises').val();
            var siteArea = $('#site-area').val();
            var urbanPopulation = $('#urban-population').val();
            var urbanizationRate = $('#urbanization-rate').val();
            var industrialEmployment = $('#industrial-employment').val();
            var gdpProportion = $('#gdp-proportion').val();
            var gdpPerCapita = $('#gdp-per-capita').val();

            var selectValue = JSON.stringify(layui.formSelects.value('select_data_group'));

            $.ajax({
                type: 'GET',
                url: "${ctx}/main/calculate",
                data: {
                    "totalEmployment": totalEmployment,
                    "actualOperatingIncome": actualOperatingIncome,
                    "actualTotalEnterprises": actualTotalEnterprises,
                    "siteArea": siteArea,
                    "urbanPopulation": urbanPopulation,
                    "urbanizationRate": urbanizationRate,
                    "industrialEmployment": industrialEmployment,
                    "gdpProportion": gdpProportion,
                    "gdpPerCapita": gdpPerCapita,
                    "selectValue": selectValue
                },
                dataType: 'json',
                success: function (result) {
                    if (result.code != 200) {
                        layer.msg(result.msg, {icon: 2});
                        return false;
                    } else {
                        console.log(result.data.degree);
                        console.log(result.data.level);
                        $(".degree-of-coupling").html(result.data.degree);
                        $(".level-of-coupling").html(result.data.level);
                        $(".layui-input").val("");
                    }
                }
            })
        });

        $(function () {
            getDataGroup();
        });

        function getDataGroup() {
            $.ajax({
                type: 'GET',
                url: "${ctx}/main/dataGroup",
                dataType: 'json',
                success: function (result) {
                    if (result.code != 200) {
                        layer.msg(result.msg, {icon: 2});
                        return false;
                    } else {
                        var dataGroup = result.data.dataGroup;
                        var html = '<option value="">请选择</option>';
                        dataGroup.forEach(function (element) {
                            var name = element.name;
                            var id = element.id;
                            html = html + '<option value="' + id + '">' + name + '</option>';
                        });
                        $("#select_data_group").html(html);
                        formSelects.render('select_data_group');
                    }
                }
            });
        }


        //分享工具
        layui.util.fixbar({
            bar1: '&#xe641;',
            click: function (type) {
                if (type === 'bar1') {
                    var sear = new RegExp('layui-hide');
                    if (sear.test($('.index-share').attr('class'))) {
                        shareIn();
                    } else {
                        shareOut();
                    }
                }
            }
        });

        //share-body和share-footer点击事件，用来关闭百度分享
        $('.share-body,.share-footer').click(function () {
            shareOut();
        });

        //显示百度分享
        function shareIn() {
            $('.index-share').unbind('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend');
            $('.index-share').removeClass('shareOut');
            $('.index-share').addClass('shareIn');
            $('.index-share').removeClass('layui-hide');
            $('.index-share').addClass('layui-show');
        }

        //隐藏百度分享
        function shareOut() {
            $('.index-share').on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                $('.index-share').addClass('layui-hide');
            });
            $('.index-share').removeClass('shareIn');
            $('.index-share').addClass('shareOut');
            $('.index-share').removeClass('layui-show');
        }

    });

    //百度分享插件
    window._bd_share_config = {
        "common": {
            "bdSnsKey": {},
            "bdText": "",
            "bdStyle": "0",
            "bdSize": "32",
            "bdUrl": "https://www.baidu.com/"  // 暂定为百度页面，当有新网址的时候记得在这里填写新网址
        },
        "share": {}
    };
    with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];

</script>
</html>