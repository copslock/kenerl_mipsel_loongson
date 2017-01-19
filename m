Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 12:55:00 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:40820 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993014AbdASLyxoed-B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Jan 2017 12:54:53 +0100
Subject: Re: [PATCH] MIPS: Lantiq: Fix cascaded IRQ setup
To:     Felix Fietkau <nbd@nbd.name>, linux-mips@linux-mips.org
References: <20170119112822.59445-1-nbd@nbd.name>
Cc:     ralf@linux-mips.org
From:   John Crispin <john@phrozen.org>
Message-ID: <d9a072f8-27c5-c4c8-d742-595b4d28b9d1@phrozen.org>
Date:   Thu, 19 Jan 2017 12:54:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170119112822.59445-1-nbd@nbd.name>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 19/01/2017 12:28, Felix Fietkau wrote:
> With the IRQ stack changes integrated, the XRX200 devices started
> emitting a constant stream of kernel messages like this:
> 
> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
> 
> This appears to be caused by IP0 firing for some reason without being
> handled. Fix this by setting up IP2-6 as a proper chained IRQ handler and
> calling do_IRQ for all MIPS CPU interrupts.
> 
> Cc: john@phrozen.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: John Crispin <john@phrozen.org>

> ---
>  arch/mips/lantiq/irq.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index 8ac0e5994ed2..0ddf3698b85d 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -269,6 +269,11 @@ static void ltq_hw5_irqdispatch(void)
>  DEFINE_HWx_IRQDISPATCH(5)
>  #endif
>  
> +static void ltq_hw_irq_handler(struct irq_desc *desc)
> +{
> +	ltq_hw_irqdispatch(irq_desc_get_irq(desc) - 2);
> +}
> +
>  #ifdef CONFIG_MIPS_MT_SMP
>  void __init arch_init_ipiirq(int irq, struct irqaction *action)
>  {
> @@ -313,23 +318,19 @@ static struct irqaction irq_call = {
>  asmlinkage void plat_irq_dispatch(void)
>  {
>  	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
> -	unsigned int i;
> -
> -	if ((MIPS_CPU_TIMER_IRQ == 7) && (pending & CAUSEF_IP7)) {
> -		do_IRQ(MIPS_CPU_TIMER_IRQ);
> -		goto out;
> -	} else {
> -		for (i = 0; i < MAX_IM; i++) {
> -			if (pending & (CAUSEF_IP2 << i)) {
> -				ltq_hw_irqdispatch(i);
> -				goto out;
> -			}
> -		}
> +	int irq;
> +
> +	if (!pending) {
> +		spurious_interrupt();
> +		return;
>  	}
> -	pr_alert("Spurious IRQ: CAUSE=0x%08x\n", read_c0_status());
>  
> -out:
> -	return;
> +	pending >>= CAUSEB_IP;
> +	while (pending) {
> +		irq = fls(pending) - 1;
> +		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
> +		pending &= ~BIT(irq);
> +	}
>  }
>  
>  static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> @@ -354,11 +355,6 @@ static const struct irq_domain_ops irq_domain_ops = {
>  	.map = icu_map,
>  };
>  
> -static struct irqaction cascade = {
> -	.handler = no_action,
> -	.name = "cascade",
> -};
> -
>  int __init icu_of_init(struct device_node *node, struct device_node *parent)
>  {
>  	struct device_node *eiu_node;
> @@ -390,7 +386,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
>  	mips_cpu_irq_init();
>  
>  	for (i = 0; i < MAX_IM; i++)
> -		setup_irq(i + 2, &cascade);
> +		irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
>  
>  	if (cpu_has_vint) {
>  		pr_info("Setting up vectored interrupts\n");
> 
