Shader "Custom/inking" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_Factor("Factor", range(0,1)) = 0.5
		_OutlineWidth("OutlineWidth", range(0,1)) = 1
	}


	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200


		Pass
		{
			Cull Front
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag 

			#include "UnityCG.cginc"

			struct v2f
			{
				float3 diffuse : TEXCOORD0;
				float4 pos	: SV_POSITION;
			};

			float4 _Color;
			float _Factor;
			float _OutlineWidth;

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

				float3 dir = normalize ( v.vertex.xyz );
				float3 dir2 = v.normal;
				
				dir = lerp ( dir, dir2, _Factor );
				dir = mul ( ( float3x3 ) UNITY_MATRIX_IT_MV, dir );
				float2 offset = TransformViewToProjection ( dir.xy );
				offset = normalize ( offset );
				float dist = distance ( mul ( _Object2World, v.vertex ), _WorldSpaceCameraPos );
				o.pos.xy += offset * o.pos.z * _OutlineWidth / dist;

				return o;
			}

			float4 frag( v2f i ) : SV_Target
			{
				float4 col = float4(0.0, 0.0, 0.0, 1.0);
				return col;
			}

			ENDCG
		}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag 

			#include "UnityCG.cginc"

			struct v2f
			{
				float3 diffuse : TEXCOORD0;
				float4 pos	: SV_POSITION;
			};

			float4 _Color;


			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

				float3 viewDir = normalize(ObjSpaceViewDir(v.vertex));
				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
				float3 worldNormal = mul(_Object2World, v.normal);
				o.diffuse = dot(worldNormal, lightDir);

				return o;	
			}

			float4 frag( v2f i ) : SV_Target
			{
				float4 col = _Color * float4(i.diffuse, 1.0);
				return col;
			}

			ENDCG
		}
	}
}
