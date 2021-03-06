<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<div class="col-md-3 left_col">
	<div class="left_col scroll-view">

		<div class="navbar nav_title" style="border: 0;">
			<a href="index.html" class="site_title"><i class="glyphicon glyphicon-fire"></i>
				<span>Tinder</span></a>
		</div>
		<div class="clearfix">
		</div>

		<!-- menu prile quick info -->
		<a href="Profile">
			<div class="profile">
				<div class="profile_pic">
					<img src="images/${user.avatarName}"  alt="..." class="img-circle profile_img">
				</div>
				<div class="profile_info">
					<span>Welcome, ${user.username}</span>
					<span class="glyphicon glyphicon-envelope">
						${user.email}
					</span>
				</div>
			</div>
		</a>
		<!-- /menu prile quick info -->

		<br />

		<!-- sidebar menu -->
		<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

			<div class="menu_section">
				<h3>General</h3>
				<ul class="nav side-menu">
					<li><a href="Messages"><i class="fa fa-comment"></i>
							Messages </a></li>
					<li><a href="DiscoverySettings"><i
							class="fa fa-heart-o"></i> Discovery settings</a></li>
					<li><a href="AppSettings"><i class="fa fa-fire"></i>
							App settings</a></li>
					<li><a href="#"><i class="fa fa-info"></i>
							Help and Info</a></li>
				</ul>
			</div>

		</div>
		<!-- /sidebar menu -->

		<!-- /menu footer buttons -->
		<div class="sidebar-footer hidden-small">
			<a href="Logout" data-toggle="tooltip" data-placement="top"
				title="Logout"> <span class="glyphicon glyphicon-off"
				aria-hidden="true"></span>
			</a>
		</div>
		<!-- /menu footer buttons -->
	</div>
</div>