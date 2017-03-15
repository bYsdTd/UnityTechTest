Shader "Custom/OpaqueReplacableColored" {
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_ReplaceColor("Replace color", Color) = (1, 1, 1, 1)
	}
	
	SubShader
	{
		LOD 200

		Tags { "RenderType"="Opaque"
				"Queue" = "Transparent"
			 }
		
		Pass
		{
			Cull Back
			Lighting Off
			ZWrite On
			Fog { Mode Off }
			Offset -1, -1
			Blend Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _ReplaceColor;
		
			struct appdata_t
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};
	
			struct v2f
			{
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};
	
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.color = v.color;
				return o;
			}
				
			fixed4 frag (v2f IN) : COLOR
			{
				fixed4 col = tex2D(_MainTex, IN.texcoord);
				col.rgb = col.rgb + (1 - col.a) * (_ReplaceColor - float3(1, 1, 1)) * col.rgb;
				return col;
			}
			ENDCG
		}
	}
}
