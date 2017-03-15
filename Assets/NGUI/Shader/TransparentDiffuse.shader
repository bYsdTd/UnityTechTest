﻿Shader "Custom/TransparentDiffuse" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	
    SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	    LOD 200
	
	    // extra pass that renders to depth buffer only
	    Pass {
	        ZWrite On
	        ColorMask 0
	    }
	
	    // paste in forward rendering passes from Transparent/Diffuse
	    UsePass "Transparent/Diffuse/FORWARD"
	}
}
