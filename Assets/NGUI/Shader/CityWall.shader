Shader "Custom/CityWall" {
	Properties {
		_Factor ("Factor", Range(0, 1)) = 0
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_HurtTex ("Albedo (RGB)", 2D) = "black" {}
		_Threshold ("Threshold", Range(0, 1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		Cull Off
		
		CGPROGRAM
		
		#include "UnityCG.cginc"
		#pragma surface surf FactorLambert

		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _HurtTex;
		float _Threshold;
		
		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		half _Factor;
		
		half4 LightingFactorLambert (SurfaceOutput s, half3 lightDir, half atten) {
		    half NdotL = dot (s.Normal, lightDir);
		    half diff = NdotL * (1.0 - _Factor) + _Factor;
		    half4 c;
		    c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten);
		    c.a = s.Alpha;
		    return c;
	    }
	    
		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 h = tex2D (_HurtTex, IN.uv_MainTex);
//			if (c.a >= _Threshold){
//				o.Albedo = c.rgb;
//			}
//			else{
//				o.Albedo = c.rgb * (1 - h.a) + h.rgb * h.a;
//			}
			fixed rate = h.a * _Threshold;
			o.Albedo = c.rgb * (1 - rate) + h.rgb * rate;
			o.Alpha = 1;
		}
		ENDCG
	} 
}
