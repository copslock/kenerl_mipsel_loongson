Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2015 19:26:30 +0100 (CET)
Received: from smtp-out-084.synserver.de ([212.40.185.84]:1057 "EHLO
        smtp-out-084.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011162AbbAYS01nCPuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Jan 2015 19:26:27 +0100
Received: (qmail 10134 invoked by uid 0); 25 Jan 2015 18:26:27 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 10048
Received: from ppp-188-174-121-24.dynamic.mnet-online.de (HELO ?192.168.178.21?) [188.174.121.24]
  by 217.119.54.73 with AES256-SHA encrypted SMTP; 25 Jan 2015 18:26:26 -0000
Message-ID: <54C535CB.2030304@metafoo.de>
Date:   Sun, 25 Jan 2015 19:28:27 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 23/36] MIPS: jz4740: define IRQ numbers based on number
 of intc IRQs
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com> <1421620846-24917-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1421620846-24917-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 01/18/2015 11:40 PM, Paul Burton wrote:
> For interrupts numbered after those of the interrupt controller, define
> their numbers based upon the number of interrupts provided by the SoC
> interrupt controller. This is in preparation for supporting later jz47xx
> series SoCs which provide more interrupts.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   arch/mips/include/asm/mach-jz4740/irq.h | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
> index df50736..b218f76 100644
> --- a/arch/mips/include/asm/mach-jz4740/irq.h
> +++ b/arch/mips/include/asm/mach-jz4740/irq.h
> @@ -19,6 +19,10 @@
>   #define MIPS_CPU_IRQ_BASE 0
>   #define JZ4740_IRQ_BASE 8
>
> +#ifdef CONFIG_MACH_JZ4740
> +# define NR_INTC_IRQS	32
> +#endif
> +
>   /* 1st-level interrupts */
>   #define JZ4740_IRQ(x)		(JZ4740_IRQ_BASE + (x))
>   #define JZ4740_IRQ_I2C		JZ4740_IRQ(1)
> @@ -45,12 +49,12 @@
>   #define JZ4740_IRQ_LCD		JZ4740_IRQ(30)
>
>   /* 2nd-level interrupts */
> -#define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(32) + (x))
> +#define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(NR_INTC_IRQS) + (x))

Looking at things JZ4740_IRQ_DMA() doesn't seem to be used, so we could just 
remove it.

>
>   #define JZ4740_IRQ_INTC_GPIO(x) (JZ4740_IRQ_GPIO0 - (x))
> -#define JZ4740_IRQ_GPIO(x)	(JZ4740_IRQ(48) + (x))
> +#define JZ4740_IRQ_GPIO(x)	(JZ4740_IRQ(NR_INTC_IRQS + 16) + (x))
>
> -#define JZ4740_IRQ_ADC_BASE	JZ4740_IRQ(176)
> +#define JZ4740_IRQ_ADC_BASE	JZ4740_IRQ(NR_INTC_IRQS + 144)

These other two should be updated to properly use IRQ domains. I think the ADC 
should be trivial. The GPIOs though might be not so easy.
