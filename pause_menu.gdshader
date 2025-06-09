shader_type canvas_item;
uniform sampler2D scree_texture: hint_screen_texture, filter_linear_mipmap;

uniform float lod: hint_range(0.0, 5) = 0.0;

void fragment(){
	vec4 color = texture(scree_texture, SCREEN_UV, lod);
	COLOR = color;
}