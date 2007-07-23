Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 14:19:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:29379 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022655AbXGWNTr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 14:19:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6NDJjGC001680;
	Mon, 23 Jul 2007 14:19:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6NDJiGb001679;
	Mon, 23 Jul 2007 14:19:44 +0100
Date:	Mon, 23 Jul 2007 14:19:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove unneeded reset function for jazz
Message-ID: <20070723131944.GC31040@linux-mips.org>
References: <20070722130649.439bf4c2.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070722130649.439bf4c2.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 22, 2007 at 01:06:49PM +0900, Yoichi Yuasa wrote:

> remove unneeded reset function for jazz

Thanks, ok?  Or do you instead want to put something into these functions?

  Ralf

> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/jazz/reset.c generic/arch/mips/jazz/reset.c
> --- generic-orig/arch/mips/jazz/reset.c	2007-07-21 21:55:08.089094250 +0900
> +++ generic/arch/mips/jazz/reset.c	2007-07-21 22:22:10.724855500 +0900
> @@ -6,10 +6,6 @@
>   */
>  #include <linux/jiffies.h>
>  #include <asm/jazz.h>
> -#include <asm/io.h>
> -#include <asm/system.h>
> -#include <asm/reboot.h>
> -#include <asm/delay.h>
>  
>  #define KBD_STAT_IBF		0x02	/* Keyboard input buffer full */
>  
> @@ -58,12 +54,3 @@ void jazz_machine_restart(char *command)
>  		jazz_write_output (0x00);
>  	}
>  }
> -
> -void jazz_machine_halt(void)
> -{
> -}
> -
> -void jazz_machine_power_off(void)
> -{
> -	/* Jazz machines don't have a software power switch */
> -}
> diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/jazz/setup.c generic/arch/mips/jazz/setup.c
> --- generic-orig/arch/mips/jazz/setup.c	2007-07-21 21:55:08.101095000 +0900
> +++ generic/arch/mips/jazz/setup.c	2007-07-21 22:20:20.045938500 +0900
> @@ -34,8 +34,6 @@
>  extern asmlinkage void jazz_handle_int(void);
>  
>  extern void jazz_machine_restart(char *command);
> -extern void jazz_machine_halt(void);
> -extern void jazz_machine_power_off(void);
>  
>  void __init plat_timer_setup(struct irqaction *irq)
>  {
> @@ -95,8 +93,6 @@ void __init plat_mem_setup(void)
>  	/* The RTC is outside the port address space */
>  
>  	_machine_restart = jazz_machine_restart;
> -	_machine_halt = jazz_machine_halt;
> -	pm_power_off = jazz_machine_power_off;
>  
>  	screen_info = (struct screen_info) {
>  		0, 0,		/* orig-x, orig-y */

  Ralf
