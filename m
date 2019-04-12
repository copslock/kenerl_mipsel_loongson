Return-Path: <SRS0=LuVy=SO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121F9C10F14
	for <linux-mips@archiver.kernel.org>; Fri, 12 Apr 2019 21:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF3E2171F
	for <linux-mips@archiver.kernel.org>; Fri, 12 Apr 2019 21:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDLVQo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:16:44 -0400
Received: from nbd.name ([46.4.11.11]:40000 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfDLVQo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 12 Apr 2019 17:16:44 -0400
Received: from p548c8d43.dip0.t-ipconnect.de ([84.140.141.67] helo=[192.168.45.69])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hF3XJ-0002jf-SZ; Fri, 12 Apr 2019 23:16:37 +0200
Subject: Re: [PATCH v2] MIPS: perf: ath79: Fix perfcount IRQ assignment
To:     =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        linux-mips@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <1555006009-5764-1-git-send-email-ynezz@true.cz>
 <1555103312-28232-1-git-send-email-ynezz@true.cz>
From:   John Crispin <john@phrozen.org>
Message-ID: <2b51e5ce-060b-0a47-0b1b-8bbb714faaf9@phrozen.org>
Date:   Fri, 12 Apr 2019 23:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555103312-28232-1-git-send-email-ynezz@true.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 12/04/2019 23:08, Petr Štetiar wrote:
> Currently it's not possible to use perf on ath79 due to genirq flags
> mismatch happening on static virtual IRQ 13 which is used for
> performance counters hardware IRQ 5.
>
> On TP-Link Archer C7v5:
>
>             CPU0
>    2:          0      MIPS   2  ath9k
>    4:        318      MIPS   4  19000000.eth
>    7:      55034      MIPS   7  timer
>    8:       1236      MISC   3  ttyS0
>   12:          0      INTC   1  ehci_hcd:usb1
>   13:          0  gpio-ath79   2  keys
>   14:          0  gpio-ath79   5  keys
>   15:         31  AR724X PCI    1  ath10k_pci
>
>   $ perf top
>   genirq: Flags mismatch irq 13. 00014c83 (mips_perf_pmu) vs. 00002003 (keys)
>
> On TP-Link Archer C7v4:
>
>           CPU0
>    4:          0      MIPS   4  19000000.eth
>    5:       7135      MIPS   5  1a000000.eth
>    7:      98379      MIPS   7  timer
>    8:         30      MISC   3  ttyS0
>   12:      90028      INTC   0  ath9k
>   13:       5520      INTC   1  ehci_hcd:usb1
>   14:       4623      INTC   2  ehci_hcd:usb2
>   15:      32844  AR724X PCI    1  ath10k_pci
>   16:          0  gpio-ath79  16  keys
>   23:          0  gpio-ath79  23  keys
>
>   $ perf top
>   genirq: Flags mismatch irq 13. 00014c80 (mips_perf_pmu) vs. 00000080 (ehci_hcd:usb1)
>
> This problem is happening, because currently statically assigned virtual
> IRQ 13 for performance counters is not claimed during the initialization
> of MIPS PMU during the bootup, so the IRQ subsystem doesn't know, that
> this interrupt isn't available for further use.
>
> So this patch fixes the issue by simply booking hardware IRQ 5 for MIPS PMU.
>
> Tested-by: Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
> Signed-off-by: Petr Štetiar <ynezz@true.cz>

Thanks for the fast turn around

Acked-by: John Crispin <john@phrozen.org>


> ---
>
> Changes since v1:
>
>   I've incorporated two comments which I've received on IRC from blogic and
>   I've also reworded the commit message to match the changes in v2 of this
>   patch.
>
>    * use actual hardware perfcount IRQ 5 instead of the virtual IRQ 13
>    * dropped the CONFIG_PERF_EVENTS ifdef around irq_create_mapping
>
>   arch/mips/ath79/setup.c          |  6 ------
>   drivers/irqchip/irq-ath79-misc.c | 11 +++++++++++
>   2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
> index 4a70c5d..25a5789 100644
> --- a/arch/mips/ath79/setup.c
> +++ b/arch/mips/ath79/setup.c
> @@ -210,12 +210,6 @@ const char *get_system_type(void)
>   	return ath79_sys_type;
>   }
>   
> -int get_c0_perfcount_int(void)
> -{
> -	return ATH79_MISC_IRQ(5);
> -}
> -EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
> -
>   unsigned int get_c0_compare_int(void)
>   {
>   	return CP0_LEGACY_COMPARE_IRQ;
> diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
> index aa72907..0390603 100644
> --- a/drivers/irqchip/irq-ath79-misc.c
> +++ b/drivers/irqchip/irq-ath79-misc.c
> @@ -22,6 +22,15 @@
>   #define AR71XX_RESET_REG_MISC_INT_ENABLE	4
>   
>   #define ATH79_MISC_IRQ_COUNT			32
> +#define ATH79_MISC_PERF_IRQ			5
> +
> +static int ath79_perfcount_irq;
> +
> +int get_c0_perfcount_int(void)
> +{
> +	return ath79_perfcount_irq;
> +}
> +EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
>   
>   static void ath79_misc_irq_handler(struct irq_desc *desc)
>   {
> @@ -113,6 +122,8 @@ static void __init ath79_misc_intc_domain_init(
>   {
>   	void __iomem *base = domain->host_data;
>   
> +	ath79_perfcount_irq = irq_create_mapping(domain, ATH79_MISC_PERF_IRQ);
> +
>   	/* Disable and clear all interrupts */
>   	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
>   	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
