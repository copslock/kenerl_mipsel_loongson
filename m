Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2007 20:01:08 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:28038 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20032597AbXJXTBA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2007 20:01:00 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 88DAE3EC9; Wed, 24 Oct 2007 12:00:26 -0700 (PDT)
Message-ID: <471F9655.2010702@ru.mvista.com>
Date:	Wed, 24 Oct 2007 23:00:37 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] txx9tmr clockevent/clocksource driver (take 2)
References: <20071025.013409.26096880.anemo@mba.ocn.ne.jp>
In-Reply-To: <20071025.013409.26096880.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> Convert jmr3927_clock_event_device to more generic
> txx9tmr_clock_event_device which supports one-shot mode.  The
> txx9tmr_clock_event_device can be used for TX49 too if the cp0 timer
> interrupt was not available.

> Convert jmr3927_hpt_read to txx9_clocksource driver which does not
> depends jiffies anymore.  The txx9_clocksource itself can be used for
> TX49, but normally TX49 uses higher precision clocksource_mips.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> Changes from "take 1" (suggested by Sergei Shtylyov)
> 
> * Define TXX9_CLOCKSOURCE_BITS and add a comment.
> * Remove #ifdef around txx9_clocksource.  It can be used for TX49 too.
> * Move TXX9_TIMER_BITS into txx9tmr.h.
> * Fix typo.

>  arch/mips/Kconfig                                  |    6 +
>  arch/mips/jmr3927/rbhma3100/setup.c                |   83 +---------
>  arch/mips/kernel/Makefile                          |    1 +
>  arch/mips/kernel/cevt-txx9.c                       |  171 ++++++++++++++++++++
>  .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   17 +-
>  arch/mips/tx4938/toshiba_rbtx4938/setup.c          |   19 +--
>  include/asm-mips/jmr3927/jmr3927.h                 |    9 +-
>  include/asm-mips/jmr3927/tx3927.h                  |    4 +-
>  include/asm-mips/jmr3927/txx927.h                  |   37 -----
>  include/asm-mips/tx4927/tx4927_pci.h               |    3 +
>  include/asm-mips/tx4938/tx4938.h                   |    1 -
>  include/asm-mips/txx9tmr.h                         |   67 ++++++++
>  12 files changed, 273 insertions(+), 145 deletions(-)

> @@ -736,6 +739,9 @@ config CEVT_GT641XX
>  config CEVT_R4K
>  	bool
>  
> +config CEVT_TXX9
> +	bool
> +

    Oh, the large economy -- instead of CEVT_* ISO CLOCKEVENT_*... :-)

> @@ -937,12 +939,11 @@ void __init toshiba_rbtx4927_setup(void)
>  void __init
>  toshiba_rbtx4927_time_init(void)
>  {
> -	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "-\n");
> -
>  	mips_hpt_frequency = tx4927_cpu_clock / 2;
> -
> -	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "+\n");
> -
> +	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_TINTDIS)
> +		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
> +				     TXX9_IRQ_BASE + 17,
> +				     50000000);

    Wait, you're not registering TXx9 clocksource anyway, so it's only taking 
space indeed.  Maybe we should register clock source/event regardless of the 
value of CCFG.TINTDIS, and let them be selected according to rating?

WBR, Sergei
