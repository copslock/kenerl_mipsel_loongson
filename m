Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 17:06:52 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57072 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTGPQGu>;
	Wed, 16 Jul 2003 17:06:50 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA14303;
	Wed, 16 Jul 2003 09:06:46 -0700
Subject: Re: [PATCH] [2.6.0-test1] Alchemy Pb1500 - Power management
From: Pete Popov <ppopov@mvista.com>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <1058348289.10765.1527.camel@caernarfon>
References: <1058348289.10765.1527.camel@caernarfon>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1058371630.27085.4.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Jul 2003 09:07:10 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Thanks.

BTW, I'm waiting for some PM patches from Embedded Edge that will
cleanup and Au1x PM support.

Pete

On Wed, 2003-07-16 at 02:38, Liam Girdwood wrote:
> Hi,
> 
> I'm working my way through building the latest CVS for my Pb1500 and
> I've run into a couple of build problems.
> 
> This patch fixes some function naming problems and removes duplicate
> symbol au1k_wait() (defined in kernel/cpu-probe.c) in the Pb1500 power
> management code.
> 
> Index: arch/mips/au1000/common/power.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/common/power.c,v
> retrieving revision 1.10
> diff -r1.10 power.c
> 36a37
> > #include <linux/jiffies.h>
> 54,55c55,56
> < extern void set_au1000_speed(unsigned int new_freq);
> < extern unsigned int get_au1000_speed(void);
> ---
> > extern void set_au1x00_speed(unsigned int new_freq);
> > extern unsigned int get_au1x00_speed(void);
> 190,191c191,192
> < 		old_baud_base = get_au1000_uart_baud_base();
> < 		old_cpu_freq = get_au1000_speed();
> ---
> > 		old_baud_base = get_au1x00_uart_baud_base();
> > 		old_cpu_freq = get_au1x00_speed();
> 195,196c196,197
> < 		set_au1000_speed(new_cpu_freq);
> < 		set_au1000_uart_baud_base(new_baud_base);
> ---
> > 		set_au1x00_speed(new_cpu_freq);
> > 		set_au1x00_uart_baud_base(new_baud_base);
> 325,329d325
> < }
> < 
> < void au1k_wait(void)
> < {
> < 	__asm__("nop\n\t" "nop\n\t");
> 
> 
> Liam
