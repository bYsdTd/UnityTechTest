using UnityEngine;
using System.Collections;

public sealed class Singleton
{
	public static void func()
	{
		Debug.Log("func call ");	
	}

	public static int a = 1;

	private Singleton()
	{
		Debug.Log("Singleton static constructor");	
	}

	public static Singleton Instance()
	{
		Debug.Log("Instance call ");
		return Nested.instance;

	}
		
	class Nested
	{
		private Nested()
		{
			Debug.Log("Nested constructor");
		}

		internal static Singleton instance = new Singleton();

	}

	public void HelloWorld()
	{
		Debug.Log("HelloWorld");
	}
}
