Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 May 2007 17:17:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:216 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022580AbXEEQR4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 May 2007 17:17:56 +0100
Received: from localhost (p1094-ipad26funabasi.chiba.ocn.ne.jp [220.104.87.94])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 25266969E; Sun,  6 May 2007 01:16:28 +0900 (JST)
Date:	Sun, 06 May 2007 01:16:36 +0900 (JST)
Message-Id: <20070506.011636.92588372.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11782930063123-git-send-email-fbuihuu@gmail.com>
References: <1178293006633-git-send-email-fbuihuu@gmail.com>
	<11782930063123-git-send-email-fbuihuu@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri,  4 May 2007 17:36:45 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -239,21 +239,14 @@ asmlinkage void ll_local_timer_interrupt(int irq)
>  /*
>   * time_init() - it does the following things.
>   *
> - * 1) board_time_init() -
> - * 	a) (optional) set up RTC routines,
> - *      b) (optional) calibrate and set the mips_hpt_frequency
> - *	    (only needed if you intended to use cpu counter as timer interrupt
> - *	     source)
> - * 2) setup xtime based on rtc_mips_get_time().
> - * 3) calculate a couple of cached variables for later usage
> - * 4) plat_timer_setup() -
> + * 1) setup xtime based on rtc_mips_get_time().
> + * 2) calculate a couple of cached variables for later usage
> + * 3) plat_timer_setup() -
>   *	a) (optional) over-write any choices made above by time_init().
>   *	b) machine specific code should setup the timer irqaction.
>   *	c) enable the timer interrupt
>   */
>  
> -void (*board_time_init)(void);
> -
>  unsigned int mips_hpt_frequency;
>  
>  static struct irqaction timer_irqaction = {

As I wrote in another mail I think we can not remove board_time_init
for now, but if you really removed it please update
Documentation/mips/time.README too.

---
Atsushi Nemoto
