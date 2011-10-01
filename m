Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2011 09:43:15 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4198 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491130Ab1JAHnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2011 09:43:07 +0200
X-TM-IMSS-Message-ID: <46d24d3d00010283@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 46d24d3d00010283 ; Sat, 1 Oct 2011 00:42:59 -0700
Date:   Sat, 1 Oct 2011 13:09:36 +0530
From:   Jayachandran C. <jayachandranc@netlogicmicro.com>
To:     Hillf Danton <dhillf@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] count TLB refill for Netlogic XLR chip
Message-ID: <20111001073936.GA15674@jayachandranc.netlogicmicro.com>
References: <CAJd=RBDQ9eyfgWkgsdUrojteqbnribZyk0QATr3CgPXLbBDkPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJd=RBDQ9eyfgWkgsdUrojteqbnribZyk0QATr3CgPXLbBDkPQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 01 Oct 2011 07:39:36.0568 (UTC) FILETIME=[44E4D780:01CC800D]
X-archive-position: 31194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 129

On Sat, Oct 01, 2011 at 01:19:53PM +0800, Hillf Danton wrote:
> TLB miss is one of the concerned factors when tuning the performance of user
> applications, and there are on netlogic XLR chip eight 64-bit registers,
> c0 register 22 select 0-7, which could be used as temporary storage.
> 
> One of them is used for counting TLB refill, and any comment is appreciated.
> 

Few comments:

Adding this unconditionally will add overhead to the TLB refill handler, this
should be probably controlled by a boot-time variable, or with some
perf/profile framework.

If you have access to our SDK, it uses register 22,2 for counting TLB misses
it would be good to retain that compability, otherwise it will mess up when
we merge this back to our internal code.

The reporting part currently will only print the misses on a crash (if I am
not mistaken), again this has to be tied in with some standard framework.


> Signed-off-by: Hillf Danton <dhillf@gmail.com>
> ---
> 
> --- a/arch/mips/mm/tlbex.c	Sat Aug 13 11:44:39 2011
> +++ b/arch/mips/mm/tlbex.c	Sat Oct  1 12:41:07 2011
> @@ -1239,6 +1239,11 @@ static void __cpuinit build_r4000_tlb_re
>  	memset(relocs, 0, sizeof(relocs));
>  	memset(final_handler, 0, sizeof(final_handler));
> 
> +	if (current_cpu_type() == CPU_XLR) {
> +		UASM_i_MFC0(p, K0, 22, 0);
> +		UASM_i_ADDIU(p, K0, K0, 1);
> +		UASM_i_MTC0(p, K0, 22, 0);
> +	}
>  	if ((scratch_reg > 0 || scratchpad_available()) && use_bbit_insns()) {
>  		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
>  							  scratch_reg);
> --- a/arch/mips/lib/dump_tlb.c	Sat May 14 15:21:02 2011
> +++ b/arch/mips/lib/dump_tlb.c	Sat Oct  1 12:46:19 2011
> @@ -99,6 +99,10 @@ static void dump_tlb(int first, int last
>  			       (entrylo1 & 1) ? 1 : 0);
>  		}
>  	}
> +	if (current_cpu_type() == CPU_XLR) {
> +		entrylo0 = __read_64bit_c0_register($22, 0);
> +		printk("TLB refill count %llu\n", entrylo0);
> +	}
>  	printk("\n");
> 
>  	write_c0_entryhi(s_entryhi);

JC.
