Shader "Hidden/MultiplyDouble"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BlendTex ("Blend", 2D) = "" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _BlendTex;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 dst = tex2D(_MainTex, i.uv);
				fixed4 blendTex = tex2D(_BlendTex, i.uv);

				blendTex.rgb = blendTex.rgb * 2;

				// blend
				fixed4 src = lerp(fixed4(0.5f,0.5f,0.5f,0.5f), blendTex, blendTex.a);

				// 这里相当于Blend   DstColor  SrcColor
				// 即DstColor * SrcColor + SrcColor * DstColor
				fixed4 final = 2.0 * src * dst;
				return final;
			}
			ENDCG
		}
	}
}
