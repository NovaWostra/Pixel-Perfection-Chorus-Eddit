#version 150

#moj_import <minecraft:fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 overlayColor;
in vec4 lightMapColor;
in vec4 vertexShading;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    if (color.a < 0.01) {
        discard;
    }
	
	color *= vertexColor * ColorModulator;
		
	if (!(color.a > 0.98 && color.a < 0.99)) {
		color *= vertexShading;
	}
	
#ifndef NO_OVERLAY
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
#endif
	
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
