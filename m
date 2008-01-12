Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 17:20:22 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:5881 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20032512AbYALRUO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2008 17:20:14 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 581683EC9; Sat, 12 Jan 2008 09:20:11 -0800 (PST)
Message-ID: <4788F6FE.6000803@ru.mvista.com>
Date:	Sat, 12 Jan 2008 20:21:02 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] pnx8xxx clocksource cleanups
References: <4788BAAC.3020908@gmail.com>
In-Reply-To: <4788BAAC.3020908@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Vitaly Wool wrote:

> This patch does some PNX8XXX clocksource cleanups.

> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

> Index: linux-mips.git/arch/mips/philips/pnx8550/common/time.c
> ===================================================================
> --- linux-mips.git.orig/arch/mips/philips/pnx8550/common/time.c
> +++ linux-mips.git/arch/mips/philips/pnx8550/common/time.c
> @@ -47,11 +47,6 @@ static struct clocksource pnx_clocksourc
>     .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
> };
> 
> -static void timer_ack(void)
> -{
> -    write_c0_compare(cpj);
> -}
> -
> static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
> {
>     struct clock_event_device *c = dev_id;
> @@ -94,30 +89,22 @@ static struct clock_event_device pnx8xxx
>     .set_next_event = pnx8xxx_set_next_event,
> };
> 
> -/*
> - * plat_time_init() - it does the following things:
> - *
> - * 1) plat_time_init() -
> - *     a) (optional) set up RTC routines,
> - *      b) (optional) calibrate and set the mips_hpt_frequency
> - *        (only needed if you intended to use cpu counter as timer 
> interrupt
> - *         source)
> - */
> +static inline void timer_ack(void)
> +{
> +    write_c0_compare(cpj);
> +}

    I still don't understand why you need this function at all, and the 'cpj' 
variable as well -- clockevents core will set the comparator to a needed 
value.  Also, I don't see much value in moving that function...

WBR, Sergei
