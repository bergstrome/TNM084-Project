shader_type spatial;

uniform sampler2D noise_texture; // Noise texture (e.g., OpenSimplex or Perlin)
uniform vec3 base_color = vec3(0.1, 0.1, 0.1); // Base gravel color
uniform vec3 highlight_color = vec3(0.7, 0.7, 0.7); // Highlight for stones
uniform vec3 dark_color = vec3(0.3, 0.2, 0.2); // Darker stones for variation
uniform float scale : hint_range(0.1, 10.0) = 3.0; // Overall scale of the pattern
uniform float stone_size : hint_range(0.1, 2.0) = 0.5; // Average size of stones
uniform float roughness : hint_range(0.0, 1.0) = 0.8; // Surface roughness
uniform float metallic : hint_range(0.0, 1.0) = 0.0; // Metallic property

void fragment() {
    vec2 uv = UV * scale; // Scale UV coordinates for noise pattern

    // Sample noise texture
    float noise_value = texture(noise_texture, uv).r;

    // Approximate Voronoi pattern for stones
    vec2 cell = floor(uv / stone_size);
    vec2 cell_offset = fract(uv / stone_size);
    float dist = length(cell_offset - vec2(0.5)); // Distance from the cell center
    float stone_mask = smoothstep(0.3, 0.5, 1.0 - dist); // Stones as circles

    // Randomize stone color using noise
    float random_color = texture(noise_texture, cell * 0.5).r;
    vec3 gravel_color = mix(base_color, highlight_color, random_color);
    gravel_color = mix(gravel_color, dark_color, stone_mask * random_color);

    // Add surface roughness with fine noise
    float fine_detail = texture(noise_texture, uv * 2.0).r * 0.1;
    gravel_color += fine_detail;

    // Set material properties
    ALBEDO = gravel_color;
    ROUGHNESS = roughness;
    METALLIC = metallic;
}
