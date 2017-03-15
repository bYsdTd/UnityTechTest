Shader "Custom/CircleCutOff" {
	Properties
    {
        _MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
        _CenterU("CenterU", Float) = 0.5
        _CenterV("CenterV", Float) = 0.5
        _RadiusTransPercent("Gradual change in circle outer edge", Float) = 0.5
        _RadiusPercent("RadiusPercent", Float) = 0.1
        _RadiusScaleUToV("RadiusScale U To V", Float) = 1
    }
    
    SubShader
    {
        LOD 200

        Tags
        {
            "Queue" = "Transparent"
            "IgnoreProjector" = "True"
            "RenderType" = "Transparent"
        }
        
        Pass
        {
            Cull Off
            Lighting Off
            ZWrite Off
            ZTest Off
            Fog { Mode Off }
            Offset -1, -1
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag            
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _CenterU;
            float _CenterV;
            float _RadiusPercent;
            float _RadiusScaleUToV;
            float _RadiusTransPercent;
    
            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                fixed4 color : COLOR;
            };
    
            struct v2f
            {
                float4 vertex : SV_POSITION;
                half2 texcoord : TEXCOORD0;
                fixed4 color : COLOR;
            };
    
            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.color = v.color;
                return o;
            }
                
            fixed4 frag (v2f IN) : COLOR
            {
            	float offSetU = (IN.texcoord.x - _CenterU) * _RadiusScaleUToV;
            	float offSetV = IN.texcoord.y - _CenterV;
            	fixed4 col = tex2D(_MainTex, IN.texcoord);
            	col *= IN.color;
            	float dis = sqrt(offSetU * offSetU + offSetV * offSetV);
            	if	(dis < _RadiusPercent)
            	{
            		float alpha = 0;
            		if(dis > _RadiusPercent * _RadiusTransPercent)
	            	{
	            		alpha = (dis / _RadiusPercent - _RadiusTransPercent) * (1 / (1 - _RadiusTransPercent));
	            	}
	            	col.a *= alpha;
	            	
	               	// the following will cause bug 1092.  The center is black, so can not see the back;
//	            	if(dis > _RadiusPercent * _RadiusTransPercent)
//	            	{
//	            		col.a *= (dis / _RadiusPercent - _RadiusTransPercent) * (1 / (1 - _RadiusTransPercent));
//	            	}
//	            	else
//	            	{
//	            		col.a = 0;
//					}
            	}
            	
                return col;
            }
            ENDCG
        }
    }

    SubShader
    {
        LOD 100

        Tags
        {
            "Queue" = "Transparent"
            "IgnoreProjector" = "True"
            "RenderType" = "Transparent"
        }
        
        Pass
        {
            Cull Off
            Lighting Off
            ZWrite Off
            Fog { Mode Off }
            Offset -1, -1
            ColorMask RGB
            Blend SrcAlpha OneMinusSrcAlpha
            ColorMaterial AmbientAndDiffuse
            
            SetTexture [_MainTex]
            {
                Combine Texture * Primary
            }
        }
    }
}
