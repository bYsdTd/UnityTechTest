using UnityEngine;
using System.Collections;

public class Main : MonoBehaviour {

	// Use this for initialization
	void Start () {
//		Singleton.func();
//
//		Singleton.Instance().HelloWorld();

		//AssemblyCSharp.President.Instance().Say();
		AssemblyCSharp.ChinaPresident.Instance().Say();
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void FixedUpdate()
	{
		Debug.Log("FixedUpdate");
	}
}
