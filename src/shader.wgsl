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

fn srgb(r: f32, g: f32, b: f32, a: f32) -> vec4<f32> {
    return vec4<f32>(
        pow(((r + 0.055) / 1.055), 2.4),
        pow(((g + 0.055) / 1.055), 2.4),
        pow(((b + 0.055) / 1.055), 2.4),
        pow(((a + 0.055) / 1.055), 2.4),
    );
}

struct Uniforms {
    height: f32, // The screen height (px)
    width: f32, // The screen width (px)
    time: f32,
    speed: f32,
}

@group(0) @binding(0)
var<uniform> uniforms: Uniforms;

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let aspect_ratio = uniforms.height / uniforms.width;
    var uv: vec2<f32> = in.frag_position.xy;
    uv.x *= aspect_ratio;

    var col = vec3<f32>();

    var d = length(uv);
    d = sin(d*8. + uniforms.time) / 8.;
    d = abs(d);
    d = .02 / d;
    
    return srgb(d, d, d, 1.0);
}
