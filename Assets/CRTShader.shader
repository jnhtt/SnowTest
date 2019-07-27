Shader "Custom/CRTShader"
{
    Properties
    {
        _EffectiveDist ("Effective Distance", Range(0, 64)) = 32
        _X ("X", Range(0, 1024)) = 512
        _Y ("Y", Range(0, 1024)) = 512
    }
    SubShader
    {
        Cull Off
        ZWrite Off
        ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex CustomRenderTextureVertexShader
            #pragma fragment frag
            #include "UnityCustomRenderTexture.cginc"

            float2 _WorldPos;
            float _EffectiveDist;
            float _X;
            float _Y;

            float4 frag(v2f_customrendertexture i) : SV_Target
            {
                float2 uv = i.globalTexcoord;
                float du = 1.0 / _CustomRenderTextureWidth;
                float dv = 1.0 / _CustomRenderTextureHeight;

                //float2 pos = float2(_X * du, _Y * dv);
                float2 pos = float2(_WorldPos.x * du, _WorldPos.y * dv);
                float dist = distance(pos, uv);
                float scale = 0;
                float ed = _EffectiveDist * du;
                if (dist < ed)
                {
                    scale = 1 - dist / ed;
                } 
                float2 c = tex2D(_SelfTexture2D, uv);
                float p = scale + c.g;
                return float4(clamp(p, 0, 1), c.r, 0, 0);
            }
            ENDCG
        }
    }
}
