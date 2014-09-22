var roadMarkerArr = [{garage_name:"临港软件园",total_parking_spaces: 360,remaining_parking_spaces:120,address:"环湖西一路99号", price: 5.0,status:"busy", point:"121.931348|30.906358", isOpen:0, road_garage:1},
					{garage_name:"临港软件园",total_parking_spaces: 280,remaining_parking_spaces:220,address:"环湖西一路99号", price: 5.0,status:"idle", point:"121.931689|30.907837", isOpen:0, road_garage:1},
					{garage_name:"临港软件园",total_parking_spaces: 150,remaining_parking_spaces:10,address:"环湖西一路99号", price: 5.0,status:"nervous", point:"121.934011|30.909166", isOpen:0, road_garage:1},
					{garage_name:"临港软件园",total_parking_spaces: 60,remaining_parking_spaces:0,address:"环湖西一路99号", price: 5.0,status:"full", point:"121.93296|30.904812", isOpen:0, road_garage:1}
					];
					
var markerArr = [{garage_name:"宜浩佳园",total_parking_spaces: 480,remaining_parking_spaces:160,address:"竹柏路366弄", price: 10.0,status:"idle", point:"121.915811|30.908283", isOpen:0, road_garage:0},
				{garage_name:"宜浩佳园",total_parking_spaces: 430,remaining_parking_spaces:0,address:"竹柏路333弄", price: 10.0,status:"full", point:"121.915757|30.905947", isOpen:0, road_garage:0},
				{garage_name:"宜浩佳园",total_parking_spaces: 370,remaining_parking_spaces:0,address:"竹柏路100弄", price: 10.0,status:"full", point:"121.92183|30.907764", isOpen:0, road_garage:0},
				{garage_name:"宜浩佳园",total_parking_spaces: 296,remaining_parking_spaces:16,address:"竹柏路111弄", price: 10.0,status:"idle", point:"121.919988|30.90592", isOpen:0, road_garage:0}
				];


//移动到当前坐标的位置
var geolocation = new BMap.Geolocation();
//通过百度地图获取当前位置
var point = new BMap.Point(121.480241,31.236303);


//加载省份信息
function getProvinces(provincesId, cityId){
	$.ajax({
		type:"GET",
		dataType:'json',
		url:"/localities.json?level=1",
		success:function(data){
			for (var i = 0; i < data.length; i++){
				provincesId.append(new Option(data[i].name,data[i].code)); 
			}
		},
		error: function(){
			alert ("请求发送失败，请稍候再试");
		}
	});
	
	
}
//加载城市信息,改变Provinces下拉框的事件
function changeProvinces(cityId,areasId, blocksId, parentId){
	cityId.html ("<option value=\"0000\">(All)</option>");
	areasId.html ("<option value=\"000000\">(All)</option>");
	blocksId.html ("<option value=\"00000000\">(All)</option>");
	$.ajax({
		type:"GET",
		dataType:'json',
		url:"/localities.json?level=2&parentId="+parentId,
		success:function(data){
			
			for (var i = 0; i < data.length; i++){
				cityId.append(new Option(data[i].name,data[i].code)); 
			}
			cityId.prop("disabled", false);
			/*
			if(cityId.find("option").length <= 1) { 
				areasId.prop("disabled", true);
			}else{
				areasId.prop("disabled", false);
			}
			*/
		},
		error: function(){
			alert ("请求发送失败，请稍候再试");
		}
	});
}
//加载区域信息,改变city下拉框的事件
function changeCity(areasId, blocksId, parentId){
	areasId.html ("<option value=\"000000\">(All)</option>");
	blocksId.html ("<option value=\"00000000\">(All)</option>");
	$.ajax({
		type:"GET",
		dataType:'json',
		url:"/localities.json?level=3&parentId="+parentId,
		success:function(data){
			for (var i = 0; i < data.length; i++){
				areasId.append(new Option(data[i].name,data[i].code)); 
			}
			areasId.prop("disabled", false); 
			/*
			if(areasId.find("option").length <= 1) {
				blocksId.prop("disabled", true); 
			}else{
				blocksId.prop("disabled", false); 
			}
			*/
		},
		error: function(){
			alert ("请求发送失败，请稍候再试");
		}
	});
}
//加载街道信息改变areas下拉框的事件
function changeAreas(blocksId, parentId){
	blocksId.html ("<option value=\"00000000\">(All)</option>");
	$.ajax({
		type:"GET",
		dataType:'json',
		url:"/localities.json?level=4&parentId="+parentId,
		success:function(data){
			for (var i = 0; i < data.length; i++){
				blocksId.append(new Option(data[i].name,data[i].code)); 
			}
			blocksId.prop("disabled", false); 
		},
		error: function(){
			alert ("请求发送失败，请稍候再试");
		}
	});
}
//加载省市区街道信息
function loadLocalityContent(provinces, city, areas, blocks){
	provinces.html ("<option value=\"00\">(All)</option>");
	city.html ("<option value=\"0000\">(All)</option>");
	areas.html ("<option value=\"000000\">(All)</option>");
	blocks.html ("<option value=\"00000000\">(All)</option>");
	getProvinces(provinces, city);
	city.prop("disabled", true);
	areas.prop("disabled", true);
	blocks.prop("disabled", true);
}

