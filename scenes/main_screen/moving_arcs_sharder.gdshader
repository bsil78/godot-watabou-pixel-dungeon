shader_type canvas_item;
instance uniform float speed: hint_range(1.0,100.0,1.0) = 1.0;
instance uniform float scale: hint_range(0.1,10.0,0.1) = 1.0;
instance uniform float x_offset: hint_range(-100.0,100.0,1.0) = 0.0;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	vec4 color=texture(TEXTURE,vec2((UV.x+(x_offset/100.0))/scale,(UV.y/scale)+speed*(TIME/40.0)));
    COLOR=color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
