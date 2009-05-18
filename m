Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 00:27:25 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17220 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024466AbZERX1S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 00:27:18 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a11eebc0000>; Mon, 18 May 2009 19:26:52 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 May 2009 16:26:55 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 May 2009 16:26:55 -0700
Message-ID: <4A11EEBF.8020007@caviumnetworks.com>
Date:	Mon, 18 May 2009 16:26:55 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fold the TLB refill at the vmalloc path if possible
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com> <20090513002337.GA12536@cuplxvomd02.corp.sa.net> <4A0A1E6B.6050908@caviumnetworks.com> <alpine.LFD.1.10.0905160706300.12158@ftp.linux-mips.org> <4A118BE8.50201@caviumnetworks.com> <alpine.LFD.1.10.0905181829270.20791@ftp.linux-mips.org> <alpine.LFD.1.10.0905182011260.20791@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0905182011260.20791@ftp.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 May 2009 23:26:55.0445 (UTC) FILETIME=[21C5B050:01C9D810]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  Try to fold the 64-bit TLB refill handler opportunistically at the 
> beginning of the vmalloc path so as to avoid splitting execution flow in 
> half and wasting cycles for a branch required at that point then.  Resort 
> to doing the split if either of the newly created parts would not fit into 
> its designated slot.
> 

Unless you have an objection, I will test this, forward ported to the 
HEAD and modified to work with my patch that gets rid of all the magic 
numbers.  And then send the result to Ralf.

David Daney



> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> David,
> 
>  So I took the opportunity and spent a few minutes cooking up thich 
> change.  It works correctly with my SWARM filling the XTLB handler slot 
> with the fast path up to the offset of 0x6c inclusive, where the final 
> ERET is placed and the TLB handler slot with the vmalloc path, up to 0x14 
> inclusive.  With the M3 workaround enabled it correctly resorts to 
> inserting a branch with the ERET landing at 0x10 into the TLB slot.
> 
>  It's meant to work for your case -- please try it. :)  Unfortunately I 
> lack the resources to check with a more modern kernel, but I hope it 
> applies cleanly; if that turns out to be a problem, then I can look into 
> it later.  I haven't updated the space exhaustion check for the corner 
> case of both parts being exactly 32 instructions with the ERET at 0x7c 
> into the XTLB slot; I'm leaving it as an exercise for the first one to 
> actually hit such a scenario. ;)
> 
>  Further improvement might include getting rid of #ifdef MODULE_START 
> directives scattered throughout the file.
> 
>  Ralf, please consider.
> 
>   Maciej
> 
> patch-mips-2.6.27-rc8-20081004-mips-tlbex-fold-0
> Index: linux-mips-2.6.27-rc8-20081004-swarm-eb/arch/mips/mm/tlbex.c
> ===================================================================
> --- linux-mips-2.6.27-rc8-20081004-swarm-eb.orig/arch/mips/mm/tlbex.c
> +++ linux-mips-2.6.27-rc8-20081004-swarm-eb/arch/mips/mm/tlbex.c
> @@ -6,7 +6,7 @@
>   * Synthesize TLB refill handlers at runtime.
>   *
>   * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
> - * Copyright (C) 2005, 2007, 2008  Maciej W. Rozycki
> + * Copyright (C) 2005, 2007, 2008, 2009  Maciej W. Rozycki
>   * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
>   *
>   * ... and the days got worse and worse and now you see
> @@ -19,6 +19,7 @@
>   * (Condolences to Napoleon XIV)
>   */
>  
> +#include <linux/bug.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/string.h>
> @@ -738,28 +739,52 @@ static void __cpuinit build_r4000_tlb_re
>  		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
>  		final_len = p - tlb_handler;
>  	} else {
> -		u32 *split = tlb_handler + 30;
> +#ifdef MODULE_START
> +		const enum label_id ls = label_module_alloc;
> +#else
> +		const enum label_id ls = label_vmalloc;
> +#endif
> +		const int ie = sizeof(labels) / sizeof(labels[0]);
> +		u32 *split;
> +		int ov = 0;
> +		int i;
>  
>  		/*
>  		 * Find the split point.
>  		 */
> -		if (uasm_insn_has_bdelay(relocs, split - 1))
> -			split--;
> +		for (i = 0; i < ie && labels[i].lab != ls; i++);
> +		BUG_ON(i == ie);
> +		split = labels[i].addr;
> +
> +		/*
> +		 * See if we have overflown one way or the other.
> +		 */
> +		if (split > tlb_handler + 32 || split < p - 32)
> +			ov = 1;
> +
> +		if (ov) {
> +			split = tlb_handler + 30;
> +			if (uasm_insn_has_bdelay(relocs, split - 1))
> +				split--;
> +		}
>  
>  		/* Copy first part of the handler. */
>  		uasm_copy_handler(relocs, labels, tlb_handler, split, f);
>  		f += split - tlb_handler;
>  
> -		/* Insert branch. */
> -		uasm_l_split(&l, final_handler);
> -		uasm_il_b(&f, &r, label_split);
> -		if (uasm_insn_has_bdelay(relocs, split))
> -			uasm_i_nop(&f);
> -		else {
> -			uasm_copy_handler(relocs, labels, split, split + 1, f);
> -			uasm_move_labels(labels, f, f + 1, -1);
> -			f++;
> -			split++;
> +		if (ov) {
> +			/* Insert branch. */
> +			uasm_l_split(&l, final_handler);
> +			uasm_il_b(&f, &r, label_split);
> +			if (uasm_insn_has_bdelay(relocs, split))
> +				uasm_i_nop(&f);
> +			else {
> +				uasm_copy_handler(relocs, labels,
> +						  split, split + 1, f);
> +				uasm_move_labels(labels, f, f + 1, -1);
> +				f++;
> +				split++;
> +			}
>  		}
>  
>  		/* Copy the rest of the handler. */
> 
