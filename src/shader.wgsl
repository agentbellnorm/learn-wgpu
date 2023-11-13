struct VertexInput {
    @location(0) position: vec3<f32>,
}

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) frag_position: vec3<f32>,
}

@vertex
fn vs_main(
    model: VertexInput,
) -> VertexOutput {
    var out: VertexOutput;
    out.clip_position = vec4<f32>(model.position, 1.0);
    out.frag_position = model.position;

    return out;
}

fn srgb(color: vec4<f32>) -> vec4<f32> {
    return vec4<f32>(
        pow(((color.r + 0.055) / 1.055), 2.4),
        pow(((color.g + 0.055) / 1.055), 2.4),
        pow(((color.b + 0.055) / 1.055), 2.4),
        pow(((color.a + 0.055) / 1.055), 2.4),
    );
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    var uv: vec2<f32> = in.frag_position.xy;
    
    return srgb(vec4<f32>(uv, 0.0, 1.0));
}
