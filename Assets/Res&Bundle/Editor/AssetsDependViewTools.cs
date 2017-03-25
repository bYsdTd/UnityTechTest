using UnityEngine;
using UnityEditor;
using System.Collections;

public class AssetsDependViewTools : EditorWindow 
{
	[MenuItem("Assets/Open Asset Depend Viewer", false, 0)]
	static public void OpenAtlasMaker ()
	{
		EditorWindow.GetWindow<AssetsDependViewTools>(false, "Asset Depend Viewer", true).Show();
	}

	[MenuItem("Assets/Build Scene Bundle", false, 0)]
	static public void BuildSceneBundle()
	{
		AssetBundleBuild[] buildmap = new AssetBundleBuild[1];
		buildmap[0].assetBundleName = "scene";
		buildmap[0].assetNames = new string[]{"Assets/Res&Bundle/TestBuildSceneBundle/scn_testBuildSceneBundle.unity"};

		AssetBundleManifest manifest = BuildPipeline.BuildAssetBundles("Assets/Res&Bundle/ABs_Scene", buildmap);	

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

	[MenuItem("Assets/Build Asset Bundle", false, 0)]
	static public void BuildAssetBundle()
	{
		AssetBundleBuild[] buildmap = new AssetBundleBuild[3];
		buildmap[0].assetBundleName = "prefab/cube";
		buildmap[0].assetNames = new string[]{"Assets/Res&Bundle/Resources/Prefab/Cube.prefab", "Assets/Res&Bundle/Resources/mat_Cube.mat"};

		buildmap[1].assetBundleName = "prefab/sphere";
		buildmap[1].assetNames = new string[]{"Assets/Res&Bundle/Resources/Prefab/Sphere.prefab", "Assets/Res&Bundle/Resources/mat_Sphere.mat"};

//		buildmap[1].assetBundleName = "mat/mat1";
//		buildmap[1].assetNames = new string[]{"Assets/Res&Bundle/Resources/mat_Cube.mat"};
//
//		buildmap[2].assetBundleName = "mat/mat2";
//		buildmap[2].assetNames = new string[]{"Assets/Res&Bundle/Resources/mat_Sphere.mat"};

		buildmap[2].assetBundleName = "shader/shader";
		buildmap[2].assetNames = new string[]{"Assets/Res&Bundle/Resources/standardSurface.shader"};

		AssetBundleManifest manifest = BuildPipeline.BuildAssetBundles("Assets/Res&Bundle/ABs", buildmap);	

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

	string myString = "Hello World";
	bool groupEnabled;
	bool myBool = true;
	float myFloat = 1.23f;
	Vector2 scrollPos;
	bool showPosition = true;
	string status;
	bool show = true;

	void OnGUI () {
		GUILayout.Label ("Base Settings", EditorStyles.boldLabel);
		myString = EditorGUILayout.TextField ("Text Field", myString);

		groupEnabled = EditorGUILayout.BeginToggleGroup ("Optional Settings", groupEnabled);
		myBool = EditorGUILayout.Toggle ("Toggle", myBool);
		myFloat = EditorGUILayout.Slider ("Slider", myFloat, -3, 3);
		EditorGUILayout.EndToggleGroup ();


		EditorGUILayout.BeginVertical();
		scrollPos = 
			EditorGUILayout.BeginScrollView(scrollPos, GUILayout.Width (100), GUILayout.Height (100));
		GUILayout.Label(myString);
		EditorGUILayout.EndScrollView();
		if(GUILayout.Button("Add More Text", GUILayout.Width (100), GUILayout.Height (100)))
			myString += " \nAnd this is more text!";


		showPosition = EditorGUILayout.Foldout(showPosition, status);

		if(showPosition)
		{
			GUILayout.BeginHorizontal(); GUILayout.Label("file1", EditorStyles.boldLabel); GUILayout.EndHorizontal();
			GUILayout.Label("file2", EditorStyles.boldLabel);
			GUILayout.Label("file3", EditorStyles.boldLabel);
			GUILayout.Label("file4", EditorStyles.boldLabel);


			show = EditorGUILayout.Foldout(show, "directory");

			if(show)
			{
				GUILayout.Label("file5", EditorStyles.boldLabel);
				GUILayout.Label("file5", EditorStyles.boldLabel);
				GUILayout.Label("file5", EditorStyles.boldLabel);
				GUILayout.Label("file5", EditorStyles.boldLabel);
				GUILayout.Label("file5", EditorStyles.boldLabel);

			}
		}

		EditorGUILayout.EndVertical();

	}

	void OnInspectorUpdate()
	{
		this.Repaint();
	}
}
