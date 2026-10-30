// Application.h
#ifndef _APP1_H
#define _APP1_H

// Includes
#include "DXF.h"	// include dxframework
#include "ManipulationShader.h"
#include <chrono>


class App1 : public BaseApplication
{
public:

	App1();
	~App1();
	void init(HINSTANCE hinstance, HWND hwnd, int screenWidth, int screenHeight, Input* in, bool VSYNC, bool FULL_SCREEN);

	bool frame();

protected:
	bool render();
	void gui();

private:
	ManipulationShader* shader;
	PlaneMesh* mesh;
	Light* light;
	XMFLOAT4* waveInfo;
	std::chrono::steady_clock::time_point startTime;
	float dummyFloat;
};

#endif