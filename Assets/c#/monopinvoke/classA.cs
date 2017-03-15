using UnityEngine;
using System.Collections;

public class FunctionAttribute : System.Attribute
{
	private System.Type type;

	public FunctionAttribute(System.Type t)
	{
		type = t;
	}
}


public class classA 
{
	public delegate void CallFunction(int b);

	//[FunctionAttribute(typeof(CallFunction))]
	static public void FunctionA(int a)
	{
		Debug.Log("call Function A");
	}

	static public void CallBack(CallFunction callback)
	{
		if(callback != null)
		{
			callback.Invoke(10);
		}
	}

	static public void Main()
	{
		CallBack(FunctionA);
	}
}

