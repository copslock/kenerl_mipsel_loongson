Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 08:54:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59710 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029837AbcERGyPu-6HY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 08:54:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id D0EC36F474A45;
        Wed, 18 May 2016 07:54:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 07:54:09 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 18 May
 2016 07:54:09 +0100
Subject: Re: [PATCH 3/3] irqchip: mips-gic: Setup EIC mode on each CPU if it's
 in use
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
References: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
 <1463495466-29689-4-git-send-email-paul.burton@imgtec.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <573C1191.80707@imgtec.com>
Date:   Wed, 18 May 2016 07:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1463495466-29689-4-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 17/05/16 15:31, Paul Burton wrote:
> When EIC mode is in use (cpu_has_veic is true) enable it on each CPU
> during GIC initialisation. Otherwise there may be a mismatch between the
> hardware default interrupt model & that expected by the kernel.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>   drivers/irqchip/irq-mips-gic.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 4dffccf..bc23c92 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -956,7 +956,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
>   			      unsigned int cpu_vec, unsigned int irqbase,
>   			      struct device_node *node)
>   {
> -	unsigned int gicconfig;
> +	unsigned int gicconfig, cpu;
>   	unsigned int v[2];
>   
>   	__gic_base_addr = gic_base_addr;
> @@ -973,6 +973,14 @@ static void __init __gic_init(unsigned long gic_base_addr,
>   	gic_vpes = gic_vpes + 1;
>   
>   	if (cpu_has_veic) {
> +		/* Set EIC mode for all VPEs */
> +		for_each_present_cpu(cpu) {
> +			gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_OTHER_ADDR),
> +				  mips_cm_vp_id(cpu));
> +			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_CTL),
> +				  GIC_VPE_CTL_EIC_MODE_MSK);
> +		}
> +
>   		/* Always use vector 1 in EIC mode */
>   		gic_cpu_pin = 0;
>   		timer_cpu_pin = gic_cpu_pin;
Hi Paul

Reviewed-by: Matt Redfearn <matt.redfearn@imgtec.com>
Tested-by: Matt Redfearn <matt.redfearn@imgtec.com>

Thanks,
Matt
