shader_type spatial;
//render_mode cull_disabled;
//uniform vec3 color: source_color;
uniform vec3 color = vec3(0, 0.286, 0);
//uniform vec3 color2: source_color;
uniform vec3 color2 = vec3(0, 0.179, 0);

uniform sampler2D noise;
uniform sampler2D nosie2;
uniform float noiseScale = 20.0;

varying vec3 worldPos;
void vertex() {
	// Called for every vertex the material is visible on.

	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;

}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 noiseLevel = texture(noise, worldPos.xz / noiseScale).rgb;
	vec3 noiseLevel2 = texture(nosie2, worldPos.xy / noiseScale).rgb;
	 // Add randomness to color mixing
    float randomMixFactor = fract(noiseLevel.r * 10.0 + noiseLevel2.g * 5.0); // Generate a random mix factor

    // Mix the colors with randomness
    vec3 mixedColor = mix(color, color2, randomMixFactor);

    // Apply the base color with noise
    ALBEDO = mixedColor;
	//ALBEDO =  mix(color, color2, noiseLevel.r - noiseLevel2.r);
	if (! FRONT_FACING){
		NORMAL = -NORMAL;
	}
	SPECULAR = 1.0;

}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
