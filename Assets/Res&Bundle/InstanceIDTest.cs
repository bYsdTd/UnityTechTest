using UnityEngine;
using System.Collections;

public class InstanceIDTest : MonoBehaviour {

	// Use this for initialization
	void Start () {

		//TestBundleManifest();

		//TestLoadBundleNotInterity();
		TestLoadAssetsFromBundleNameAndAssetsName();
	}

	void TestInstanceID()
	{
		GameObject prefab = Resources.Load<GameObject>("Cube");
		Debug.Log("prefab " + prefab.GetInstanceID());

		Material mat = prefab.GetComponent<Material>();
		Debug.Log("mat " + mat.GetInstanceID());

		GameObject instance = GameObject.Instantiate(prefab);
		Debug.Log("instance " + instance.GetInstanceID());

		Material matInstance = instance.GetComponent<Material>();
		Debug.Log("matInstance " + matInstance.GetInstanceID());

		Shader shader = Shader.Find("Custom/standardSurface");
		Material matCustom = new Material(shader);
		Debug.Log("matCustom " + matCustom.GetInstanceID());

		// Assets data base
		string[] paths = new string[]{"Assets/Res&Bundle/Resources"};
		string[] guids = UnityEditor.AssetDatabase.FindAssets("Cube", paths);
		foreach(string guid in guids)
		{
			string path = UnityEditor.AssetDatabase.GUIDToAssetPath(guid);
			Debug.Log("path " + path);
			Object cube = UnityEditor.AssetDatabase.LoadAssetAtPath<Object>(path);

			Debug.Log("assets " + cube.GetInstanceID());
		}
	}

	void TestBundleManifest()
	{
		AssetBundle bundleManifest = AssetBundle.LoadFromFile("/Users/zhangyi/code/unity/UnityTechTest/Assets/Res&Bundle/ABs/ABs");
		string[] names = bundleManifest.GetAllAssetNames();

		foreach(string name in names)
		{
			Debug.Log("asset in bundle name: " + name);
		}

		AssetBundleManifest manifest = bundleManifest.LoadAsset<AssetBundleManifest>("assetbundlemanifest");

		string[] bundleNames = manifest.GetAllAssetBundles();

		foreach(var name in bundleNames)
		{
			Debug.Log("name  " + name);

			string[] dependencies = manifest.GetAllDependencies(name);

			foreach(var dependeceName in dependencies)
			{
				Debug.Log("dependence " + dependeceName);
			}
		}
	}

	void TestLoadBundleNotInterity()
	{
		AssetBundle cube = AssetBundle.LoadFromFile("/Users/zhangyi/code/unity/UnityTechTest/Assets/Res&Bundle/ABs/prefab/cube");
		AssetBundle sphere = AssetBundle.LoadFromFile("/Users/zhangyi/code/unity/UnityTechTest/Assets/Res&Bundle/ABs/prefab/sphere");
		AssetBundle shader = AssetBundle.LoadFromFile("/Users/zhangyi/code/unity/UnityTechTest/Assets/Res&Bundle/ABs/shader/shader");


		string[] names = cube.GetAllAssetNames();

		string[] scenePaths = cube.GetAllScenePaths();

		foreach(string name in names)
		{
			Debug.Log("asset in bundle cube: " + name);
		}

		foreach(string scenePath in scenePaths)
		{
			Debug.Log("scene path: " + scenePath);
		}

		GameObject cubeObj = cube.LoadAsset<GameObject>("cube");

		GameObject cubeInstance = GameObject.Instantiate(cubeObj);
	}

	void TestLoadAssetsFromBundleNameAndAssetsName()
	{
		string[] names = UnityEditor.AssetDatabase.GetAllAssetBundleNames();
		foreach(string name in names)
		{
			Debug.Log("bundle name " + name);
		}

		string[] paths = UnityEditor.AssetDatabase.GetAssetPathsFromAssetBundleAndAssetName("prefab/cube", "cube");

		foreach(string path in paths)
		{
			Debug.Log("cube path " + path);
		}

		GameObject cubeObj = UnityEditor.AssetDatabase.LoadAssetAtPath<GameObject>(paths[0]);

		GameObject cubeInstance = GameObject.Instantiate(cubeObj);
	}
	// Update is called once per frame
	void Update () {
	
	}
}
