#version 150

#moj_import <minecraft:fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 vertexLight;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
	if (color.a < 0.5) {
        discard;
    }
	
    color *= min((vertexColor * vertexLight)/color.a,1.0) * ColorModulator;
	
	// requires inaccurate implementation; causes glowing translucent mip pixels otherwise :(
	
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}