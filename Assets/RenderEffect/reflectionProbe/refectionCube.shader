Shader "Unlit/refectionCube"
{
	Properties
	{
		_texCube("cube tex", CUBE) = ""{}
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
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float3 ref : TEXCOORD1;
				//UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			//samplerCUBE unity_SpecCube0;
			//samplerCUBE unity_SpecCube1;

			//samplerCUBE _texCube;
			TextureCube _texCube; 
			SamplerState sampler_texCube;

			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//UNITY_TRANSFER_FOG(o,o.vertex);

				float3 worldNormal = mul((float3x3)_Object2World, v.normal);
				float3 worldPos = mul(_Object2World, v.vertex).xyz;
				float3 viewDir = normalize(_WorldSpaceCameraPos - worldPos);

				o.ref = normalize(viewDir + worldNormal);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				
				//fixed4 col = UNITY_SAMPLE_TEXCUBE(unity_SpecCube1, i.ref);
				fixed4 col = unity_SpecCube1.Sample(samplerunity_SpecCube1, i.ref);
				//col.xyz = i.ref.xyz;

				col = _texCube.Sample(sampler_texCube, i.ref);

				//#if defined(SHADER_API_GLCORE)
				//	return fixed4(1.0, 0.0, 0.0, 1.0);
				//#else
					return col;
				//#endif
			}
			ENDCG
		}
	}
}
