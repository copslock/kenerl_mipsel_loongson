Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 00:44:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8472 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011923AbbD1WoELADnD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 00:44:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D568D4E345051;
        Tue, 28 Apr 2015 23:43:55 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 28 Apr
 2015 23:43:59 +0100
Received: from [10.100.200.184] (10.100.200.184) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 28 Apr
 2015 23:43:59 +0100
Message-ID: <55400C75.9070609@imgtec.com>
Date:   Tue, 28 Apr 2015 19:40:53 -0300
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Damien Horsley" <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        "Paul Bolle" <pebolle@tiscali.nl>
Subject: Re: [PATCH V3 2/2] pinctrl: Add Pistachio SoC pin control driver
References: <1428435862-14354-1-git-send-email-abrestic@chromium.org> <1428435862-14354-3-git-send-email-abrestic@chromium.org>
In-Reply-To: <1428435862-14354-3-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.184]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Just a silly comment.

On 04/07/2015 04:44 PM, Andrew Bresticker wrote:
[..]
> +
> +static const struct pinmux_ops pistachio_pinmux_ops = {
> +	.get_functions_count = pistachio_pinmux_get_functions_count,
> +	.get_function_name = pistachio_pinmux_get_function_name,
> +	.get_function_groups = pistachio_pinmux_get_function_groups,
> +	.set_mux = pistachio_pinmux_enable,
> +};
> +
> +static int pistachio_pinconf_get(struct pinctrl_dev *pctldev, unsigned pin,
> +				 unsigned long *config)
> +{
> +	struct pistachio_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	u32 val, arg;
> +
> +	switch (param) {
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		val = pctl_readl(pctl, PADS_SCHMITT_EN_REG(pin));
> +		arg = !!(val & PADS_SCHMITT_EN_BIT(pin));
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
> +			PADS_PU_PD_SHIFT(pin);
> +		arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_HIGHZ;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
> +			PADS_PU_PD_SHIFT(pin);
> +		arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_UP;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
> +			PADS_PU_PD_SHIFT(pin);
> +		arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
> +			PADS_PU_PD_SHIFT(pin);
> +		arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_BUS;
> +		break;
> +	case PIN_CONFIG_SLEW_RATE:
> +		val = pctl_readl(pctl, PADS_SLEW_RATE_REG(pin));
> +		arg = !!(val & PADS_SLEW_RATE_BIT(pin));
> +		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		val = pctl_readl(pctl, PADS_DRIVE_STRENGTH_REG(pin)) >>
> +			PADS_DRIVE_STRENGTH_SHIFT(pin);
> +		switch (val & PADS_DRIVE_STRENGTH_MASK) {
> +		case PADS_DRIVE_STRENGTH_2MA:
> +			arg = 2;
> +			break;
> +		case PADS_DRIVE_STRENGTH_4MA:
> +			arg = 4;
> +			break;
> +		case PADS_DRIVE_STRENGTH_8MA:
> +			arg = 8;
> +			break;
> +		case PADS_DRIVE_STRENGTH_12MA:
> +		default:
> +			arg = 12;
> +			break;
> +		}
> +		break;
> +	default:
> +		dev_err(pctl->dev, "Property %u not supported\n", param);

Probably just a nitpick, but maybe this should be dev_dbg. Otherwise,
we'll get a ton of these errors when cat'ing pinconf-pins in debugfs.

> +		return -EINVAL;

And this should be -ENOTSUPP. I guess it doesn't matter much.

-- 
Ezequiel
