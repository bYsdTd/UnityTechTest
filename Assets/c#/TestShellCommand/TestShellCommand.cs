using UnityEngine;
using System.Collections;
using System.Diagnostics;

public class TestShellCommand : MonoBehaviour {

	// Use this for initialization
	void Start () {

		ProcessStartInfo proc = new ProcessStartInfo();
		proc.FileName = "open";
		proc.WorkingDirectory = "/users/zhangyi";
		proc.Arguments = "talk.sh";
		proc.WindowStyle = ProcessWindowStyle.Minimized;
		proc.CreateNoWindow = true;
		Process.Start(proc);
		UnityEngine.Debug.Log("Halløjsa");
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