$(document).ready(function(){
	setVisibleHeight();
	//设置显示当天的时间
	showCurrentTime($("#mapCurrentTime"));
	initMap(point);
	//显示地图主页
	setVisibleHeight();
	//获取位置信息
	loadLocalityContent($("#provinces"), $("#city"), $("#areas"), $("#blocks"));
	/*左侧导航栏*/
	$("#home").click(function(e){
		revertBackgroundAndColor();
		setBackgroundAndColor($(this));
		//设置显示当天的时间
		showCurrentTime($("#mapCurrentTime"));
		//显示homeContent
		hiddenContent($("#homeContent"));
		hiddenContent($("#occupancyContent"));
		hiddenContent($("#analyticsContent"));
		showContent($("#homeContent"));
		
		initMap(point);
	});
	//显示停车空闲数据
	$("#occupancy").click(function(e){
		revertBackgroundAndColor();
		setBackgroundAndColor($(this));
		//设置显示当天的时间
		showCurrentTime($("#currentTime"));
		//date range
		showDateRange();
		//显示occupancyContent
		hiddenContent($("#homeContent"));
		showContent($("#analyticsContent"));
		
		hiddenContent($('#changeTable'));
		showContent($('#changeOccupancy'));
		
		showContent($("#occupancyContent"));
		hiddenContent($('#analyticsData'));
		
		showContent($("#status"));
		hiddenContent($('#tabOccupancy'));
		hiddenContent($('#weekStarting'));
		//设置表格背景色 hsl(115, 80%, 60%)   red darkgray
		$("#occupancyTable td").each(function() {
			var str = $(this).text();
			if( str == "空"){
				setBackgroundColor($(this), "hsl(115, "+"80%"+", 60%)");
			}else if(str == "忙"){
				setBackgroundColor($(this), "red");
			}else{
				setBackgroundColor($(this), "darkgray");
			}
		});
	});
	//显示数据分析
	$("#analytics").click(function(e){
		revertBackgroundAndColor();
		setBackgroundAndColor($(this));
		//设置显示当天的时间
		showCurrentTime($("#currentTime"));
		//显示日期区间
		showDateRange();
		//显示analyticsContent
		hiddenContent($("#homeContent"));
		showContent($("#analyticsContent"));
		
		hiddenContent($('#changeOccupancy'));
		showContent($('#changeTable'));
		
		showContent($("#analyticsData"));
		hiddenContent($('#occupancyContent'));
		
		
		hiddenContent($('#status'));
		if($("#chart").is(":visible")){
			showContent($("#weekStarting"));
			hiddenContent($('#tabOccupancy'));
			showBarCharts();
		}else if ($("#analytics-occupancy").is(":visible")){
			showContent($("#tabOccupancy"));
			hiddenContent($('#weekStarting'));
			//设置表格背景色 hsl(120, 8%, 100%)
			$("#analyticsTable td").each(function(i, n) {
				if (i % 16 != 0){
					setBackgroundColor($(this),"hsl(120,"+$(this).text()+", 50%)");
				}
			});
		}
		
		
		
	});
	
	/*查找区域地图*/
	$("#searchBtn").click(function(){
		searchMap();
	});
	
	/*切换选择柱状图或者车库数据分析表格*/
	$("#changeTable").change(function(){
		//显示日期区间
		showDateRange();
		if($(this).val() == "turnover"){
			$("#analyticsData h3").text($(this).find('option:selected').text());
			
			showContent($("#chart"));
			hiddenContent($('#analytics-occupancy'));
			
			showContent($("#weekStarting"));
			hiddenContent($('#tabOccupancy'));
		}else{
			$("#analyticsData h3").text($(this).find('option:selected').text());
			hiddenContent($("#chart"));
			hiddenContent($("#weekStarting"));
			showContent($("#analytics-occupancy"));
			showContent($("#tabOccupancy"));
			//设置表格背景色 hsl(120, 8%, 100%)
			$("#analyticsTable td").each(function(i, n) {
				if (i % 16 != 0){
					setBackgroundColor($(this),"hsl(120, "+$(this).text()+", 50%)")
				}
			});
		}
	});
	
	
	/*切换选择省市区*/
	$("#provinces").change(function(){
		changeProvinces($("#city"), $("#areas"), $("#blocks"), $(this).find('option:selected').val());
	
	});
	$("#city").change(function(){
		changeCity($("#areas"), $("#blocks"), $(this).find('option:selected').val());
	});
	$("#areas").change(function(){
		changeAreas($("#blocks"), $(this).find('option:selected').val());
	});
	
	
	//滑动日期区间，更改label的显示值
	$("#rangeSlider").on("valuesChanged", function(e, data){
		var weeKday = data.values.min.getDay();
		var year = data.values.min.getFullYear();
		var month = data.values.min.getMonth()+1;
		var date = data.values.min.getDate();
		var days = getDaysInMonth(year, month);
		if ( weeKday == 0){
			$("#firstWeek").text(month+"/"+date+"/"+year);
			if (date+7 > days){
				$("#secondWeek").text((month+1) + "/"+(date+7 - days)+"/"+year);
			}else{
				$("#secondWeek").text(month + "/"+(date+7)+"/"+year);
			}
			if (date+14 > days){
				$("#thirdWeek").text((month+1) + "/"+(date+14 - days)+"/"+year);
			}else{
				$("#thirdWeek").text(month + "/"+(date+14)+"/"+year);
			}
			if (date+21 > days){
				$("#fourthWeek").text((month+1) + "/"+(date+21 - days)+"/"+year);
			}else{
				$("#fourthWeek").text(month + "/"+(date+21)+"/"+year);
			}
		}else{
			if(date+7-weeKday > days){
				$("#firstWeek").text((month+1) + "/"+(date+7-weeKday - days)+"/"+year);
			}else{
				$("#firstWeek").text(month + "/"+(date+7-weeKday)+"/"+year);
			}
			if(date+14-weeKday > days){
				$("#secondWeek").text((month+1) + "/"+(date+14-weeKday - days)+"/"+year);
			}else{
				$("#secondWeek").text(month + "/"+(date+14-weeKday)+"/"+year);
			}
			if(date+21-weeKday > days){
				$("#thirdWeek").text((month+1) + "/"+(date+21-weeKday - days)+"/"+year);
			}else{
				$("#thirdWeek").text(month + "/"+(date+21-weeKday)+"/"+year);
			}
			if(date+28-weeKday > days){
				$("#fourthWeek").text((month+1) + "/"+(date+28-weeKday - days)+"/"+year);
			}else{
				$("#fourthWeek").text(month + "/"+(date+28-weeKday)+"/"+year);
			}
		}
    });
	
});
//设置导航栏li的背景色与前景色
function setBackgroundAndColor(id){
	id.css({"background-color":"#fefefe", "color":"hsl(115, 80%, 60%)"});
}
//重置导航栏li的背景色与前景色
function revertBackgroundAndColor(){
	$("#home").css({"background-color":"#eeeeee", "color":"black"});
	$("#occupancy").css({"background-color":"#eeeeee", "color":"black"});
	$("#analytics").css({"background-color":"#eeeeee", "color":"black"});
}
//显示右侧内容DIV
function showContent(id){
	id.css("display","block");
}
//隐藏右侧内容DIV
function hiddenContent(id){
	id.css("display","none");
}


