Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 11:38:52 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:43163 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20037785AbWIKKiu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2006 11:38:50 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id AF43246407; Mon, 11 Sep 2006 12:38:38 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GMiPZ-0004jf-Un; Mon, 11 Sep 2006 10:49:05 +0100
Date:	Mon, 11 Sep 2006 10:49:05 +0100
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	nigel@mips.com, ralf@linux-mips.org, dan@debian.org,
	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
Message-ID: <20060911094905.GB13414@networkno.de>
References: <20060909.225641.41198763.anemo@mba.ocn.ne.jp> <450491FA.3010600@mips.com> <20060911.140403.126141483.nemoto@toshiba-tops.co.jp> <20060911.175029.37531637.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911.175029.37531637.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
[snip]
> @@ -375,6 +376,72 @@ #endif
>  	BUILD_HANDLER dsp dsp sti silent		/* #26 */
>  	BUILD_HANDLER reserved reserved sti verbose	/* others */
>  
> +	.align	5
> +	LEAF(handle_ri_rdhwr_vivt)
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	PANIC_PIC("handle_ri_rdhwr_vivt called")
> +#else
> +	.set	push
> +	.set	noat
> +	.set	noreorder
> +	/* check if TLB contains a entry for EPC */
> +	MFC0	k1, CP0_ENTRYHI
> +	andi	k1, 0xff	/* ASID_MASK */
> +	MFC0	k0, CP0_EPC
> +	PTR_SRL	k0, PAGE_SHIFT + 1
> +	PTR_SLL	k0, PAGE_SHIFT + 1
> +	or	k1, k0
> +	MTC0	k1, CP0_ENTRYHI
> +	mtc0_tlbw_hazard
> +	tlbp

This needs a .set mips3/.set mips0 pair.

> +#ifdef CONFIG_CPU_MIPSR2
> +	_ehb			/* tlb_probe_hazard */
> +#else
> +	nop; nop; nop; nop; nop; nop	/* tlb_probe_hazard */
> +#endif

What about a mtc0_tlbp_hazard macro here?


Thiemo
