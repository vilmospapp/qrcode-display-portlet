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

package hu.vilmospapp.qrcodedisplay.action;

import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.portlet.LiferayPortletConfig;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;

/**
 * @author Vilmos Papp
 */
public class ConfigurationActionImpl extends DefaultConfigurationAction {

	public void processAction(
			PortletConfig portletConfig, ActionRequest actionRequest,
			ActionResponse actionResponse)
		throws Exception {

		String portletResource = ParamUtil.getString(
			actionRequest, "portletResource");

		PortletPreferences prefs =
			PortletPreferencesFactoryUtil.getPortletSetup(
				actionRequest, portletResource);

		String backgroundColor = getParameter(actionRequest, "backgroundColor");
		String borderColor = getParameter(actionRequest, "borderColor");
		String borderEnabled = getParameter(actionRequest, "borderEnabled");
		String borderRadius = getParameter(actionRequest, "borderRadius");
		String borderStyle = getParameter(actionRequest, "borderStyle");
		String borderWidth = getParameter(actionRequest, "borderWidth");
		String characterSet = getParameter(actionRequest, "characterSet");
		String content = getParameter(actionRequest, "content");
		String dimension = getParameter(actionRequest, "dimension");
		String displayType = getParameter(actionRequest, "displayType");
		String errorCorrection = getParameter(actionRequest, "errorCorrection");
		String foregroundColor = getParameter(actionRequest, "foregroundColor");
		String imageFormat = getParameter(actionRequest, "imageFormat");
		String margin = getParameter(actionRequest, "margin");
		String mode = getParameter(actionRequest, "mode");
		String shadowAngle = getParameter(actionRequest, "shadowAngle");
		String shadowBlur = getParameter(actionRequest, "shadowBlur");
		String shadowColor = getParameter(actionRequest, "shadowColor");
		String shadowDistance = getParameter(actionRequest, "shadowDistance");
		String shadowEnabled = getParameter(actionRequest, "shadowEnabled");
		String shadowOpacity = getParameter(actionRequest, "shadowOpacity");
		String stripParams = getParameter(actionRequest, "stripParams");

		prefs.setValue("backgroundColor", backgroundColor);
		prefs.setValue("borderColor", borderColor);
		prefs.setValue("borderEnabled", borderEnabled);
		prefs.setValue("borderRadius", borderRadius);
		prefs.setValue("borderStyle", borderStyle);
		prefs.setValue("borderWidth", borderWidth);
		prefs.setValue("characterSet", characterSet);
		prefs.setValue("content", content);
		prefs.setValue("dimension", dimension);
		prefs.setValue("displayType", displayType);
		prefs.setValue("errorCorrection", errorCorrection);
		prefs.setValue("foregroundColor", foregroundColor);
		prefs.setValue("imageFormat", imageFormat);
		prefs.setValue("margin", margin);
		prefs.setValue("mode", mode);
		prefs.setValue("shadowAngle", shadowAngle);
		prefs.setValue("shadowBlur", shadowBlur);
		prefs.setValue("shadowColor", shadowColor);
		prefs.setValue("shadowDistance", shadowDistance);
		prefs.setValue("shadowEnabled", shadowEnabled);
		prefs.setValue("shadowOpacity", shadowOpacity);
		prefs.setValue("stripParams", stripParams);

		prefs.store();

		LiferayPortletConfig liferayPortletConfig =
			(LiferayPortletConfig)portletConfig;

		SessionMessages.add(
			actionRequest,
			liferayPortletConfig.getPortletId() +
				SessionMessages.KEY_SUFFIX_REFRESH_PORTLET,
			portletResource);

		SessionMessages.add(
			actionRequest,
			liferayPortletConfig.getPortletId() +
				SessionMessages.KEY_SUFFIX_UPDATED_CONFIGURATION);
	}

}