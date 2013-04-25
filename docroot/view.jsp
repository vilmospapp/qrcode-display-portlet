<%--
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
--%>

<%@ include file="./init.jsp" %>

<%
ResourceURL qrCodeImageURL = liferayPortletResponse.createResourceURL();

if ( displayType == Constants.DISPLAY_TYPE_CURRENT_URL) {
	qrCodeImageURL.setParameter("currentURL", PortalUtil.getCurrentCompleteURL(request).toString());
}
StringBundler borderCSS = new StringBundler();

boolean isIE = BrowserSnifferUtil.isIe(request);

if (borderEnabled) {
	if (isIE) {
		borderCSS.append("z-index:3;");
		borderCSS.append("position:relative;");
	}

	if (!borderStyle.equals(Constants.BORDER_STYLE_NONE)) {
		borderCSS.append("border-style: ");
		borderCSS.append(borderStyle);
		borderCSS.append(StringPool.SEMICOLON);

		if (borderWidth > 0) {
			borderCSS.append("border-width: ");
			borderCSS.append(borderWidth);
			borderCSS.append("px;");
		}

		if (borderRadius > 0) {
			borderCSS.append("border-radius: ");
			borderCSS.append(borderRadius);
			borderCSS.append("px;");
		}

		if (Validator.isNotNull(borderColor)) {
			borderCSS.append("border-color: ");
			borderCSS.append(borderColor);
			borderCSS.append(";");
		}
	}
}

StringBundler shadowCSS = new StringBundler();

if (shadowEnabled) {
	String browserId = StringPool.BLANK;


	int horizonalPlacement = (int)(shadowDistance * Math.cos(Math.toRadians(shadowAngle)));
	int verticalPlacement = (int)(shadowDistance * Math.sin(Math.toRadians(shadowAngle)));

	double opacity = ((double)shadowOpacity)/100;

	String [] rgb = ColorUtil.getRGB(shadowColor);

	if (isIE && (BrowserSnifferUtil.getMajorVersion(request) < 9)) {
		shadowCSS.append("background-color: rgb(");
		shadowCSS.append(rgb[0]);
		shadowCSS.append(StringPool.COMMA);
		shadowCSS.append(rgb[1]);
		shadowCSS.append(StringPool.COMMA);
		shadowCSS.append(rgb[2]);
		shadowCSS.append(");");
		shadowCSS.append("filter: progid:DXImageTransform.Microsoft.Shadow(Color=");
 		shadowCSS.append(shadowColor);
 		shadowCSS.append(",Direction=");
 		shadowCSS.append(90 + shadowAngle);
 		shadowCSS.append(",Strength=");
 		shadowCSS.append(opacity*shadowDistance);
 		shadowCSS.append(");");
		shadowCSS.append("zoom: 1;");
		shadowCSS.append("display:block;");
		shadowCSS.append("position:absolute;");
		shadowCSS.append("z-index:2;");
		shadowCSS.append("width:");
		shadowCSS.append(dimension);
		shadowCSS.append("px;");
		shadowCSS.append("height:");
		shadowCSS.append(dimension);
		shadowCSS.append("px;");
	}
	else {
		if (BrowserSnifferUtil.isChrome(request) || BrowserSnifferUtil.isSafari(request)) {
			browserId = "-webkit-";
		}
		else if (BrowserSnifferUtil.isGecko(request) || BrowserSnifferUtil.isFirefox(request)) {
			if (BrowserSnifferUtil.getMajorVersion(request) < 13) {
				browserId = "-moz-";
			}
		}

		shadowCSS.append(browserId);
		shadowCSS.append("box-shadow: ");
		shadowCSS.append(horizonalPlacement);
		shadowCSS.append("px ");
		shadowCSS.append(verticalPlacement);
		shadowCSS.append("px ");
		shadowCSS.append(shadowBlur);
		shadowCSS.append("px ");
		shadowCSS.append("rgba(");
		shadowCSS.append(rgb[0]);
		shadowCSS.append(StringPool.COMMA);
		shadowCSS.append(rgb[1]);
		shadowCSS.append(StringPool.COMMA);
		shadowCSS.append(rgb[2]);
		shadowCSS.append(StringPool.COMMA);
		shadowCSS.append(opacity);
		shadowCSS.append(");");
	}
}

String css = StringPool.BLANK;

if ((borderCSS.length() > 0) || (shadowCSS.length() > 0)) {
	css = borderCSS.toString();

	StringBundler borderSizeCSS = new StringBundler(6);

	borderSizeCSS.append("width:");
	borderSizeCSS.append(dimension);
	borderSizeCSS.append("px;");
	borderSizeCSS.append("height:");
	borderSizeCSS.append(dimension);
	borderSizeCSS.append("px;");

	css += borderSizeCSS.toString();
}

css += shadowCSS.toString();
%>

<div style="height:<%= (dimension + borderWidth + shadowDistance) %>px;">
	<div <%= (css.length() > 0 ? ("style=\"" + css.toString() + "\"") : StringPool.BLANK ) %>>
		<img src="<%= qrCodeImageURL.toString() %>" />
	</div>
</div>