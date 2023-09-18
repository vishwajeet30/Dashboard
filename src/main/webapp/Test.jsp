<%@ page language="java" import="java.sql.*, java.io.IOException, java.lang.*,java.text.*,java.util.*,java.awt.*,javax.naming.*,java.util.*,javax.sql.*,java.io.InputStream"%>


<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/all.min.css" media="all">
<link rel="stylesheet" href="css/style.css" media="all">
<script src="Charts.js"></script>
<script src="apexChart.js"></script>
<script src="googleCharts.js"></script>
 <link rel="stylesheet" href="./assets/css/theme.css">
 <link rel="stylesheet" href="./assets/css/loopple/loopple.css">
</head>
<body>

	<%
	Connection con = null;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.62.201:1521:dev1", "imigration", "nicsi123");

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
		String depQuery = "";
		int today_Arrival_Count = 0;
		int total_Arrival_Flights = 0;
		int dep_Passenger_Flights = 0;
		int daily_Dep_Count = 0;
		int total_Dep_Flights = 0;
		int total_Arrival_Count = 0;
		int yesterday_Arrival_Count = 0;

		try {
			dashQuery = "select distinct GRAND_TOTAL_PAX_ARR as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

		total_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}

		try {
			dashQuery = "select distinct DAILY_ARRIVAL_PAX_COUNT as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33-1)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

		yesterday_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}
		try {
			dashQuery = "select distinct DAILY_ARRIVAL_PAX_COUNT as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

		today_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}
	%>
	<div class="row">
		<div class="column2">
			<div class="box_main red">
				<div class="d_flex">
					<div class="icon">
						<i class="fa-solid fa-plane-arrival"></i>
					</div>
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
		/////////////////////////////////////////////////////////////
		int total_Dep_Count = 0;
		int arr_Flight_Count = 0;
		int yest_Flight_Count = 0;
		try {
			dashQuery = "select distinct GRAND_TOTAL_CNT_FLT_ARR as total_Arrival_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				total_Arrival_Flights = rsTemp.getInt("total_Arrival_Flights");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}

		try {
			dashQuery = "select distinct DAILY_ARRIVAL_FLIGHT_COUNT as arr_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				arr_Flight_Count = rsTemp.getInt("arr_Flights");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}

		try {
			dashQuery = "select distinct DAILY_ARRIVAL_FLIGHT_COUNT as arr_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33-1)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				yest_Flight_Count = rsTemp.getInt("arr_Flights");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}
		%>
		<div class="column2">
			<div class="box_main blue">
				<div class="d_flex">
					<div class="icon">
						<i class="fa-solid fa-plane-arrival"></i>
					</div>
					<div>
						<table>
							<tr>
								<td><h1><%=total_Arrival_Flights%></h1></td>
								<td>Total Arrival Flights</td>
							</tr>
							<tr>
								<td><h2><%=yest_Flight_Count%></h2></td>
								<td>Yesterday Arrival Flights</td>
							</tr>
							<tr>
								<td><h3><%=arr_Flight_Count%></h3></td>
								<td>Today Arrival Flights</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<%
		////////////////////////////////////////////////////////////////////////////////////
		int today_Dep_Count = 0;
		int yest_Dep_Count = 0;

		try {
			dashQuery = "select distinct GRAND_TOTAL_PAX_DEP as dep_Passenger from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				total_Dep_Count = rsTemp.getInt("dep_Passenger");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}

		try {
			dashQuery = "select distinct DAILY_DEPARTURE_PAX_COUNT as dep_Passenger_Count from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33-1)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				yest_Dep_Count = rsTemp.getInt("dep_Passenger_Count");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}

		try {
			dashQuery = "select distinct DAILY_DEPARTURE_PAX_COUNT as dep_Passenger_Count from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				today_Dep_Count = rsTemp.getInt("dep_Passenger_Count");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}
		%>
		<div class="column2">
			<div class="box_main orange">
				<div class="d_flex">
					<div class="icon">
						<i class="fa-solid fa-plane-departure"></i>
					</div>
					<div>
						<table>
							<tr>
								<td><h1><%=total_Dep_Count%></h1></td>
								<td>Total Departure</td>
							</tr>
							<tr>
								<td><h2><%=yest_Dep_Count%></h2></td>
								<td>Yesterday Departure</td>
							</tr>
							<tr>
								<td><h3><%=today_Dep_Count%></h3></td>
								<td>Today Departure</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<%
		int yest_Dep_Flights = 0;
		int today_Dep_Flights = 0;
		try {
			dashQuery = "select distinct GRAND_TOTAL_CNT_FLT_DEP as total_Dep_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				total_Dep_Flights = rsTemp.getInt("total_Dep_Flights");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}

		try {
			dashQuery = "select distinct DAILY_DEPARTURE_FLIGHT_COUNT as dep_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33-1)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				yest_Dep_Flights = rsTemp.getInt("dep_Flights");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}

		try {
			dashQuery = "select distinct DAILY_DEPARTURE_FLIGHT_COUNT as dep_Flights from im_dashboard_combined where ICP_SRNO = '004' and PAX_BOARDING_DATE = trunc(sysdate-33)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			if (rsTemp.next()) {

				today_Dep_Flights = rsTemp.getInt("dep_Flights");

			}
			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Arrival Exception");
		}
		%>
		<div class="column2">
			<div class="col-lg-4">
				<div class="box_main green">
					<div class="d_flex">
						<div class="icon">
							<i class="fa-solid fa-plane-departure"></i>
						</div>
						<div>
							<table>
								<tr>
									<td><h1><%=total_Dep_Flights%></h1></td>
									<td>Total Departure Flights</td>
								</tr>
								<tr>
									<td><h2><%=yest_Dep_Flights%></h2></td>
									<td>Yesterday Departure Flights</td>
								</tr>
								<tr>
									<td><h3><%=today_Dep_Flights%></h3></td>
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
					<div class="icon">
						<i class="fa-solid fa-globe"></i>
					</div>
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
					<div class="icon">
						<i class="fa-solid fa-user"></i>
					</div>
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
					<div class="icon">
						<i class="fa-solid fa-chart-line"></i>
					</div>
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
						<div class="icon">
							<i class="fa-solid fa-chart-simple"></i>
						</div>
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
						<div class="icon">
							<i class="fa-solid fa-chart-pie"></i>
						</div>
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
						<div class="icon">
							<i class="fa-solid fa-chart-pie"></i>
						</div>
						<div>
							<h2 id="count6"></h2>
							<p>hello world!</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>






	<!-- CHARTS -->


	<div class="heading">
		<h2>Charts Data</h2>
	</div>

	<div class="row">

		<%
		int hours_Axis = 0;
		String hourly_flight_count_Axis = "";

		//ArrayList<String> str_Hours = new ArrayList<>();
		//ArrayList<String> str_Hours_Flight_Count = new ArrayList<>();

		StringBuilder bl = new StringBuilder();
		StringBuilder b2 = new StringBuilder();

		//String hourSet = "";

		boolean zero_entry_Arr = false;
		try {
			dashQuery = "select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_flight_count,active_counter_count,pax_boarding_date,hourly_pax_count from im_dashboard_combined where table_type = 'IM_TRANS_ARR_TOTAL' and ICP_SRNO = '004' and pax_boarding_date = trunc(sysdate-37)";
			psTemp = con.prepareStatement(dashQuery);
			rsTemp = psTemp.executeQuery();
			while (rsTemp.next()) {

				hours_Axis = rsTemp.getInt("hours");
				//hourSet =  hourSet + "," ;
				hourly_flight_count_Axis = rsTemp.getString("hourly_flight_count");
				//hours,hourly_flight_count
				//str_Hours.add(hours_Axis);
				//str_Hours_Flight_Count.add(hourly_flight_count_Axis);

				if (zero_entry_Arr == true) {
			bl.append(",");
			b2.append(",");
				} else
			zero_entry_Arr = true;
				bl.append(hours_Axis);
				b2.append(hourly_flight_count_Axis);

			}

			rsTemp.close();
			psTemp.close();
		} catch (Exception e) {
			out.println("Chart 1 Exception");
		}
		//String str1 = str_Hours.toString();
		//String str2 = str_Hours_Flight_Count.toString();
		String str3 = bl.toString();
		String str4 = b2.toString();
		//out.println(str1);
		%>
		<div class="column">
			<canvas id="myPlot1" class="chart"></canvas>
			<script>
			new Chart("myPlot1", {
			  type: 'line',
			  data: {
				labels: [<%=str3%>],
				datasets: [{
				  fill:false,
				  lineTension: 0,
				  backgroundColor:"rgba(255, 0, 0, 0.8)",
				  borderColor: "rgba(255, 0, 0, 0.2)",
				  data: [<%=str4%>]
				}]
			  },
			  options: {
				legend: {display: false},
				scales: {
				  yAxes: [{ticks: {min: 0, max:12}}],
				  xAxes: [{ticks: {min: 0000, max:2400}}]
				}
			  }
			});
			</script>
		</div>

		<%
		int hours_Axis_Dep = 0;
		String hourly_flight_count_Axis_Dep = "";

		StringBuilder b5 = new StringBuilder();
		StringBuilder b6 = new StringBuilder();

		String hourSet_Dep = "";

		boolean zero_entry2 = false;
		try {
			depQuery = "select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_flight_count,active_counter_count,pax_boarding_date,hourly_pax_count from im_dashboard_combined where table_type = 'IM_TRANS_DEP_TOTAL' and ICP_SRNO = '004' and pax_boarding_date = trunc(sysdate-36)";
			psTemp = con.prepareStatement(depQuery);
			rsTemp = psTemp.executeQuery();
			while (rsTemp.next()) {

				hours_Axis_Dep = rsTemp.getInt("hours");
				//hourSet_Dep =  hourSet_Dep + "," ;
				hourly_flight_count_Axis_Dep = rsTemp.getString("hourly_flight_count");

				if (zero_entry2 == true) {
			b5.append(",");
			b6.append(",");
				} else
			zero_entry2 = true;
				b5.append(hours_Axis_Dep);
				b6.append(hourly_flight_count_Axis_Dep);

			}
			rsTemp.close();
			psTemp.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		//String str1 = str_Hours.toString();
		/*String str2 = str_Hours_Flight_Count.toString();*/
		String str5 = b5.toString();
		String str6 = b6.toString();
		//out.println(str1);
		%>
		<div class="column">
			<canvas id="myPlot2" class="chart"></canvas>
			<script>
			new Chart("myPlot2", {
			  type: 'line',
			  data: {
				labels: [<%=str5%>],
				datasets: [{
				  fill:false,
				  lineTension: 0,
				  backgroundColor:"rgba(8, 84, 20, 0.8)",
				  borderColor: "rgba(116, 207, 131, 0.8)",
				  data: [<%=str6%>]
				}]
			  },
			  options: {
				legend: {display: false},
				scales: {
				  yAxes: [{ticks: {min: 0, max:12}}],
				  xAxes: [{ticks: {min: 0000, max:2400}}]
				}
			  }
			});
			</script>
		</div>
	</div>

	<%
	////////////////////////////////////////////	Arr/Dep PAX Count - Start	////////////////////////////////////////////////////
	String WeeklyPAXQuery = "";
	String weekly_XAxis = "";
	int weekelyArrPaxCount = 0;
	int weekelyDepPaxCount = 0;

	StringBuilder weekDays = new StringBuilder();
	StringBuilder weekArrPax = new StringBuilder();
	StringBuilder weekDepPax = new StringBuilder();

	boolean flagPaxCount = false;
	try {
		WeeklyPAXQuery = "select distinct  to_char(pax_boarding_date,'Mon-dd') as show_date,pax_boarding_date,icp_description,DAILY_ARRIVAL_PAX_COUNT,DAILY_DEPARTURE_PAX_COUNT from im_dashboard_combined where table_type = 'IM_TRANS_DEP_TOTAL' and ICP_SRNO = '004' and pax_boarding_date >= trunc(sysdate-42) and pax_boarding_date <= trunc(sysdate-36) order by pax_boarding_date";
		psTemp = con.prepareStatement(WeeklyPAXQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			weekly_XAxis = rsTemp.getString("show_date");
			//out.println(weekly_XAxis);
			weekelyArrPaxCount = rsTemp.getInt("DAILY_ARRIVAL_PAX_COUNT");
			weekelyDepPaxCount = rsTemp.getInt("DAILY_DEPARTURE_PAX_COUNT");
			//out.println(weekelyArrPaxCount+weekelyDepPaxCount);

			if (flagPaxCount == true) {
		weekDays.append(",");
		weekArrPax.append(",");
		weekDepPax.append(",");
			} else
		flagPaxCount = true;

			weekDays.append("\"");
			weekDays.append(weekly_XAxis);
			weekDays.append("\"");
			weekArrPax.append(weekelyArrPaxCount);
			weekDepPax.append(weekelyDepPaxCount);
		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Arr/Dep PAX Count  Exception");
	}

	//String str1 = str_Hours.toString();
	//String str2 = str_Hours_Flight_Count.toString();
	String strWeekDays = weekDays.toString();
	String strweekArrPax = weekArrPax.toString();
	String strweekDepPax = weekDepPax.toString();
	//out.println(strWeekDays);
	%>

	<div class="row">

		<div class="column">
			<canvas id="canvasPAX" class="chart"></canvas>
			<script>



			// <block:setup:1>
			const DATA_COUNT = 7;
			const NUMBER_CFG = {count: DATA_COUNT, min: -100, max: 100};

			const labels = Utils.months({count: 7});
			const data = {
			  labels: labels,
			  datasets: [
			    {
			      label: 'Dataset 1',
			      data: Utils.numbers(NUMBER_CFG),
			      borderColor: Utils.CHART_COLORS.red,
			      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.red, 0.5),
			    },
			    {
			      label: 'Dataset 2',
			      data: Utils.numbers(NUMBER_CFG),
			      borderColor: Utils.CHART_COLORS.blue,
			      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.blue, 0.5),
			    }
			  ]
			};
			// </block:setup>

			// <block:config:0>
			const config = {
			  type: 'bar',
			  data: data,
			  options: {
			    indexAxis: 'y',
			    // Elements options apply to all of the options unless overridden in a dataset
			    // In this case, we are setting the border of each horizontal bar to be 2px wide
			    elements: {
			      bar: {
			        borderWidth: 2,
			      }
			    },
			    responsive: true,
			    plugins: {
			      legend: {
			        position: 'right',
			      },
			      title: {
			        display: true,
			        text: "Arrival and Departure Immigration Clearance in last 7 days"
			      }
			    }
			  },
			};
			// </block:config>

			module.exports = {
			  actions: actions,
			  config: config,
			};
			
			
						

			const NUMBER_CFG = {min: -100, max: 100};
 
				const xValuees = [<%=strWeekDays%>];	
				new Chart("canvasPAX", {
				  type: "bar",
				  data:
				  
				  {
					  labels: xValuees,
					  datasets: [
					    {
					      label: 'Arrival Footfalls',
					      data: Utils.numbers(NUMBER_CFG),
					      borderColor: Utils.CHART_COLORS.red,
					      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.red, 0.5),
					    },
					    {
					      label: 'Departure Footfalls',
					      data: Utils.numbers(NUMBER_CFG),
					      borderColor: Utils.CHART_COLORS.blue,
					      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.blue, 0.5),
					    }
					  ]
					}
				  
					{
					labels: xValuees,
					datasets: [{ 
						label: "",
					      backgroundColor: "pink",
					      borderColor: "red",
					      borderWidth: 1,
					      data: [<%=strweekArrPax%>]
					}, { 
						  label: "Departure Footfalls",
					      backgroundColor: "lightblue",
					      borderColor: "blue",
					      borderWidth: 1,
					      data: [<%=strweekDepPax%>]
					}]
				  }
				  	
				  	
				  	,
				  options: {
					  type: 'bar',
					  data: data,
					  options: {
					    indexAxis: 'y',
					    // Elements options apply to all of the options unless overridden in a dataset
					    // In this case, we are setting the border of each horizontal bar to be 2px wide
					    elements: {
					      bar: {
					        borderWidth: 2,
					      }
					    },
					    responsive: true,
					    plugins: {
					      legend: {
					        position: 'right',
					      },
					      title: {
					        display: true,
					        text: "Arrival and Departure Immigration Clearance in last 7 days"
					      }
					    }
					  },
					}
				});
			</script>
		</div>

		<%
		////////////////////////////////////////////	Arr/Dep PAX Count - End	////////////////////////////////////////////////////
		%>

		<%
		//////////////////////////////////////////////	Arr/Dep Flight Count - Start	////////////////////////////////////////////////////
		String WeeklyFlightsQuery = "";
		String weeklyFlightXAxis = "";
		int weekelyArrFlightCount = 0;
		int weekelyDepFlightCount = 0;

		StringBuilder weekDaysFlights = new StringBuilder();
		StringBuilder weekArrFlights = new StringBuilder();
		StringBuilder weekDepFlights = new StringBuilder();

		boolean flagFlightCount = false;
		try {
			WeeklyFlightsQuery = "select distinct  to_char(pax_boarding_date,'Mon-dd') as show_date,pax_boarding_date,icp_description,DAILY_ARRIVAL_FLIGHT_COUNT,DAILY_DEPARTURE_FLIGHT_COUNT from im_dashboard_combined where table_type = 'IM_TRANS_DEP_TOTAL' and ICP_SRNO = '004' and pax_boarding_date >= trunc(sysdate-42) and pax_boarding_date <= trunc(sysdate-36) order by pax_boarding_date";
			psTemp = con.prepareStatement(WeeklyFlightsQuery);
			rsTemp = psTemp.executeQuery();
			while (rsTemp.next()) {

				weeklyFlightXAxis = rsTemp.getString("show_date");
				//out.println(weeklyFlightXAxis);
				weekelyArrFlightCount = rsTemp.getInt("DAILY_ARRIVAL_FLIGHT_COUNT");
				weekelyDepFlightCount = rsTemp.getInt("DAILY_DEPARTURE_FLIGHT_COUNT");
				//out.println(weekelyArrFlightCount+weekelyDepFlightCount);

				if (flagFlightCount == true) {
			weekDaysFlights.append(",");
			weekArrFlights.append(",");
			weekDepFlights.append(",");
				} else
			flagFlightCount = true;

				weekDaysFlights.append("\"");
				weekDaysFlights.append(weeklyFlightXAxis);
				weekDaysFlights.append("\"");
				weekArrFlights.append(weekelyArrFlightCount);
				weekDepFlights.append(weekelyDepFlightCount);

			}
			rsTemp.close();
			psTemp.close();

		} catch (Exception e) {
			out.println("Arr/Dep Flight Count  Exception");
		}

		String strWeekDaysFlights = weekDaysFlights.toString();
		String strweekArrFlights = weekArrFlights.toString();
		String strweekDepFlights = weekDepFlights.toString();
		%>

		<div class="column">
			<canvas id="canvasFlights" class="chart"></canvas>
			<script>
				const xValueess = [<%=strWeekDaysFlights%>];	
				new Chart("canvasFlights", {
				  type: "bar",
				  data: {
					labels: xValueess,
					datasets: [{ 
						  label: "Arrival Flights Count",
					      backgroundColor: "pink",
					      borderColor: "red",
					      borderWidth: 1,
					      data: [<%=strweekArrFlights%>]
					}, { 
						  label: "Departure Flights Count",
					      backgroundColor: "lightblue",
					      borderColor: "blue",
					      borderWidth: 1,
					      data: [<%=strweekDepFlights%>]
					}]
				  },
				  options: {
					  responsive: true,
					  legend: {
					    position: "top"
					  },
					  title: {
					    display: true,
					    text: "Arrival and Departure Flights in last 7 days"
					  },
					  scales: {
					    yAxes: [{
					      ticks: {
					        beginAtZero: true
					      }
					    }]
					  }
				  }
				});
			</script>
		</div>
		
	</div>

	<%
	////////////////////////////////////////////	Arr/Dep Flight Count - End	////////////////////////////////////////////////////
	%>


	<%
	////////////////////////////////////////////	Arr Hourly PAX,flight,counter Count - Start	////////////////////////////////////////////////////
	String arrHourlyQuery = "";
	String hourlyXAxis = "";
	int hourlyArrFlightCount = 0;
	int hourlyArrPaxCount = 0;
	int hourlyArrActiveCounter = 0;

	StringBuilder hourlyTime = new StringBuilder();
	StringBuilder hourlyPax = new StringBuilder();
	StringBuilder hourlyFlight = new StringBuilder();
	StringBuilder hourlyActiveCounter = new StringBuilder();
 
	flagPaxCount = false;
	try {
		arrHourlyQuery = "select * from (select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_flight_count,active_counter_count,pax_boarding_date,hourly_pax_count  from im_dashboard_combined where pax_boarding_date = trunc(sysdate-6) and table_type = 'IM_TRANS_ARR_TOTAL' and icp_srno = '004' order by pax_boarding_date,HOURS desc ) where rownum<=7";
		psTemp = con.prepareStatement(arrHourlyQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			hourlyXAxis = rsTemp.getString("date_time");
			//out.println(hourlyXAxis);
			hourlyArrFlightCount = rsTemp.getInt("hourly_flight_count");
			hourlyArrPaxCount = rsTemp.getInt("hourly_pax_count");
			hourlyArrActiveCounter = rsTemp.getInt("active_counter_count");
			//out.println(hourlyArrActiveCounter);

			if (flagPaxCount == true) {
		hourlyTime.append(",");
		hourlyPax.append(",");
		hourlyFlight.append(",");
		hourlyActiveCounter.append(",");
			} else
		flagPaxCount = true;

			hourlyTime.append("\"");
			hourlyTime.append(hourlyXAxis);
			hourlyTime.append("\"");
			hourlyPax.append(hourlyArrPaxCount);
			hourlyFlight.append(hourlyArrFlightCount);
			hourlyActiveCounter.append(hourlyArrActiveCounter);
		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Arr PAX, Flight and Active Count  Exception");
	}

	//String str1 = str_Hours.toString();
	//String str2 = str_Hours_Flight_Count.toString();
	String strHourlyTime = hourlyTime.toString();
	String strHourlyArrPax = hourlyPax.toString();
	String strHourlyArrFlight = hourlyFlight.toString();
	String strHourlyArrActiveCounter = hourlyActiveCounter.toString();
	
	%>

	<div class="row" class="chart-container" style="position: relative; height:40vh; width:80vw">

		<div class="column"  >
			<canvas id="canvasArrPAXFltActCount" class="chart"></canvas>
			<script>
				const xValueesss = [<%=strHourlyTime%>];	
				new Chart("canvasArrPAXFltActCount", {
				  type: "bar",
				  data: {
					labels: xValueesss,
					datasets: [{ 
						label: "Arrival Footfalls",
					      backgroundColor: "pink",
					      borderColor: "red",
					      borderWidth: 1,
					      data: [<%=strHourlyArrPax%>]
					}, { 
						  label: "Arrival Flights",
					      backgroundColor: "lightblue",
					      borderColor: "blue",
					      borderWidth: 1,
					      data: [<%=strHourlyArrFlight%>]
					},
					 { 
						  label: "Arrival Active Counters",
					      backgroundColor: "lightgrey",
					      borderColor: "grey",
					      borderWidth: 1,
					      data: [<%=strHourlyArrActiveCounter%>]
					}]
				  },
				  options: {
					  maintainAspectRatio : true,
					  responsive: true,
					  legend: {
					    position: "top"
					  },
					  title: {
					    display: true,
					    text: "Arrival : PAX, Flight and Active Counters for last 7 hours"
					  },
					  scales: {
					    yAxes: [{
					      ticks: {
					        beginAtZero: true
					      }
					    }]
					  }
				  }
				});
			</script>
		</div>

		<%
		////////////////////////////////////////////	Arr Hourly PAX,flight,counter Count - End	////////////////////////////////////////////////////
		%>
		
<%
	////////////////////////////////////////////	Dep Hourly PAX,flight,counter Count - Start	////////////////////////////////////////////////////
	String depHourlyQuery = "";
	String hourlyDepXAxis = "";
	int hourlyDepFlightCount = 0;
	int hourlyDepPaxCount = 0;
	int hourlyDepActiveCounter = 0;

	StringBuilder hourlyDepTime = new StringBuilder();
	StringBuilder hourlyDepPax = new StringBuilder();
	StringBuilder hourlyDepFlight = new StringBuilder();
	StringBuilder hourlyDepDepActiveCounter = new StringBuilder();

	flagPaxCount = false;
	try {
		depHourlyQuery = "select * from (select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_flight_count,active_counter_count,pax_boarding_date,hourly_pax_count  from im_dashboard_combined where pax_boarding_date = trunc(sysdate-8) and table_type = 'IM_TRANS_DEP_TOTAL' and icp_srno = '004' order by pax_boarding_date,HOURS desc ) where rownum<=7";
		psTemp = con.prepareStatement(depHourlyQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			hourlyDepXAxis = rsTemp.getString("date_time");
			//out.println(hourlyDepXAxis);
			hourlyDepFlightCount = rsTemp.getInt("hourly_flight_count");
			hourlyDepPaxCount = rsTemp.getInt("hourly_pax_count");
			hourlyDepActiveCounter = rsTemp.getInt("active_counter_count");
			//out.println(hourlyDepActiveCounter);

			if (flagPaxCount == true) {
		hourlyDepTime.append(",");
		hourlyDepPax.append(",");
		hourlyDepFlight.append(",");
		hourlyDepDepActiveCounter.append(",");
			} else
		flagPaxCount = true;

			hourlyDepTime.append("\"");
			hourlyDepTime.append(hourlyDepXAxis);
			hourlyDepTime.append("\"");
			hourlyDepPax.append(hourlyDepPaxCount);
			hourlyDepFlight.append(hourlyDepFlightCount);
			hourlyDepDepActiveCounter.append(hourlyDepActiveCounter);
		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Dep PAX, Flight and Active Count  Exception");
	}

	//String str1 = str_Hours.toString();
	//String str2 = str_Hours_Flight_Count.toString();
	strHourlyTime = "";
	strHourlyTime = hourlyDepTime.toString();
	String strHourlyDepPax = hourlyDepPax.toString();
	String strHourlyDepFlight = hourlyDepFlight.toString();
	String strHourlyDepActiveCounter = hourlyDepDepActiveCounter.toString();
	//out.println(strHourlyDepActiveCounter);
	%>


		<div class="column" >
			<canvas id="canvasDepPAXFltActCount" class="chart"></canvas>
			<script>
				const xValueessss = [<%=strHourlyTime%>];	
				new Chart("canvasDepPAXFltActCount", {
				  type: "bar",
				  data: {
					labels: xValueessss,
					datasets: [{ 
						label: "Departure Footfalls",
					      backgroundColor: "pink",
					      borderColor: "red",
					      borderWidth: 1,
					      data: [<%=strHourlyDepPax%>]
					}, { 
						  label: "Departure Flights",
					      backgroundColor: "lightblue",
					      borderColor: "blue",
					      borderWidth: 1,
					      data: [<%=strHourlyDepFlight%>]
					},
					 { 
						  label: "Departure Active Counters",
					      backgroundColor: "lightgrey",
					      borderColor: "grey",
					      borderWidth: 1,
					      data: [<%=strHourlyDepActiveCounter%>]
					}]
				  },
				  options: {
					  maintainAspectRatio : true,
					  responsive: true,
					  legend: {
					    position: "top"
					  },
					  title: {
					    display: true,
					    text: "Departure : PAX, Flight and Active Counters for last 7 hours"
					  },
					  scales: {
					    yAxes: [{
					      ticks: {
					        beginAtZero: true
					      }
					    }]
					  }
				  }
				});
			</script>
		</div>

		<%
		////////////////////////////////////////////	Dep Hourly PAX,flight,counter Count - End	////////////////////////////////////////////////////
		%>
	</div>		
	
	<div class="row">

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
		  backgroundColor : "red",
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
			<canvas id="myFunc2" class="chart"></canvas>
<script>
    

var options = {
  series: [{
  name: 'Males',
  data: [0.4, 0.65, 0.76, 0.88, 1.5, 2.1, 2.9, 3.8, 3.9, 4.2, 4, 4.3, 4.1, 4.2, 4.5,
    3.9, 3.5, 3
  ]
},
{
  name: 'Females',
  data: [-0.8, -1.05, -1.06, -1.18, -1.4, -2.2, -2.85, -3.7, -3.96, -4.22, -4.3, -4.4,
    -4.1, -4, -4.1, -3.4, -3.1, -2.8
  ]
}
],
  chart: {
  type: 'bar',
  height: 440,
  stacked: true
},
colors: ['#008FFB', '#FF4560'],
plotOptions: {
  bar: {
    horizontal: true,
    barHeight: '80%',
  },
},
dataLabels: {
  enabled: false
},
stroke: {
  width: 1,
  colors: ["#fff"]
},

grid: {
  xaxis: {
    lines: {
      show: false
    }
  }
},
yaxis: {
  min: -5,
  max: 5,
  title: {
    // text: 'Age',
  },
},
tooltip: {
  shared: false,
  x: {
    formatter: function (val) {
      return val
    }
  },
  y: {
    formatter: function (val) {
      return Math.abs(val) + "%"
    }
  }
},
title: {
  text: 'Mauritius population pyramid 2011'
},
xaxis: {
  categories: ['85+', '80-84', '75-79', '70-74', '65-69', '60-64', '55-59', '50-54',
    '45-49', '40-44', '35-39', '30-34', '25-29', '20-24', '15-19', '10-14', '5-9',
    '0-4'
  ],
  title: {
    text: 'Percent'
  },
  labels: {
    formatter: function (val) {
      return Math.abs(Math.round(val)) + "%"
    }
  }
},
};

var chart = new ApexCharts(document.querySelector("#chart"), options);
chart.render();



	</script>
		</div>
	</div>
	<div class="row">
	
	<div class="column">
	<div id="horizontalChart" style="width:100%; max-width:600px; height:500px;"></div>	</div>
	<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

// Set Data
const datass = google.visualization.arrayToDataTable([
  ['Contry', 'Mhl'],
  ['Italy',55],
  ['France',49],
  ['Spain',44],
  ['USA',24],
  ['Argentina',15]
]);

// Set Options
const optionssss = {
  title:'World Wide Wine Production'
};

// Draw
const chartsss = new google.visualization.BarChart(document.getElementById('horizontalChart'));
chartsss.draw(datass, optionssss);

}
</script>

	</div>
	
	<div class="row">
<div class="column">
 
 
 
      <div class="main-content" id="panel">
        
        <div class="container-fluid pt-3">
            <div class="row mt-4 removable">
                <div class="col-lg-8 col-md-6">
                    <div class="card mb-4 bg-dark">
                        
                        <div class="card-body px-0 pb-2">
                            <div class="table-responsive">
                                <table class="table table-dark align-items-center mb-0">
                                    <thead>
                                        <tr>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Date</th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Pax Count</th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Flight Count</th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Active Counter Count</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% 
                                    //String strHourlyTime = hourlyTime.toString();
                                	//String strHourlyArrPax = hourlyPax.toString();
                                	//String strHourlyArrFlight = hourlyFlight.toString();
                                	//String strHourlyArrActiveCounter = hourlyActiveCounter.toString();
                                	
                                	
                                	//out.println(hourlyTime.toString().replace("\"",""));
                                    
                                	String[] weekList = hourlyTime.toString().replace("\"","").split(",");
                                	String[] arrPax = strHourlyArrPax.split(",");
                                	String[] arrFlight = strHourlyArrFlight.split(",");
                                	String[] arrCounter = strHourlyArrActiveCounter.split(",");
                                	
                                	for(int i = 0; i < weekList.length; i++)
                                    {
                                    %>
                                        <tr>
                                            <td>
                                                <div class="d-flex px-2 py-1">
                                                    <div>
                                                        <img src="https://demos.creative-tim.com/soft-ui-dashboard/assets/img/small-logos/logo-xd.svg" class="avatar avatar-sm me-3">
                                                    </div>
                                                    <div class="d-flex flex-column justify-content-center">
                                                        <h6 class="mb-0 text-sm text-white"><%=weekList[i] %></h6>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
  												<span class="text-xs text-white font-weight-bold"><%=arrPax[i] %> </span>
                                               
                                            </td>
                                            <td class="align-middle text-center text-sm">
                                                <span class="text-xs text-white font-weight-bold"><%=arrFlight[i] %> </span>
                                            </td>
                                            <td class="align-middle text-center text-sm">
                                                <span class="text-xs text-white font-weight-bold"><%=arrCounter[i] %> </span>
                                            </td>
                                            <!--  <td class="align-middle">
                                                <div class="progress-wrapper w-75 mx-auto">
                                                    <div class="progress-info">
                                                        <div class="progress-percentage">
                                                            <span class="text-xs font-weight-bold">60%</span>
                                                        </div>
                                                    </div>
                                                    <div class="progress">
                                                        <div class="progress-bar bg-gradient-info w-60" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                </div>
                                            </td>
                                            -->
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">

                </div>
            </div>
        </div>


    </div>
    </div>
    </div>

    <script>
        if (document.querySelector("#chart-bars")) {
           	var ctx = document.getElementById("chart-bars").getContext("2d");
           	new Chart(ctx, {
              type: "bar",
              data: {
                labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                  label: "Sales",
                  tension: 0.4,
                  borderWidth: 0,
                  borderRadius: 4,
                  borderSkipped: false,
                  backgroundColor: "#fff",
                  data: [450, 200, 100, 220, 500, 100, 400, 230, 500],
                  maxBarThickness: 6
                }, ],
              },
              options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                  legend: {
                    display: false,
                  }
                },
                interaction: {
                  intersect: false,
                  mode: 'index',
                },
                scales: {
                  y: {
                    grid: {
                      drawBorder: false,
                      display: false,
                      drawOnChartArea: false,
                      drawTicks: false,
                    },
                    ticks: {
                      suggestedMin: 0,
                      suggestedMax: 500,
                      beginAtZero: true,
                      padding: 15,
                      font: {
                        size: 14,
                        family: "Open Sans",
                        style: 'normal',
                        lineHeight: 2
                      },
                      color: "#fff"
                    },
                  },
                  x: {
                    grid: {
                      drawBorder: false,
                      display: false,
                      drawOnChartArea: false,
                      drawTicks: false
                    },
                    ticks: {
                      display: false
                    },
                  },
                },
              },
            });
        
           };
           if (document.querySelector("#chart-line")) {
           	var ctx2 = document.getElementById("chart-line").getContext("2d");
           	var gradientStroke1 = ctx2.createLinearGradient(0, 230, 0, 50);
           	gradientStroke1.addColorStop(1, "rgba(203,12,159,0.2)");
           	gradientStroke1.addColorStop(0.2, "rgba(72,72,176,0.0)");
           	gradientStroke1.addColorStop(0, "rgba(203,12,159,0)");
           	var gradientStroke2 = ctx2.createLinearGradient(0, 230, 0, 50);
           	gradientStroke2.addColorStop(1, "rgba(20,23,39,0.2)");
           	gradientStroke2.addColorStop(0.2, "rgba(72,72,176,0.0)");
           	gradientStroke2.addColorStop(0, "rgba(20,23,39,0)");
           	new Chart(ctx2, {
              type: "line",
              data: {
                labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Mobile apps",
                    tension: 0.4,
                    borderWidth: 0,
                    pointRadius: 0,
                    borderColor: "#cb0c9f",
                    borderWidth: 3,
                    backgroundColor: gradientStroke1,
                    fill: true,
                    data: [50, 40, 300, 220, 500, 250, 400, 230, 500],
                    maxBarThickness: 6
        
                  },
                  {
                    label: "Websites",
                    tension: 0.4,
                    borderWidth: 0,
                    pointRadius: 0,
                    borderColor: "#3A416F",
                    borderWidth: 3,
                    backgroundColor: gradientStroke2,
                    fill: true,
                    data: [30, 90, 40, 140, 290, 290, 340, 230, 400],
                    maxBarThickness: 6
                  },
                ],
              },
              options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                  legend: {
                    display: false,
                  }
                },
                interaction: {
                  intersect: false,
                  mode: 'index',
                },
                scales: {
                  y: {
                    grid: {
                      drawBorder: false,
                      display: true,
                      drawOnChartArea: true,
                      drawTicks: false,
                      borderDash: [5, 5]
                    },
                    ticks: {
                      display: true,
                      padding: 10,
                      color: '#b2b9bf',
                      font: {
                        size: 11,
                        family: "Open Sans",
                        style: 'normal',
                        lineHeight: 2
                      },
                    }
                  },
                  x: {
                    grid: {
                      drawBorder: false,
                      display: false,
                      drawOnChartArea: false,
                      drawTicks: false,
                      borderDash: [5, 5]
                    },
                    ticks: {
                      display: true,
                      color: '#b2b9bf',
                      padding: 20,
                      font: {
                        size: 11,
                        family: "Open Sans",
                        style: 'normal',
                        lineHeight: 2
                      },
                    }
                  },
                },
              },
            }); 
           };
    </script>



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
	} catch (Exception e) {
	e.printStackTrace();
	} finally {
	if (con != null)
		con.close();

	}
	%>
</body>
</html>
