using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class dynamicreflection : MonoBehaviour {

	public Transform posA;
	public Transform posB;

	public Cubemap cubeA;
	public Cubemap cubeB;

	RenderTexture dynamiccube;
	Camera rendercamera;


	// Use this for initialization
	void Start () {

	}
	
	// Update is called once per frame
	void Update () {

		//var cube = CheckProbeDistance();

//		var mesh = gameObject.GetComponent<MeshRenderer>();
//		mesh.sharedMaterial.SetTexture("_Cubemap", cube);

		// update cube map

		updatecubemap();
	}

	void updatecubemap()
	{
		if(rendercamera == null)
		{
			GameObject go = new GameObject("cubemapcamera");
			rendercamera = go.AddComponent<Camera>();
			go.transform.position = gameObject.transform.position;
			go.transform.rotation = Quaternion.identity;


		}

		if(dynamiccube == null)
		{
			dynamiccube = new RenderTexture(128, 128, 16);
			dynamiccube.isCubemap = true;


		}

		var mesh = gameObject.GetComponent<MeshRenderer>();
		mesh.sharedMaterial.SetTexture("_Cubemap", dynamiccube);
		rendercamera.transform.position = gameObject.transform.position;
		rendercamera.RenderToCubemap(dynamiccube);
	}

//	private Cubemap CheckProbeDistance()  
//	{  
//		float distA = Vector3.Distance(transform.position, posA.position);  
//		float distB = Vector3.Distance(transform.position, posB.position);  
//		
//		if(distA < distB)  
//		{  
//			return cubeA;  
//		}  
//		else if(distB < distA)  
//		{  
//			return cubeB;  
//		}  
//		else  
//		{  
//			return cubeA;  
//		}  
//		
//	}

}
