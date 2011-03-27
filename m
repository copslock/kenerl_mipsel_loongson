Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 23:12:45 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:41662 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab1C0VMl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Mar 2011 23:12:41 +0200
Received: by iyb39 with SMTP id 39so2734482iyb.36
        for <multiple recipients>; Sun, 27 Mar 2011 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Aeg5K+DCSoITsbRbqzKXxl8Y1+bDLZJyxORjUbLdOgw=;
        b=Tjx+mRmGC3PKkMyAgGIkh67KsKfu8Vr49MDQElL4PYt70qjFohff+0bFm6MOWCsEn5
         enG7Z8Sx/jrls/os5Lu4POdUHAj/mwwrzdjSHSI181rH3IlXVROPJ3s7VjL+zRmNf84n
         v+e72vTMydBu3eibEfoE7Jglal9ldLeH0aGlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=J6XzWGwrs4mlxqaYqbJNmXX/zNfWb9pOXiinTmD8KbJAQlXtvGUarE4DrhunS8CsbS
         UtnLQN4JgcQCNpXES3IcHKkIWFWTKpv/U5ErpXDX3LUzSB3Y8EhoaRnYsghKyqc9yrmh
         R7rx5VJWK+CMa06/me+KVcXy6wYj9eHzRA1/0=
Received: by 10.42.134.132 with SMTP id l4mr5241018ict.13.1301260355244;
        Sun, 27 Mar 2011 14:12:35 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-59-9.dsl.pltn13.pacbell.net [67.127.59.9])
        by mx.google.com with ESMTPS id he40sm2449270ibb.67.2011.03.27.14.12.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 14:12:34 -0700 (PDT)
Message-ID: <4D8FA840.2080108@gmail.com>
Date:   Sun, 27 Mar 2011 14:12:32 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.38.b3pre.fc13 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [patch 3/5] MIPS: Octeon: Simplify irq_cpu_on/offline irq chip
        functions
References: <20110327155637.623706071@linutronix.de> <20110327161118.737588559@linutronix.de>
In-Reply-To: <20110327161118.737588559@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 03/27/2011 09:22 AM, Thomas Gleixner wrote:
> Make use of the IRQCHIP_ONOFFLINE_ENABLED flag and remove the
> wrappers. Use irqd_irq_disabled() instead of desc->status, which will
> go away.
>

I rewrote my patch set and was testing it.  Interesting that I came up 
with a function with almost the same name and purpose.

However my function told us if the irq was masked *or* disabled.  The 
idea being a function that returns true if the irq could fire.  We 
cannot be enabling the interrupt in the controller if it is masked.

For example I need to test this when adjusting affinity, and taking CPUs 
on and off line.

I don't think your genirq changes can tell the me information I really 
need in their current state.  I think we need to consider how the masked 
state interacts with IRQCHIP_ONOFFLINE_ENABLED and irqd_irq_disabled().

Since I have totally rewritten my interrupt code, I am a bit ambivalent 
about applying these patches.  It might make more sense that I adjust my 
patch for your genirq changes and test it before committing it.

David Daney

> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc: David Daney<ddaney@caviumnetworks.com>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c |   71 ++++++++---------------------------
>   1 file changed, 17 insertions(+), 54 deletions(-)
>
> Index: linux-2.6-tip/arch/mips/cavium-octeon/octeon-irq.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/mips/cavium-octeon/octeon-irq.c
> +++ linux-2.6-tip/arch/mips/cavium-octeon/octeon-irq.c
> @@ -152,19 +152,6 @@ static void octeon_irq_core_bus_sync_unl
>   	mutex_unlock(&cd->core_irq_mutex);
>   }
>
> -
> -static void octeon_irq_core_cpu_online(struct irq_data *data)
> -{
> -	if (irqd_irq_disabled(data))
> -		octeon_irq_core_eoi(data);
> -}
> -
> -static void octeon_irq_core_cpu_offline(struct irq_data *data)
> -{
> -	if (irqd_irq_disabled(data))
> -		octeon_irq_core_ack(data);
> -}
> -
>   static struct irq_chip octeon_irq_chip_core = {
>   	.name = "Core",
>   	.irq_enable = octeon_irq_core_enable,
> @@ -174,8 +161,9 @@ static struct irq_chip octeon_irq_chip_c
>   	.irq_bus_lock = octeon_irq_core_bus_lock,
>   	.irq_bus_sync_unlock = octeon_irq_core_bus_sync_unlock,
>
> -	.irq_cpu_online = octeon_irq_core_cpu_online,
> -	.irq_cpu_offline = octeon_irq_core_cpu_offline,
> +	.irq_cpu_online = octeon_irq_core_eoi,
> +	.irq_cpu_offline = octeon_irq_core_ack,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   };
>
>   static void __init octeon_irq_init_core(void)
> @@ -517,30 +505,6 @@ static void octeon_irq_ciu_enable_all_v2
>   	}
>   }
>
> -static void octeon_irq_cpu_online_mbox(struct irq_data *data)
> -{
> -	if (irqd_irq_disabled(data))
> -		octeon_irq_ciu_enable_local(data);
> -}
> -
> -static void octeon_irq_cpu_online_mbox_v2(struct irq_data *data)
> -{
> -	if (irqd_irq_disabled(data))
> -		octeon_irq_ciu_enable_local_v2(data);
> -}
> -
> -static void octeon_irq_cpu_offline_mbox(struct irq_data *data)
> -{
> -	if (irqd_irq_disabled(data))
> -		octeon_irq_ciu_disable_local(data);
> -}
> -
> -static void octeon_irq_cpu_offline_mbox_v2(struct irq_data *data)
> -{
> -	if (irqd_irq_disabled(data))
> -		octeon_irq_ciu_disable_local_v2(data);
> -}
> -
>   #ifdef CONFIG_SMP
>
>   static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
> @@ -570,8 +534,7 @@ static int octeon_irq_ciu_set_affinity(s
>   				       const struct cpumask *dest, bool force)
>   {
>   	int cpu;
> -	struct irq_desc *desc = irq_to_desc(data->irq);
> -	int enable_one = (desc->status&  IRQ_DISABLED) == 0;
> +	bool enable_one = !irqd_irq_disabled(data);
>   	unsigned long flags;
>   	union octeon_ciu_chip_data cd;
>
> @@ -585,7 +548,7 @@ static int octeon_irq_ciu_set_affinity(s
>   	if (cpumask_weight(dest) != 1)
>   		return -EINVAL;
>
> -	if (desc->status&  IRQ_DISABLED)
> +	if (!enable_one)
>   		return 0;
>
>   	if (cd.s.line == 0) {
> @@ -595,7 +558,7 @@ static int octeon_irq_ciu_set_affinity(s
>   			unsigned long *pen =&per_cpu(octeon_irq_ciu0_en_mirror, cpu);
>
>   			if (cpumask_test_cpu(cpu, dest)&&  enable_one) {
> -				enable_one = 0;
> +				enable_one = false;
>   				set_bit(cd.s.bit, pen);
>   			} else {
>   				clear_bit(cd.s.bit, pen);
> @@ -610,7 +573,7 @@ static int octeon_irq_ciu_set_affinity(s
>   			unsigned long *pen =&per_cpu(octeon_irq_ciu1_en_mirror, cpu);
>
>   			if (cpumask_test_cpu(cpu, dest)&&  enable_one) {
> -				enable_one = 0;
> +				enable_one = false;
>   				set_bit(cd.s.bit, pen);
>   			} else {
>   				clear_bit(cd.s.bit, pen);
> @@ -631,12 +594,11 @@ static int octeon_irq_ciu_set_affinity_v
>   					  bool force)
>   {
>   	int cpu;
> -	struct irq_desc *desc = irq_to_desc(data->irq);
> -	int enable_one = (desc->status&  IRQ_DISABLED) == 0;
> +	bool enable_one = !irqd_irq_disabled(data);
>   	u64 mask;
>   	union octeon_ciu_chip_data cd;
>
> -	if (desc->status&  IRQ_DISABLED)
> +	if (!enable_one)
>   		return 0;
>
>   	cd.p = data->chip_data;
> @@ -647,7 +609,7 @@ static int octeon_irq_ciu_set_affinity_v
>   			unsigned long *pen =&per_cpu(octeon_irq_ciu0_en_mirror, cpu);
>   			int index = octeon_coreid_for_cpu(cpu) * 2;
>   			if (cpumask_test_cpu(cpu, dest)&&  enable_one) {
> -				enable_one = 0;
> +				enable_one = false;
>   				set_bit(cd.s.bit, pen);
>   				cvmx_write_csr(CVMX_CIU_INTX_EN0_W1S(index), mask);
>   			} else {
> @@ -660,7 +622,7 @@ static int octeon_irq_ciu_set_affinity_v
>   			unsigned long *pen =&per_cpu(octeon_irq_ciu1_en_mirror, cpu);
>   			int index = octeon_coreid_for_cpu(cpu) * 2 + 1;
>   			if (cpumask_test_cpu(cpu, dest)&&  enable_one) {
> -				enable_one = 0;
> +				enable_one = false;
>   				set_bit(cd.s.bit, pen);
>   				cvmx_write_csr(CVMX_CIU_INTX_EN1_W1S(index), mask);
>   			} else {
> @@ -679,7 +641,6 @@ static int octeon_irq_ciu_set_affinity_v
>    */
>   static void octeon_irq_dummy_mask(struct irq_data *data)
>   {
> -	return;
>   }
>
>   /*
> @@ -741,8 +702,9 @@ static struct irq_chip octeon_irq_chip_c
>   	.irq_ack = octeon_irq_ciu_disable_local_v2,
>   	.irq_eoi = octeon_irq_ciu_enable_local_v2,
>
> -	.irq_cpu_online = octeon_irq_cpu_online_mbox_v2,
> -	.irq_cpu_offline = octeon_irq_cpu_offline_mbox_v2,
> +	.irq_cpu_online = octeon_irq_ciu_enable_local_v2,
> +	.irq_cpu_offline = octeon_irq_ciu_disable_local_v2,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   };
>
>   static struct irq_chip octeon_irq_chip_ciu_mbox = {
> @@ -750,8 +712,9 @@ static struct irq_chip octeon_irq_chip_c
>   	.irq_enable = octeon_irq_ciu_enable_all,
>   	.irq_disable = octeon_irq_ciu_disable_all,
>
> -	.irq_cpu_online = octeon_irq_cpu_online_mbox,
> -	.irq_cpu_offline = octeon_irq_cpu_offline_mbox,
> +	.irq_cpu_online = octeon_irq_ciu_enable_local,
> +	.irq_cpu_offline = octeon_irq_ciu_disable_local,
> +	.flags = IRQCHIP_ONOFFLINE_ENABLED,
>   };
>
>   /*
>
>
>
