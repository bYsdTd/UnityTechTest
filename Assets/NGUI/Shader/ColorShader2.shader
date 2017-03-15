Shader "Custom/ColorShader2" {
	Properties
	{
		
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
// Upgrade NOTE: excluded shader from DX11 and Xbox360; has structs without semantics (struct v2f members color)
#pragma exclude_renderers d3d11 xbox360
				#pragma vertex vert
				#pragma fragment frag
				
				#include "UnityCG.cginc"
	
				struct appdata_t
				{
					float4 vertex : POSITION;
					float4 color : COLOR;
				};
	
				struct v2f
				{
					float4 vertex : SV_POSITION;
					float4 color : COLOR;
				};
				
				v2f vert (appdata_t v)
				{
					v2f o;
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.color = v.color;
					return o;
				}
				
				fixed4 frag (v2f i) : COLOR
				{
					return i.color;
					//return fixed4(1, 1, 0, 1)
				}
			ENDCG
		}
	}
}

