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
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="com.liferay.portal.kernel.servlet.BrowserSnifferUtil" %><%@
page import="com.liferay.portal.kernel.util.GetterUtil" %><%@
page import="com.liferay.portal.kernel.util.HtmlUtil" %><%@
page import="com.liferay.portal.kernel.util.ParamUtil" %><%@
page import="com.liferay.portal.kernel.util.StringBundler" %><%@
page import="com.liferay.portal.kernel.util.StringPool" %><%@
page import="com.liferay.portal.kernel.util.Validator" %><%@
page import="com.liferay.portal.util.PortalUtil" %><%@
page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>

<%@ page import="hu.vilmospapp.qrcodedisplay.ColorUtil" %><%@
page import="hu.vilmospapp.qrcodedisplay.Constants" %>

<%@ page import="java.nio.charset.Charset" %><%@
page import="java.lang.Math" %><%@
page import="java.util.Map" %><%@
page import="javax.portlet.PortletPreferences" %><%@
page import="javax.portlet.ResourceURL" %>

<liferay-theme:defineObjects />
<portlet:defineObjects />

<%
	PortletPreferences preferences = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(renderRequest, "portletResource");

if (Validator.isNotNull(portletResource)) {
	preferences = PortletPreferencesFactoryUtil.getPortletSetup(
		renderRequest, portletResource);
}

String backgroundColor = GetterUtil.getString(preferences.getValue("backgroundColor", Constants.DEFAULT_BACKGROUND_COLOR));
String borderColor = GetterUtil.getString(preferences.getValue("borderColor", Constants.DEFAULT_BACKGROUND_COLOR));
boolean borderEnabled = GetterUtil.getBoolean(preferences.getValue("borderEnabled", Boolean.FALSE.toString()));
int borderRadius = GetterUtil.getInteger(preferences.getValue("borderRadius", String.valueOf(Constants.DEFAULT_BORDER_RADIUS)));
String borderStyle = GetterUtil.getString(preferences.getValue("borderStyle", Constants.DEFAULT_BORDER_STYLE));
int borderWidth = GetterUtil.getInteger(preferences.getValue("borderWidth", String.valueOf(Constants.DEFAULT_BORDER_WIDTH)));
String characterSet = GetterUtil.getString(preferences.getValue("characterSet", Constants.DEFAULT_CHARSET));
String content = GetterUtil.getString(preferences.getValue("content", StringPool.BLANK));
int displayType = GetterUtil.getInteger(preferences.getValue("displayType", String.valueOf(Constants.DISPLAY_TYPE_CURRENT_URL)));
int dimension = GetterUtil.getInteger(preferences.getValue("dimension", String.valueOf(Constants.DEFAULT_DIMENSION)));
int errorCorrection = GetterUtil.getInteger(preferences.getValue("errorCorrection", String.valueOf(Constants.ERROR_CORRECTION_LOW)));
String foregroundColor = GetterUtil.getString(preferences.getValue("foregroundColor", Constants.DEFAULT_FOREGROUND_COLOR));
String imageFormat = GetterUtil.getString(preferences.getValue("imageFormat", Constants.IMAGE_FORMAT_PNG));
int margin = GetterUtil.getInteger(preferences.getValue("margin", String.valueOf(Constants.DEFAULT_MARGIN)));
int mode = GetterUtil.getInteger(preferences.getValue("mode", String.valueOf(Constants.MODE_BYTE)));
int shadowAngle = GetterUtil.getInteger(preferences.getValue("shadowAngle", String.valueOf(Constants.DEFAULT_SHADOW_ANGLE)));
int shadowBlur = GetterUtil.getInteger(preferences.getValue("shadowBlur", String.valueOf(Constants.DEFAULT_SHADOW_BLUR)));
String shadowColor = GetterUtil.getString(preferences.getValue("shadowColor", String.valueOf(Constants.DEFAULT_SHADOW_COLOR)));
int shadowDistance = GetterUtil.getInteger(preferences.getValue("shadowDistance", String.valueOf(Constants.DEFAULT_SHADOW_DISTANCE)));
boolean shadowEnabled = GetterUtil.getBoolean(preferences.getValue("shadowEnabled", Boolean.FALSE.toString()));
int shadowOpacity = GetterUtil.getInteger(preferences.getValue("shadowOpacity", String.valueOf(Constants.DEFAULT_SHADOW_OPACITY)));
boolean stripParams = GetterUtil.getBoolean(preferences.getValue("stripParams", Boolean.FALSE.toString()));
%>