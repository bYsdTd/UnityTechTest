using UnityEngine;
using System.Collections;
using System.Threading;

public class Worker
{
	public string name {set; get;}

	// This method will be called when the thread is started.
	public void DoWork()
	{
		Debug.Log(name + "worker thread: start.");


		while (!_shouldStop)
		{
			Debug.Log(name + "worker thread: working...");
		}

		Debug.Log(name + "worker thread: terminating gracefully.");
	}

	public void RequestStop()
	{
		_shouldStop = true;
	}
	// Volatile is used as hint to the compiler that this data
	// member will be accessed by multiple threads.
	private volatile bool _shouldStop;
}

public class ThreadA 
{
	private Thread workerThread;
	private Worker workerObject;

	public string name {set; get;}

	public void Main()
	{
		// Create the thread object. This does not start the thread.
		workerObject = new Worker();
		workerObject.name = name;
		workerThread = new Thread(workerObject.DoWork);

		// Start the worker thread.
		workerThread.Start();	
	}

	public void RequestClose()
	{
		workerObject.RequestStop();
	}
}
