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

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />

<liferay-util:include page="/main_js.jsp" servletContext="<%= application %>" strict="true" />

<aui:form action="<%= configurationURL %>" method="post" name="fm" onSubmit='<%= "event.preventDefault(); " + renderResponse.getNamespace() + "saveConfiguration();" %>'>
	<aui:input name="preferences--backgroundColor--" type="hidden" value="<%= backgroundColor %>" />
	<aui:input name="preferences--borderColor--" type="hidden" value="<%= borderColor %>" />
	<aui:input name="preferences--borderRadius--" type="hidden" value="<%= borderRadius %>" />
	<aui:input name="preferences--borderEnabled--" type="hidden" value="<%= borderEnabled %>" />
	<aui:input name="preferences--borderStyle--" type="hidden" value="<%= borderStyle %>" />
	<aui:input name="preferences--borderWidth--" type="hidden" value="<%= borderWidth %>" />
	<aui:input name="preferences--characterSet--" type="hidden" value="<%= characterSet %>" />
	<aui:input name="preferences--content--" type="hidden" value="<%= HtmlUtil.escape(content) %>" />
	<aui:input name="preferences--dimension--" type="hidden"  value="<%= dimension %>" />
	<aui:input name="preferences--displayType--" type="hidden" value="<%= displayType %>" />
	<aui:input name="preferences--errorCorrection--" type="hidden" value="<%= errorCorrection %>" />
	<aui:input name="preferences--foregroundColor--" type="hidden"  value="<%= foregroundColor %>" />
	<aui:input name="preferences--imageFormat--" type="hidden"  value="<%= imageFormat %>" />
	<aui:input name="preferences--margin--" type="hidden"  value="<%= margin %>" />
	<aui:input name="preferences--mode--" type="hidden"  value="<%= mode %>" />
	<aui:input name="preferences--shadowAngle--" type="hidden"  value="<%= shadowAngle %>" />
	<aui:input name="preferences--shadowBlur--" type="hidden"  value="<%= shadowBlur %>" />
	<aui:input name="preferences--shadowColor--" type="hidden"  value="<%= shadowColor %>" />
	<aui:input name="preferences--shadowDistance--" type="hidden"  value="<%= shadowDistance %>" />
	<aui:input name="preferences--shadowEnabled--" type="hidden"  value="<%= shadowEnabled %>" />
	<aui:input name="preferences--shadowOpacity--" type="hidden"  value="<%= shadowOpacity %>" />
	<aui:input name="preferences--stripParams--" type="hidden"  value="<%= stripParams %>" />

	<liferay-ui:panel-container extended="<%= true %>" id="PanelContainer" persistState="<%= true %>">
		<liferay-ui:panel collapsible="<%= true %>" defaultState="open" extended="<%= true %>" id="preferences" persistState="<%= true %>" title="basic-setup">
			<aui:fieldset>
				<aui:select label="display-type" name="displayTypeField">
					<aui:option label="current-url" selected="<%= displayType == Constants.DISPLAY_TYPE_CURRENT_URL %>" value="<%= Constants.DISPLAY_TYPE_CURRENT_URL %>" />
					<aui:option label="custom-text" selected="<%= displayType == Constants.DISPLAY_TYPE_CUSTOM_TEXT %>" value="<%= Constants.DISPLAY_TYPE_CUSTOM_TEXT %>" />
					<aui:option label="portal-url" selected="<%= displayType == Constants.DISPLAY_TYPE_PORTAL_URL %>" value="<%= Constants.DISPLAY_TYPE_PORTAL_URL %>" />
				</aui:select>


				<aui:select helpMessage="image-format-help" label="image-format" name="imageFormatField">
					<aui:option label="gif" selected="<%= imageFormat.equals(Constants.IMAGE_FORMAT_GIF) %>" value="<%= Constants.IMAGE_FORMAT_GIF %>" />
					<aui:option label="jpeg" selected="<%= imageFormat.equals(Constants.IMAGE_FORMAT_JPG) %>" value="<%= Constants.IMAGE_FORMAT_JPG%>" />
					<aui:option label="png" selected="<%= imageFormat.equals(Constants.IMAGE_FORMAT_PNG) %>" value="<%= Constants.IMAGE_FORMAT_PNG %>" />
				</aui:select>

				<table>
					<tr>
						<td class="label">
							<liferay-ui:message key="foreground-color"></liferay-ui:message>:
						</td>
						<td>
							<div class="color-box" id="<portlet:namespace />foregroundColorField" style="background-color: <%= foregroundColor %>;"></div>
						</td>
						<td>
							<div id="<portlet:namespace />foregroundColorSelector"></div>
						</td>
					</tr>
					<tr>
						<td class="label">
							<liferay-ui:message key="background-color"></liferay-ui:message>:
						</td>
						<td>
							<div class="color-box" id="<portlet:namespace />backgroundColorField" style="background-color: <%= backgroundColor %>;"></div>
						</td>
						<td>
							<div id="<portlet:namespace />backgroundColorSelector"></div>
						</td>
					</tr>
				</table>

				<aui:input inputCssClass="aui-field-digits" label="margin" name="marginField" type="input" value="<%= margin %>" />

				<aui:select label="dimensions" name="dimensions">

					<%
						for (int size = 21; size <= 177; size +=4) {
							StringBundler sb = new StringBundler(4);
							sb.append(size);
							sb.append(" x ");
							sb.append(size);
							sb.append(" pixels");
					%>

					<aui:option label="<%= sb.toString() %>" selected="<%= dimension == size %>" value="<%= size %>" />

					<%
						}
					%>

				</aui:select>

				<aui:input checked="<%= stripParams %>"  disabled="<%= displayType != Constants.DISPLAY_TYPE_CURRENT_URL %>" helpMessage="strip-params-help" label="strip-params" name="stripParamsField" type="checkbox" />

				<%
					boolean disabled = ((displayType == Constants.DISPLAY_TYPE_CURRENT_URL) || (displayType == Constants.DISPLAY_TYPE_PORTAL_URL));
				%>

				<div class="contentDiv">
					<aui:input disabled="<%= disabled %>" helpMessage="content-length-help" label="custom-text" name="contentField" type="textarea" value="<%= HtmlUtil.escape(content) %>" />
				</div>
			</aui:fieldset>
		</liferay-ui:panel>
		<liferay-ui:panel collapsible="<%= true %>" defaultState="close" extended="<%= false %>" id="preferences" persistState="<%= true %>" title="image-decoration-setup">
			<aui:fieldset>
				<aui:input checked="<%= borderEnabled %>" helpMessage="border-setup-help" label="border-enabled" name="borderEnabledField" type="checkbox" />

				<aui:input helpMessage="border-radius-help" inputCssClass="aui-field-digits"  label="border-radius" name="borderRadiusField" type="text" value="<%= borderRadius %>" />

				<aui:input helpMessage="border-width-help" inputCssClass="aui-field-digits"  label="border-width" name="borderWidthField" type="text" value="<%= borderRadius %>" />

				<aui:select helpMessage="border-Style" label="border-style" name="borderStyleField">
					<aui:option label="<%= Constants.BORDER_STYLE_NONE.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_NONE) %>" value="<%= Constants.BORDER_STYLE_NONE %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_DASHED.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_DASHED) %>" value="<%= Constants.BORDER_STYLE_DASHED %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_DOTTED.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_DOTTED) %>" value="<%= Constants.BORDER_STYLE_DOTTED %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_DOUBLE.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_DOUBLE) %>" value="<%= Constants.BORDER_STYLE_DOUBLE %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_GROOVE.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_GROOVE) %>" value="<%= Constants.BORDER_STYLE_GROOVE %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_INSET.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_INSET) %>" value="<%= Constants.BORDER_STYLE_INSET %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_OUTSET.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_OUTSET) %>" value="<%= Constants.BORDER_STYLE_OUTSET %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_RIDGE.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_RIDGE) %>" value="<%= Constants.BORDER_STYLE_RIDGE %>" />
					<aui:option label="<%= Constants.BORDER_STYLE_SOLID.toLowerCase() %>" selected="<%= borderStyle.equals(Constants.BORDER_STYLE_SOLID) %>" value="<%= Constants.BORDER_STYLE_SOLID %>" />
				</aui:select>

				<table>
					<tr>
						<td class="label">
							<liferay-ui:message key="border-color"></liferay-ui:message>:
						</td>
						<td>
							<div class="color-box" id="<portlet:namespace />borderColorField" style="background-color: <%= borderColor %>;"></div>
						</td>
						<td>
							<div id="<portlet:namespace />borderColorSelector"></div>
						</td>
					</tr>
				</table>
				<hr />
				<aui:input checked="<%= shadowEnabled %>" label="shadow-enabled" name="shadowEnabledField" type="checkbox" />

				<aui:input label="shadow-angle" name="shadowAngleField" type="text" value="<%= shadowAngle %>" />

				<aui:input inputCssClass="aui-field-digits"  label="shadow-blur" name="shadowBlurField" type="text" value="<%= shadowBlur %>" />

				<aui:input inputCssClass="aui-field-digits"  label="shadow-distance" name="shadowDistanceField" type="text" value="<%= shadowDistance %>" />

				<aui:input iputCssClass="aui-field-number"  label="shadow-opacity" name="shadowOpacityField" type="text" value="<%= shadowOpacity %>" />

				<table>
					<tr>
						<td class="label">
							<liferay-ui:message key="shadow-color"></liferay-ui:message>:
						</td>
						<td>
							<div class="color-box" id="<portlet:namespace />shadowColorField" style="background-color: <%= shadowColor %>;"></div>
						</td>
						<td>
							<div id="<portlet:namespace />shadowColorSelector"></div>
						</td>
					</tr>
				</table>
			</aui:fieldset>
		</liferay-ui:panel>
		<liferay-ui:panel collapsible="<%= true %>" defaultState="close" extended="<%= false %>" id="preferences" persistState="<%= true %>" title="advanced-setup">
			<aui:fieldset>
				<aui:select helpMessage="characterset-help" label="characterset" name="characterSetField">

				<%
					Map<String, Charset> charSets = Charset.availableCharsets();
					for (String key : charSets.keySet()) {
						%>

							<aui:option label="<%= key.toLowerCase() %>" selected="<%= characterSet.equals(key) %>" value="<%= key %>" />

						<%
					}
				%>

				</aui:select>

				<aui:select helpMessage="mode-selector-help" label="mode-selector" name="modeField">
					<aui:option label="numeric-mode" selected="<%= mode == Constants.MODE_NUMERIC %>" value="<%= Constants.MODE_NUMERIC %>" />
					<aui:option label="alphanumeric-mode" selected="<%= mode == Constants.MODE_ALPHANUMERIC %>" value="<%= Constants.MODE_ALPHANUMERIC %>" />
					<aui:option label="byte-mode" selected="<%= mode == Constants.MODE_BYTE %>" value="<%= Constants.MODE_BYTE %>" />
					<aui:option label="kanji-mode" selected="<%= mode == Constants.MODE_KANJI %>" value="<%= Constants.MODE_KANJI %>" />
				</aui:select>

				<aui:select label="error-correction-level" name="errorCorrectionField">
					<aui:option label="low" selected="<%= errorCorrection == Constants.ERROR_CORRECTION_LOW %>" value="<%= Constants.ERROR_CORRECTION_LOW %>" />
					<aui:option label="medium" selected="<%= errorCorrection == Constants.ERROR_CORRECTION_MEDIUM %>" value="<%= Constants.ERROR_CORRECTION_MEDIUM %>" />
					<aui:option label="quartile" selected="<%= errorCorrection == Constants.ERROR_CORRECTION_QUARTILE %>" value="<%= Constants.ERROR_CORRECTION_QUARTILE %>" />
					<aui:option label="high" selected="<%= errorCorrection == Constants.ERROR_CORRECTION_HIGH %>" value="<%= Constants.ERROR_CORRECTION_HIGH %>" />
				</aui:select>
			</aui:fieldset>
		</liferay-ui:panel>
	</liferay-ui:panel-container>

	<aui:button-row>
		<aui:button type="submit" />
	</aui:button-row>
