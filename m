Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2011 15:20:11 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32823 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901346Ab1J0NUH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Oct 2011 15:20:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=VfDR3bbU/hgftCb03ICQ7NmLat6BM8tWKej5XnFx7MQ=;
        b=WwTyXwykuXfl0/EttyKhLX9wARAVZPY+CVcRVO3OTZfOiVM6SNDGUw+99QnINz1MkesQk8JMYorCJUhjQ1buc/dOaOy4AVIDamliMTYDWwEzDf3uBSkZjUSWIdcT+pTB3jC8mlbY6LsaomPIhBWdMLUz8tEap+CihtqdmPwV+vE=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:59756)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1RJPjy-0006On-TU; Thu, 27 Oct 2011 14:11:27 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1RJPjx-000473-2r; Thu, 27 Oct 2011 14:11:25 +0100
Date:   Thu, 27 Oct 2011 14:11:24 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jonas Bonn <jonas@southpole.se>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linux@lists.openrisc.net, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
Message-ID: <20111027131124.GK19187@n2100.arm.linux.org.uk>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1319720503-3183-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1319720503-3183-1-git-send-email-vapier@gentoo.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 31309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19724

On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index d494001..622851c 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -170,6 +170,29 @@ extern int __gpio_cansleep(unsigned gpio);
>  
>  extern int __gpio_to_irq(unsigned gpio);
>  
> +#ifndef gpio_get_value
> +#define gpio_get_value(gpio) __gpio_get_value(gpio)
> +#endif
> +
> +#ifndef gpio_set_value
> +#define gpio_set_value(gpio, value) __gpio_set_value(gpio, value)
> +#endif
> +
> +#ifndef gpio_cansleep
> +#define gpio_cansleep(gpio) __gpio_cansleep(gpio)
> +#endif
> +
> +#ifndef gpio_to_irq
> +#define gpio_to_irq(gpio) __gpio_to_irq(gpio)
> +#endif
> +
> +#ifndef irq_to_gpio
> +static inline int irq_to_gpio(unsigned int irq)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +

This is extremely dangerous.  Consider for example this code
(see ARM mach-davinci's gpio.h):

#include <asm-generic/gpio.h>

static inline int gpio_get_value(unsigned gpio)
{
        struct davinci_gpio_controller *ctlr;

        if (!__builtin_constant_p(gpio) || gpio >= davinci_soc_info.gpio_num)
                return __gpio_get_value(gpio);

        ctlr = __gpio_to_controller(gpio);
        return __gpio_mask(gpio) & __raw_readl(ctlr->in_data);
}

The result with your changes above will be:

static inline int __gpio_get_value(unsigned gpio)
{
        struct davinci_gpio_controller *ctlr;

        if (!__builtin_constant_p(gpio) || gpio >= davinci_soc_info.gpio_num)
                return __gpio_get_value(gpio);

        ctlr = __gpio_to_controller(gpio);
        return __gpio_mask(gpio) & __raw_readl(ctlr->in_data);
}

and notice the recursive call there.

This is why I didn't solve this using the preprocessor method in ARM, but
instead used __ARM_GPIOLIB_COMPLEX to control whether these definitions
are required.
