Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 15:35:28 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:31644 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28577065AbWLSPez (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 15:34:55 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1GwgzW-0006VH-6v
	for linux-mips@linux-mips.org; Tue, 19 Dec 2006 07:34:54 -0800
Message-ID: <7949125.post@talk.nabble.com>
Date:	Tue, 19 Dec 2006 07:34:54 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
In-Reply-To: <20061220.000113.59033093.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp> <20061220.000113.59033093.anemo@mba.ocn.ne.jp>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips




Atsushi Nemoto wrote:
> 
> On Tue, 19 Dec 2006 00:17:24 -0800 (PST), Daniel Laird
> <danieljlaird@hotmail.com> wrote:
>> On the PNX8550 it does not use the CP0 timer but use a different timer
>> (the
>> Custom MIPS core has 3 extra timers) 
> 
> Do you know what this ifndef line mean?
> 
> #ifndef CONFIG_SOC_PNX8550	/* pnx8550 resets to zero */
> 	/* Ack this timer interrupt and set the next one.  */
> 	expirelo += cycles_per_jiffy;
> #endif
> 
> If it means "On PNX8550, writing to COMPARE register resets COUNTER to
> zero", new time.c might be broken for PNX8550.  Could you try this
> patch?
> 
> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index 11aab6d..4eb0741 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -119,7 +119,11 @@ static cycle_t c0_hpt_read(void)
>  /* For use both as a high precision timer and an interrupt source.  */
>  static void __init c0_hpt_timer_init(void)
>  {
> +#ifdef CONFIG_SOC_PNX8550	/* pnx8550 resets to zero */
> +	expirelo = cycles_per_jiffy;
> +#else
>  	expirelo = read_c0_count() + cycles_per_jiffy;
> +#endif
>  	write_c0_compare(expirelo);
>  }
>  
> 
> 
> 
I am just digging out the mips core user manual...  
However I have tried this change you suggested, it still takes a long time
to get past the calibrate delay function (~10seconds).
However after this it seems to run at full speed where as before it used to
run very slow.
So an improvement, I think this does mean the new time.c has broken 8550
support hopefully I can find otu what the core does so it can be fixed.

-- 
View this message in context: http://www.nabble.com/2.6.19-timer-API-changes-tf2838715.html#a7949125
Sent from the linux-mips main mailing list archive at Nabble.com.
