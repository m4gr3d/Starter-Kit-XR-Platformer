<p align="center"><img src="icon.png"/></p>

# Starter Kit XR Platformer

This package includes a basic template for a XR platformer game in Godot 4.3 (stable). Includes features like;

- Character controller (with double jump)
- Collectable coins and falling platforms
- Camera controls (rotate, zoom)
- Gamepad support
- Sprites and 3D Models _(CC0 licensed)_
- Sound effects _(CC0 licensed)_

### Screenshot

<p align="center"><img src="screenshots/screenshot.png"/></p>

### From 3D to XR

This project is a fork of the [Starter Kit 3D Platformer by Kenney](https://github.com/KenneyNL/Starter-Kit-3D-Platformer).

Described below is the process used to turn the project from a 3D game to a XR game running on the Meta Quest:

#### Project configuration

- Start by opening the original [Starter Kit 3D Platformer](https://github.com/KenneyNL/Starter-Kit-3D-Platformer) in the Godot Editor
- To improve performance on the Quest, we'll disable some of the project settings:
  - In the scene dock, click on the **Environment** node
  - In the inspector dock, under the *WorldEnvironment* section, click on the *main-environment* entry
	- Set the **Tonemap** to *Linear*
	- Click on **SSAO** and set *Enabled* to **OFF**
	- Click on **Glow** and set *Enabled* to **OFF**
  - Change the renderer to *Compatibility*
	- this can be done from the drop-down in the top right corner of the editor window
	- Or from the project settings
  - Save & restart as needed
- Run the project to validate that it runs as expected
  - The character can be controlled using keyboard keys
	- The four keyboard arrows (up, down, left, right) are used to control the camera
	- WASD are used to move the character
	- SPACE is used for jumps
   
#### Adding the XR components

- Using the *Asset Library*, add the [Godot OpenXR Vendors plugin for Godot 4.3](https://godotengine.org/asset-library/asset/3076) to the project.
- After installing the plugin, navigate to the *Project Settings* and scroll down to the *XR* section
  - In the *Shaders* section, set *Enabled* to **ON**
  - In the *OpenXR* section
	- Set *Enabled* to **ON**
	- Set *Reference Space* to **Local Floor**
  - Click *Save & Restart* to apply the new settings.

#### Configuring the XR Scene

- In the scene dock, find the **View** node (under the **Main** node) and delete it
- Add a **XROrigin3D** node to the **Main** node
- Add a **XRCamera3D** node to the added **XROrigin3D** node
- In the spatial editor window, position the **XROrigin3D** node where you want the user to be when loading the scene
  - E.g: high above the scene looking down on the playable character
- Select the **Player** node
  - In the inspector dock, under the *Components* section, select the **XROrigin3D** node for the *View* field
- Attach a script to the **XROrigin3D** node, and configure it to set up the XR scene
  - Update the *_ready()* function as follow:
 
```
func _ready() -> void:
  var xr_interface = XRServer.find_interface("OpenXR")
  if xr_interface and xr_interface.initialize():
	# Enable XR on the viewport
	var viewport = get_viewport()
	viewport.use_xr = true

	# Disable vsync
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
```

- Once the script is complete, click the *Play* button to run the XR scene

### License

MIT License

Copyright (c) 2024 Kenney

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Assets included in this package (2D sprites, 3D models and sound effects) are [CC0 licensed](https://creativecommons.org/publicdomain/zero/1.0/)
