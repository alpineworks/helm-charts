This is a direct copy of https://github.com/amithkk/stable-diffusion-k8s, with the compatibility tweaks to fix the initcontainer by @timothyclarke

## GPU Support

To enable GPU support, set the `runtimeClassName` to your GPU runtime class:

```yaml
runtimeClassName: "nvidia"
```

The chart already includes a nodeSelector for GPU nodes (`nvidia.com/gpu.present: "true"`).