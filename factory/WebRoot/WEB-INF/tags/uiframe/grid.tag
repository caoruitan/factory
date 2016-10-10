<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="id" rtexprvalue="true" required="true" description="ID" %>
<%@ attribute name="start" rtexprvalue="true" required="true" description="起始条数" %>
<%@ attribute name="limit" rtexprvalue="true" required="true" description="每页条数" %>
<%@ attribute name="loadurl" rtexprvalue="true" required="true" description="加载数据url" %>
<%@ attribute name="tbar" fragment="true"%>
<%@ attribute name="thead" fragment="true"%>

<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <jsp:invoke fragment="tbar"/>
        </tr>
        <tr>
            <jsp:invoke fragment="thead"/>
        </tr>
    </thead>
    <tbody id="<%=id%>GridBody" class="grid-body">
        
    </tbody>
</table>
<div class="pagination pagination-right">
    <ul>
        <li id="<%=id%>PrePageLi" class="disabled"><a id="<%=id%>PrePageBtn" href="#">上一页</a></li>
        <li class="active"><a id="<%=id%>PageField" href="#">第1/1页</a></li>
        <li id="<%=id%>NextPageLi"><a id="<%=id%>NextPageBtn" href="#">下一页</a></li>
    </ul>
</div>

<script type="text/javascript">
    var grid = {
        url : '<%=loadurl%>',
        totalPage : 1,
        currentPage : 1,
        baseParams : {},
        load : function(params) {
            var loadParams = {
                start : <%=start%>,
                limit : <%=limit%>
            };
            if(params) {
                for(var key in params) {
                    loadParams[key] = params[key];
                }
            }
            var scope = this;
            $("#<%=id%>GridBody").load(this.url, loadParams, function() {
                scope.total = parseInt($("#<%=id%>GridBody").find("input.total").val()); // 总条数
                if(!scope.total) {
                    scope.total = 0;
                }
                scope.totalPage = Math.ceil(parseInt(scope.total)/loadParams.limit);
                scope.currentPage = Math.ceil(loadParams.start/loadParams.limit) + 1;
                scope.baseParams = loadParams;
                scope.initPageToolBar(); // 初始化翻页工具栏
            });
        },
        reload : function() {
            var scope = this;
            $("#<%=id%>GridBody").load(this.url, this.baseParams, function() {
                scope.total = parseInt($("#<%=id%>GridBody").find("input.total").val()); // 总条数
                if(!scope.total) {
                    scope.total = 0;
                }
                scope.totalPage = Math.ceil(parseInt(scope.total)/scope.baseParams.limit);
                scope.currentPage = Math.ceil(scope.baseParams.start/scope.baseParams.limit) + 1;
                scope.initPageToolBar(); // 初始化翻页工具栏
            });
        },
        initPageToolBar : function() {
            if(this.total == 0) {
                $("#<%=id%>PageField").text("无数据");
                $("#<%=id%>PrePageLi").addClass("disabled");
                $("#<%=id%>PrePageBtn").unbind("click");
                $("#<%=id%>NextPageLi").addClass("disabled");
                $("#<%=id%>NextPageBtn").unbind("click");
            } else {
                $("#<%=id%>PageField").text("第 " + this.currentPage + "/" + this.totalPage + " 页");
                if(this.currentPage == 1) {
                    $("#<%=id%>PrePageLi").addClass("disabled");
                    $("#<%=id%>PrePageBtn").unbind("click");
                } else {
                    $("#<%=id%>PrePageLi").removeClass("disabled");
                    $("#<%=id%>PrePageBtn").on("click", this.prePage);
                }
                if(this.currentPage == this.totalPage) {
                    $("#<%=id%>NextPageLi").addClass("disabled");
                    $("#<%=id%>NextPageBtn").unbind("click");
                } else {
                    $("#<%=id%>NextPageLi").removeClass("disabled");
                    $("#<%=id%>NextPageBtn").on("click", this.nextPage);
                }
            }
        },
        nextPage : function() {
            var param = grid.baseParams;
            grid.baseParams.start = grid.baseParams.start + grid.baseParams.limit;
            grid.load(param);
        },
        prePage : function() {
            var param = grid.baseParams;
            grid.baseParams.start = grid.baseParams.start - grid.baseParams.limit;
            grid.load(param);
        }
    }
    $(function() {
        grid.load();
    });
</script>