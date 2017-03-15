Shader "Custom/noiseTex2" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NoiseTex ("Texture", 2D) = "white" {}
		_ScrollXSpeed("X SPEED", Range(0, 1)) = 1
		_ScrollYSpeed("Y SPEED", Range(0, 1)) = 1
		_OffsetScale("offset scale", Range(0, 1)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NoiseTex;
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;
		fixed _OffsetScale;
		
		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			
//			float2 scrolledUV = IN.uv_MainTex;
//			float4 noiseuv = tex2D(_NoiseTex, scrolledUV);
//			float offsetu = (noiseuv.x * 2.0 - 1.0) * _OffsetScale;
//			float offsetv = (noiseuv.y * 2.0 - 1.0) * _OffsetScale;
//			scrolledUV += float2(offsetu, offsetv);
				
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
