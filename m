Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 18:35:57 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42233 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835081Ab3DLQfY0jzj8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 18:35:24 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iZETbEJ19dGV; Fri, 12 Apr 2013 18:34:34 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 122EF280520;
        Fri, 12 Apr 2013 18:34:32 +0200 (CEST)
Message-ID: <516837E4.4060206@openwrt.org>
Date:   Fri, 12 Apr 2013 18:35:48 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 15/16] MIPS: ralink: add support for periodic timer
 irq
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-15-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365751663-5725-15-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.12. 9:27 keltezéssel, John Crispin írta:
> Adds a driver for the periodic timer found on Ralink SoC.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/Makefile |    2 +-
>  arch/mips/ralink/timer.c  |  193 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 194 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/ralink/timer.c
> 
> diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
> index 38cf1a8..e37e0ec 100644
> --- a/arch/mips/ralink/Makefile
> +++ b/arch/mips/ralink/Makefile
> @@ -6,7 +6,7 @@
>  # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
>  # Copyright (C) 2013 John Crispin <blogic@openwrt.org>
>  
> -obj-y := prom.o of.o reset.o clk.o irq.o
> +obj-y := prom.o of.o reset.o clk.o irq.o timer.o
>  
>  obj-$(CONFIG_SOC_RT288X) += rt288x.o
>  obj-$(CONFIG_SOC_RT305X) += rt305x.o
> diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c

<...>

> +static void rt_timer_disable(struct rt_timer *rt)
> +{
> +	u32 t;
> +
> +	t = rt_timer_r32(rt, TIMER_REG_TMR0CTL);
> +	t &= ~TMR0CTL_ENABLE;
> +	rt_timer_w32(rt, TIMER_REG_TMR0CTL, t);
> +}
> +
> +static int rt_timer_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct rt_timer *rt;
> +	struct clk *clk;
> +
> +	if (!res) {
> +		dev_err(&pdev->dev, "no memory resource found\n");
> +		return -EINVAL;
> +	}
> +
> +	rt = devm_kzalloc(&pdev->dev, sizeof(*rt), GFP_KERNEL);
> +	if (!rt) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	rt->irq = platform_get_irq(pdev, 0);
> +	if (!rt->irq) {
> +		dev_err(&pdev->dev, "failed to load irq\n");
> +		return -ENOENT;
> +	}
> +
> +	rt->membase = devm_ioremap_resource(&pdev->dev, res);
> +	if (!rt->membase) {

If devm_ioremap_resource fails, it returns with ERR_PTR thus you should use
IS_ERR(rt->membase) here ...


> +		dev_err(&pdev->dev, "failed to ioremap\n");
> +		return -ENOMEM;

... and 'return PRT_ERR(rt->membase)' here.

> +	}

Also devm_ioremap_resource() provides its own error messages so the
message can be removed.

IIRC, you have fixed this already in one of your internal trees but it seems
that you forgot to fold that fix into this patch.

-Gabor
