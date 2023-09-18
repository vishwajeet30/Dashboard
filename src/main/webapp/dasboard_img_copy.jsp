<%@ page language = "java" import = "java.sql.*, java.io.IOException, java.lang.*,java.text.*,java.util.*,java.awt.*,javax.naming.*,javax.sql.*,java.io.InputStream"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/all.min.css" media="all">
<link rel="stylesheet" href="css/style.css" media="all">
<script src="Charts.js"></script>
</head>
<body>

<%
Context ctx = null;
Connection con = null;
ctx = new InitialContext();
Context envCtx = (Context)ctx.lookup("java:comp/env");
DataSource ds = (DataSource)envCtx.lookup("jdbc/im_pax_flights");
con = ds.getConnection();

PreparedStatement psMain = null;
PreparedStatement psTemp = null;
ResultSet rsMain = null;
ResultSet rsTemp = null;
/*
ICP_SRNO
ICP_DESCRIPTION
TABLE_TYPE
PAX_BOARDING_DATE
HOURS
HOURLY_FLIGHT_COUNT
HOURLY_PAX_COUNT
HOURLY_INDIAN_COUNT
HOURLY_FOREIGNER_COUNT
HOURLY_EVISA_COUNT
HOURLY_VOA_COUNT
DAILY_ARRIVAL_FLIGHT_COUNT
DAILY_ARRIVAL_PAX_COUNT
DAILY_DEPARTURE_FLIGHT_COUNT
DAILY_DEPARTURE_PAX_COUNT
ACTIVE_COUNTER_COUNT
GRAND_TOTAL_PAX_ARR
GRAND_TOTAL_PAX_DEP
GRAND_TOTAL_CNT_FLT_ARR
GRAND_TOTAL_CNT_FLT_DEP
HOURLY_MALE_COUNT
HOURLY_FEMALE_COUNT
HOURLY_OTHERS_COUNT
HOURLY_OCI_COUNT
HOURLY_REGULAR_VISA_COUNT
HOURLY_VISA_EXEMPTED_COUNT
HOURLY_BIO_ENROLLED
HOURLY_BIO_VERIFIED
HOURLY_BIO_EXEMPTED*/

String dashQuery = "";
int today_Arrival_Count = 0;
int total_Arrival_Flights = 0;
int dep_Passenger_Flights = 0;
int daily_Dep_Count = 0;
int total_Dep_Flights = 0;
int total_Arrival_Count = 0;
int yesterday_Arrival_Count = 0;



try
{
  dashQuery = "select distinct DAILY_ARRIVAL_PAX_COUNT as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33-1)";
  psTemp = con.prepareStatement(dashQuery);
  rsTemp = psTemp.executeQuery();
  if(rsTemp.next())
  {

    yesterday_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

  }
  rsTemp.close();
  psTemp.close();
}
catch(Exception e)
{
  out.println("Arrival Exception");
}
try
{
  dashQuery = "select distinct DAILY_ARRIVAL_PAX_COUNT as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
  psTemp = con.prepareStatement(dashQuery);
  rsTemp = psTemp.executeQuery();
  if(rsTemp.next())
  {

    today_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

  }
  rsTemp.close();
  psTemp.close();
}
catch(Exception e)
{
  out.println("Arrival Exception");
}





%>
<div class="row">
  <div class="column2">
    <div class="box_main red">
      <div class="d_flex">
        <div class="icon"> <i class="fa-solid fa-plane-arrival"></i> </div>
         <div>
         <table>
        	<tr>
            	<td><h1><%=total_Arrival_Count%></h1></td>
                <td>Total Arrival</td>
            </tr>
            <tr>
            	<td><h2><%=yesterday_Arrival_Count%></h2></td>
                <td>Yesterday Arrival</td>
            </tr>
            <tr>
            	<td><h3><%=today_Arrival_Count%></h3></td>
                <td>Today Arrival</td>
            </tr>
        </table>
        </div>        
      </div>
    </div>
  </div>

<%
try
{
  dashQuery = "select distinct GRAND_TOTAL_CNT_FLT_ARR as total_Arrival_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
  psTemp = con.prepareStatement(dashQuery);
  rsTemp = psTemp.executeQuery();
  if(rsTemp.next())
  {

    total_Arrival_Flights = rsTemp.getInt("total_Arrival_Flights");

  }
  rsTemp.close();
  psTemp.close();
}
catch(Exception e)
{
  out.println("Arrival Exception");
}
%>
  <div class="column2">
    <div class="box_main blue">
      <div class="d_flex">
        <div class="icon"> <i class="fa-solid fa-plane-arrival"></i> </div>
         <div>
         <table>
        	<tr>
            	<td><h1><%=total_Arrival_Flights%></h1></td>
                <td>Total Arrival Flights</td>
            </tr>
            <tr>
            	<td><h2>100000</h2></td>
                <td>Yesterday Arrival Flights</td>
            </tr>
            <tr>
            	<td><h3>7000</h3></td>
                <td>Today Arrival Flights</td>
            </tr>
        </table>
        </div>        
      </div>
    </div>
  </div>
