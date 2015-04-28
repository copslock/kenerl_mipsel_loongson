Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 01:27:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27623 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011923AbbD1X13WEj82 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 01:27:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 730FD8BBC1839;
        Wed, 29 Apr 2015 00:27:21 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 29 Apr
 2015 00:27:25 +0100
Received: from [10.100.200.184] (10.100.200.184) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Wed, 29 Apr
 2015 00:27:24 +0100
Message-ID: <554016A5.7040209@imgtec.com>
Date:   Tue, 28 Apr 2015 20:24:21 -0300
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
X-archive-position: 47144
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

Andrew,

On 04/07/2015 04:44 PM, Andrew Bresticker wrote:
[..]
> +static int pistachio_pinmux_enable(struct pinctrl_dev *pctldev,
> +				   unsigned func, unsigned group)
> +{
> +	struct pistachio_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +	const struct pistachio_pin_group *pg = &pctl->groups[group];
> +	const struct pistachio_function *pf = &pctl->functions[func];
> +	struct pinctrl_gpio_range *range;
> +	unsigned int i;
> +	u32 val;
> +
> +	if (pg->mux_reg > 0) {
> +		for (i = 0; i < ARRAY_SIZE(pg->mux_option); i++) {
> +			if (pg->mux_option[i] == func)
> +				break;
> +		}
> +		if (i == ARRAY_SIZE(pg->mux_option)) {
> +			dev_err(pctl->dev, "Cannot mux pin %u to function %u\n",
> +				group, func);
> +			return -EINVAL;
> +		}
> +
> +		val = pctl_readl(pctl, pg->mux_reg);
> +		val &= ~(pg->mux_mask << pg->mux_shift);
> +		val |= i << pg->mux_shift;
> +		pctl_writel(pctl, val, pg->mux_reg);
> +
> +		if (pf->scenarios) {
> +			for (i = 0; i < pf->nscenarios; i++) {
> +				if (pf->scenarios[i] == group)
> +					break;
> +			}
> +			if (WARN_ON(i == pf->nscenarios))
> +				return -EINVAL;
> +
> +			val = pctl_readl(pctl, pf->scenario_reg);
> +			val &= ~(pf->scenario_mask << pf->scenario_shift);
> +			val |= i << pf->scenario_shift;
> +			pctl_writel(pctl, val, pf->scenario_reg);
> +		}
> +	}
> +
> +	range = pinctrl_find_gpio_range_from_pin(pctl->pctldev, group);
> +	if (range)
> +		gpio_disable(gc_to_bank(range->gc), group - range->pin_base);
> +

If you plan to submit a v4, how about using "pg->pins" here instead of "group"?

Using "group" relies on having the same numberspace for the group and the pin,
and it'll break when introducing the RPU pinctrl.

Thanks!
-- 
Ezequiel
