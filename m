Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 14:29:40 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:3332 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28583140AbWLTO3g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 14:29:36 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 2C6363EC9; Wed, 20 Dec 2006 06:29:30 -0800 (PST)
Message-ID: <458948C5.4050909@ru.mvista.com>
Date:	Wed, 20 Dec 2006 17:29:25 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	danieljlaird@hotmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: 2.6.19 timer API changes
References: <20061219.233410.25911550.anemo@mba.ocn.ne.jp>	<20061220.000113.59033093.anemo@mba.ocn.ne.jp>	<7949125.post@talk.nabble.com> <20061220.021508.97296486.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061220.021508.97296486.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>I am just digging out the mips core user manual...  
>>However I have tried this change you suggested, it still takes a long time
>>to get past the calibrate delay function (~10seconds).
>>However after this it seems to run at full speed where as before it used to
>>run very slow.
>>So an improvement, I think this does mean the new time.c has broken 8550
>>support hopefully I can find otu what the core does so it can be fixed.

> Hm, then it seems writing to COMPARE does not clear COUNT.

    Looks like the count/compare match does this...

> How about this?  You should still fix pnx8550_hpt_read() anyway, but I
> suppose gettimeofday() on PNX8550 was broken long time.

    And nobody noticed. :-)

> Subject: [MIPS] Use custom timer_ack and clocksource_mips.read for PNX8550
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index 11aab6d..8aa544f 100644
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
> index 65c440e..e86905a 100644
> --- a/arch/mips/philips/pnx8550/common/time.c
> +++ b/arch/mips/philips/pnx8550/common/time.c
> @@ -33,7 +33,18 @@ #include <asm/debug.h>
>  #include <int.h>
>  #include <cm.h>

> -extern unsigned int mips_hpt_frequency;
> +static unsigned long cycles_per_jiffy __read_mostly;

   I wonder shouldn't it be added to <asm-mips/time.h> just for such occasions..

> +
> +static void pnx8550_timer_ack(void)
> +{
> +	write_c0_compare(cycles_per_jiffy);
> +}
> +
> +static cycle_t pnx8550_hpt_read(void)
> +{
> +	/* FIXME: we should use timer2 or timer3 as freerun counter */
> +	return read_c0_count();
 > +}

    I'd suggest read_c0_count2() here, possibly adding an interrupt handler 
for it since it will interrupt upon hitting compare2 reg. value (but we could 
probably just mask the IRQ off), and enabling the timer 2, of course (the 
current code disables it)...

WBR, Sergei
