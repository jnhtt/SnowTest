Shader "Custom/Displace"
{
    Properties
    {
        _MainTex ("Main Tex", 2D) = "white" {}
        _MinColor ("Min Color", Color) = (0.4, 0.4, 0.4, 1)
        _MaxColor ("Max Color", Color) = (1, 1, 1, 1)
        _MinHeight ("Min Height", Float) = -0.1
        _MaxHeight ("Max Height", Float) = 2
        _VTF2Dlod ("VTF", 2D) = "gray" {}
        _EdgeLength ("Edge length", Range(3, 40)) = 10
        _Parallax ("Height", Range(0.0, 1.0)) = 0.5
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        CGPROGRAM
        #pragma target 5.0
        #pragma surface surf BlinnPhong addshadow vertex:disp tessellate:tessEdge
        #include "Tessellation.cginc"

        struct appdata
        {
            float4 vertex : POSITION;
            float4 tangent : TANGENT;
            float3 normal : NORMAL;
            float2 texcoord : TEXCOORD0;
            float2 texcoord1 : TEXCOORD1;
            float2 texcoord2 : TEXCOORD2;
        };

        float _EdgeLength;
        float _Parallax;
        sampler2D _MainTex;
        sampler2D _VTF2Dlod;
        float4 _MinColor;
        float4 _MaxColor;
        float _MinHeight;
        float _MaxHeight;

        float4 tessEdge(appdata v0, appdata v1, appdata v2)
        {
            return UnityEdgeLengthBasedTessCull(v0.vertex, v1.vertex, v2.vertex, _EdgeLength, _Parallax * 1.5f);
        }

        void disp(inout appdata v)
        {
            float2 uv = 1 - v.texcoord.xy;
            float d = tex2Dlod(_VTF2Dlod, float4(uv, 0, 0)).r;
            v.vertex.xyz += v.normal * (1 - d) * _Parallax;
        }

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            float3 c = tex2D(_MainTex, IN.uv_MainTex).rgb;
            float h = (_MaxHeight - IN.worldPos.y) / (_MaxHeight - _MinHeight);
            o.Albedo = c * ((1 - h) * _MaxColor + h * _MinColor);
        }
        
        ENDCG
    }
}