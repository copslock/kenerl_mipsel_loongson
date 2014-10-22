Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 11:33:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23469 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011331AbaJVJdwlombu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 11:33:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C32F095415C4E;
        Wed, 22 Oct 2014 10:33:43 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Oct 2014 10:33:45 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 10:33:45 +0100
Message-ID: <544779F8.2040505@imgtec.com>
Date:   Wed, 22 Oct 2014 10:33:44 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Paul Burton <paul.burton@imgtec.com>,
        "John Crispin" <blogic@openwrt.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/19] MIPS: sead3: Stop using GIC REG macros
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org> <1413831846-32100-4-git-send-email-abrestic@chromium.org>
In-Reply-To: <1413831846-32100-4-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 10/20/2014 08:03 PM, Andrew Bresticker wrote:
> Stop using the REG macros from gic.h and instead use proper iomem
> accessors.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>   arch/mips/mti-sead3/sead3-int.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
> index 69ae185..995c401 100644
> --- a/arch/mips/mti-sead3/sead3-int.c
> +++ b/arch/mips/mti-sead3/sead3-int.c
> @@ -20,16 +20,15 @@
>   #define SEAD_CONFIG_BASE		0x1b100110
>   #define SEAD_CONFIG_SIZE		4
>   
> -static unsigned long sead3_config_reg;
> +static void __iomem *sead3_config_reg;
>   
>   void __init arch_init_irq(void)
>   {
>   	if (!cpu_has_veic)
>   		mips_cpu_irq_init();
>   
> -	sead3_config_reg = (unsigned long)ioremap_nocache(SEAD_CONFIG_BASE,
> -		SEAD_CONFIG_SIZE);
> -	gic_present = (REG32(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
> +	sead3_config_reg = ioremap_nocache(SEAD_CONFIG_BASE, SEAD_CONFIG_SIZE);
> +	gic_present = (readl(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
>   		SEAD_CONFIG_GIC_PRESENT_SHF;
>   	pr_info("GIC: %spresent\n", (gic_present) ? "" : "not ");
>   	pr_info("EIC: %s\n",

I think you need to use the __raw_readl() variant here and for all other 
similar changes.

Qais
