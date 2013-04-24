/**
 * QRCode Display Portlet
 * Copyright (c) 2013 Vilmos Papp <papp.gyorgy.vilmos@gmail.com>
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package hu.vilmospapp.qrcodedisplay;

/**
 * @author Vilmos Papp
 */
public class Constants {

	public static final String BORDER_STYLE_DASHED = "dashed";
	public static final String BORDER_STYLE_DOTTED = "dotted";
	public static final String BORDER_STYLE_DOUBLE = "double";
	public static final String BORDER_STYLE_GROOVE = "groove";
	public static final String BORDER_STYLE_INSET = "inset";
	public static final String BORDER_STYLE_NONE = "none";
	public static final String BORDER_STYLE_OUTSET = "outset";
	public static final String BORDER_STYLE_RIDGE = "ridge";
	public static final String BORDER_STYLE_SOLID = "solid";

	public static final String DEFAULT_BACKGROUND_COLOR = "#FFFFFF";
	public static final int DEFAULT_BORDER_RADIUS = 0;
	public static final String DEFAULT_BORDER_STYLE = "none";
	public static final int DEFAULT_BORDER_WIDTH = 2;
	public static final String DEFAULT_CHARSET = "UTF-8";
	public static final int DEFAULT_DIMENSION = 129;
	public static final String DEFAULT_FOREGROUND_COLOR = "#000000";
	public static final int DEFAULT_MARGIN = 0;
	public static final int DEFAULT_SHADOW_ANGLE = 45;
	public static final int DEFAULT_SHADOW_BLUR = 5;
	public static final int DEFAULT_SHADOW_DISTANCE = 10;
	public static final String DEFAULT_SHADOW_COLOR = "#B0B0B0";
	public static final double DEFAULT_SHADOW_OPACITY = 0.75;

	public static final int DISPLAY_TYPE_CURRENT_URL = 1;
	public static final int DISPLAY_TYPE_CUSTOM_TEXT = 2;
	public static final int DISPLAY_TYPE_PORTAL_URL = 0;

	public static final int ERROR_CORRECTION_HIGH = 3;
	public static final int ERROR_CORRECTION_LOW = 0;
	public static final int ERROR_CORRECTION_MEDIUM = 1;
	public static final int ERROR_CORRECTION_QUARTILE = 2;

	public static final String IMAGE_FORMAT_GIF = "gif";
	public static final String IMAGE_FORMAT_JPG = "jpeg";
	public static final String IMAGE_FORMAT_PNG = "png";

	public static final int MODE_ALPHANUMERIC = 1;
	public static final int MODE_BYTE = 2;
	public static final int MODE_KANJI = 3;
	public static final int MODE_NUMERIC = 0;

}