//创建和初始化地图函数：
function initMap(point){
	createMap(point);//创建地图
	setMapEvent();//设置地图事件
	addMapControl();//向地图添加控件
	addMarker();//向地图中添加marker
}

//创建地图函数：
function createMap(point){
	var map = new BMap.Map("mapCanvas");//在百度地图容器中创建一个地图
	
	map.centerAndZoom(point,17);//设定地图的中心点和坐标并将地图显示在地图容器中
	window.map = map;//将map变量存储在全局
	addPositionMarker(point);
}

//地图事件设置函数：
function setMapEvent(){
	map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
	map.enableScrollWheelZoom();//启用地图滚轮放大缩小
	map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
	map.enableKeyboard();//启用键盘上下左右键移动地图
	map.enablePinchToZoom();//启用手势缩放
}

//地图控件添加函数：
function addMapControl(){
	//向地图中添加缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	map.addControl(ctrl_nav);
	//向地图中添加缩略图控件
	var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
	//map.addControl(ctrl_ove);
	//向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	//map.addControl(ctrl_sca);
	
	// 创建自定义控件
	var myLocationCtrl = new LocationControl();
	// 添加到地图当中
	//map.addControl(myLocationCtrl);
}
//创建marker
function addMarker(){
	createMarker(roadMarkerArr);
	createMarker(markerArr);
	/*
	$.ajax({
		type:"GET",
		dataType:'json',
		url:"http://yj.wgq.me//parkers.json",
		success:function(data){
			createMarker(data);
		},
		error: function(){
		
		}
	});
	*/
}
//更具数组创建marker
function createMarker(arr){
	for(var i=0;i<arr.length;i++){
		var json = arr[i];
		var p0 = json.point.split("|")[0];
		var p1 = json.point.split("|")[1];
		var point = new BMap.Point(p0,p1);
		//var iconImg = createIcon(json.imgUrl, json.icon);
		var iconImg;
		if (json.road_garage == 1) {
			if(json.status == "idle"){
				iconImg = createIcon("/assets/img/green.png");
			}else if (json.status == "busy") {
				iconImg = createIcon("/assets/img/orange.png");
			}else if (json.status == "nervous") {
				iconImg = createIcon("/assets/img/red.png");
			}else{
				iconImg = createIcon("/assets/img/gray.png");
			}
		}else{
			if(json.status == "idle"){
				iconImg = createIcon("/assets/img/green_p.png");
			}else{
				iconImg = createIcon("/assets/img/gray_p.png");
			}
		}
		var marker = new BMap.Marker(point,{icon:iconImg});
		var iw = createInfoWindow(i, arr);
		if (json.road_garage == 1){
			var label = new BMap.Label(json.remaining_parking_spaces, {offset:new BMap.Size(12, 20)});
			label.setStyle({
				color:"yellow",
				border:"0",
				width:"50px",
				textAlign:"center",
				fontSize:"16px",
				cursor:"pointer",
				fontWeight :"bold" ,
				backgroundColor:"0.05"
			});
			marker.setLabel(label);
		}
		
		map.addOverlay(marker);
		(function(){
			var index = i;
			var _iw = createInfoWindow(i, arr);
			var _marker = marker;
			_marker.addEventListener("click",function(){
				this.openInfoWindow(_iw);
			});
			_iw.addEventListener("open",function(){
				//_marker.getLabel().hide();
			})
			_iw.addEventListener("close",function(){
				//_marker.getLabel().show();
			})
			/*
			label.addEventListener("click",function(){
				_marker.openInfoWindow(_iw);
			})
			*/
			//两个感叹号的作用就在于，如果明确设置了变量的值
			//（非null/undifined/0/”“等值),
			//结果就会根据变量的实际值来返回，如果没有设置，结果就会返回false。
			if(!!json.isOpen){
				//label.hide();
				_marker.openInfoWindow(_iw);
			}
		})()
	}

}

