Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 20:23:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18514 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990644AbdFLSXnQX1ei (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2017 20:23:43 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3702941F8E74;
        Mon, 12 Jun 2017 20:32:57 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 12 Jun 2017 20:32:57 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 12 Jun 2017 20:32:57 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8DB0EE92397EC;
        Mon, 12 Jun 2017 19:23:33 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 12 Jun 2017 19:23:37 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 12 Jun
 2017 19:23:37 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 12 Jun
 2017 11:23:35 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Hardcode cpu_has_* where known at compile time due to ISA
Date:   Mon, 12 Jun 2017 11:23:28 -0700
Message-ID: <1645206.SpfHWSWaJU@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <43f9a0a3-bc2b-b3c5-7ee9-e8dcb6ff90e8@gentoo.org>
References: <20170610002130.7898-1-paul.burton@imgtec.com> <43f9a0a3-bc2b-b3c5-7ee9-e8dcb6ff90e8@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2162231.G4V5cdszci";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart2162231.G4V5cdszci
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Joshua,

On Saturday, 10 June 2017 19:38:43 PDT Joshua Kinard wrote:
> On 06/09/2017 20:21, Paul Burton wrote:
> > Many architectural features have over time moved from being optional to
> > either be required or removed by newer architecture releases. This means
> > that in many cases we can know at compile time whether a feature will be
> > supported or not purely due to the knowledge we have about the ISA the
> > kernel build is targeting.
> > 
> > This patch introduces a bunch of utility macros for checking for
> > supported options, ASEs & combinations of those with ISA revisions. It
> > then makes use of these in the default definitions of cpu_has_* macros.
> > The result is that many of the macros become compile-time constant,
> > allowing more optimisation opportunities for the compiler - particularly
> > with kernels built for later ISA revisions.
> > 
> > To demonstrate the effect of this patch, the following table shows the
> > size in bytes of the kernel binary as reported by scripts/bloat-o-meter
> > for v4.12-rc4 maltasmvp_defconfig kernels with & without this patch. A
> > variant of maltasmvp_defconfig with CONFIG_CPU_MIPS32_R6 selected is
> > also shown, to demonstrate that MIPSr6 systems benefit more due to extra
> > features becoming required by that architecture revision. Builds of
> > pistachio_defconfig are also shown, as although this is a MIPSr2
> > platform it doesn't hardcode any features in a machine-specific
> > cpu-feature-overrides.h, which allows it to gain more from this patch
> > than the equivalent Malta r2 build.
> > 
> >      Config         | Before  | After   |  Change
> >     
> >     ----------------|---------|---------|---------
> >     
> >      maltasmvp      | 7248316 | 7247714 |    -602
> >      maltasmvp + r6 | 6955595 | 6950777 |   -4818
> >      pistachio      | 8650977 | 8363898 | -287079
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > ---
> > 
> >  arch/mips/include/asm/cpu-features.h | 164
> >  +++++++++++++++++++++-------------- 1 file changed, 101 insertions(+),
> >  63 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/cpu-features.h
> > b/arch/mips/include/asm/cpu-features.h index 494d38274142..46c669e370d3
> > 100644
> > --- a/arch/mips/include/asm/cpu-features.h
> > +++ b/arch/mips/include/asm/cpu-features.h
> > @@ -13,39 +13,77 @@
> > 
> >  #include <asm/cpu-info.h>
> >  #include <cpu-feature-overrides.h>
> > 
> > +#define __ase(ase)			(cpu_data[0].ases & (ase))
> > +#define __opt(opt)			(cpu_data[0].options & (opt))
> > +
> > +/*
> > + * Check if __mips_isa_rev is >= isa *and* an option or ASE is detected
> > during + * boot (typically by cpu_probe()).
> > + *
> > + * Note that these should only be used in cases where a kernel built for
> > an + * older ISA *cannot* run on a CPU which supports the feature in
> > question. For + * example this may be used for features introduced with
> > MIPSr6, since a kernel + * built for an older ISA cannot run on a MIPSr6
> > CPU. This should not be used for + * MIPSr2 features however, since a
> > MIPSr1 or earlier kernel might run on a + * MIPSr2 CPU.
> > + */
> > +#define __isa_ge_and_ase(isa, ase)	((__mips_isa_rev >= (isa)) &&
> > __ase(ase)) +#define __isa_ge_and_opt(isa, opt)	((__mips_isa_rev >=
> > (isa)) && __opt(opt)) +
> > +/*
> > + * Check if __mips_isa_rev is >= isa *or* an option or ASE is detected
> > during + * boot (typically by cpu_probe()).
> > + *
> > + * These are for use with features that are optional up until a
> > particular ISA + * revision & then become required.
> > + */
> > +#define __isa_ge_or_ase(isa, ase)	((__mips_isa_rev >= (isa)) ||
> > __ase(ase)) +#define __isa_ge_or_opt(isa, opt)	((__mips_isa_rev >= (isa))
> > || __opt(opt)) +
> > +/*
> > + * Check if __mips_isa_rev is < isa *and* an option or ASE is detected
> > during + * boot (typically by cpu_probe()).
> > + *
> > + * These are for use with features that are optional up until a
> > particular ISA + * revision & are then removed - ie. no longer present in
> > any CPU implementing + * the given ISA revision.
> > + */
> > +#define __isa_lt_and_ase(isa, ase)	((__mips_isa_rev < (isa)) &&
> > __ase(ase)) +#define __isa_lt_and_opt(isa, opt)	((__mips_isa_rev < (isa))
> > && __opt(opt)) +
> > 
> >  /*
> >  
> >   * SMP assumption: Options of CPU 0 are a superset of all processors.
> >   * This is true for all known MIPS systems.
> >   */
> >  
> >  #ifndef cpu_has_tlb
> > 
> > -#define cpu_has_tlb		(cpu_data[0].options & MIPS_CPU_TLB)
> > +#define cpu_has_tlb		__opt(MIPS_CPU_TLB)
> > 
> >  #endif
> >  #ifndef cpu_has_ftlb
> > 
> > -#define cpu_has_ftlb		(cpu_data[0].options & MIPS_CPU_FTLB)
> > +#define cpu_has_ftlb		__opt(MIPS_CPU_FTLB)
> > 
> >  #endif
> >  #ifndef cpu_has_tlbinv
> > 
> > -#define cpu_has_tlbinv		(cpu_data[0].options & MIPS_CPU_TLBINV)
> > +#define cpu_has_tlbinv		__opt(MIPS_CPU_TLBINV)
> > 
> >  #endif
> >  #ifndef cpu_has_segments
> > 
> > -#define cpu_has_segments	(cpu_data[0].options & MIPS_CPU_SEGMENTS)
> > +#define cpu_has_segments	__opt(MIPS_CPU_SEGMENTS)
> > 
> >  #endif
> >  #ifndef cpu_has_eva
> > 
> > -#define cpu_has_eva		(cpu_data[0].options & MIPS_CPU_EVA)
> > +#define cpu_has_eva		__opt(MIPS_CPU_EVA)
> > 
> >  #endif
> >  #ifndef cpu_has_htw
> > 
> > -#define cpu_has_htw		(cpu_data[0].options & MIPS_CPU_HTW)
> > +#define cpu_has_htw		__opt(MIPS_CPU_HTW)
> > 
> >  #endif
> >  #ifndef cpu_has_ldpte
> > 
> > -#define cpu_has_ldpte		(cpu_data[0].options & MIPS_CPU_LDPTE)
> > +#define cpu_has_ldpte		__opt(MIPS_CPU_LDPTE)
> > 
> >  #endif
> >  #ifndef cpu_has_rixiex
> > 
> > -#define cpu_has_rixiex		(cpu_data[0].options & MIPS_CPU_RIXIEX)
> > +#define cpu_has_rixiex		__isa_ge_or_opt(6, MIPS_CPU_RIXIEX)
> > 
> >  #endif
> >  #ifndef cpu_has_maar
> > 
> > -#define cpu_has_maar		(cpu_data[0].options & MIPS_CPU_MAAR)
> > +#define cpu_has_maar		__opt(MIPS_CPU_MAAR)
> > 
> >  #endif
> >  #ifndef cpu_has_rw_llb
> > 
> > -#define cpu_has_rw_llb		(cpu_data[0].options & MIPS_CPU_RW_LLB)
> > +#define cpu_has_rw_llb		__isa_ge_or_opt(6, MIPS_CPU_RW_LLB)
> > 
> >  #endif
> >  
> >  /*
> > 
> > @@ -58,18 +96,18 @@
> > 
> >  #define cpu_has_3kex		(!cpu_has_4kex)
> >  #endif
> >  #ifndef cpu_has_4kex
> > 
> > -#define cpu_has_4kex		(cpu_data[0].options & MIPS_CPU_4KEX)
> > +#define cpu_has_4kex		__isa_ge_or_opt(1, MIPS_CPU_4KEX)
> > 
> >  #endif
> >  #ifndef cpu_has_3k_cache
> > 
> > -#define cpu_has_3k_cache	(cpu_data[0].options & MIPS_CPU_3K_CACHE)
> > +#define cpu_has_3k_cache	__isa_lt_and_opt(1, MIPS_CPU_3K_CACHE)
> > 
> >  #endif
> >  #define cpu_has_6k_cache	0
> >  #define cpu_has_8k_cache	0
> >  #ifndef cpu_has_4k_cache
> > 
> > -#define cpu_has_4k_cache	(cpu_data[0].options & MIPS_CPU_4K_CACHE)
> > +#define cpu_has_4k_cache	__isa_ge_or_opt(1, MIPS_CPU_4K_CACHE)
> > 
> >  #endif
> >  #ifndef cpu_has_tx39_cache
> > 
> > -#define cpu_has_tx39_cache	(cpu_data[0].options & MIPS_CPU_TX39_CACHE)
> > +#define cpu_has_tx39_cache	__opt(MIPS_CPU_TX39_CACHE)
> > 
> >  #endif
> >  #ifndef cpu_has_octeon_cache
> >  #define cpu_has_octeon_cache	0
> > 
> > @@ -82,89 +120,89 @@
> > 
> >  #define raw_cpu_has_fpu		cpu_has_fpu
> >  #endif
> >  #ifndef cpu_has_32fpr
> > 
> > -#define cpu_has_32fpr		(cpu_data[0].options & MIPS_CPU_32FPR)
> > +#define cpu_has_32fpr		__isa_ge_or_opt(1, MIPS_CPU_32FPR)
> > 
> >  #endif
> >  #ifndef cpu_has_counter
> > 
> > -#define cpu_has_counter		(cpu_data[0].options & MIPS_CPU_COUNTER)
> > +#define cpu_has_counter		__opt(MIPS_CPU_COUNTER)
> > 
> >  #endif
> >  #ifndef cpu_has_watch
> > 
> > -#define cpu_has_watch		(cpu_data[0].options & MIPS_CPU_WATCH)
> > +#define cpu_has_watch		__opt(MIPS_CPU_WATCH)
> > 
> >  #endif
> >  #ifndef cpu_has_divec
> > 
> > -#define cpu_has_divec		(cpu_data[0].options & MIPS_CPU_DIVEC)
> > +#define cpu_has_divec		__isa_ge_or_opt(1, MIPS_CPU_DIVEC)
> > 
> >  #endif
> >  #ifndef cpu_has_vce
> > 
> > -#define cpu_has_vce		(cpu_data[0].options & MIPS_CPU_VCE)
> > +#define cpu_has_vce		__opt(MIPS_CPU_VCE)
> > 
> >  #endif
> >  #ifndef cpu_has_cache_cdex_p
> > 
> > -#define cpu_has_cache_cdex_p	(cpu_data[0].options &
> > MIPS_CPU_CACHE_CDEX_P)
> > +#define cpu_has_cache_cdex_p	__opt(MIPS_CPU_CACHE_CDEX_P)
> > 
> >  #endif
> >  #ifndef cpu_has_cache_cdex_s
> > 
> > -#define cpu_has_cache_cdex_s	(cpu_data[0].options &
> > MIPS_CPU_CACHE_CDEX_S)
> > +#define cpu_has_cache_cdex_s	__opt(MIPS_CPU_CACHE_CDEX_S)
> > 
> >  #endif
> >  #ifndef cpu_has_prefetch
> > 
> > -#define cpu_has_prefetch	(cpu_data[0].options & MIPS_CPU_PREFETCH)
> > +#define cpu_has_prefetch	__isa_ge_or_opt(1, MIPS_CPU_PREFETCH)
> > 
> >  #endif
> >  #ifndef cpu_has_mcheck
> > 
> > -#define cpu_has_mcheck		(cpu_data[0].options & MIPS_CPU_MCHECK)
> > +#define cpu_has_mcheck		__isa_ge_or_opt(1, MIPS_CPU_MCHECK)
> > 
> >  #endif
> >  #ifndef cpu_has_ejtag
> > 
> > -#define cpu_has_ejtag		(cpu_data[0].options & MIPS_CPU_EJTAG)
> > +#define cpu_has_ejtag		__opt(MIPS_CPU_EJTAG)
> > 
> >  #endif
> >  #ifndef cpu_has_llsc
> > 
> > -#define cpu_has_llsc		(cpu_data[0].options & MIPS_CPU_LLSC)
> > +#define cpu_has_llsc		__isa_ge_or_opt(1, MIPS_CPU_LLSC)
> > 
> >  #endif
> >  #ifndef cpu_has_bp_ghist
> > 
> > -#define cpu_has_bp_ghist	(cpu_data[0].options & MIPS_CPU_BP_GHIST)
> > +#define cpu_has_bp_ghist	__opt(MIPS_CPU_BP_GHIST)
> > 
> >  #endif
> >  #ifndef kernel_uses_llsc
> >  #define kernel_uses_llsc	cpu_has_llsc
> >  #endif
> >  #ifndef cpu_has_guestctl0ext
> > 
> > -#define cpu_has_guestctl0ext	(cpu_data[0].options &
> > MIPS_CPU_GUESTCTL0EXT)
> > +#define cpu_has_guestctl0ext	__opt(MIPS_CPU_GUESTCTL0EXT)
> > 
> >  #endif
> >  #ifndef cpu_has_guestctl1
> > 
> > -#define cpu_has_guestctl1	(cpu_data[0].options & MIPS_CPU_GUESTCTL1)
> > +#define cpu_has_guestctl1	__opt(MIPS_CPU_GUESTCTL1)
> > 
> >  #endif
> >  #ifndef cpu_has_guestctl2
> > 
> > -#define cpu_has_guestctl2	(cpu_data[0].options & MIPS_CPU_GUESTCTL2)
> > +#define cpu_has_guestctl2	__opt(MIPS_CPU_GUESTCTL2)
> > 
> >  #endif
> >  #ifndef cpu_has_guestid
> > 
> > -#define cpu_has_guestid		(cpu_data[0].options & MIPS_CPU_GUESTID)
> > +#define cpu_has_guestid		__opt(MIPS_CPU_GUESTID)
> > 
> >  #endif
> >  #ifndef cpu_has_drg
> > 
> > -#define cpu_has_drg		(cpu_data[0].options & MIPS_CPU_DRG)
> > +#define cpu_has_drg		__opt(MIPS_CPU_DRG)
> > 
> >  #endif
> >  #ifndef cpu_has_mips16
> > 
> > -#define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
> > +#define cpu_has_mips16		__isa_lt_and_ase(6, MIPS_ASE_MIPS16)
> > 
> >  #endif
> >  #ifndef cpu_has_mdmx
> > 
> > -#define cpu_has_mdmx		(cpu_data[0].ases & MIPS_ASE_MDMX)
> > +#define cpu_has_mdmx		__isa_lt_and_ase(6, MIPS_ASE_MDMX)
> > 
> >  #endif
> >  #ifndef cpu_has_mips3d
> > 
> > -#define cpu_has_mips3d		(cpu_data[0].ases & MIPS_ASE_MIPS3D)
> > +#define cpu_has_mips3d		__isa_lt_and_ase(6, MIPS_ASE_MIPS3D)
> > 
> >  #endif
> >  #ifndef cpu_has_smartmips
> > 
> > -#define cpu_has_smartmips	(cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
> > +#define cpu_has_smartmips	__isa_lt_and_ase(6, MIPS_ASE_SMARTMIPS)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_rixi
> > 
> > -#define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
> > +#define cpu_has_rixi		__isa_ge_or_opt(6, MIPS_CPU_RIXI)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_mmips
> >  # ifdef CONFIG_SYS_SUPPORTS_MICROMIPS
> > 
> > -#  define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
> > +#  define cpu_has_mmips		__opt(MIPS_CPU_MICROMIPS)
> > 
> >  # else
> >  #  define cpu_has_mmips		0
> >  # endif
> >  #endif
> >  
> >  #ifndef cpu_has_lpa
> > 
> > -#define cpu_has_lpa		(cpu_data[0].options & MIPS_CPU_LPA)
> > +#define cpu_has_lpa		__opt(MIPS_CPU_LPA)
> > 
> >  #endif
> >  #ifndef cpu_has_mvh
> > 
> > -#define cpu_has_mvh		(cpu_data[0].options & MIPS_CPU_MVH)
> > +#define cpu_has_mvh		__opt(MIPS_CPU_MVH)
> > 
> >  #endif
> >  #ifndef cpu_has_xpa
> >  #define cpu_has_xpa		(cpu_has_lpa && cpu_has_mvh)
> > 
> > @@ -334,32 +372,32 @@
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_dsp
> > 
> > -#define cpu_has_dsp		(cpu_data[0].ases & MIPS_ASE_DSP)
> > +#define cpu_has_dsp		__ase(MIPS_ASE_DSP)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_dsp2
> > 
> > -#define cpu_has_dsp2		(cpu_data[0].ases & MIPS_ASE_DSP2P)
> > +#define cpu_has_dsp2		__ase(MIPS_ASE_DSP2P)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_dsp3
> > 
> > -#define cpu_has_dsp3		(cpu_data[0].ases & MIPS_ASE_DSP3)
> > +#define cpu_has_dsp3		__ase(MIPS_ASE_DSP3)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_mipsmt
> > 
> > -#define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
> > +#define cpu_has_mipsmt		__isa_lt_and_ase(6, MIPS_ASE_MIPSMT)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_vp
> > 
> > -#define cpu_has_vp		(cpu_data[0].options & MIPS_CPU_VP)
> > +#define cpu_has_vp		__isa_ge_and_opt(6, MIPS_CPU_VP)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_userlocal
> > 
> > -#define cpu_has_userlocal	(cpu_data[0].options & MIPS_CPU_ULRI)
> > +#define cpu_has_userlocal	__isa_ge_or_opt(6, MIPS_CPU_ULRI)
> > 
> >  #endif
> >  
> >  #ifdef CONFIG_32BIT
> >  # ifndef cpu_has_nofpuex
> > 
> > -# define cpu_has_nofpuex	(cpu_data[0].options & MIPS_CPU_NOFPUEX)
> > +# define cpu_has_nofpuex	__isa_lt_and_opt(1, MIPS_CPU_NOFPUEX)
> > 
> >  # endif
> >  # ifndef cpu_has_64bits
> >  # define cpu_has_64bits		(cpu_data[0].isa_level & 
MIPS_CPU_ISA_64BIT)
> > 
> > @@ -401,19 +439,19 @@
> > 
> >  #endif
> >  
> >  #if defined(CONFIG_CPU_MIPSR2_IRQ_VI) && !defined(cpu_has_vint)
> > 
> > -# define cpu_has_vint		(cpu_data[0].options & MIPS_CPU_VINT)
> > +# define cpu_has_vint		__opt(MIPS_CPU_VINT)
> > 
> >  #elif !defined(cpu_has_vint)
> >  # define cpu_has_vint			0
> >  #endif
> >  
> >  #if defined(CONFIG_CPU_MIPSR2_IRQ_EI) && !defined(cpu_has_veic)
> > 
> > -# define cpu_has_veic		(cpu_data[0].options & MIPS_CPU_VEIC)
> > +# define cpu_has_veic		__opt(MIPS_CPU_VEIC)
> > 
> >  #elif !defined(cpu_has_veic)
> >  # define cpu_has_veic			0
> >  #endif
> >  
> >  #ifndef cpu_has_inclusive_pcaches
> > 
> > -#define cpu_has_inclusive_pcaches	(cpu_data[0].options &
> > MIPS_CPU_INCLUSIVE_CACHES) +#define
> > cpu_has_inclusive_pcaches	__opt(MIPS_CPU_INCLUSIVE_CACHES)> 
> >  #endif
> >  
> >  #ifndef cpu_dcache_line_size
> > 
> > @@ -431,60 +469,60 @@
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_perf_cntr_intr_bit
> > 
> > -#define cpu_has_perf_cntr_intr_bit	(cpu_data[0].options & MIPS_CPU_PCI)
> > +#define cpu_has_perf_cntr_intr_bit	__opt(MIPS_CPU_PCI)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_vz
> > 
> > -#define cpu_has_vz		(cpu_data[0].ases & MIPS_ASE_VZ)
> > +#define cpu_has_vz		__ase(MIPS_ASE_VZ)
> > 
> >  #endif
> >  
> >  #if defined(CONFIG_CPU_HAS_MSA) && !defined(cpu_has_msa)
> > 
> > -# define cpu_has_msa		(cpu_data[0].ases & MIPS_ASE_MSA)
> > +# define cpu_has_msa		__ase(MIPS_ASE_MSA)
> > 
> >  #elif !defined(cpu_has_msa)
> >  # define cpu_has_msa		0
> >  #endif
> >  
> >  #ifndef cpu_has_ufr
> > 
> > -# define cpu_has_ufr		(cpu_data[0].options & MIPS_CPU_UFR)
> > +# define cpu_has_ufr		__opt(MIPS_CPU_UFR)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_fre
> > 
> > -# define cpu_has_fre		(cpu_data[0].options & MIPS_CPU_FRE)
> > +# define cpu_has_fre		__opt(MIPS_CPU_FRE)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_cdmm
> > 
> > -# define cpu_has_cdmm		(cpu_data[0].options & MIPS_CPU_CDMM)
> > +# define cpu_has_cdmm		__opt(MIPS_CPU_CDMM)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_small_pages
> > 
> > -# define cpu_has_small_pages	(cpu_data[0].options & MIPS_CPU_SP)
> > +# define cpu_has_small_pages	__opt(MIPS_CPU_SP)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_nan_legacy
> > 
> > -#define cpu_has_nan_legacy	(cpu_data[0].options & MIPS_CPU_NAN_LEGACY)
> > +#define cpu_has_nan_legacy	__isa_lt_and_opt(6, MIPS_CPU_NAN_LEGACY)
> > 
> >  #endif
> >  #ifndef cpu_has_nan_2008
> > 
> > -#define cpu_has_nan_2008	(cpu_data[0].options & MIPS_CPU_NAN_2008)
> > +#define cpu_has_nan_2008	__isa_ge_or_opt(6, MIPS_CPU_NAN_2008)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_ebase_wg
> > 
> > -# define cpu_has_ebase_wg	(cpu_data[0].options & MIPS_CPU_EBASE_WG)
> > +# define cpu_has_ebase_wg	__opt(MIPS_CPU_EBASE_WG)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_badinstr
> > 
> > -# define cpu_has_badinstr	(cpu_data[0].options & MIPS_CPU_BADINSTR)
> > +# define cpu_has_badinstr	__isa_ge_or_opt(6, MIPS_CPU_BADINSTR)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_badinstrp
> > 
> > -# define cpu_has_badinstrp	(cpu_data[0].options & MIPS_CPU_BADINSTRP)
> > +# define cpu_has_badinstrp	__isa_ge_or_opt(6, MIPS_CPU_BADINSTRP)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_contextconfig
> > 
> > -# define cpu_has_contextconfig	(cpu_data[0].options & MIPS_CPU_CTXTC)
> > +# define cpu_has_contextconfig	__opt(MIPS_CPU_CTXTC)
> > 
> >  #endif
> >  
> >  #ifndef cpu_has_perf
> > 
> > -# define cpu_has_perf		(cpu_data[0].options & MIPS_CPU_PERF)
> > +# define cpu_has_perf		__opt(MIPS_CPU_PERF)
> > 
> >  #endif
> >  
> >  /*
> 
> Getting a build error for a kernel for an SGI machine with this patch:
> In file included from ./arch/mips/include/asm/bitops.h:21:0,
>                  from ./include/linux/bitops.h:36,
>                  from ./include/linux/kernel.h:10,
>                  from arch/mips/kernel/cpu-probe.c:15:
> arch/mips/kernel/cpu-probe.c: In function 'cpu_set_nan_2008':
> ./arch/mips/include/asm/cpu-features.h:52:38: error: '__mips_isa_rev'
> undeclared (first use in this function); did you mean '__mips_set_bit'?
>  #define __isa_lt_and_opt(isa, opt) ((__mips_isa_rev < (isa)) && __opt(opt))
> ^
> 
> My guess is the older platforms don't define __mips_isa_rev anywhere.  A lot
> of other uses first use 'defined()' to check for its presence, but in this
> case, it's being used to setup the '__isa_ge_and_ase' and
> '__isa_ge_and_opt' macros. Not sure of a clean workaround to test this
> patch at the moment.  Also am not seeing where this macro is even defined. 
> Is it a compiler intrinsic?

D'oh!

__mips_isa_rev is a predefined macro with gcc, but I guess not always. I'll 
submit a v2 to handle the lack of it.

Thanks for testing,
    Paul
--nextPart2162231.G4V5cdszci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlk+3CAACgkQgiDZ+mk8
HGWpNg/8D4xrg1JXCZVq+H70pLjVWas0XKFRwctuiudqUuQf5xa06euzkNXvKIb0
DUb8f3STsEtRESEcSDhEHUBY3pXSdIgCZ6MItVisZToyVl9z8uL5dhm7bwUTCFZs
vBnoz8jfRO1CtCRwBp8JfiauS6Yzo5H/9wyMYSgJtaTp/r59OOSudr4yi+n7rgKr
1jxTAdfpSABHnwGSEsEz3iUU347L4R/ndXibMcgyIzIKkdAW1LBo/Z1nqLNscRBo
eqqoipgPlhE7HuNencDdsGA35T/JycVngagYpN9IZ74kGkjUWWdu0Vsan3whXjyB
OLQcMI11/XGzBgdh+vCpJPUKnlU2rjjWbrpXyuXFlExPL5gWoc6Hsp0JOCjYQRb7
f3L6O2w+Cd8nNbi1accBVWLfa5LeEeohbXEBbs/yYgcUD5YjR2ihKdx4w9cCIqLN
22MGC2YqZnuChixtJhurCk+nuedfRu2eEBvXvu3zC61tn1zaBThCkeIACZSocYfV
Fa06XXx3yxPm/VoBdET5SSlu/VLI9VX3GcPu0UJ5sU3l+WW7ayr9RuYGDVrim5Gp
O4o+68at/+22ezAo8cDKe1tf8p3MZMpVkpCjMUHrR/eFvd/sK5LtMVwgIRlu3cDa
8PDhA1f0Y1p9Yjxz5eu7qdrJtc1j0fkGgUysK8knL8qXZFtMPwg=
=SJP5
-----END PGP SIGNATURE-----

--nextPart2162231.G4V5cdszci--
