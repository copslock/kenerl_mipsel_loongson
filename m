Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 18:39:53 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:35477 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S28641845AbYECRjq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 May 2008 18:39:46 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m43HcqrV016504
	for <linux-mips@linux-mips.org>; Sat, 3 May 2008 10:38:53 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m43HdTs3010586;
	Sat, 3 May 2008 18:39:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m43HdSVV010579;
	Sat, 3 May 2008 18:39:28 +0100
Date:	Sat, 3 May 2008 18:39:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	tsbogend@alpha.franken.de, linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
Message-ID: <20080503173927.GA19925@linux-mips.org>
References: <20080501163314.GA9955@alpha.franken.de> <20080502101113.GA24408@linux-mips.org> <20080504.011647.93019265.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080504.011647.93019265.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 04, 2008 at 01:16:47AM +0900, Atsushi Nemoto wrote:

> Then how about this fix?
> 
> ---------------------------------------------------------------------
> Subject: [PATCH] Fix detection of kernel segment on 64-bit
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index cb8b0e2..7893bb3 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -78,6 +78,19 @@ void (*board_nmi_handler_setup)(void);
>  void (*board_ejtag_handler_setup)(void);
>  void (*board_bind_eic_interrupt)(int irq, int regset);
>  
> +static inline int kernel_unmapped_seg(void *addr)
> +{
> +	unsigned long a = (unsigned long)addr;
> +
> +#ifdef CONFIG_32BIT
> +	/* KSEG0 or KSEG1 */
> +	return (a & 0xc0000000) == KSEG0;

Slightly cleaner:

  return KSEGX(a) == KSEG0;

Unfortunately there is no such macro for the 64-bit segments nor does
the existing KSEGX() work correctly for non-CKSEGx 64-bit addresses.

  Ralf