//创建InfoWindow
function createInfoWindow(i, arr){
	var json = arr[i];
	var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.garage_name
	+ "'>" + json.garage_name + "</b><div class='iw_poi_content'>"+'价格：'+json.price+'元/小时'+'&nbsp;&nbsp;&nbsp;&nbsp;车位：'+json.remaining_parking_spaces+'/'+json.total_parking_spaces+'<br/>'+'地址：'+json.address+"</div>", {enableMessage:false});
	return iw;
}
//创建一个Icon, json
function createIcon(imgUrl){
	//var icon = new BMap.Icon(imgUrl, new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)});
	var icon = new BMap.Icon(imgUrl, new BMap.Size(72, 72),{      
		// 指定定位位置。     
		// 当标注显示在地图上时，其所指向的地理位置距离图标左上      
		// 角各偏移36像素和75像素。您可以看到在本例中该位置即是     
		// 图标中央下端的尖角位置。      
		anchor: new BMap.Size(36, 75)        
	});
	return icon;
}


//地图搜索
function searchMap() {
    var area = document.getElementById("searchTxt").value; //得到地区
    var ls = new BMap.LocalSearch(map);
    ls.setSearchCompleteCallback(function(rs) {
        if (ls.getStatus() == BMAP_STATUS_SUCCESS) {
            var poi = rs.getPoi(0);
            if (poi) {
                initMap(poi.point);//创建地图(经度poi.point.lng,纬度poi.point.lat)
            }
        }
    });
    ls.search(area);
	
}


