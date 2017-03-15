Shader "Custom/actorDiffuse" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Bump ("Bump", 2D) = "bump" {} 
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf BasicDiffuse

		#pragma target 2.0

		sampler2D _MainTex;
		sampler2D _Bump;
		
		struct Input {
			float2 uv_MainTex;
			float2 uv_Bump;
			float3 viewDir;
		};
      
		inline float4 LightingBasicDiffuse(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			float difLight = max(0, dot(s.Normal, lightDir));
			float4 col;
			
			col.rgb = s.Albedo * _LightColor0.rgb * difLight * 2 * atten;
	        col.a = s.Alpha;
	        return col;
		}
		
		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			
			fixed3 norm = UnpackNormal(tex2D(_Bump, IN.uv_Bump)).rgb;
			o.Normal = normalize(norm); 
			
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
