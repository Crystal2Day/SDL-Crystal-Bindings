# Based on https://examples.libsdl.org/SDL3/renderer/11-color-mods/

require "../../src/sdl3-crystal-bindings.cr"

require "file_utils"

LibSDLMacro.main_use_callbacks(->app_init_func, ->app_iterate_func, ->app_event_func, ->app_quit_func)

WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

class Globals
  class_property window = Pointer(LibSDL::Window).null
  class_property renderer = Pointer(LibSDL::Renderer).null
  class_property texture = Pointer(LibSDL::Texture).null
  class_property texture_width = 0i32
  class_property texture_height = 0i32
  class_property initial_time = Time.utc
end

def app_init_func(appstate : Void**, argc : LibC::Int, argv : LibC::Char**)
  LibSDL.set_app_metadata("Example Renderer Color Mods", "1.0", "com.example.renderer-color-mods")

  if 0 == LibSDL.init(LibSDL::InitFlags::VIDEO)
    LibSDL.log("Couldn't initialize SDL: %s", LibSDL.get_error)
    return LibSDL::AppResult::FAILURE
  end

  if 0 == LibSDL.create_window_and_renderer("examples/renderer/color-mods", WINDOW_WIDTH, WINDOW_HEIGHT, LibSDL::WindowFlags::None, out window, out renderer)
    LibSDL.log("Couldn't create window/renderer: %s", LibSDL.get_error)
    return LibSDL::AppResult::FAILURE
  end

  Globals.window = window
  Globals.renderer = renderer

  bmp_path = Path.new(FileUtils.pwd, "sdl3_examples/resources/sample.bmp")
  surface = LibSDL.load_bmp(bmp_path.to_s)
  if !surface
    LibSDL.log("Couldn't load bitmap: %s", LibSDL.get_error)
    return LibSDL::AppResult::FAILURE
  end

  Globals.texture_width = surface.value.w
  Globals.texture_height = surface.value.h

  Globals.texture = LibSDL.create_texture_from_surface(Globals.renderer, surface)
  if !Globals.texture
    LibSDL.log("Couldn't create static texture: %s", LibSDL.get_error)
    return LibSDL::AppResult::FAILURE
  end

  LibSDL.destroy_surface(surface)

  return LibSDL::AppResult::CONTINUE
end

def app_iterate_func(appstate : Void*)
  dst_rect = LibSDL::FRect.new
  now = (Time.utc - Globals.initial_time).total_milliseconds / 1000.0

  red = 0.5 + 0.5 * Math.sin(now)
  green = 0.5 + 0.5 * Math.sin(now + Math::PI * 2 / 3)
  blue = 0.5 + 0.5 * Math.sin(now + Math::PI * 4 / 3)

  LibSDL.set_render_draw_color(Globals.renderer, 0, 0, 0, LibSDL::ALPHA_OPAQUE)
  LibSDL.render_clear(Globals.renderer)

  dst_rect.x = 0.0
  dst_rect.y = 0.0
  dst_rect.w = Globals.texture_width
  dst_rect.h = Globals.texture_height
  LibSDL.set_texture_color_mod_float(Globals.texture, 0.0, 0.0, 1.0)
  LibSDL.render_texture(Globals.renderer, Globals.texture, nil, pointerof(dst_rect))
  
  dst_rect.x = (WINDOW_WIDTH - Globals.texture_width) / 2.0
  dst_rect.y = (WINDOW_HEIGHT - Globals.texture_height) / 2.0
  dst_rect.w = Globals.texture_width
  dst_rect.h = Globals.texture_height
  LibSDL.set_texture_color_mod_float(Globals.texture, red, green, blue)
  LibSDL.render_texture(Globals.renderer, Globals.texture, nil, pointerof(dst_rect))

  dst_rect.x = WINDOW_WIDTH - Globals.texture_width
  dst_rect.y = WINDOW_HEIGHT - Globals.texture_height
  dst_rect.w = Globals.texture_width
  dst_rect.h = Globals.texture_height
  LibSDL.set_texture_color_mod_float(Globals.texture, 1.0, 0.0, 0.0)
  LibSDL.render_texture(Globals.renderer, Globals.texture, nil, pointerof(dst_rect))

  LibSDL.render_present(Globals.renderer)

  return LibSDL::AppResult::CONTINUE
end

def app_event_func(appstate : Void*, event : LibSDL::Event*)
  if event.value.type == LibSDL::EventType::QUIT.to_u32
    return LibSDL::AppResult::SUCCESS
  end

  return LibSDL::AppResult::CONTINUE
end

def app_quit_func(appstate : Void*, result : LibSDL::AppResult)
  LibSDL.destroy_texture(Globals.texture)
end
