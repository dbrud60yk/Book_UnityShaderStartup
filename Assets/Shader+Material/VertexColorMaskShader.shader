Shader "Custom/VertexColorMask"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo2 (RGB)", 2D) = "white" {}
        _MainTex3("Albedo3 (RGB)", 2D) = "white" {}
        _MainTex4("Albedo4 (RGB)", 2D) = "white" {}
        _BumpMap("Normalmap", 2D) = "bump" {}
        _Metallic("Metallic", Range(0, 1)) = 0.0
        _Smoothness("Smoothness", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard noambient
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;
        sampler2D _MainTex3;
        sampler2D _MainTex4;
        sampler2D _BumpMap;
        float _Metallic;
        float _Smoothness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
            float2 uv_MainTex3;
            float2 uv_MainTex4;
            float2 uv_BumpMap;
            float4 color:COLOR;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D(_MainTex2, IN.uv_MainTex2);
            fixed4 e = tex2D(_MainTex3, IN.uv_MainTex3);
            fixed4 f = tex2D(_MainTex4, IN.uv_MainTex4);
            
            //방법1
            float3 lerpCalc = lerp(c.rgb, d.rgb, IN.color.r);
            lerpCalc = lerp(lerpCalc, e.rgb, IN.color.g);
            lerpCalc = lerp(lerpCalc, f.rgb, IN.color.b);
            //o.Emission = lerpCalc;
            o.Albedo = lerpCalc;

            //방법2
            //o.Emission = 
            //    d.rgb * IN.color.r + 
            //    e.rgb * IN.color.g + 
            //    f.rgb * IN.color.b + 
            //    c.rgb * (1 - (IN.color.r + IN.color.g + IN.color.b));

            //직접 해결한 방법
            //float3 lerp0 = lerp(c.rgb, 0, IN.color.r + IN.color.g + IN.color.b);
            //float3 lerp1 = lerp(0, d.rgb, IN.color.r);
            //float3 lerp2 = lerp(0, e.rgb, IN.color.g);
            //float3 lerp3 = lerp(0, f.rgb, IN.color.b);
            //o.Emission = lerp0 + lerp1 + lerp2 + lerp3;

            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
