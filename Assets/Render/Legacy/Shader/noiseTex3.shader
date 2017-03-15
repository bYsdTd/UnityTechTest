Shader "Custom/noiseTex3" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NoiseTex ("Texture", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
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
		
		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		fixed _OffsetScale;
		
		void surf (Input IN, inout SurfaceOutputStandard o) {
		
			float2 scrolledUV = IN.uv_MainTex;
			float4 noiseuv = tex2D(_NoiseTex, scrolledUV + float2(0.1 * _Time.y, 0.1 * _Time.y));
			float offsetu = (noiseuv.x * 2.0 - 1.0) * _OffsetScale;
			float offsetv = (noiseuv.y * 2.0 - 1.0) * _OffsetScale;
			scrolledUV += float2(offsetu, offsetv);
			
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, scrolledUV) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
