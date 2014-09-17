Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 10:56:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32047 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008413AbaIQI4dlfZMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 10:56:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C2FBC34D11062;
        Wed, 17 Sep 2014 09:56:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 17 Sep 2014 09:56:27 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 17 Sep
 2014 09:56:25 +0100
Message-ID: <54194CB9.4010200@imgtec.com>
Date:   Wed, 17 Sep 2014 09:56:25 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Jonas Gorski" <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/24] MIPS: Provide a generic plat_irq_dispatch
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org> <1410825087-5497-4-git-send-email-abrestic@chromium.org>
In-Reply-To: <1410825087-5497-4-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42657
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

Hi Andrew,

On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
> For platforms which boot with device-tree or have correctly chained
> all external interrupt controllers, a generic plat_irq_dispatch() can
> be used.  Implement a plat_irq_dispatch() which simply handles all the
> pending interrupts as reported by C0_Cause.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>   arch/mips/kernel/irq_cpu.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
> index ca98a9f..f17bd08 100644
> --- a/arch/mips/kernel/irq_cpu.c
> +++ b/arch/mips/kernel/irq_cpu.c
> @@ -94,6 +94,21 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
>   	.irq_eoi	= unmask_mips_irq,
>   };
>   
> +asmlinkage void __weak plat_irq_dispatch(void)
> +{
> +	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +	int irq;
> +
> +	if (!pending) {
> +		spurious_interrupt();
> +		return;
> +	}
> +
> +	pending >>= CAUSEB_IP;
> +	for_each_set_bit(irq, &pending, 8)
> +		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
> +}
> +

If I read the for_each_set_bit() macro correctly it'll iterate through 
the bits from least to most significant ones which is the reversed 
priority expected. Some platforms set timer interrupt to bit 7 which is 
should be the highest priority interrupt. Also when cpu_has_vint is set 
the hardware prioritirise from most significant to least significant 
bits so if plat_irq_dispatch() is used with set_vi_handler() it'll cause 
interrupts to be serviced in the wrong order.

Qais

>   static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
>   			     irq_hw_number_t hw)
>   {
