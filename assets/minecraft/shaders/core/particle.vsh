#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;

out float vertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;
out vec4 lightColor;
out vec4 maxLightColor;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = cylindrical_distance(ModelViewMat, IViewRotMat * Position);
    texCoord0 = UV0;
    vertexColor = Color;
	lightColor = minecraft_sample_lightmap(Sampler2, UV2);
	maxLightColor = minecraft_sample_lightmap(Sampler2, ivec2(240.0, 240.0));
}
