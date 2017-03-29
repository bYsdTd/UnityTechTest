Shader "Unlit/transparentMesh"
{
	Properties
	{
		_xrayColor("xraycolor", Color) = (0.5,0.5,0.5,1)
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Blend Off
			ZWrite On
			ZTest Less

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float3 diffuse : TEXCOORD1;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata_base v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				float3 viewDir = normalize(ObjSpaceViewDir(v.vertex));
				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
				float3 worldNormal = mul(_Object2World, v.normal);
				o.diffuse = dot(worldNormal, lightDir);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{	
				float4 col = float4(i.diffuse, 1.0);
				return col;
			}
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcColor
			ZWrite off
			ZTest Greater


			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct v2f
			{
				float4 pos	: SV_POSITION;
				float2 cap	: TEXCOORD0;
			};

			uniform sampler2D _MatCap;
			float4 _xrayColor;

			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
				
				float3 worldNorm = normalize(_World2Object[0].xyz * v.normal.x + _World2Object[1].xyz * v.normal.y + _World2Object[2].xyz * v.normal.z);
				worldNorm = mul((float3x3)UNITY_MATRIX_V, worldNorm);
				o.cap.xy = worldNorm.xy * 0.5 + 0.5;
				
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float4 mc = tex2D(_MatCap, i.cap);
				
				return _xrayColor * mc * 2.0;
			}
			ENDCG
		}
	}
}