<%
try
{
  dashQuery = "select distinct GRAND_TOTAL_PAX_DEP as dep_Passenger_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
  psTemp = con.prepareStatement(dashQuery);
  rsTemp = psTemp.executeQuery();
  if(rsTemp.next())
  {

    daily_Dep_Count = rsTemp.getInt("dep_Passenger_Flights");

  }
  rsTemp.close();
  psTemp.close();
}
catch(Exception e)
{
  out.println("Arrival Exception");
}
%>
  <div class="column2">
    <div class="box_main orange">
      <div class="d_flex">
        <div class="icon"> <i class="fa-solid fa-plane-departure"></i> </div>
         <div>
         <table>
        	<tr>
            	<td><h1><%=daily_Dep_Count%></h1></td>
                <td>Total Departure</td>
            </tr>
            <tr>
            	<td><h2>100000</h2></td>
                <td>Yesterday Departure</td>
            </tr>
            <tr>
            	<td><h3>7000</h3></td>
                <td>Today Departure</td>
            </tr>
        </table>
        </div>        
      </div>
    </div>
  </div>
<%
try
{
  dashQuery = "select distinct GRAND_TOTAL_CNT_FLT_DEP as total_Dep_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
  psTemp = con.prepareStatement(dashQuery);
  rsTemp = psTemp.executeQuery();
  if(rsTemp.next())
  {

    total_Dep_Flights = rsTemp.getInt("total_Dep_Flights");

  }
  rsTemp.close();
  psTemp.close();
}
catch(Exception e)
{
  out.println("Arrival Exception");
}
%>
  <div class="column2">
  	<div class="col-lg-4">
        <div class="box_main green">
          <div class="d_flex">
        <div class="icon"> <i class="fa-solid fa-plane-departure"></i> </div>
         <div>
         <table>
        	<tr>
            	<td><h1><%=total_Dep_Flights%></h1></td>
                <td>Total Departure Flights</td>
            </tr>
            <tr>
            	<td><h2>100000</h2></td>
                <td>Yesterday Departure Flights</td>
            </tr>
            <tr>
            	<td><h3>7000</h3></td>
                <td>Today Departure Flights</td>
            </tr>
        </table>
        </div>        
      </div>
        </div>
      </div>
  </div>
</div>

<div class="row">
  <div class="column3">
    <div class="box red">
      <div class="d_flex">
        <div class="icon"> <i class="fa-solid fa-globe"></i> </div>
        <div>
          <h2 id="count1"></h2>
          <p>hello world!</p> 
        </div>
      </div>
    </div>
  </div>
  <div class="column3">
    <div class="box blue">
      <div class="d_flex">
        <div class="icon"> <i class="fa-solid fa-user"></i> </div>
        <div>
          <h2 id="count2"></h2>
          <p>hello world!</p>
        </div>
      </div>
    </div>
  </div>
  <div class="column3">
    <div class="box orange">
      <div class="d_flex">
        <div class="icon"> <i class="fa-solid fa-chart-line"></i> </div>
        <div>
          <h2 id="count3"></h2>
          <p>hello world!</p>
        </div>
      </div>
    </div>
  </div>
  <div class="column3">
  	<div class="col-lg-4">
        <div class="box green">
          <div class="d_flex">
            <div class="icon"> <i class="fa-solid fa-chart-simple"></i> </div>
            <div>
              <h2 id="count4"></h2>
              <p>hello world!</p>
               </div>
          </div>
        </div>
      </div>
  </div>
  <div class="column3">
  	<div class="col-lg-4">
        <div class="box voilet">
          <div class="d_flex">
            <div class="icon"> <i class="fa-solid fa-chart-pie"></i> </div>
            <div>
              <h2 id="count5"></h2>
              <p>hello world!</p>
               </div>
          </div>
        </div>
      </div>
  </div>
  <div class="column3">
  	<div class="col-lg-4">
        <div class="box yellow">
          <div class="d_flex">
            <div class="icon"> <i class="fa-solid fa-chart-pie"></i> </div>
            <div>
              <h2 id="count6"></h2>
              <p>hello world!</p>
               </div>
          </div>
        </div>
      </div>
  </div>
