Shader "Custom/actorDiffuseMask" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalMap ("Normalmap", 2D) = "bump" {}
		_MaskMap ("Maskmap", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf BasicDiffuse

		#pragma target 2.0

		sampler2D _MainTex;
		sampler2D _NormalMap;
		sampler2D _MaskMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalTex;
			float2 uv_MaskTex;
			float3 viewDir;
		};
      
		inline float4 LightingBasicDiffuse(SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			half3 h = normalize (lightDir + viewDir);
			float nh = max (0, dot (s.Normal, h));

			float difLight = max(0, dot(s.Normal, lightDir));
			float4 col;
			
			float spec = pow(nh, s.Specular);

			col.rgb = (s.Albedo * _LightColor0.rgb * difLight + _LightColor0.rgb * s.Gloss * spec );
	        col.a = s.Alpha;
	        return col;
		}
		
		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
			o.Normal = tex2D (_NormalMap, IN.uv_NormalTex);
			fixed4 mask = tex2D (_MaskMap, IN.uv_MaskTex);
			o.Specular = mask.a;
			o.Gloss = mask.r;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
