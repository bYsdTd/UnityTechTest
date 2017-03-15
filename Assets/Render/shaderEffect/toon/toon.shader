Shader "Unlit/toon"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_GradientTex ("Gradient", 2D) = "white" {}

		_blue ("blue", Range(0.0, 1.0)) = 1.0
		_yellow ("yellow", Range(0.0, 1.0)) = 1.0
		_a ("a", Range(0.0, 10.0)) = 1.0
		_b ("b", Range(0.0, 10.0)) = 1.0
		_kd ("kd", Range(0.0, 1.0)) = 1.0

		_Ambient("ambnient color", Color) = (1.0, 1.0, 1.0, 1.0)
		_Diffuse("diffuse color", Color) = (1.0, 1.0, 1.0, 1.0)
		_Specular("specular color", Color) = (1.0, 1.0, 1.0, 1.0)
		_Rim("rim color", Color) = (0.0, 0.0, 0.0, 1.0)

		_DiffuseThreshold("diffuse threshold", Range(0.0, 1.0)) = 1.0
		_SpecularThreshold("specular threshold", Range(0.0, 1.0)) = 1.0

		_Tooniness ("Tooniness", Range(0.1,20)) = 4 

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			
			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
				float3 lightDir: TEXCOORD1;
				float3 viewDir: TEXCOORD2;
				float3 halfVector: TEXCOORD3;
			};

			sampler2D _MainTex;
			sampler2D _GradientTex;

			float4 _MainTex_ST;
			float _blue;
			float _yellow;
			float _a;
			float _b;
			float _kd;

			float4 _Ambient;
			float4 _Diffuse;
			float4 _Specular;
			float4 _Rim;

			float _DiffuseThreshold;
			float _SpecularThreshold;
			float _Tooniness;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.lightDir = WorldSpaceLightDir(v.vertex);
				
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.viewDir = WorldSpaceViewDir(v.vertex);
				o.uv = v.uv;

				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				float4 kd = tex2D(_MainTex, i.uv);
//				
//				float4 kcool = float4(0.0, 0.0, _blue, 1.0) + float4(_kd, _kd, _kd, 1.0) * _a * kd;
//				float4 kwarm = float4(_yellow, _yellow, 0.0, 1.0) + float4(_kd, _kd, _kd, 1.0) * _b * kd;
//				
//				float ndotl = dot(-i.lightDir, i.normal);
//				float weight = (ndotl + 1) * 0.5;
//				
//				float4 final = //max(0, ndotl) * float4(_kd, _kd, _kd, 1.0); 
//				weight * kwarm + (1 - weight) * kcool;
//				
//				return final;

				float NdotL = dot(i.normal, normalize(-i.lightDir));
				float H = normalize(normalize(-i.lightDir) + normalize(i.viewDir)); 
				float NdotH = dot(i.normal, H);

				float NdotV = dot(i.normal, normalize(i.viewDir));

				//kd = float4(1.0, 1.0, 1.0, 1.0);

				//kd = floor(_Tooniness * kd) / _Tooniness;

				float4 final = _Diffuse * kd;

				if(NdotL < _DiffuseThreshold )
				{
					final = _Ambient * kd;
				}

				if(NdotH > _SpecularThreshold)
				{
					final = kd * 1.5;
				}

				float2 uv = float2(NdotV, 0.5);
				float4 rim = tex2D(_GradientTex, uv);
				//float4 rim = float4(NdotH, NdotH, NdotH, 1.0);
				final = final * rim;

				return final;
			}
			ENDCG
		}
	}
}
