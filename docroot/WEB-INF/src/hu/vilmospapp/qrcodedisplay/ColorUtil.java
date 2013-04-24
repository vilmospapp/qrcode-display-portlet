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

import com.liferay.portal.kernel.util.StringPool;

/**
 * @author Vilmos Papp
 */
public class ColorUtil {

	public static String[] getRGB(String hex) {
		hex = (hex.startsWith("#")? hex.substring(1) : hex);

		String redHex = StringPool.BLANK;
		String greenHex = StringPool.BLANK;
		String blueHex = StringPool.BLANK;

		if (hex.length() == 3) {
			redHex += hex.charAt(0);
			redHex += hex.charAt(0);

			greenHex += hex.charAt(1);
			greenHex += hex.charAt(1);

			blueHex += hex.charAt(2);
			blueHex += hex.charAt(2);
		}
		else if (hex.length() == 6) {
			redHex += hex.charAt(0);
			redHex += hex.charAt(1);

			greenHex += hex.charAt(2);
			greenHex += hex.charAt(3);

			blueHex += hex.charAt(4);
			blueHex += hex.charAt(5);
		}

		int red = Integer.parseInt(redHex, 16);
		int green = Integer.parseInt(greenHex, 16);
		int blue = Integer.parseInt(blueHex, 16);

		String [] rgb = new String[] {
							String.valueOf(red),
							String.valueOf(green),
							String.valueOf(blue)
						};

		return rgb;
	}

}
