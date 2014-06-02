
public class FormValidator 
{
	static boolean validateUsername(String s)	//usernames must be atleast 3 chars and can contain nums and letters
	{
		if(s.matches("[a-zA-Z0-9\\._\\-]{3,}"))
			return true;
		else
			return false;
	}
	static boolean validatePassword(String s) //same as username
	{
		if(s.matches("[a-zA-Z0-9\\._\\-]{3,}"))
			return true;
		else
			return false;
	}
	static boolean validateTitle(String s)	//makes sure it not empty
	{
		if(s.length()==0)
			return false;
		else
			return true;
	}
	static boolean validateContent(String s) //makes sure it not empty
	{
		if(s.length()==0)
			return false;
		else
			return true;
	}
}
