#version 150

#moj_import <minecraft:fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 vertexShading;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
	if (color.a < 0.1) {
        discard;
    }
	
	float alpha = (color.a - 0.1) / 0.9;
	
	color *= min(vertexShading / alpha,1);
	color *= vertexColor * ColorModulator;
	
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color.rgb *= lightMapColor.rgb * alpha + (-alpha + 1);
	
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
