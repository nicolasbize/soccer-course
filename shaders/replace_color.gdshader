shader_type canvas_item;

group_uniforms Palettes;
uniform sampler2D skin_palette;
uniform sampler2D team_palette;
group_uniforms;

uniform int skin_color : hint_enum("Light", "Medium", "Dark");
uniform int team_color;

vec2 px_to_uv(ivec2 pos, ivec2 tex_size) {
	return vec2(
		(float(pos[0]) + 0.5) / float(tex_size[0]),
		(float(pos[1]) + 0.5) / float(tex_size[1])
	);
}

vec4 get_palette_color(vec4 color, sampler2D palette, int selection) {
	ivec2 tex_size = textureSize(palette, 0);
	for (int i=0; i<tex_size[0]; i++) {
		vec2 uv_color_ref = px_to_uv(ivec2(i, 0), tex_size);
		vec4 color_ref = texture(palette, uv_color_ref);
		if (color == color_ref) {
			vec2 uv_color_dest = px_to_uv(ivec2(i, selection), tex_size);
			return texture(palette, uv_color_dest);
		}
	}

	return color;
}

void fragment() {
	COLOR = get_palette_color(COLOR, team_palette, team_color);
	if (skin_color > 0) {
		COLOR = get_palette_color(COLOR, skin_palette, skin_color);
	}
}
