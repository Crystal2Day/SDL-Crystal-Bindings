@[Link("SDL3_ttf")]
lib LibSDL
  # additions3/helper_ttf.cr

  enum TTFImageType
    INVALID
    ALPHA
    COLOR
    SDF
  end

  # SDL_ttf

  TTF_MAJOR_VERSION = 3
  TTF_MINOR_VERSION = 3
  TTF_MICRO_VERSION = 0
  TTF_VERSION = (((TTF_MAJOR_VERSION)*1000000 + (TTF_MINOR_VERSION)*1000 + (TTF_MICRO_VERSION)))
  TTF_PROP_FONT_CREATE_FILENAME_STRING = "ttf.font.create.filename"
  TTF_PROP_FONT_CREATE_IOSTREAM_POINTER = "ttf.font.create.iostream"
  TTF_PROP_FONT_CREATE_IOSTREAM_OFFSET_NUMBER = "ttf.font.create.iostream.offset"
  TTF_PROP_FONT_CREATE_IOSTREAM_AUTOCLOSE_BOOLEAN = "ttf.font.create.iostream.autoclose"
  TTF_PROP_FONT_CREATE_SIZE_FLOAT = "ttf.font.create.size"
  TTF_PROP_FONT_CREATE_FACE_NUMBER = "ttf.font.create.face"
  TTF_PROP_FONT_CREATE_HORIZONTAL_DPI_NUMBER = "ttf.font.create.hdpi"
  TTF_PROP_FONT_CREATE_VERTICAL_DPI_NUMBER = "ttf.font.create.vdpi"
  TTF_PROP_FONT_CREATE_EXISTING_FONT = "ttf.font.create.existing_font"
  TTF_PROP_FONT_OUTLINE_LINE_CAP_NUMBER = "ttf.font.outline.line_cap"
  TTF_PROP_FONT_OUTLINE_LINE_JOIN_NUMBER = "ttf.font.outline.line_join"
  TTF_PROP_FONT_OUTLINE_MITER_LIMIT_NUMBER = "ttf.font.outline.miter_limit"
  TTF_STYLE_NORMAL = 0x00
  TTF_STYLE_BOLD = 0x01
  TTF_STYLE_ITALIC = 0x02
  TTF_STYLE_UNDERLINE = 0x04
  TTF_STYLE_STRIKETHROUGH = 0x08
  TTF_FONT_WEIGHT_THIN = 100
  TTF_FONT_WEIGHT_EXTRA_LIGHT = 200
  TTF_FONT_WEIGHT_LIGHT = 300
  TTF_FONT_WEIGHT_NORMAL = 400
  TTF_FONT_WEIGHT_MEDIUM = 500
  TTF_FONT_WEIGHT_SEMI_BOLD = 600
  TTF_FONT_WEIGHT_BOLD = 700
  TTF_FONT_WEIGHT_EXTRA_BOLD = 800
  TTF_FONT_WEIGHT_BLACK = 900
  TTF_FONT_WEIGHT_EXTRA_BLACK = 950
  TTF_PROP_RENDERER_TEXT_ENGINE_RENDERER = "ttf.renderer_text_engine.create.renderer"
  TTF_PROP_RENDERER_TEXT_ENGINE_ATLAS_TEXTURE_SIZE = "ttf.renderer_text_engine.create.atlas_texture_size"
  TTF_PROP_GPU_TEXT_ENGINE_DEVICE = "ttf.gpu_text_engine.create.device"
  TTF_PROP_GPU_TEXT_ENGINE_ATLAS_TEXTURE_SIZE = "ttf.gpu_text_engine.create.atlas_texture_size"
  TTF_SUBSTRING_DIRECTION_MASK = 0x000000FF
  TTF_SUBSTRING_TEXT_START = 0x00000100
  TTF_SUBSTRING_LINE_START = 0x00000200
  TTF_SUBSTRING_LINE_END = 0x00000400
  TTF_SUBSTRING_TEXT_END = 0x00000800

  type TTFFont = Void
  type TTFTextEngine = Void
  type TTFTextData = Void
  alias TTFFontStyleFlags = UInt32
  alias TTFSubStringFlags = UInt32

  @[Flags]
  enum TTFHintingFlags
    INVALID = -1
    NORMAL
    LIGHT
    MONO
    NONE
    LIGHT_SUBPIXEL
  end

  enum TTFHorizontalAlignment
    INVALID = -1
    LEFT
    CENTER
    RIGHT
  end

  enum TTFDirection
    INVALID = 0
    LTR = 4
    RTL
    TTB
    BTT
  end

  enum TTFGPUTextEngineWinding
    INVALID = -1
    CLOCKWISE
    COUNTER_CLOCKWISE
  end

  struct TTFText
    text : LibC::Char*
    num_lines : LibC::Int
    refcount : LibC::Int
    internal : TTFTextData*
  end

  struct TTFGPUAtlasDrawSequence
    atlas_texture : GPUTexture*
    xy : FPoint*
    uv : FPoint*
    num_vertices : LibC::Int
    indices : LibC::Int*
    num_indices : LibC::Int
    image_type : TTFImageType
    next : TTFGPUAtlasDrawSequence*
  end

  struct TTFSubString
    flags : TTFSubStringFlags
    offset : LibC::Int
    length : LibC::Int
    line_index : LibC::Int
    cluster_index : LibC::Int
    rect : Rect
  end

  fun ttf_version = TTF_Version() : LibC::Int
  fun ttf_get_free_type_version = TTF_GetFreeTypeVersion(major : LibC::Int*, minor : LibC::Int*, patch : LibC::Int*) : Void
  fun ttf_get_harf_buzz_version = TTF_GetHarfBuzzVersion(major : LibC::Int*, minor : LibC::Int*, patch : LibC::Int*) : Void
  fun ttf_init = TTF_Init() : CBool
  fun ttf_open_font = TTF_OpenFont(file : LibC::Char*, ptsize : LibC::Float) : TTFFont*
  fun ttf_open_font_io = TTF_OpenFontIO(src : IOStream*, closeio : CBool, ptsize : LibC::Float) : TTFFont*
  fun ttf_open_font_with_properties = TTF_OpenFontWithProperties(props : PropertiesID) : TTFFont*
  fun ttf_copy_font = TTF_CopyFont(existing_font : TTFFont*) : TTFFont*
  fun ttf_get_font_properties = TTF_GetFontProperties(font : TTFFont*) : PropertiesID
  fun ttf_get_font_generation = TTF_GetFontGeneration(font : TTFFont*) : UInt32
  fun ttf_add_fallback_font = TTF_AddFallbackFont(font : TTFFont*, fallback : TTFFont*) : CBool
  fun ttf_remove_fallback_font = TTF_RemoveFallbackFont(font : TTFFont*, fallback : TTFFont*) : Void
  fun ttf_clear_fallback_fonts = TTF_ClearFallbackFonts(font : TTFFont*) : Void
  fun ttf_set_font_size = TTF_SetFontSize(font : TTFFont*, ptsize : LibC::Float) : CBool
  fun ttf_set_font_size_dpi = TTF_SetFontSizeDPI(font : TTFFont*, ptsize : LibC::Float, hdpi : LibC::Int, vdpi : LibC::Int) : CBool
  fun ttf_get_font_size = TTF_GetFontSize(font : TTFFont*) : LibC::Float
  fun ttf_get_font_dpi = TTF_GetFontDPI(font : TTFFont*, hdpi : LibC::Int*, vdpi : LibC::Int*) : CBool
  fun ttf_set_font_style = TTF_SetFontStyle(font : TTFFont*, style : TTFFontStyleFlags) : Void
  fun ttf_get_font_style = TTF_GetFontStyle(font : TTFFont*) : TTFFontStyleFlags
  fun ttf_set_font_outline = TTF_SetFontOutline(font : TTFFont*, outline : LibC::Int) : CBool
  fun ttf_get_font_outline = TTF_GetFontOutline(font : TTFFont*) : LibC::Int
  fun ttf_set_font_hinting = TTF_SetFontHinting(font : TTFFont*, hinting : TTFHintingFlags) : Void
  fun ttf_get_num_font_faces = TTF_GetNumFontFaces(font : TTFFont*) : LibC::Int
  fun ttf_get_font_hinting = TTF_GetFontHinting(font : TTFFont*) : TTFHintingFlags
  fun ttf_set_font_sdf = TTF_SetFontSDF(font : TTFFont*, enabled : CBool) : CBool
  fun ttf_get_font_sdf = TTF_GetFontSDF(font : TTFFont*) : CBool
  fun ttf_get_font_weight = TTF_GetFontWeight(font : TTFFont*) : LibC::Int
  fun ttf_set_font_wrap_alignment = TTF_SetFontWrapAlignment(font : TTFFont*, align : TTFHorizontalAlignment) : Void
  fun ttf_get_font_wrap_alignment = TTF_GetFontWrapAlignment(font : TTFFont*) : TTFHorizontalAlignment
  fun ttf_get_font_height = TTF_GetFontHeight(font : TTFFont*) : LibC::Int
  fun ttf_get_font_ascent = TTF_GetFontAscent(font : TTFFont*) : LibC::Int
  fun ttf_get_font_descent = TTF_GetFontDescent(font : TTFFont*) : LibC::Int
  fun ttf_set_font_line_skip = TTF_SetFontLineSkip(font : TTFFont*, lineskip : LibC::Int) : Void
  fun ttf_get_font_line_skip = TTF_GetFontLineSkip(font : TTFFont*) : LibC::Int
  fun ttf_set_font_kerning = TTF_SetFontKerning(font : TTFFont*, enabled : CBool) : Void
  fun ttf_get_font_kerning = TTF_GetFontKerning(font : TTFFont*) : CBool
  fun ttf_font_is_fixed_width = TTF_FontIsFixedWidth(font : TTFFont*) : CBool
  fun ttf_font_is_scalable = TTF_FontIsScalable(font : TTFFont*) : CBool
  fun ttf_get_font_family_name = TTF_GetFontFamilyName(font : TTFFont*) : LibC::Char*
  fun ttf_get_font_style_name = TTF_GetFontStyleName(font : TTFFont*) : LibC::Char*
  fun ttf_set_font_direction = TTF_SetFontDirection(font : TTFFont*, direction : TTFDirection) : CBool
  fun ttf_get_font_direction = TTF_GetFontDirection(font : TTFFont*) : TTFDirection
  fun ttf_string_to_tag = TTF_StringToTag(string : LibC::Char*) : UInt32
  fun ttf_tag_to_string = TTF_TagToString(tag : UInt32, string : LibC::Char*, size : LibC::SizeT) : Void
  fun ttf_set_font_script = TTF_SetFontScript(font : TTFFont*, script : UInt32) : CBool
  fun ttf_get_font_script = TTF_GetFontScript(font : TTFFont*) : UInt32
  fun ttf_get_glyph_script = TTF_GetGlyphScript(ch : UInt32) : UInt32
  fun ttf_set_font_language = TTF_SetFontLanguage(font : TTFFont*, language_bcp47 : LibC::Char*) : CBool
  fun ttf_font_has_glyph = TTF_FontHasGlyph(font : TTFFont*, ch : UInt32) : CBool
  fun ttf_get_glyph_image = TTF_GetGlyphImage(font : TTFFont*, ch : UInt32, image_type : TTFImageType*) : Surface*
  fun ttf_get_glyph_image_for_index = TTF_GetGlyphImageForIndex(font : TTFFont*, glyph_index : UInt32, image_type : TTFImageType*) : Surface*
  fun ttf_get_glyph_metrics = TTF_GetGlyphMetrics(font : TTFFont*, ch : UInt32, minx : LibC::Int*, maxx : LibC::Int*, miny : LibC::Int*, maxy : LibC::Int*, advance : LibC::Int*) : CBool
  fun ttf_get_glyph_kerning = TTF_GetGlyphKerning(font : TTFFont*, previous_ch : UInt32, ch : UInt32, kerning : LibC::Int*) : CBool
  fun ttf_get_string_size = TTF_GetStringSize(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, w : LibC::Int*, h : LibC::Int*) : CBool
  fun ttf_get_string_size_wrapped = TTF_GetStringSizeWrapped(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, wrap_width : LibC::Int, w : LibC::Int*, h : LibC::Int*) : CBool
  fun ttf_measure_string = TTF_MeasureString(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, max_width : LibC::Int, measured_width : LibC::Int*, measured_length : LibC::SizeT*) : CBool
  fun ttf_render_text_solid = TTF_RenderText_Solid(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color) : Surface*
  fun ttf_render_text_solid_wrapped = TTF_RenderText_Solid_Wrapped(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color, wrap_length : LibC::Int) : Surface*
  fun ttf_render_glyph_solid = TTF_RenderGlyph_Solid(font : TTFFont*, ch : UInt32, fg : Color) : Surface*
  fun ttf_render_text_shaded = TTF_RenderText_Shaded(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color, bg : Color) : Surface*
  fun ttf_render_text_shaded_wrapped = TTF_RenderText_Shaded_Wrapped(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color, bg : Color, wrap_width : LibC::Int) : Surface*
  fun ttf_render_glyph_shaded = TTF_RenderGlyph_Shaded(font : TTFFont*, ch : UInt32, fg : Color, bg : Color) : Surface*
  fun ttf_render_text_blended = TTF_RenderText_Blended(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color) : Surface*
  fun ttf_render_text_blended_wrapped = TTF_RenderText_Blended_Wrapped(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color, wrap_width : LibC::Int) : Surface*
  fun ttf_render_glyph_blended = TTF_RenderGlyph_Blended(font : TTFFont*, ch : UInt32, fg : Color) : Surface*
  fun ttf_render_text_lcd = TTF_RenderText_LCD(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color, bg : Color) : Surface*
  fun ttf_render_text_lcd_wrapped = TTF_RenderText_LCD_Wrapped(font : TTFFont*, text : LibC::Char*, length : LibC::SizeT, fg : Color, bg : Color, wrap_width : LibC::Int) : Surface*
  fun ttf_render_glyph_lcd = TTF_RenderGlyph_LCD(font : TTFFont*, ch : UInt32, fg : Color, bg : Color) : Surface*
  fun ttf_create_surface_text_engine = TTF_CreateSurfaceTextEngine() : TTFTextEngine*
  fun ttf_draw_surface_text = TTF_DrawSurfaceText(text : TTFText*, x : LibC::Int, y : LibC::Int, surface : Surface*) : CBool
  fun ttf_destroy_surface_text_engine = TTF_DestroySurfaceTextEngine(engine : TTFTextEngine*) : Void
  fun ttf_create_renderer_text_engine = TTF_CreateRendererTextEngine(renderer : Renderer*) : TTFTextEngine*
  fun ttf_create_renderer_text_engine_with_properties = TTF_CreateRendererTextEngineWithProperties(props : PropertiesID) : TTFTextEngine*
  fun ttf_draw_renderer_text = TTF_DrawRendererText(text : TTFText*, x : LibC::Float, y : LibC::Float) : CBool
  fun ttf_destroy_renderer_text_engine = TTF_DestroyRendererTextEngine(engine : TTFTextEngine*) : Void
  fun ttf_create_gputext_engine = TTF_CreateGPUTextEngine(device : GPUDevice*) : TTFTextEngine*
  fun ttf_create_gputext_engine_with_properties = TTF_CreateGPUTextEngineWithProperties(props : PropertiesID) : TTFTextEngine*
  fun ttf_get_gputext_draw_data = TTF_GetGPUTextDrawData(text : TTFText*) : TTFGPUAtlasDrawSequence*
  fun ttf_destroy_gputext_engine = TTF_DestroyGPUTextEngine(engine : TTFTextEngine*) : Void
  fun ttf_set_gputext_engine_winding = TTF_SetGPUTextEngineWinding(engine : TTFTextEngine*, winding : TTFGPUTextEngineWinding) : Void
  fun ttf_get_gputext_engine_winding = TTF_GetGPUTextEngineWinding(engine : TTFTextEngine*) : TTFGPUTextEngineWinding
  fun ttf_create_text = TTF_CreateText(engine : TTFTextEngine*, font : TTFFont*, text : LibC::Char*, length : LibC::SizeT) : TTFText*
  fun ttf_get_text_properties = TTF_GetTextProperties(text : TTFText*) : PropertiesID
  fun ttf_set_text_engine = TTF_SetTextEngine(text : TTFText*, engine : TTFTextEngine*) : CBool
  fun ttf_get_text_engine = TTF_GetTextEngine(text : TTFText*) : TTFTextEngine*
  fun ttf_set_text_font = TTF_SetTextFont(text : TTFText*, font : TTFFont*) : CBool
  fun ttf_get_text_font = TTF_GetTextFont(text : TTFText*) : TTFFont*
  fun ttf_set_text_direction = TTF_SetTextDirection(text : TTFText*, direction : TTFDirection) : CBool
  fun ttf_get_text_direction = TTF_GetTextDirection(text : TTFText*) : TTFDirection
  fun ttf_set_text_script = TTF_SetTextScript(text : TTFText*, script : UInt32) : CBool
  fun ttf_get_text_script = TTF_GetTextScript(text : TTFText*) : UInt32
  fun ttf_set_text_color = TTF_SetTextColor(text : TTFText*, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : CBool
  fun ttf_set_text_color_float = TTF_SetTextColorFloat(text : TTFText*, r : LibC::Float, g : LibC::Float, b : LibC::Float, a : LibC::Float) : CBool
  fun ttf_get_text_color = TTF_GetTextColor(text : TTFText*, r : UInt8*, g : UInt8*, b : UInt8*, a : UInt8*) : CBool
  fun ttf_get_text_color_float = TTF_GetTextColorFloat(text : TTFText*, r : LibC::Float*, g : LibC::Float*, b : LibC::Float*, a : LibC::Float*) : CBool
  fun ttf_set_text_position = TTF_SetTextPosition(text : TTFText*, x : LibC::Int, y : LibC::Int) : CBool
  fun ttf_get_text_position = TTF_GetTextPosition(text : TTFText*, x : LibC::Int*, y : LibC::Int*) : CBool
  fun ttf_set_text_wrap_width = TTF_SetTextWrapWidth(text : TTFText*, wrap_width : LibC::Int) : CBool
  fun ttf_get_text_wrap_width = TTF_GetTextWrapWidth(text : TTFText*, wrap_width : LibC::Int*) : CBool
  fun ttf_set_text_wrap_whitespace_visible = TTF_SetTextWrapWhitespaceVisible(text : TTFText*, visible : CBool) : CBool
  fun ttf_text_wrap_whitespace_visible = TTF_TextWrapWhitespaceVisible(text : TTFText*) : CBool
  fun ttf_set_text_string = TTF_SetTextString(text : TTFText*, string : LibC::Char*, length : LibC::SizeT) : CBool
  fun ttf_insert_text_string = TTF_InsertTextString(text : TTFText*, offset : LibC::Int, string : LibC::Char*, length : LibC::SizeT) : CBool
  fun ttf_append_text_string = TTF_AppendTextString(text : TTFText*, string : LibC::Char*, length : LibC::SizeT) : CBool
  fun ttf_delete_text_string = TTF_DeleteTextString(text : TTFText*, offset : LibC::Int, length : LibC::Int) : CBool
  fun ttf_get_text_size = TTF_GetTextSize(text : TTFText*, w : LibC::Int*, h : LibC::Int*) : CBool
  fun ttf_get_text_sub_string = TTF_GetTextSubString(text : TTFText*, offset : LibC::Int, substring : TTFSubString*) : CBool
  fun ttf_get_text_sub_string_for_line = TTF_GetTextSubStringForLine(text : TTFText*, line : LibC::Int, substring : TTFSubString*) : CBool
  fun ttf_get_text_sub_strings_for_range = TTF_GetTextSubStringsForRange(text : TTFText*, offset : LibC::Int, length : LibC::Int, count : LibC::Int*) : TTFSubString**
  fun ttf_get_text_sub_string_for_point = TTF_GetTextSubStringForPoint(text : TTFText*, x : LibC::Int, y : LibC::Int, substring : TTFSubString*) : CBool
  fun ttf_get_previous_text_sub_string = TTF_GetPreviousTextSubString(text : TTFText*, substring : TTFSubString*, previous : TTFSubString*) : CBool
  fun ttf_get_next_text_sub_string = TTF_GetNextTextSubString(text : TTFText*, substring : TTFSubString*, next : TTFSubString*) : CBool
  fun ttf_update_text = TTF_UpdateText(text : TTFText*) : CBool
  fun ttf_destroy_text = TTF_DestroyText(text : TTFText*) : Void
  fun ttf_close_font = TTF_CloseFont(font : TTFFont*) : Void
  fun ttf_quit = TTF_Quit() : Void
  fun ttf_was_init = TTF_WasInit() : LibC::Int

end

module LibSDLMacro
  # SDL_ttf

  macro ttf_version_atleast(x, y, z)
    (LibSDL::TTF_MAJOR_VERSION >= {{x}}) && (LibSDL::TTF_MAJOR_VERSION > {{x}} || LibSDL::TTF_MINOR_VERSION >= {{y}}) && (LibSDL::TTF_MAJOR_VERSION > {{x}} || LibSDL::TTF_MINOR_VERSION > {{y}} || LibSDL::TTF_PATCHLEVEL >= {{z}})
  end
end
