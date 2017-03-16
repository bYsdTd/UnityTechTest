using UnityEngine;
using System.Collections;

public class InstanceIDTest : MonoBehaviour {

	// Use this for initialization
	void Start () {

		GameObject prefab = Resources.Load<GameObject>("cube/Cube");
		Debug.Log("prefab " + prefab.GetInstanceID());

		GameObject instance = GameObject.Instantiate(prefab);
		Debug.Log("instance " + instance.GetInstanceID());

		GameObject prefab2 = Resources.Load<GameObject>("cube/Cube");
		Debug.Log("prefab2 " + prefab2.GetInstanceID());

		GameObject instance2 = GameObject.Instantiate(prefab2);
		Debug.Log("instance2 " + instance2.GetInstanceID());
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
