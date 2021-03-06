package com.tinder.model.dao.message;

import java.time.LocalDateTime;
import java.util.List;

import com.tinder.model.pojo.User;
import com.tinder.model.pojo.chat.Message;

public interface IMessageDAO {

	List<Message> getLastMessagesFrom(int numMessages, User user1, User user2, LocalDateTime fromTime);

	void sendMessage(String msg, User from, User to);

	int findChatId(User firstUser, User secondUser);
	
	void deletAllMessagesBetweenUsers(User user1,User user2);
	
	void insertMessageNotification(User from, User to);
	
	boolean isMessageNotificationExisting(User firstUser, User secondUser);

}