</div>
<div class="heading"><h2> Charts Data </h2></div>
<div class="row">
  <div class="column">
    <canvas id="myChart1" class="chart"></canvas>
    <script>
	const xValues = [100,200,300,400,500,600,700,800,900,1000];	
	new Chart("myChart1", {
	  type: "line",
	  data: {
		labels: xValues,
		datasets: [{ 
		  data: [860,1140,1060,1060,1070,1110,1330,2210,7830,2478],
		  borderColor: "red",
		  fill: false
		}, { 
		  data: [1600,1700,1700,1900,2000,2700,4000,5000,6000,7000],
		  borderColor: "green",
		  fill: false
		}, { 
		  data: [300,700,2000,5000,6000,4000,2000,1000,200,100],
		  borderColor: "blue",
		  fill: false
		}]
	  },
	  options: {
		legend: {display: false}
	  }
	});
	</script>
  </div>
  
  <div class="column">
    <canvas id="myPlot1" class="chart"></canvas>
   <script>
	new Chart("myPlot1", {
	  type: 'line',
	  data: {
		labels: [50,60,70,80,90,100,110,120,130,140,150],
		datasets: [{
		  fill:false,
		  lineTension: 0,
		  backgroundColor:"rgba(0,0,255,1.0)",
		  borderColor: "rgba(0,0,255,0.1)",
		  data: [7,8,8,9,9,9,10,11,14,14,15]
		}]
	  },
	  options: {
		legend: {display: false},
		scales: {
		  yAxes: [{ticks: {min: 6, max:16}}],
		}
	  }
	});
	</script>
  </div> 
  <div class="column">
    <canvas id="myFunc1" class="chart"></canvas>
    <script>
	var xValue = ["Italy", "France", "Spain", "USA", "Argentina"];
	var yValue = [60, 50, 40, 34, 20];
	var barColors = ["#dc3545","#007bff","#ff7839","#00aea3","#434795"];
	
	new Chart("myFunc1", {
	  type: "bar",
	  data: {
		labels: xValue,
		datasets: [{
		  backgroundColor: barColors,
		  data: yValue
		}]
	  },
	  options: {
		legend: {display: false},
		title: {
		  display: true,
		  text: "World Wine Production 2018"
		}
	  }
	});
	</script>
  </div>
</div>


<div class="row">
  <div class="column">
    <canvas id="myChart2" class="chart"></canvas>
    <script>
	const xValuee = [100,200,300,400,500,600,700,800,900,1000];	
	new Chart("myChart2", {
	  type: "line",
	  data: {
		labels: xValuee,
		datasets: [{ 
		  data: [860,1140,1060,1060,1070,1110,1330,2210,7830,2478],
		  borderColor: "red",
		  fill: false
		}, { 
		  data: [1600,1700,1700,1900,2000,2700,4000,5000,6000,7000],
		  borderColor: "green",
		  fill: false
		}, { 
		  data: [300,700,2000,5000,6000,4000,2000,1000,200,100],
		  borderColor: "blue",
		  fill: false
		}]
	  },
	  options: {
		legend: {display: false}
	  }
	});
	</script>
  </div>
  
  <div class="column">
    <canvas id="myPlot2" class="chart"></canvas>
   <script>
	new Chart("myPlot2", {
	  type: 'line',
	  data: {
		labels: [50,60,70,80,90,100,110,120,130,140,150],
		datasets: [{
		  fill:false,
		  lineTension: 0,
		  backgroundColor:"rgba(0,0,255,1.0)",
		  borderColor: "rgba(0,0,255,0.1)",
		  data: [7,8,8,9,9,9,10,11,14,14,15]
		}]
	  },
	  options: {
		legend: {display: false},
		scales: {
		  yAxes: [{ticks: {min: 6, max:16}}],
		}
	  }
	});
	</script>
  </div> 
  <div class="column">
    <canvas id="myFunc2" class="chart"></canvas>
    <script>
	var xValuess = ["Italy", "France", "Spain", "USA", "Argentina"];
	var yValuess = [60, 50, 40, 34, 20];
	var barColors = ["#dc3545","#007bff","#ff7839","#00aea3","#434795"];
	
	new Chart("myFunc2", {
	  type: "bar",
	  data: {
		labels: xValuess,
		datasets: [{
		  backgroundColor: barColors,
		  data: yValuess
		}]
	  },
	  options: {
		legend: {display: false},
		title: {
		  display: true,
		  text: "World Wine Production 2018"
		}
	  }
	});
	</script>
  </div>
</div>

<script>
const counterAnim = (qSelector, start = 0, end, duration = 1000) => {
 const target = document.querySelector(qSelector);
 let startTimestamp = null;
 const step = (timestamp) => {
  if (!startTimestamp) startTimestamp = timestamp;
  const progress = Math.min((timestamp - startTimestamp) / duration, 1);
  target.innerText = Math.floor(progress * (end - start) + start);
  if (progress < 1) {
   window.requestAnimationFrame(step);
  }
 };
 window.requestAnimationFrame(step);
};

document.addEventListener("DOMContentLoaded", () => {
 counterAnim("#count1", 10, 3500, 1000);
 counterAnim("#count2", 1000, 54646, 1500);
 counterAnim("#count3", 5000, 9898, 2000);
 counterAnim("#count4", 500, 342329, 2500);
 counterAnim("#count5", 10, 5454, 2000);
 counterAnim("#count6", 50, 224, 2500);
});
</script>

 <%
  
        con.close();
      
        ctx.close();
      
%>
</body>
</html>