// 定义一个控件类,即function
function LocationControl(){
  // 默认停靠位置和偏移量
  this.defaultAnchor = BMAP_ANCHOR_BOTTOM_RIGHT;
  this.defaultOffset = new BMap.Size(10, 10);
}

// 通过JavaScript的prototype属性继承于BMap.Control
LocationControl.prototype = new BMap.Control();

// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
LocationControl.prototype.initialize = function(map){
  // 创建一个DOM元素
  var div = document.createElement("div");
  // 添加图片
  var img = document.createElement("img");
  img.src = "/assets/img/location.png";
  div.appendChild(img);
  // 设置样式
  div.style.cursor = "pointer";
  div.style.border = "0";
  div.style.backgroundColor = "0.05";
  // 绑定事件,点击获取当前位置,并标注
  div.onclick = function(e){
	//map.panTo(center:Point, {noAnimation : yes})
	geolocation.getCurrentPosition(function(r){
		if(this.getStatus() == BMAP_STATUS_SUCCESS){
			//清楚所有覆盖物
			map.clearOverlays();
			//重新添加覆盖物
			//addMarker();
			addPositionMarker(r.point);
			map.panTo(r.point, {noAnimation : false});
		}
	});
  }
  // 添加DOM元素到地图中
  map.getContainer().appendChild(div);
  // 将DOM元素返回
  return div;
}

function addPositionMarker(point){
	var circle = new BMap.Circle(point,100,{strokeColor:"green", fillColor:"green", strokeWeight:1, strokeOpacity:0.2, fillOpacity:0.2}); //创建圆
	map.addOverlay(circle);
	var myIcon = new BMap.Icon("/assets/img/position.png",new BMap.Size(30, 30)); 
	var mk = new BMap.Marker(point, {icon: myIcon});
	map.addOverlay(mk);
}
//显示柱状图 纵坐标表示停车场日均总停车数/停车场总泊位数
function showBarCharts(){
	$.jqplot.config.enablePlugins = true;
	var s1 = [2, 6, 7, 10, 3, 9, 4];
	var s2 = [7, 5, 3, 2, 5, 8, 6];
	var s3 = [4, 1, 8, 9, 7, 6, 5];
	var s4 = [9, 5, 7, 3, 8, 4, 2];
	var ticks = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
	 
	plot2 = $.jqplot('chart', [s1, s2, s3, s4], {
		axesDefaults: {
			labelRenderer: $.jqplot.CanvasAxisLabelRenderer
		},
		seriesDefaults: {
			renderer:$.jqplot.BarRenderer,
			pointLabels: { show: true }
		},
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer,
				ticks: ticks
			},
			yaxis: {
				label: "日均总停车数/总泊位数"
			}
		}
	});
}

//显示时间区间
function showDateRange(){
	var date =  new Date();
	$("#rangeSlider").dateRangeSlider({
		bounds:{
			min: new Date(2014, 0, 1),
			max: new Date()
		},
		defaultValues:{
			min: new Date(2014, date.getMonth()-1, date.getDate()),
			max: new Date()
		},
		range:{
			min: {days: -31},
			max: {days: 31}
		},
		/*
		formatter:function(val){
			var days = val.getDate();
			var month = val.getMonth() + 1;
			var year = val.getFullYear();
			return month + "/" + days + "/" + year;
		},
		*/
		arrows:false
	});
}

//设置显示当前时间
function showCurrentTime(id){
	var date =  new Date();
	id.text( date.toLocaleString());
}

//动态设置网页的高度
function setVisibleHeight(){
	var height =  $(window).height();
	$("#mapCanvas").height(height-125);
	$("#leftNav").height(height-60);
	$("#analyticsContent").height(height-125);
}

//设置背景色
function setBackgroundColor(id, colorName){
	id.css("background-color", colorName);
}
//获取某年某月的总天数JS里面的new Date("xxxx/xx/xx")这个日期的构造方法有一个妙处，当你传入的是"xxxx/xx/0"（0号）的话，得到的日期是"xx"月的最后一天
function getDaysInMonth(year,month){ 
	var temp = new Date(year,month,0);
	return temp.getDate(); 
} 

