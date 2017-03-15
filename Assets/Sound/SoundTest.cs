using UnityEngine;
using System.Collections;

public class SoundTest : MonoBehaviour {

	public AudioSource audioSource;

	// Use this for initialization
	void Start () {

		audioSource.clip = Resources.Load<AudioClip>("bgm_battle");
		audioSource.Play();
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
