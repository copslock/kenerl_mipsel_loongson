Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2005 22:35:55 +0100 (BST)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:65030 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8225534AbVISVfj>; Mon, 19 Sep 2005 22:35:39 +0100
Received: from Snailmail (217.249.192.183)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Mon, 19 Sep 2005 23:32:50 +0200
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id j8JLWnfc001481
	for <linux-mips@linux-mips.org>; Mon, 19 Sep 2005 23:32:50 +0200
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.11-rc3-ip28) with ESMTP id j8JLWndB032611
	for <linux-mips@linux-mips.org>; Mon, 19 Sep 2005 23:32:49 +0200
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id j8JLWn1v032608
	for <linux-mips@linux-mips.org>; Mon, 19 Sep 2005 23:32:49 +0200
Date:	Mon, 19 Sep 2005 19:31:44 +0200 (CEST)
From:	peter fuerst <pf@net.alphadv.de>
To:	linux-mips-bounce@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
In-Reply-To: <20050919154056.GG3386@hattusa.textio>
Message-ID: <Pine.LNX.4.58.0509191912110.14548@Indigo2.Peter>
References: <20050919154056.GG3386@hattusa.textio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
ReSent-Date: Mon, 19 Sep 2005 23:32:40 +0200 (CEST)
ReSent-From: peter fuerst <pf@net.alphadv.de>
ReSent-To: linux-mips@linux-mips.org
ReSent-Subject:	Re: Performance bug in c-r4k.c cache handling code
ReSent-Message-ID: <Pine.LNX.4.58.0509192332400.32606@Indigo2.Peter>
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hello,

r4k_dma_cache_wback_inv and r4k_dma_cache_inv always had the same function
body.  With some invocations (on some machine at least ;) this does not only
affect performance, but also is corrupting (dma-)memory, so it had to be
adjusted in the IP28-patches from the beginning.  I had some correspondence
with Ralf about it some months ago. He hesitated to take over this changes
because of the reasons mentioned below. (so btw. IP28 got its own
r10k_dma_cache_inv :)

kind regards

pf


On Mon, 19 Sep 2005, Thiemo Seufer wrote:

> Date: Mon, 19 Sep 2005 17:40:56 +0200
> From: Thiemo Seufer <ths@networkno.de>
> Reply-To: linux-mips-bounce@linux-mips.org
> To: linux-mips@linux-mips.org
> Subject: Performance bug in c-r4k.c cache handling code
>
> Hello All,
>
> I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
> Hit_Writeback_Inv instead of Hit_Invalidate is done. Ralf mentioned
> this is probably due to broken Hit_Invalidate cache ops on some
> CPUs, does anybody have more information about this? The appended
> patch works apparently fine on R4400, R4600v2.0, R5000.
>
>
> Thiemo
>
>
> Index: arch/mips/mm/c-r4k.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
> retrieving revision 1.119
> diff -u -p -r1.119 c-r4k.c
> --- arch/mips/mm/c-r4k.c	9 Sep 2005 20:26:54 -0000	1.119
> +++ arch/mips/mm/c-r4k.c	19 Sep 2005 15:33:35 -0000
> @@ -685,7 +685,7 @@ static void r4k_dma_cache_inv(unsigned l
>  		a = addr & ~(sc_lsize - 1);
>  		end = (addr + size - 1) & ~(sc_lsize - 1);
>  		while (1) {
> -			flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
> +			invalidate_scache_line(a);	/* Hit_Invalidate_SD */
>  			if (a == end)
>  				break;
>  			a += sc_lsize;
> @@ -702,7 +702,7 @@ static void r4k_dma_cache_inv(unsigned l
>  		a = addr & ~(dc_lsize - 1);
>  		end = (addr + size - 1) & ~(dc_lsize - 1);
>  		while (1) {
> -			flush_dcache_line(a);	/* Hit_Writeback_Inv_D */
> +			invalidate_dcache_line(a);	/* Hit_Invalidate_D */
>  			if (a == end)
>  				break;
>  			a += dc_lsize;
>
>
