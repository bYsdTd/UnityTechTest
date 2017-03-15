﻿Shader "Custom/ColorShader" {
	Properties
	{
		_Color ("Color", Color) = (1, 1, 1, 1)
	}
	
	SubShader
	{
		LOD 100

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		
		Cull Off
		Lighting Off
		ZWrite Off
		Fog { Mode Off }
		Offset -1, -1
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				
				#include "UnityCG.cginc"
	
				float4 _Color;
				
				struct appdata_t
				{
					float4 vertex : POSITION;
				};
	
				struct v2f
				{
					float4 vertex : SV_POSITION;
				};
				
				v2f vert (appdata_t v)
				{
					v2f o;
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					return o;
				}
				
				fixed4 frag (v2f i) : COLOR
				{
					return _Color;
				}
			ENDCG
		}
	}
}

