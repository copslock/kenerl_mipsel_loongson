Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 18:05:17 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:43233 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021404AbXGSRFP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2007 18:05:15 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 4FA0E84B62;
	Thu, 19 Jul 2007 18:28:18 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IBYrR-0007Y6-Lo; Thu, 19 Jul 2007 17:28:17 +0100
Date:	Thu, 19 Jul 2007 17:28:17 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix known HW bug with MIPS core on NXP/Philips PNX8550
Message-ID: <20070719162817.GA17651@networkno.de>
References: <469F822D.9040209@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469F822D.9040209@nxp.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Daniel Laird wrote:
> Update Patch
>
> Fix known bug with MIPS core when using TLB on NXP/Philips PNX8550
>
> Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>
> ---
> tlb-r4k.c |    4 +++
> tlbex.c   |   71 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 75 insertions(+)
> ---
> Index: linux-2.6.22.1/arch/mips/mm/tlbex.c
> ===================================================================
> --- linux-2.6.22.1/arch/mips/mm/tlbex.c    (revision 8)
> +++ linux-2.6.22.1/arch/mips/mm/tlbex.c    (working copy)
> @@ -435,6 +435,9 @@
>     label_nopage_tlbm,
>     label_smp_pgtable_change,
>     label_r3000_write_probe_fail,
> +#ifdef CONFIG_PNX8550
> +    label_pnx8550_bac_reset
> +#endif

Please don't use #ifdef where it isn't needed ...

[snip]
> +static void __init build_pnx8550_bug_fix( u32 **p, struct label **l, 
> struct reloc **r)
> +{
> +#define MFC0(_reg, _cp, _sel)    \
> +    ((cop0_op)  << OP_SH    \
> +    | (mfc_op) << RS_SH    \
> +    | (_reg)   << RT_SH    \
> +    | (_cp)    << RD_SH    \
> +    | (_sel))
> +
> +#define MTC0(_reg, _cp, _sel)    \
> +    ((cop0_op)  << OP_SH    \
> +    | (mtc_op) << RS_SH    \
> +    | (_reg)   << RT_SH    \
> +    | (_cp)    << RD_SH    \
> +    | (_sel))

... don't reinvent the wheel ...

[snip]
> @@ -1261,8 +1328,12 @@
>     build_get_ptep(&p, K0, K1);
>     build_update_entries(&p, K0, K1);
> +#ifndef CONFIG_PNX8550
>     build_tlb_write_entry(&p, &l, &r, tlb_random);
>     l_leave(&l, p);
> +#else
> +    build_pnx8550_bug_fix(&p, &l, &r);
> +#endif

... and make that a runtime check.

>     i_eret(&p); /* return from trap */
> #ifdef CONFIG_64BIT
> Index: linux-2.6.22.1/arch/mips/mm/tlb-r4k.c
> ===================================================================
> --- linux-2.6.22.1/arch/mips/mm/tlb-r4k.c    (revision 8)
> +++ linux-2.6.22.1/arch/mips/mm/tlb-r4k.c    (working copy)
> @@ -456,7 +456,11 @@
>      */
>     probe_tlb(config);
>     write_c0_pagemask(PM_DEFAULT_MASK);
> +#ifdef CONFIG_SOC_PNX8550
> +    write_c0_wired(11);
> +#else
>     write_c0_wired(0);
> +#endif

11 wired entries sounds excessive to me. Is it really necessary to
kill that much performance?


Thiemo
