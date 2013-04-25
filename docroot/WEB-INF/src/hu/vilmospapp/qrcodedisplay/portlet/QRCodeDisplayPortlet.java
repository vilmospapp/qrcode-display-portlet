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

package hu.vilmospapp.qrcodedisplay.portlet;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import com.liferay.portal.kernel.util.CharPool;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;
import com.liferay.util.bridges.mvc.MVCPortlet;

import de.chrfr.gfx.PNG;

import hu.vilmospapp.qrcodedisplay.Constants;

import java.awt.Color;

import java.io.IOException;
import java.io.OutputStream;

import java.util.HashMap;
import java.util.Map;

import javax.portlet.PortletException;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

/**
 * @author Vilmos Papp
 */
public class QRCodeDisplayPortlet extends MVCPortlet {

	@Override
	public void serveResource(
			ResourceRequest resourceRequest, ResourceResponse resourceResponse)
		throws IOException, PortletException {

		OutputStream outputStream = null;

		try {
			PortletPreferences preferences = resourceRequest.getPreferences();

			String portletResource = ParamUtil.getString(
				resourceRequest, "portletResource");

			if (Validator.isNotNull(portletResource)) {
				preferences = PortletPreferencesFactoryUtil.getPortletSetup(
					resourceRequest, portletResource);
			}

			String backgroundColor = GetterUtil.getString(
				preferences.getValue(
					"backgroundColor", Constants.DEFAULT_BACKGROUND_COLOR));
			String characterSet = GetterUtil.getString(
				preferences.getValue(
					"characterSet", Constants.DEFAULT_CHARSET));
			String content = GetterUtil.getString(
				preferences.getValue("content", StringPool.BLANK));
			int dimension = GetterUtil.getInteger(
				preferences.getValue(
					"dimension", String.valueOf(Constants.DEFAULT_DIMENSION)));
			int displayType = GetterUtil.getInteger(
				preferences.getValue(
					"displayType", String.valueOf(
						Constants.DISPLAY_TYPE_CURRENT_URL)));
			int errorCorrection = GetterUtil.getInteger(
				preferences.getValue(
					"errorCorrection",
					String.valueOf(Constants.ERROR_CORRECTION_LOW)));
			String foregroundColor = GetterUtil.getString(
				preferences.getValue(
					"foregroundColor", Constants.DEFAULT_FOREGROUND_COLOR));
			String imageFormat = GetterUtil.getString(
				preferences.getValue(
					"imageFormat", Constants.IMAGE_FORMAT_PNG));
			int margin = GetterUtil.getInteger(
				preferences.getValue(
					"margin", String.valueOf(Constants.DEFAULT_MARGIN)));

			BitMatrix matrix = null;
			MultiFormatWriter barcodeWriter = new MultiFormatWriter();

			Map <EncodeHintType, Object> hints =
				new HashMap<EncodeHintType, Object> ();

			hints.put(EncodeHintType.MARGIN, margin);

			ErrorCorrectionLevel errorCorrectionLevel = null;

			switch(errorCorrection) {
				case Constants.ERROR_CORRECTION_LOW :
						errorCorrectionLevel = ErrorCorrectionLevel.L;
					break;
				case Constants.ERROR_CORRECTION_MEDIUM :
						errorCorrectionLevel = ErrorCorrectionLevel.M;
					break;
				case Constants.ERROR_CORRECTION_QUARTILE :
						errorCorrectionLevel = ErrorCorrectionLevel.Q;
					break;
				case Constants.ERROR_CORRECTION_HIGH :
						errorCorrectionLevel = ErrorCorrectionLevel.H;
					break;
			}

			if (errorCorrectionLevel != null) {
				hints.put(
					EncodeHintType.ERROR_CORRECTION, errorCorrectionLevel);
			}

			hints.put(EncodeHintType.CHARACTER_SET, characterSet);

			switch (displayType) {
				case Constants.DISPLAY_TYPE_CURRENT_URL:
					content = ParamUtil.getString(
						resourceRequest, "currentURL");
				break;

				case Constants.DISPLAY_TYPE_PORTAL_URL:
					content = PortalUtil.getPortalURL(resourceRequest);
				break;
			}

			matrix = barcodeWriter.encode(
				content, BarcodeFormat.QR_CODE, dimension, dimension, hints);

			if (matrix != null) {
				resourceResponse.setContentType(imageFormat);

				outputStream = resourceResponse.getPortletOutputStream();

				MatrixToImageConfig config = new MatrixToImageConfig(
					_toInt(foregroundColor), _toInt(backgroundColor));

				try {
					MatrixToImageWriter.writeToStream(
						matrix, imageFormat, outputStream, config);
				}
				catch (Throwable t) {
					Color bgColor = new Color(_toInt(backgroundColor));
					Color fgColor = new Color(_toInt(foregroundColor));

					byte[] alpha = _toRGBComponentArray(
						matrix, fgColor.getAlpha(), bgColor.getAlpha());
					byte[] red = _toRGBComponentArray(
						matrix, fgColor.getRed(), bgColor.getRed());
					byte[] green = _toRGBComponentArray(
						matrix, fgColor.getGreen(), bgColor.getGreen());
					byte[] blue = _toRGBComponentArray(
						matrix, fgColor.getBlue(), bgColor.getBlue());

					byte[] array = PNG.toPNG(
						dimension, dimension, alpha, red, green, blue);

					outputStream.write(array);
				}

				outputStream.flush();
			}
		}
		catch (Exception e) {
			throw new PortletException(e);
		}
		finally {
			if (outputStream != null) {
				outputStream.close();
			}
		}
	}

	private int _toInt(String color) {
		if (color.charAt(0) == CharPool.POUND) {
			color = color.substring(1);
		}

		return Integer.parseInt(color, 16);
	}

	private byte[] _toRGBComponentArray(
		BitMatrix matrix, int fgColor, int bgColor) {

		int width = matrix.getWidth();
		int height = matrix.getHeight();
		byte[] bitmap = new byte[width * height];
		int idx = 0;

		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				bitmap[idx] = matrix.get(x, y) ? (byte)fgColor : (byte)bgColor;

				idx++;
			}
		}

		return bitmap;
	}

	@Override
	public void doHelp(
			RenderRequest renderRequest, RenderResponse renderResponse)
		throws IOException, PortletException {

		super.doHelp(renderRequest, renderResponse);
	}

}