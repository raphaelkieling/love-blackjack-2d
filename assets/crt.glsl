extern vec2 screenSize;
extern Image iChannel0;

vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 fragCoord) {
    float warp = 0.4;
    float scan = 0.75;

    vec2 uv = texCoord;
    vec2 dc = abs(0.5 - uv);
    dc *= dc;

    // Warp nos coords
    uv.x -= 0.5; uv.x *= 1.0 + (dc.y * (0.3 * warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0 + (dc.x * (0.4 * warp)); uv.y += 0.5;

    // Fora da tela → preto
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    // Scanlines
    float apply = abs(sin(fragCoord.y) * 0.5 * scan);
    vec3 col = mix(Texel(iChannel0, uv).rgb, vec3(0.1), apply);
    return vec4(col, 1.0) * color;
}
