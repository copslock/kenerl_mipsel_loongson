Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 23:12:52 +0100 (CET)
Received: from mail-ea0-f175.google.com ([209.85.215.175]:59848 "EHLO
        mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833504Ab3A1WMvk1yj3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 23:12:51 +0100
Received: by mail-ea0-f175.google.com with SMTP id d1so1351645eab.20
        for <multiple recipients>; Mon, 28 Jan 2013 14:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VEFYhVH4vcoEkqUagB6QgP2GC2pMrOhIlw2+VTxq8YU=;
        b=jM/xSFn9w/9NnuaVSdyAkdRfNQSNmGCPwXtVN3zTQAgNrWI3LdUAfmUbn85MHziV8R
         wCZusKYhiJrL8D++GzKsSAruaFgahqqfRtfcXV9p9L5pz4ZsDRjk71AszXqlpVOSQed5
         0PEvd9p3amETtP5EViC512s4bhORjqSgARQ0lGUP9KQUpc3h4ED5si3ebm3p0VG+Nq3o
         iYdUri46Ng/nAAuaFYq1xtsryYrqK1e8DAdz/ZOza9avgwok7xE4i64RFdjP7wEuoFZH
         WcU9hBkciGzMO1n/ge+UMna3FvIHaWugaPOnYWGjN2tGUf5/lP9puqxAodzT52lDAbC2
         Gddw==
X-Received: by 10.14.213.67 with SMTP id z43mr28748477eeo.18.1359411166281;
        Mon, 28 Jan 2013 14:12:46 -0800 (PST)
Received: from ?IPv6:2a01:e35:2f70:4010:35d5:81d6:16e5:f24e? ([2a01:e35:2f70:4010:35d5:81d6:16e5:f24e])
        by mx.google.com with ESMTPS id f6sm17744518eeo.7.2013.01.28.14.12.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 14:12:45 -0800 (PST)
Message-ID: <5106F7DC.1040307@openwrt.org>
Date:   Mon, 28 Jan 2013 23:12:44 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] MIPS: add irqdomain support for the CPU IRQ controller
References: <1359410344-19737-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359410344-19737-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Le 28/01/2013 22:59, John Crispin a écrit :
> From: Gabor Juhos <juhosg@openwrt.org>
>
> Adds an irqdomain wrapper for the cpu irq controller that can be passed inside
> the of_device_id to of_irq_init().
>
> A device_node inside a dts file would look as such.
>
> cpuintc: cpuintc@0 {
> 	#address-cells = <0>;
> 	#interrupt-cells = <1>;
> 	interrupt-controller;
> 	compatible = "mti,cpu-intc";
> };

Please use this as an actual device tree documentation binding.

>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/include/asm/irq_cpu.h |    6 ++++++
>   arch/mips/kernel/irq_cpu.c      |   42 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
>
> diff --git a/arch/mips/include/asm/irq_cpu.h b/arch/mips/include/asm/irq_cpu.h
> index ef6a07c..3f11fdb 100644
> --- a/arch/mips/include/asm/irq_cpu.h
> +++ b/arch/mips/include/asm/irq_cpu.h
> @@ -17,4 +17,10 @@ extern void mips_cpu_irq_init(void);
>   extern void rm7k_cpu_irq_init(void);
>   extern void rm9k_cpu_irq_init(void);
>
> +#ifdef CONFIG_IRQ_DOMAIN
> +struct device_node;
> +extern int mips_cpu_intc_init(struct device_node *of_node,
> +			      struct device_node *parent);
> +#endif
> +
>   #endif /* _ASM_IRQ_CPU_H */
> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
> index 972263b..49bc9ca 100644
> --- a/arch/mips/kernel/irq_cpu.c
> +++ b/arch/mips/kernel/irq_cpu.c
> @@ -31,6 +31,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/kernel.h>
>   #include <linux/irq.h>
> +#include <linux/irqdomain.h>
>
>   #include <asm/irq_cpu.h>
>   #include <asm/mipsregs.h>
> @@ -113,3 +114,44 @@ void __init mips_cpu_irq_init(void)
>   		irq_set_chip_and_handler(i, &mips_cpu_irq_controller,
>   					 handle_percpu_irq);
>   }
> +
> +#ifdef CONFIG_IRQ_DOMAIN
> +static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
> +			     irq_hw_number_t hw)
> +{
> +	static struct irq_chip *chip;
> +
> +	if (hw < 2 && cpu_has_mipsmt) {
> +		/* Software interrupts are used for MT/CMT IPI */
> +		chip = &mips_mt_cpu_irq_controller;
> +	} else {
> +		chip = &mips_cpu_irq_controller;
> +	}
> +
> +	irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops mips_cpu_intc_irq_domain_ops = {
> +	.map = mips_cpu_intc_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +int __init mips_cpu_intc_init(struct device_node *of_node,
> +			      struct device_node *parent)
> +{
> +	struct irq_domain *domain;
> +
> +	/* Mask interrupts. */
> +	clear_c0_status(ST0_IM);
> +	clear_c0_cause(CAUSEF_IP);
> +
> +	domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
> +				       &mips_cpu_intc_irq_domain_ops, NULL);
> +	if (!domain)
> +		panic("Failed to add irqdomain for MIPS CPU\n");
> +
> +	return 0;
> +}
> +#endif /* CONFIG_IRQ_DOMAIN */
>
