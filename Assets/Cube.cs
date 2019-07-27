using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cube : MonoBehaviour
{
    private const float SPEED = 2f;
    private void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            transform.position += Time.deltaTime * SPEED * Vector3.forward;
        }
        else if (Input.GetKey(KeyCode.S))
        {
            transform.position -= Time.deltaTime * SPEED * Vector3.forward;
        }
        else if (Input.GetKey(KeyCode.A))
        {
            transform.position -= Time.deltaTime * SPEED * Vector3.right;
        }
        else if (Input.GetKey(KeyCode.D))
        {
            transform.position += Time.deltaTime * SPEED * Vector3.right;
        }
    }
}
