Shader "Custom/diffuse" {
		Properties 
		{
           _MainTex ("Base (RGB)", 2D) = "white" {}
           _SecondTex ("Base (RGB)", 2D) = "white" {}
           _EmColor ("Emissive Color", Color) = (1,1,1,1)
        }
		SubShader 
		{
           Tags { "RenderType"="Opaque" }
           LOD 200
           CGPROGRAM
           #pragma surface surf BasicDiffuse alpha
           sampler2D _MainTex;
           sampler2D _SecondTex;
           
           float4	 _EmColor;
           
           struct Input
           {
             float2 uv_MainTex;
           };
          	
           void surf (Input IN, inout SurfaceOutput o)
           {
             half4 c = tex2D (_MainTex, IN.uv_MainTex);
             half4 mask = tex2D(_SecondTex, IN.uv_MainTex);
             
             o.Albedo = c.rgb * _EmColor * mask.a;
             o.Alpha = c.a * mask.a;
		   }
		   
		   	inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten)
			{
		         float difLight = max(0, dot (s.Normal, lightDir));
		         float4 col;
		         //col.rgb = s.Albedo * _LightColor0.rgb * (difLight * atten * 2);
		         col.rgb = float3(difLight,difLight,difLight);
		         //col.a = s.Alpha;
		         col.a = difLight;
		         
		         return col;
			}
			
		   ENDCG 
		}
        FallBack "Diffuse"
}
