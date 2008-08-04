Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 21:54:38 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:3457 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20046740AbYHDUyb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2008 21:54:31 +0100
Received: (qmail invoked by alias); 04 Aug 2008 20:54:24 -0000
Received: from p548B1C75.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.28.117]
  by mail.gmx.net (mp040) with SMTP; 04 Aug 2008 22:54:24 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX19B8IhoX95BKDmGgssO+/jAFT6CLhyyYDvoyHgrRr
	34rnhaY8ZtMxp7
Message-ID: <48976C86.60701@gmx.de>
Date:	Mon, 04 Aug 2008 22:54:30 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH/RFC]: SGI Octane (IP30) Patches, Part two, Octane core
References: <48914C74.6090309@gentoo.org>
In-Reply-To: <48914C74.6090309@gentoo.org>
X-Enigmail-Version: 0.95.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Kumba schrieb:
> 
> The second part is the actual IP30 Patch that makes these beasts boot. 
> Assuming you've already lit incense candles and sacrificed a PC to the
> MIPS Gods above.
> 

> That's just one example, though.  There's probably more, but I've mostly
> done forward ports, and haven't really messed with re-writing much. 
> Hence why I'd like to ask others to look, poke, prod, compile, and boot,
> and see if they have other suggestions for improving and fixing this up.

I think there is a problem on SMP kernels.
In include/asm-mips/mach-ip30/heart.h

> +/* HEART internal register space */
> +#define HEART_PIU_BASE         0x900000000ff00000
> +
> +/* full addresses */
> +#define HEART_MODE             ((volatile ulong *)0x900000000ff00000)
> +#define HEART_SDRAM_MODE       ((volatile ulong *)0x900000000ff00008)
> +#define HEART_MEM_REF          ((volatile ulong *)0x900000000ff00010)
> +#define HEART_MEM_REQ_ARB      ((volatile ulong *)0x900000000ff00018)
> +#define        HEART_MEMCFG0           ((volatile ulong *)0x900000000ff00020)
> +#define        HEART_MEMCFG1           ((volatile ulong *)0x900000000ff00028)
> +#define        HEART_MEMCFG2           ((volatile ulong *)0x900000000ff00030)
> +#define        HEART_MEMCFG3           ((volatile ulong *)0x900000000ff00038)
> +#define HEART_FC_MODE          ((volatile ulong *)0x900000000ff00040)
> +#define HEART_FC_TIMER_LIMIT   ((volatile ulong *)0x900000000ff00048)
> +#define HEART_FC0_ADDR         ((volatile ulong *)0x900000000ff00050)
> +#define HEART_FC1_ADDR         ((volatile ulong *)0x900000000ff00058)
> +#define HEART_FC0_CR_CNT       ((volatile ulong *)0x900000000ff00060)
> +#define HEART_FC1_CR_CNT       ((volatile ulong *)0x900000000ff00068)
> +#define HEART_FC0_TIMER                ((volatile ulong *)0x900000000ff00070)
> +#define HEART_FC1_TIMER                ((volatile ulong *)0x900000000ff00078)
> +#define HEART_STATUS           ((volatile ulong *)0x900000000ff00080)
> +#define HEART_BERR_ADDR                ((volatile ulong *)0x900000000ff00088)
> +#define HEART_BERR_MISC                ((volatile ulong *)0x900000000ff00090)
> +#define HEART_MEMERR_ADDR      ((volatile ulong *)0x900000000ff00098)
> +#define HEART_MEMERR_DATA      ((volatile ulong *)0x900000000ff000a0)
> +#define HEART_PIUR_ACC_ERR     ((volatile ulong *)0x900000000ff000a8)
> +#define        HEART_MLAN_CLK_DIV      ((volatile ulong *)0x900000000ff000b0)
> +#define        HEART_MLAN_CTL          ((volatile ulong *)0x900000000ff000b8)

> +#define HEART_IMR(x)           ((volatile ulong *)0x900000000ff10000 + (8 * (x)))

This gives a wrong address for the second IRQ Mask Register.
I schould be.

  #define HEART_IMR(x)           ((volatile ulong *)(0x900000000ff10000 + (8 * (x))))
                                                    .                              .
  this two braces more , because without it 8*8*(x) was added to the base addr.
  checked in the assembler and on a DUAL IP30.
  without it it got stopped early with no output.
  with it it stopped much later. sometimes i got a starting and then stopped init.
  now it goes until initcall genl_init wich is generic netlink init.
  a smp kernel fully works with only one cpu in both versions.
  a patch for a 2.6.20 kernel was more like my versions too.

 
> +#define HEART_SET_ISR          ((volatile ulong *)0x900000000ff10020)
> +#define HEART_CLR_ISR          ((volatile ulong *)0x900000000ff10028)
> +#define HEART_ISR              ((volatile ulong *)0x900000000ff10030)
> +#define HEART_IMSR             ((volatile ulong *)0x900000000ff10038)
> +#define HEART_CAUSE            ((volatile ulong *)0x900000000ff10040)
> +#define HEART_COUNT            ((volatile ulong *)0x900000000ff20000)  /* 52-bit counter */
> +#define HEART_COMPARE          ((volatile ulong *)0x900000000ff30000)  /* 24-bit compare */
> +#define HEART_TRIGGER          ((volatile ulong *)0x900000000ff40000)
> +#define HEART_PRID             ((volatile ulong *)0x900000000ff50000)
> +#define HEART_SYNC             ((volatile ulong *)0x900000000ff60000)

> Thanks!,
> 
> 
> --Kumba
> 
