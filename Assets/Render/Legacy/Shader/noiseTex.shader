Shader "Unlit/noiseTex"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_NoiseTex ("Texture", 2D) = "white" {}
		_ScrollXSpeed("X SPEED", Range(0, 1)) = 1
		_ScrollYSpeed("Y SPEED", Range(0, 1)) = 1
		_OffsetScale("offset scale", Range(0, 1)) = 1
		
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
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			fixed _ScrollXSpeed;
			fixed _ScrollYSpeed;
			fixed _OffsetScale;
			
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float2 scrolledUV = i.uv;
				
				float xScrollValue = _Time.y * _ScrollXSpeed;
				float yScrollValue = _Time.y * _ScrollYSpeed;
				
				//scrolledUV += fixed2(xScrollValue, yScrollValue);
				// sample the texture				
				float4 noiseuv = tex2D(_NoiseTex, scrolledUV);
				float offsetu = (noiseuv.x * 2.0 - 1.0) * _OffsetScale * _SinTime.w;
				float offsetv = (noiseuv.y * 2.0 - 1.0) * _OffsetScale * _SinTime.w;
				scrolledUV += float2(offsetu, offsetv);
				float4 col = tex2D(_MainTex, scrolledUV);
				col = float4(_SinTime.w,0,0,1);
				// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, _Time);				
				return col;
			}
			ENDCG
		}
	}
}
