<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Tinder</title>


<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="fonts/css/font-awesome.min.css" rel="stylesheet">
<link href="css/animate.min.css" rel="stylesheet">
<link href="css/custom.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="css/maps/jquery-jvectormap-2.0.3.css" />
<link href="css/icheck/flat/green.css" rel="stylesheet" />
<link href="css/floatexamples.css" rel="stylesheet" type="text/css" />
<script src="http://code.jquery.com/jquery-2.2.2.js"
	integrity="sha256-4/zUCqiq0kqxhZIyp4G0Gk+AOtCJsY1TA00k5ClsZYE="
	crossorigin="anonymous"></script>
<link href="css/messages/messages.css" rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">

<script src="js/jquery.min.js"></script>
<script src="js/nprogress.js"></script>
</head>
<body class="nav-md">
	<div class="container body">

		<div class="main_container">

			<jsp:include page="sideMenu.jsp" />

			<div class="right_col" role="main">

				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="dashboard_graph">

							<div class="row x_title">
								<div class="col-md-12">
									<!-- form grid slider -->
									<div class="x_panel" style="">
										<div class="x_title">
											<h2>Messages</h2>
											<div class="clearfix"></div>
										</div>
										<div class="x_content">
											<div class="content container-fluid bootstrap snippets">
												<div class="row row-broken">
													<div class="col-sm-3 col-xs-12">
														<div class="col-inside-lg decor-default chat"
															style="overflow: hidden; outline: none;" tabindex="5000">
															<div id="chat-users" class="chat-users"></div>
														</div>
													</div>
													<div class="col-sm-9 col-xs-12 chat"
														style="overflow: hidden; outline: none;" tabindex="5001">
														<div class="col-inside-lg decor-default">
															<div class="chat-body">
																<div id="messages">
																	<h6>Mini Chat</h6>
																	
																</div>
																<div style='display: inline;'>
																		<input id='messageToSend'
																			placeholder='Write a message' type='text'
																			class='form-control'> <span
																			class='input-group-btn'>
																			<button id='send-button' style='width: 100%'
																				onclick='send();' type='button'
																				class='btn btn-primary'>Send</button>
																		</span>
																	</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- /form grid slider -->
								</div>
								<div class="col-md-6"></div>
							</div>


							<div class="clearfix"></div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="js/bootstrap.min.js"></script>
	<script src="js/custom.js"></script>
	<script src="js/stomp/stomp.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/0.3.4/sockjs.min.js"></script>
	<script
		src="http://91.234.35.26/iwiki-admin/v1.0.0/admin/js/jquery.nicescroll.min.js"></script>
	<script type="text/javascript">
		//$(".chat").niceScroll();
		var url = 'http://' + window.location.host + '/Tinder/messageEndpoint';
		var sock = new SockJS(url);
		var stomp = Stomp.over(sock);
		stomp
				.connect(
						'guest',
						'guest',
						function(frame) {
							console.log('Connected');
							stomp
									.subscribe(
											"/app/getInitialData",
											function(frame) {
												$('#chat-users').empty();
												chats = JSON.parse(frame.body);
												for ( var chat in chats) {
													$('#chat-users')
															.append(
																	"<div class='user' onclick='loadMessages(\""
																			+ chat
																			+ "\")'>"
																			+ "<div class='avatar'>"
																			+ "<img "
							+ "src=\"images/"+chats[chat].picture+"\" "
							+ "alt='User name'>"
																			+ "<div class='status off'></div>"
																			+ "</div>"
																			+ "<div class='name'>"
																			+ chat
																			+ "</div>"
																			+ "<div class='mood'>User mood</div>"
																			+ "</div>");
												}
												stomp
														.subscribe(
																"/topic/${user.username}",
																handleMessage);
											});
						});
		var send = function() {
			var outgoingMessage = JSON.stringify({
				'message' : $('#messageToSend').val(),
				'receiver' : toSend
			});
			stomp.send("/app/dispatcher", {}, outgoingMessage);
			var value = getMessage('right', '${user.username}', $(
					'#messageToSend').val(), "${user.avatarName}", '');
			$('#messages').append(value);
			$('#messageToSend').val('');

		};
		function handleMessage(incomingMessage) {
			var currentUser = "${user.username}";
			var message = JSON.parse(incomingMessage.body);
			if (currentUser == message.senderUsername) {
				var value = getMessage('right', message.senderUsername,
						message.message, "${user.avatarName}", '');
				$('#messages').append(value);
			} else {
				var value = getMessage('left', message.senderUsername,
						message.message, message.picture, '');
				$('#messages').append(value);
			}
			console.log('Received: ', message);
		}
		function loadMessages(chat) {
			toSend = chat;
			var currentUser = "${user.username}";
			var messages = chats[chat].messages;
			$('#messages').empty();
			for ( var message in messages) {
				if (currentUser == messages[message].senderUsername) {
					var value = getMessage('right',
							messages[message].senderUsername,
							messages[message].message, "${user.avatarName}", '');
					$('#messages').append(value);
				} else {
					var value = getMessage('left',
							messages[message].senderUsername,
							messages[message].message, chats[chat].picture, '');
					$('#messages').append(value);
				}
			}
			$(".chat").niceScroll();
		}

		function getMessage(side, senderUsername, senderMessage, picture, time) {
			return "<div class='answer "+side+"'>"
					+ "	<div class='avatar'>"
					+ "		<img "
			+ "			src='images/"+picture+"' "
			+ "			alt='User name'>"
					+ "		<div class='status offline'></div>" + "		</div>"
					+ "		<div class='name'>" + senderUsername + "</div>"
					+ "		<div class='text'>" + senderMessage + "</div>"
					+ "		<div class='time'>" + time + "</div>" + " </div>";
		}

		function getInput() {
			return "<div style=' display: inline;'> "
					+ "	<input id='messageToSend' placeholder='Write a message' type='text' class='form-control'> <span"
				+"		class='input-group-btn'>"
					+ "		<button id='send-button' style='width: 100%' onclick='send();' type='button' class='btn btn-primary'>Send</button>"
					+ "	</span>" + "</div>"
		}
	</script>
</body>

</html>