Shader "Custom/OpFactorDiffuse" {
	Properties {
		_Factor ("Factor", Range(0, 1)) = 0
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque"}
		LOD 200
		
		CGPROGRAM
		
		#pragma surface surf FactorLambert
		#pragma target 3.0
		//Blend SrcAlpha OneMinusSrcAlpha

		sampler2D _MainTex;

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
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
}
