shader_type spatial;
render_mode unshaded;

uniform int leaf_count : hint_range(1, 1000); // Number of leaves to generate
uniform float leaf_size : hint_range(0.01, 1.0); // Size of each leaf

void vertex() {
    // Pass vertex data to geometry shader
    VERTEX = vec3(VERTEX);
}

void geometry() {
    for (int i = 0; i < leaf_count; i++) {
        // Generate random position on the surface
        vec3 leaf_pos = VERTEX + vec3(rand(), rand(), rand()) * 0.1;

        // Create a leaf quad
        vec3 offset1 = vec3(-leaf_size, 0, -leaf_size);
        vec3 offset2 = vec3(leaf_size, 0, -leaf_size);
        vec3 offset3 = vec3(-leaf_size, 0, leaf_size);
        vec3 offset4 = vec3(leaf_size, 0, leaf_size);

        // Emit the quad as two triangles
        emit_vertex(leaf_pos + offset1);
        emit_vertex(leaf_pos + offset2);
        emit_vertex(leaf_pos + offset3);

        emit_vertex(leaf_pos + offset3);
        emit_vertex(leaf_pos + offset2);
        emit_vertex(leaf_pos + offset4);

        // Finalize leaf geometry
        end_primitive();
    }
}
