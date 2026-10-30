// Light vertex shader
// Standard issue vertex shader, apply matrices, pass info to pixel shader
cbuffer MatrixBuffer : register(b0)
{
	matrix worldMatrix;
	matrix viewMatrix;
	matrix projectionMatrix;
};

cbuffer MatrixBuffer : register(b1)
{
    float time;
    float frequency;
    float amplitude;
    float speed;
};

struct InputType
{
	float4 position : POSITION;
	float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
};

struct OutputType
{
	float4 position : SV_POSITION;
	float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
};

OutputType main(InputType input)
{
	OutputType output;
	
	//get the wave to affect y
    float px = frequency * input.position.x + speed * time;
    float pz = frequency * input.position.z + speed * time;
    input.position.y = amplitude * (sin(px) + cos(pz)/2);
	
    float dhdx = amplitude * frequency * cos(px);
    float dhdz = -amplitude * frequency * sin(pz)/2;
    input.normal = normalize(float3(-dhdx, 1, -dhdz));
	
    //input.position.y += sin((input.position.x + input.position.z) * frequency + time * speed) * amplitude;

	// Calculate the position of the vertex against the world, view, and projection matrices.
	output.position = mul(input.position, worldMatrix);
	output.position = mul(output.position, viewMatrix);
	output.position = mul(output.position, projectionMatrix);

	// Store the texture coordinates for the pixel shader.
	output.tex = input.tex;

	// Calculate the normal vector against the world matrix only and normalise.
	output.normal = mul(input.normal, (float3x3)worldMatrix);
	output.normal = normalize(output.normal);

	return output;
}