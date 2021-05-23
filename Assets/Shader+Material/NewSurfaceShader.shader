Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _Red("Red", Range(0,1)) = 0.5
        _Green("Green", Range(0, 1)) = 0.5
        _Blue("Blue", Range(0, 1)) = 0.5
        _BrightDark("Bright Dark", Range(-1, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        
        struct Input
        {
            float4 color : COLOR;
        };

        float _Red;
        float _Green;
        float _Blue;
        float _BrightDark;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark;// c.rgb;// float3(bbb.b, gg.r, r.r);//test.rgb;//c.rgb;
            //o.Emission = float3(_Red, _Green, _Blue) + _BrightDark; // float3(1, 0, 0) + float3(0, 1, 0);
            o.Alpha = 1;// c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
