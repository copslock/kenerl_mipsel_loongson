Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 00:05:04 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:24296 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20021890AbXIQXEz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 00:04:55 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1IXPe8-0003Px-MR
	for linux-mips@linux-mips.org; Mon, 17 Sep 2007 16:04:52 -0700
Message-ID: <12746880.post@talk.nabble.com>
Date:	Mon, 17 Sep 2007 16:04:52 -0700 (PDT)
From:	Steve Graham <stgraham2000@yahoo.com>
To:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
In-Reply-To: <20070717122711.GA19977@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: stgraham2000@yahoo.com
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469C8600.7090208@niisi.msk.ru> <20070717122711.GA19977@linux-mips.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stgraham2000@yahoo.com
Precedence: bulk
X-list: linux-mips


I am having a similar problem where complicated bash scripts on boot randomly
throw SIGILL.  I am running on a PMC MSP8510 platform - E9000 core.  I have
applied the patch to "war.h" mentioned in this thread and that did greatly
reduce the number of occurences of this problem but has not fixed it.  I was
getting at least 2 illegal instructions every boot and now I can boot
without any problems about 90% of the time.

Does the patch you mention below apply to the E9000 core as well?


Ralf Baechle DL5RB wrote:
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index f599e79..7ee0cb0 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -75,6 +75,26 @@ static void r4k_wait_irqoff(void)
>  	local_irq_enable();
>  }
>  
> +/*
> + * The RM7000 variant has to handle erratum 38.  The workaround is to not
> + * have any pending stores when the WAIT instruction is executed.
> + */
> +static void rm7k_wait_irqoff(void)
> +{
> +	local_irq_disable();
> +	if (!need_resched())
> +		__asm__(
> +		"	.set	push		\n"
> +		"	.set	mips3		\n"
> +		"	.set	noat		\n"
> +		"	mfc0	$1, $12		\n"
> +		"	sync			\n"
> +		"	mtc0	$1, $12		\n"
> +		"	wait			\n"
> +		"	.set	pop		\n");
> +	local_irq_enable();
> +}
> +
>  /* The Au1xxx wait is available only if using 32khz counter or
>   * external timer source, but specifically not CP0 Counter. */
>  int allow_au1k_wait;
> @@ -132,7 +152,6 @@ static inline void check_wait(void)
>  	case CPU_R4700:
>  	case CPU_R5000:
>  	case CPU_NEVADA:
> -	case CPU_RM7000:
>  	case CPU_4KC:
>  	case CPU_4KEC:
>  	case CPU_4KSC:
> @@ -142,6 +161,10 @@ static inline void check_wait(void)
>  		cpu_wait = r4k_wait;
>  		break;
>  
> +	case CPU_RM7000:
> +		cpu_wait = rm7k_wait_irqoff;
> +		break;
> +
>  	case CPU_24K:
>  	case CPU_34K:
>  		cpu_wait = r4k_wait;
> 
> 
> 

-- 
View this message in context: http://www.nabble.com/O2-RM7000-Issues-tf4008392.html#a12746880
Sent from the linux-mips main mailing list archive at Nabble.com.
