Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 10:10:25 +0200 (CEST)
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:59400 "EHLO
        lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006802AbbCaIKYfyxuB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 10:10:24 +0200
Received: from [192.168.10.109] ([83.160.161.190])
        by smtp-cloud3.xs4all.net with ESMTP
        id A8AF1q00546mmVf018AG9e; Tue, 31 Mar 2015 10:10:18 +0200
Message-ID: <1427789415.2408.45.camel@x220>
Subject: Re: [PATCH V2 3/3] pinctrl: Add Pistachio SoC pin control driver
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>
Date:   Tue, 31 Mar 2015 10:10:15 +0200
In-Reply-To: <1427757416-14491-4-git-send-email-abrestic@chromium.org>
References: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
         <1427757416-14491-4-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

The patch adds a mismatch between the Kconfig symbol (a bool) and the
code (which suggests that a modular build is also possible).

On Mon, 2015-03-30 at 16:16 -0700, Andrew Bresticker wrote:
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig

> +config PINCTRL_PISTACHIO
> +	def_bool y if MACH_PISTACHIO

This adds a bool symbol.

> +	select PINMUX
> +	select GENERIC_PINCONF
> +	select GPIOLIB_IRQCHIP

> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile

> +obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o

So pinctrl-pistachio.o will never be part of a module.

> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-pistachio.c

> +#include <linux/module.h>

Chances are this include is not needed.

> +static struct pinctrl_desc pistachio_pinctrl_desc = {
> +	.name = "pistachio-pinctrl",
> +	.pctlops = &pistachio_pinctrl_ops,
> +	.pmxops = &pistachio_pinmux_ops,
> +	.confops = &pistachio_pinconf_ops,
> +	.owner = THIS_MODULE,

According to include/linux/export.h THIS_MODULE is equivalent to NULL,
so this can probably be dropped.

> +};

> +#define GPIO_BANK(_bank, _pin_base, _npins)				\
> +	{								\
> +		.gpio_chip = {						\
> +			.label = "GPIO" #_bank,				\
> +			.request = pistachio_gpio_request,		\
> +			.free = pistachio_gpio_free,			\
> +			.get_direction = pistachio_gpio_get_direction,	\
> +			.direction_input = pistachio_gpio_direction_input, \
> +			.direction_output = pistachio_gpio_direction_output, \
> +			.get = pistachio_gpio_get,			\
> +			.set = pistachio_gpio_set,			\
> +			.base = _pin_base,				\
> +			.ngpio = _npins,				\
> +			.owner = THIS_MODULE,				\

Ditto.

> +		},							\
> +		.irq_chip = {						\
> +			.name = "GPIO" #_bank,				\
> +			.irq_startup = pistachio_gpio_irq_startup,	\
> +			.irq_ack = pistachio_gpio_irq_ack,		\
> +			.irq_mask = pistachio_gpio_irq_mask,		\
> +			.irq_unmask = pistachio_gpio_irq_unmask,	\
> +			.irq_set_type = pistachio_gpio_irq_set_type,	\
> +		},							\
> +		.gpio_range = {						\
> +			.name = "GPIO" #_bank,				\
> +			.id = _bank,					\
> +			.base = _pin_base,				\
> +			.pin_base = _pin_base,				\
> +			.npins = _npins,				\
> +		},							\
> +	}

> +MODULE_DEVICE_TABLE(of, pistachio_pinctrl_of_match);

According to include/linux/module.h this will be preprocessed away.

> +module_platform_driver(pistachio_pinctrl_driver);

This seems to be equivalent to adding a wrapper that does
    platform_driver_register(&pistachio_pinctrl_driver);

and marking that wrapper with device_initcall(). I don't think there's
one line macro to do that.

> +MODULE_AUTHOR("Andrew Bresticker <abrestic@chromium.org>");
> +MODULE_AUTHOR("Damien Horsley <Damien.Horsley@imgtec.com>");
> +MODULE_DESCRIPTION("Pistachio pinctrl driver");
> +MODULE_LICENSE("GPL v2");

These macros will (basically) be preprocessed away.


Paul Bolle
