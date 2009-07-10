Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 18:14:03 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58426 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493137AbZGJQN4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 18:13:56 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6AGDwM1010603;
	Fri, 10 Jul 2009 17:13:59 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6AGDwlB010601;
	Fri, 10 Jul 2009 17:13:58 +0100
Date:	Fri, 10 Jul 2009 17:13:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Raghu Gandham <raghu@mips.com>
Cc:	linux-mips@linux-mips.org, chris@mips.com
Subject: Re: [PATCH] Due to some broken bitfiles, we can't trust IntCtl
Message-ID: <20090710161358.GC1288@linux-mips.org>
References: <20090710084942.25804.864.stgit@linux-raghu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090710084942.25804.864.stgit@linux-raghu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 10, 2009 at 01:49:43AM -0700, Raghu Gandham wrote:

> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
> index 09b08d0..ca0b5ed 100644
> --- a/arch/mips/include/asm/irq.h
> +++ b/arch/mips/include/asm/irq.h
> @@ -158,6 +158,7 @@ extern void free_irqno(unsigned int irq);
>   * IE7.  Since R2 their number has to be read from the c0_intctl register.
>   */
>  #define CP0_LEGACY_COMPARE_IRQ 7
> +#define CP0_LEGACY_PERFCNT_IRQ 7
>  
>  extern int cp0_compare_irq;
>  extern int cp0_perfcount_irq;
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 08f1edf..0b6e328 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1538,7 +1538,11 @@ void __cpuinit per_cpu_trap_init(void)
>  	 */
>  	if (cpu_has_mips_r2) {
>  		cp0_compare_irq = (read_c0_intctl() >> 29) & 7;
> +		if (!cp0_compare_irq)
> +			cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
>  		cp0_perfcount_irq = (read_c0_intctl() >> 26) & 7;
> +		if (!cp0_perfcount_irq)
> +			cp0_perfcount_irq = CP0_LEGACY_PERFCNT_IRQ;
>  		if (cp0_perfcount_irq == cp0_compare_irq)
>  			cp0_perfcount_irq = -1;
>  	} else {

Is there still any point in applying this patch?  I thought only a bunch
of early bitfiles were affected but it was never actually taped out?

  Ralf
