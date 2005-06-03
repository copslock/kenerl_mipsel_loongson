Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2005 10:23:55 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:43802 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226141AbVFCJXk>; Fri, 3 Jun 2005 10:23:40 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j539M5Sd008819
	for <linux-mips@linux-mips.org>; Fri, 3 Jun 2005 10:22:05 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j539M5rD008818
	for linux-mips@linux-mips.org; Fri, 3 Jun 2005 10:22:05 +0100
Date:	Fri, 3 Jun 2005 10:22:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050603092205.GA4573@linux-mips.org>
References: <20050603022113Z8226140-1340+8064@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603022113Z8226140-1340+8064@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 03, 2005 at 03:21:13AM +0100, ths@linux-mips.org wrote:

> Log message:
> 	Fix R4[04]00 hazards breakage.
> 
> diff -urN linux/arch/mips/mm/tlbex-r4k.S linux/arch/mips/mm/tlbex-r4k.S
> --- linux/arch/mips/mm/Attic/tlbex-r4k.S	2004/11/25 22:18:38	1.2.2.19
> +++ linux/arch/mips/mm/Attic/tlbex-r4k.S	2005/06/03 02:21:06	1.2.2.20
> @@ -186,6 +186,7 @@
>  	P_MTC0	k1, CP0_ENTRYLO1		# load it
>  	mtc0_tlbw_hazard
>  	tlbwr					# write random tlb entry
> +	nop
>  	tlbw_eret_hazard

I did previously object to a similar patch - why not fix tlbw_eret_hazard
instead.

  Ralf
