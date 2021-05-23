Shader "Custom/LerpShader"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)", 2D) = "white" {}
        _TexLerp("Tex Lerp", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        float _TexLerp;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D(_MainTex2, IN.uv_MainTex2);
           
            o.Albedo = lerp(c.rgb, d.rgb, 1 - c.a);
            //o.Albedo = lerp(d.rgb, c.rgb, c.a);

            //o.Albedo = lerp(c.rgb, d.rgb, _TexLerp);

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
