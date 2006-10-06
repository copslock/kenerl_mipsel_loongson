Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 18:22:00 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:60884 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20039482AbWJFRVy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2006 18:21:54 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 3BD66455A7; Fri,  6 Oct 2006 19:21:51 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GVtOT-0006QZ-3S; Fri, 06 Oct 2006 18:21:53 +0100
Date:	Fri, 6 Oct 2006 18:21:53 +0100
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
Message-ID: <20061006172153.GB4456@networkno.de>
References: <45265BF0.8080103@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45265BF0.8080103@innova-card.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> This patch introduces __pa_symbol() macro which should be used to
> calculate the physical address of kernel symbols. We should fix any
> linker issues in this macro, if any, but more importantly
> __pa_symbol() uses __pa() to do the real conversion.
> 
> One resulting thing is that we can see that most of CPHYSADDR() uses
> weren't needed.
> 
> It also rely on RELOC_HIDE() to avoid any compiler's oddities when
> doing arithmetics on symbols.
> 
> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
>  arch/mips/kernel/setup.c |   17 ++++++++++-------
>  include/asm-mips/page.h  |    1 +
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index fdbb508..cccccd5 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -204,12 +204,12 @@ static void __init finalize_initrd(void)
>  		printk(KERN_INFO "Initrd not found or empty");
>  		goto disable;
>  	}
> -	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
> +	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {

ISTR this failed on O2, where kernel+initrd are loaded into KSEG0 but the
PAGE_OFFSET is for XKPHYS.


Thiemo
