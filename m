Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 15:35:30 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:51748 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28643926AbWLUPf0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 15:35:26 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 76A053EC9; Thu, 21 Dec 2006 07:35:17 -0800 (PST)
Message-ID: <458AA9B0.2050203@ru.mvista.com>
Date:	Thu, 21 Dec 2006 18:35:12 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] pnx8550: fix system timer support
References: <20061221173439.fc76c832.vitalywool@gmail.com>
In-Reply-To: <20061221173439.fc76c832.vitalywool@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Vitaly Wool wrote:

> the patch inlined below restores proper time accounting for PNX8550-based boards. It also gets rid of #ifdef in the generic code which becomes unnecessary then.

> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index 11aab6d..5fe3eb8 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -94,10 +94,8 @@ static void c0_timer_ack(void)
>  {
>  	unsigned int count;
>  
> -#ifndef CONFIG_SOC_PNX8550	/* pnx8550 resets to zero */
>  	/* Ack this timer interrupt and set the next one.  */
>  	expirelo += cycles_per_jiffy;
> -#endif
>  	write_c0_compare(expirelo);
>  
>  	/* Check to see if we have missed any timer interrupts.  */
> diff --git a/arch/mips/philips/pnx8550/common/time.c b/arch/mips/philips/pnx8550/common/time.c
> index 65c440e..25a8df7 100644
> --- a/arch/mips/philips/pnx8550/common/time.c
> +++ b/arch/mips/philips/pnx8550/common/time.c
> @@ -29,12 +29,27 @@
>  #include <asm/hardirq.h>
>  #include <asm/div64.h>
>  #include <asm/debug.h>
> +#include <asm/time.h>
>  
>  #include <int.h>
>  #include <cm.h>

>  extern unsigned int mips_hpt_frequency;

    This is already declared in <asm/time.h>...

> +static unsigned long cpj;
> +
> +static cycle_t hpt_read(void)
> +{
> +	return read_c0_count2();
> +}
> +
> +static void timer_ack(void)
> +{
> +	write_c0_compare(cpj);
> +}
> +
> +extern struct clocksource clocksource_mips;

    And this too...

> @@ -68,22 +83,41 @@ void pnx8550_time_init(void)
>  	 * HZ timer interrupts per second.
>  	 */
>  	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
> +	cpj = (mips_hpt_frequency + HZ / 2) / HZ;
> +	timer_ack();

    Probably makes sense to clear Count2 as well...

>  void __init plat_timer_setup(struct irqaction *irq)
>  {
>  	int configPR;
>  
>  	setup_irq(PNX8550_INT_TIMER1, irq);
> +	setup_irq(PNX8550_INT_TIMER2, &monotonic_irqaction);
>  
>  	/* Start timer1 */
>  	configPR = read_c0_config7();
>  	configPR &= ~0x00000008;
>  	write_c0_config7(configPR);
>  
> -	/* Timer 2 stop */
> +	/* Timer 2 start */
>  	configPR = read_c0_config7();
> -	configPR |= 0x00000010;
> +	configPR &= ~0x00000010;
>  	write_c0_config7(configPR);

    I'd have coalesced that into one RMW but well...

>  	write_c0_count2(0);

WBR, Sergei