</aui:form>

<aui:script>
	var <portlet:namespace />formValidator;

	Liferay.provide(
		window,
		'<portlet:namespace />saveConfiguration',
		function() {
			var A = AUI();

			var backgroundColorField = A.one('#<portlet:namespace />backgroundColorField');
			var borderColorField = A.one('#<portlet:namespace />borderColorField');
			var borderRadiusField = A.one('#<portlet:namespace />borderRadiusField');
			var borderEnabledField = A.one('#<portlet:namespace />borderEnabledField');
			var borderStyleField = A.one('#<portlet:namespace />borderStyleField');
			var borderWidthField = A.one('#<portlet:namespace />borderWidthField');
			var characterSetField = A.one('#<portlet:namespace />characterSetField');
			var contentField = A.one('#<portlet:namespace />contentField');
			var dimensionsField = A.one('#<portlet:namespace />dimensions');
			var displayTypeField = A.one('#<portlet:namespace />displayTypeField');
			var errorCorrectionField = A.one('#<portlet:namespace />errorCorrectionField');
			var foregroundColorField = A.one('#<portlet:namespace />foregroundColorField');
			var imageFormatField = A.one('#<portlet:namespace />imageFormatField');
			var marginField = A.one('#<portlet:namespace />marginField');
			var modeField = A.one('#<portlet:namespace />modeField');
			var shadowAngleField = A.one('#<portlet:namespace />shadowAngleField');
			var shadowBlurField = A.one('#<portlet:namespace />shadowBlurField');
			var shadowColorField = A.one('#<portlet:namespace />shadowColorField');
			var shadowDistanceField = A.one('#<portlet:namespace />shadowDistanceField');
			var shadowEnabledField = A.one('#<portlet:namespace />shadowEnabledField');
			var shadowOpacityField = A.one('#<portlet:namespace />shadowOpacityField');
			var stripParamsField = A.one('#<portlet:namespace />stripParamsFieldCheckbox');

			if (contentField.attr('disabled')) {
				contentField.val('');
			}

			if (stripParamsField.attr('disabled')) {
				stripParamsField.val(false);
			}

			bgColor = backgroundColorField.getStyle('backgroundColor');
			boColor = borderColorField.getStyle('backgroundColor');
			fgColor = foregroundColorField.getStyle('backgroundColor');
			shColor = shadowColorField.getStyle('backgroundColor');

			document.<portlet:namespace />fm.<portlet:namespace />backgroundColor.value = A.Color.toHex(bgColor);
			document.<portlet:namespace />fm.<portlet:namespace />borderColor.value = A.Color.toHex(boColor);
			document.<portlet:namespace />fm.<portlet:namespace />borderRadius.value = borderRadiusField.val();
			document.<portlet:namespace />fm.<portlet:namespace />borderEnabled.value = borderEnabledField.val();
			document.<portlet:namespace />fm.<portlet:namespace />borderStyle.value = borderStyleField.val();
			document.<portlet:namespace />fm.<portlet:namespace />borderWidth.value = borderWidthField.val();
			document.<portlet:namespace />fm.<portlet:namespace />content.value = contentField.val();
			document.<portlet:namespace />fm.<portlet:namespace />characterSet.value = characterSetField.val();
			document.<portlet:namespace />fm.<portlet:namespace />dimension.value = dimensionsField.val();
			document.<portlet:namespace />fm.<portlet:namespace />displayType.value = displayTypeField.val();
			document.<portlet:namespace />fm.<portlet:namespace />errorCorrection.value = errorCorrectionField.val();
			document.<portlet:namespace />fm.<portlet:namespace />foregroundColor.value = A.Color.toHex(fgColor);
			document.<portlet:namespace />fm.<portlet:namespace />imageFormat.value = imageFormatField.val();
			document.<portlet:namespace />fm.<portlet:namespace />margin.value = marginField.val();
			document.<portlet:namespace />fm.<portlet:namespace />mode.value = modeField.val();
			document.<portlet:namespace />fm.<portlet:namespace />shadowAngle.value = shadowAngleField.val();
			document.<portlet:namespace />fm.<portlet:namespace />shadowBlur.value = shadowBlurField.val();
			document.<portlet:namespace />fm.<portlet:namespace />shadowColor.value = A.Color.toHex(shColor);
			document.<portlet:namespace />fm.<portlet:namespace />shadowDistance.value = shadowDistanceField.val();
			document.<portlet:namespace />fm.<portlet:namespace />shadowEnabled.value = shadowEnabledField.val();
			document.<portlet:namespace />fm.<portlet:namespace />shadowOpacity.value = shadowOpacityField.val();
			document.<portlet:namespace />fm.<portlet:namespace />stripParams.value = stripParamsField.val();

			<portlet:namespace/>formValidator.validate();

			if (!<portlet:namespace/>formValidator.hasErrors()) {
				submitForm(document.<portlet:namespace />fm);
			}
		}
	);

	

	AUI().ready('aui-color-picker-base', function(A) {
		var backgroundColorNode = A.one('#<portlet:namespace />backgroundColorField');

		window.backgroundColorPicker = new A.ColorPicker(
			{
				after: {
					colorChange: function(val) {
						var hex = '#' + this.get('hex');
						backgroundColorNode.setStyle('backgroundColor', hex);
					}
				}
			}
		)
		.render('#<portlet:namespace />backgroundColorSelector');

			var borderColorNode = A.one('#<portlet:namespace />borderColorField');

			window.borderColorPicker = new A.ColorPicker(
				{
					after: {
						colorChange: function(val) {
							var hex = '#' + this.get('hex');
							borderColorNode.setStyle('backgroundColor', hex);
						}
					}
				}
			)
			.render('#<portlet:namespace />borderColorSelector');

			var foregroundColorNode = A.one('#<portlet:namespace />foregroundColorField');

			window.foregroundColorPicker = new A.ColorPicker(
				{
					after: {
						colorChange: function(val) {
							var hex = '#' + this.get('hex');
							foregroundColorNode.setStyle('backgroundColor', hex);
						}
					}
				}
			)
			.render('#<portlet:namespace />foregroundColorSelector');

			var shadowColorNode = A.one('#<portlet:namespace />shadowColorField');

			window.shadowColorPicker = new A.ColorPicker(
				{
					after: {
						colorChange: function(val) {
							var hex = '#' + this.get('hex');
							shadowColorNode.setStyle('backgroundColor', hex);
						}
					}
				}
			)
			.render('#<portlet:namespace />shadowColorSelector');

		}
	);

	AUI().ready('aui-form-validator', function(A) {

		<portlet:namespace />formValidator = new A.FormValidator(
			{
				boundingBox: document.<portlet:namespace />fm,
				validateOnInput: true,
				rules : {
					<portlet:namespace />contentField:{
						required:<%= displayType == Constants.DISPLAY_TYPE_CUSTOM_TEXT %>
						<%
							if (displayType == Constants.DISPLAY_TYPE_CUSTOM_TEXT) {
							%>
								,maxLength:<portlet:namespace />getMaxLength()
							<%
							}
						%>
					},
					<portlet:namespace />borderRadiusField:{
						digits: true,
						min: 0,
						max: 100
					},
					<portlet:namespace />borderWidthField:{
						digits: true,
						min: 0,
						max: 360
					},
					<portlet:namespace />shadowAngleField:{
						digits: true,
						min: 0,
						max: 360
					},
					<portlet:namespace />shadowBlurField:{
						digits: true,
						min: 0,
						max: 100
					},
					<portlet:namespace />shadowDistanceField:{
						digits: true,
						min: 0,
						max: 100
					},
					<portlet:namespace />shadowOpacityField:{
						digits: true,
						min: 0,
						max: 100
					},
					
				}
			}
		);
		}
	);

	function <portlet:namespace />getMaxLength() {
		var A = AUI();

		var dimensionsField = A.one('#<portlet:namespace />dimensions');
		var displayTypeField = A.one('#<portlet:namespace />displayTypeField');
		var errorCorrectionField = A.one('#<portlet:namespace />errorCorrectionField');
		var modeField = A.one('#<portlet:namespace />modeField');

		if (displayTypeField.val() != <%= Constants.DISPLAY_TYPE_CUSTOM_TEXT %>) {
			return;
		}

		var dimension = "D" + dimensionsField.val() + "x" + dimensionsField.val();
		var errorCorrection = "";

		switch(errorCorrectionField.val()) {
			case '<%= Constants.ERROR_CORRECTION_LOW %>': errorCorrection = 'L';
				break;
			case '<%= Constants.ERROR_CORRECTION_MEDIUM %>': errorCorrection = 'M';
				break;
			case '<%= Constants.ERROR_CORRECTION_QUARTILE %>': errorCorrection = 'Q';
				break;
			case '<%= Constants.ERROR_CORRECTION_HIGH %>': errorCorrection = 'H';
				break;
		}

		var formatKey = dimension + errorCorrection;
		var format = formats[formatKey];

		var maxLength = 0;

		switch(modeField.val()) {
			case '<%= Constants.MODE_NUMERIC %>': maxLength = format['numeric'];
				break;
			case '<%= Constants.MODE_ALPHANUMERIC %>': maxLength = format['alphanumeric'];
				break;
			case '<%= Constants.MODE_BYTE %>': maxLength = format['byte'];
				break;
			case '<%= Constants.MODE_KANJI %>': maxLength = format['kanji'];
				break;
		}
		return maxLength;
	}

	function <portlet:namespace />updateContentFieldRule() {
		var A = AUI();

		var contentField = A.one('#<portlet:namespace />contentField')
		var modeField = A.one('#<portlet:namespace />modeField');

		var rule = {};

		if (!contentField.attr('disabled')) {
			rule.required = true;
			rule.maxLength = <portlet:namespace />getMaxLength();

			if(modeField.val() == '<%= Constants.MODE_NUMERIC %>') {
				rule.digits = true;
			}
		}

		<portlet:namespace/>formValidator.get('rules')['<portlet:namespace />contentField'] = rule;

		<portlet:namespace/>formValidator.validateField(contentField);

	}

	AUI().ready('aui-base', function(A) {
		A.one('#<portlet:namespace />dimensions').on(
			'change',
			function() {
				<portlet:namespace />updateContentFieldRule();
			}
		);

		A.one('#<portlet:namespace />displayTypeField').on(
			'change',
			function() {
				var disabled = true;

				if (this.val() == <%= Constants.DISPLAY_TYPE_CUSTOM_TEXT %>) {
					disabled = false;
				}

				A.one('#<portlet:namespace />contentField').attr('disabled', disabled);

				A.one('#<portlet:namespace />stripParamsFieldCheckbox').attr('disabled', !disabled);

				<portlet:namespace />updateContentFieldRule();
			}
		);

		A.one('#<portlet:namespace />errorCorrectionField').on(
			'change',
			function() {
				<portlet:namespace />updateContentFieldRule();
			}
		);

		A.one('#<portlet:namespace />modeField').on(
			'change',
			function() {
				<portlet:namespace />updateContentFieldRule();
			}
		);
	});


</aui:script>