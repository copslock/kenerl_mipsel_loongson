Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2014 23:36:01 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:36886 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860188AbaHBVfyCS5w- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Aug 2014 23:35:54 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XDgxm-0008PS-ER; Sat, 02 Aug 2014 23:35:38 +0200
Date:   Sat, 2 Aug 2014 23:35:38 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james@albanarts.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
Message-ID: <20140802213538.GC19066@hall.aurel32.net>
References: <1406616880-17142-1-git-send-email-chenhc@lemote.com>
 <2357839.vPXx615ci5@radagast>
 <53D9674E.4000507@caviumnetworks.com>
 <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com>
 <53D99854.8090109@caviumnetworks.com>
 <53DA2E66.20200@imgtec.com>
 <53DA7E03.9090306@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <53DA7E03.9090306@caviumnetworks.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Jul 31, 2014 at 10:33:55AM -0700, David Daney wrote:
> On 07/31/2014 04:54 AM, James Hogan wrote:
> >Hi,
> >
> >On 31/07/14 02:13, David Daney wrote:
> >>On 07/30/2014 05:48 PM, Huacai Chen wrote:
> >>>For non-Octeon CPU, htlb_info.huge_pte is equal to K0, but I don't
> >>>know much about Octeon. So I think you know whether we should use K0
> >>>  or htlb_info.huge_pte here, since you are the original author.
> >>>
> >>
> >>This is why I requested that somebody show me a disassembly of the
> >>faulty handler.  I cannot tell where the problem is unless I see that.

Here is the faulty handler, that is a dump on a machine affected by the
bug:

| #define _PAGE_PRESENT_SHIFT 0
| #define _PAGE_READ_SHIFT 1
| #define _PAGE_WRITE_SHIFT 2
| #define _PAGE_ACCESSED_SHIFT 3
| #define _PAGE_MODIFIED_SHIFT 4
| #define _PAGE_HUGE_SHIFT 5
| #define _PAGE_SPLITTING_SHIFT 6
| #define _PAGE_GLOBAL_SHIFT 7
| #define _PAGE_VALID_SHIFT 8
| #define _PAGE_DIRTY_SHIFT 9
| #define _PFN_SHIFT 13
| 
| 0000000000000000 <r4000_tlb_refill>:
|    0:	001ad1fa 	dsrl	k0,k0,0x7
|    4:	40ba1000 	dmtc0	k0,c0_entrylo0
|    8:	675a4000 	daddiu	k0,k0,16384
|    c:	40ba1800 	dmtc0	k0,c0_entrylo1
|   10:	3c1a001f 	lui	k0,0x1f
|   14:	375ae000 	ori	k0,k0,0xe000
|   18:	409a2800 	mtc0	k0,c0_pagemask
|   1c:	42000006 	tlbwr
|   20:	10000031 	b	e8 <r4000_tlb_refill+0xe8>
|   24:	40802800 	mtc0	zero,c0_pagemask
|   28:	10000019 	b	90 <r4000_tlb_refill+0x90>
|   2c:	3c1b8095 	lui	k1,0x8095
| 	...
|   80:	403a4000 	dmfc0	k0,c0_badvaddr
|   84:	0740ffe8 	bltz	k0,28 <r4000_tlb_refill+0x28>
|   88:	3c1b8095 	lui	k1,0x8095
|   8c:	df7b4fb0 	ld	k1,20400(k1)
|   90:	001ad6fa 	dsrl	k0,k0,0x1b
|   94:	335a1ff8 	andi	k0,k0,0x1ff8
|   98:	037ad82d 	daddu	k1,k1,k0
|   9c:	403a4000 	dmfc0	k0,c0_badvaddr
|   a0:	df7b0000 	ld	k1,0(k1)
|   a4:	001ad4ba 	dsrl	k0,k0,0x12
|   a8:	335a0ff8 	andi	k0,k0,0xff8
|   ac:	037ad82d 	daddu	k1,k1,k0
|   b0:	df7a0000 	ld	k0,0(k1)
|   b4:	335a0020 	andi	k0,k0,0x20
|   b8:	1740ffd1 	bnez	k0,0 <r4000_tlb_refill>
|   bc:	403aa000 	dmfc0	k0,c0_xcontext
|   c0:	df7b0000 	ld	k1,0(k1)
|   c4:	335a0ff0 	andi	k0,k0,0xff0
|   c8:	037ad82d 	daddu	k1,k1,k0
|   cc:	df7a0000 	ld	k0,0(k1)
|   d0:	df7b0008 	ld	k1,8(k1)
|   d4:	001ad1fa 	dsrl	k0,k0,0x7
|   d8:	40ba1000 	dmtc0	k0,c0_entrylo0
|   dc:	001bd9fa 	dsrl	k1,k1,0x7
|   e0:	40bb1800 	dmtc0	k1,c0_entrylo1
|   e4:	42000006 	tlbwr
|   e8:	42000018 	eret
| 	...

> >>Really I think the problem is in build_is_huge_pte(), where we are
> >>clobbering 'tmp' which is K0.

Indeed, that is the problem. In the above code build_is_huge_pte()
corresponds to addresses b4 and b8. It needs huge_pte loaded in K0, but
at the same time it clobbers it. That's the reason why prior to commit
2c8c53e28f1, k0 was reloaded before calling build_huge_update_entries.

> >>So you could reload tmp/K0 in build_is_huge_pte().
> >
> >b4 is apparently where it branches back to the huge page case at the
> >beginning. In that case the at register (htlb_info.huge_pte) is set to
> >*(k1+at) instead of *(k1), so loading to htlb_info.huge_pte instead of
> >k0 would I think be bad and change the behaviour. So forget my suggestion!
> >
> >On the other hand loading the pte to k0 is redundant when
> >build_fast_tlb_refill_handler is used (which depends on bbit1), and also
> >in the other case if bbit1 is available since it won't get clobbered by
> >build_is_huge_pte().
> >
> >Maybe the reload should simply be conditional on !use_bbit_insns()?
> >
> 
> That was kind of my suggestion.  What happens if you do something
> like (untested):
> 
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -716,6 +716,7 @@ build_is_huge_pte(u32 **p, struct uasm_reloc
> **r, unsigned int tmp,
>         } else {
>                 uasm_i_andi(p, tmp, tmp, _PAGE_HUGE);
>                 uasm_il_bnez(p, r, tmp, lid);
> +               UASM_i_LW(p, tmp, 0, pmd);
>         }
>  }

I haven't tested it, but it my opinion this patch won't work or at least
is suboptimal given build_is_huge_pte is also used to build
r4000_tlb_load, r4000_tlb_store and r4000_tlb_modify handlers.

> or
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index f99ec587..341add1 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1299,6 +1299,8 @@ static void build_r4000_tlb_refill_handler(void)
>         }
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>         uasm_l_tlb_huge_update(&l, p);
> +       if (!use_bbit_insns())
> +               UASM_i_LW(&p, K0, 0, K1);
>         build_huge_update_entries(&p, htlb_info.huge_pte, K1);
>         build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
>                                    htlb_info.restore_scratch);

This patch fixes the issue, thanks. That said it doesn't look fully
correct. The test should be done the same way as for
build_fast_tlb_refill_handler. For example the fast handler is not
called on a 32-bit machine with bbit instructions, so it would need
to reload K0.

Now I do wonder if we should add yet another test there, or simply move
and duplicate these 3 or 4 lines in the fast and non-fast branches. At 
least it will improve readability.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
