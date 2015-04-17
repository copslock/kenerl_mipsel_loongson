Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 07:30:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60689 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009610AbbDQFaJYNhkZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 07:30:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 21A7A5CEB52FD;
        Fri, 17 Apr 2015 06:30:04 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 17 Apr
 2015 06:30:04 +0100
Received: from [10.100.200.190] (10.100.200.190) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 17 Apr
 2015 06:30:04 +0100
Message-ID: <553099AF.3060108@imgtec.com>
Date:   Fri, 17 Apr 2015 02:27:11 -0300
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
X-Originating-IP: [10.100.200.190]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46873
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


Hi Andrew,

On 04/07/2015 04:44 PM, Andrew Bresticker wrote:
[..]
> +static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
> +{
> +	struct device_node *node = pctl->dev->of_node;
> +	struct pistachio_gpio_bank *bank;
> +	unsigned int i;
> +	int irq, ret = 0;
> +
> +	for (i = 0; i < pctl->nbanks; i++) {
> +		char child_name[sizeof("gpioXX")];
> +		struct device_node *child;

The first submission used for_each_child_of_node, and I can't find
any review comments explaining why you've changed it to a regular for
loop.

> +
> +		snprintf(child_name, sizeof(child_name), "gpio%d", i);

This assumes the GPIO bank nodes are called gpio0, gpio1, ... and so on.
Do we really want to assume that?

Thanks,
-- 
Ezequiel
