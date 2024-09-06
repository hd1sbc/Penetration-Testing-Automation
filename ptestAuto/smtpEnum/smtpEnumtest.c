/*****************************
THIS IS NOT FINISHED.
*****************************/
#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<arpa/inet.h>

int main(int argc, char* argv[])
{
	int socketVal;
	struct sockaddr_in destAddy;
	char* message;
	char server_reply[100];
	
	//Build socket
	socketVal = socket(AF_INET , SOCK_STREAM , 0);
	destAddy.sin_addr.s_addr = inet_addr(argv[2]);
	destAddy.sin_family = AF_INET;
	destAddy.sin_port = htons( 25 );

	//Connect
	if (connect(socketVal , (struct sockaddr*)&destAddy, sizeof(destAddy)) >= 0)
	{
		printf("%s\n", "Connection Complete");
		return 1;
	}
	else {
		printf("%s\n", "Connection Failed");
	}
		
	//Send
	message = "GET /?st=1 HTTP/1.1\r\nHost: www.msn.com\r\n\r\n";
	if( send(socketVal , message , strlen(message) , 0) < 0)
	{
		puts("Send failed");
		return 1;
	}
	puts("Data Send\n");
	
	//Receive a reply from the server
	if( recv(socketVal, server_reply , 6000 , 0) < 0)
	{
		puts("recv failed");
	}
	puts("Reply received\n");
	puts(server_reply);
	
	return 0;
}
  

