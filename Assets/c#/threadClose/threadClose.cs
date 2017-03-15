using UnityEngine;
using System.Collections;

public class threadClose : MonoBehaviour {

	private ThreadA thread;

	// Use this for initialization
	void Start () {
	
		thread = new ThreadA();
		thread.name = "A";

		thread.Main();


		StartCoroutine(delayCall());
	}

	IEnumerator delayCall()
	{
		yield return new WaitForSeconds(3.0f);

		thread = new ThreadA();
		thread.name = "B";
		thread.Main();
		yield break;
	}

	// Update is called once per frame
	void Update () {
	
	}
}
