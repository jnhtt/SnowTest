using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour
{
    [SerializeField]
    private CustomRenderTexture texture;
    [SerializeField]
    private Transform target;
    [SerializeField]
    private Material material;

    private Vector2 p;
    private Vector3 center;

#if true
    void Start()
    {
        center = new Vector3(5f, 0f, 5f);
        texture.initializationColor = Color.clear;
        texture.Initialize();
        texture.ClearUpdateZones();
        p.x = target.position.x * 0.1f * texture.width;
        p.y = target.position.z * 0.1f * texture.height;
        material.SetVector("_WorldPos", p);

        var defaultZone = new CustomRenderTextureUpdateZone();
        defaultZone.needSwap = true;
        defaultZone.passIndex = 0; // 波動方程式のシミュレーションのパス
        defaultZone.rotation = 0f;
        defaultZone.updateZoneCenter = new Vector2(0.5f, 0.5f);
        defaultZone.updateZoneSize = new Vector2(1f, 1f);

        texture.SetUpdateZones(new CustomRenderTextureUpdateZone[] { defaultZone });
    }

    private void FixedUpdate()
    {
        p.x = (target.position.x + center.x) * 0.1f * texture.width;
        p.y = (target.position.z + center.z) * 0.1f * texture.height;
        material.SetVector("_WorldPos", p);
        texture.Update(1);
    }
#endif
}
