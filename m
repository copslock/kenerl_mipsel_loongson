Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 20:55:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33387 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991960AbdFLSzGwuKLn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2017 20:55:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A9D48BBD51A15;
        Mon, 12 Jun 2017 19:54:55 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 12 Jun 2017 19:54:59
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH v2 2/2] MIPS: Hardcode cpu_has_* where known at compile time due to ISA
Date:   Mon, 12 Jun 2017 11:54:23 -0700
Message-ID: <20170612185423.18972-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170612185423.18972-1-paul.burton@imgtec.com>
References: <1645206.SpfHWSWaJU@np-p-burton>
 <20170612185423.18972-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58413
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

Many architectural features have over time moved from being optional to
either be required or removed by newer architecture releases. This means
that in many cases we can know at compile time whether a feature will be
supported or not purely due to the knowledge we have about the ISA the
kernel build is targeting.

This patch introduces a bunch of utility macros for checking for
supported options, ASEs & combinations of those with ISA revisions. It
then makes use of these in the default definitions of cpu_has_* macros.
The result is that many of the macros become compile-time constant,
allowing more optimisation opportunities for the compiler - particularly
with kernels built for later ISA revisions.

To demonstrate the effect of this patch, the following table shows the
size in bytes of the kernel binary as reported by scripts/bloat-o-meter
for v4.12-rc4 maltasmvp_defconfig kernels with & without this patch. A
variant of maltasmvp_defconfig with CONFIG_CPU_MIPS32_R6 selected is
also shown, to demonstrate that MIPSr6 systems benefit more due to extra
features becoming required by that architecture revision. Builds of
pistachio_defconfig are also shown, as although this is a MIPSr2
platform it doesn't hardcode any features in a machine-specific
cpu-feature-overrides.h, which allows it to gain more from this patch
than the equivalent Malta r2 build.

     Config         | Before  | After   |  Change
    ----------------|---------|---------|---------
     maltasmvp      | 7248316 | 7247714 |    -602
     maltasmvp + r6 | 6955595 | 6950777 |   -4818
     pistachio      | 8650977 | 8363898 | -287079

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Joshua Kinard <kumba@gentoo.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v2:
- Include asm/isarev.h.

 arch/mips/include/asm/cpu-features.h | 165 ++++++++++++++++++++++-------------
 1 file changed, 102 insertions(+), 63 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 494d38274142..e9605e215f6e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -11,41 +11,80 @@
 
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
+#include <asm/isarev.h>
 #include <cpu-feature-overrides.h>
 
+#define __ase(ase)			(cpu_data[0].ases & (ase))
+#define __opt(opt)			(cpu_data[0].options & (opt))
+
+/*
+ * Check if __mips_isa_rev is >= isa *and* an option or ASE is detected during
+ * boot (typically by cpu_probe()).
+ *
+ * Note that these should only be used in cases where a kernel built for an
+ * older ISA *cannot* run on a CPU which supports the feature in question. For
+ * example this may be used for features introduced with MIPSr6, since a kernel
+ * built for an older ISA cannot run on a MIPSr6 CPU. This should not be used for
+ * MIPSr2 features however, since a MIPSr1 or earlier kernel might run on a
+ * MIPSr2 CPU.
+ */
+#define __isa_ge_and_ase(isa, ase)	((__mips_isa_rev >= (isa)) && __ase(ase))
+#define __isa_ge_and_opt(isa, opt)	((__mips_isa_rev >= (isa)) && __opt(opt))
+
+/*
+ * Check if __mips_isa_rev is >= isa *or* an option or ASE is detected during
+ * boot (typically by cpu_probe()).
+ *
+ * These are for use with features that are optional up until a particular ISA
+ * revision & then become required.
+ */
+#define __isa_ge_or_ase(isa, ase)	((__mips_isa_rev >= (isa)) || __ase(ase))
+#define __isa_ge_or_opt(isa, opt)	((__mips_isa_rev >= (isa)) || __opt(opt))
+
+/*
+ * Check if __mips_isa_rev is < isa *and* an option or ASE is detected during
+ * boot (typically by cpu_probe()).
+ *
+ * These are for use with features that are optional up until a particular ISA
+ * revision & are then removed - ie. no longer present in any CPU implementing
+ * the given ISA revision.
+ */
+#define __isa_lt_and_ase(isa, ase)	((__mips_isa_rev < (isa)) && __ase(ase))
+#define __isa_lt_and_opt(isa, opt)	((__mips_isa_rev < (isa)) && __opt(opt))
+
 /*
  * SMP assumption: Options of CPU 0 are a superset of all processors.
  * This is true for all known MIPS systems.
  */
 #ifndef cpu_has_tlb
-#define cpu_has_tlb		(cpu_data[0].options & MIPS_CPU_TLB)
+#define cpu_has_tlb		__opt(MIPS_CPU_TLB)
 #endif
 #ifndef cpu_has_ftlb
-#define cpu_has_ftlb		(cpu_data[0].options & MIPS_CPU_FTLB)
+#define cpu_has_ftlb		__opt(MIPS_CPU_FTLB)
 #endif
 #ifndef cpu_has_tlbinv
-#define cpu_has_tlbinv		(cpu_data[0].options & MIPS_CPU_TLBINV)
+#define cpu_has_tlbinv		__opt(MIPS_CPU_TLBINV)
 #endif
 #ifndef cpu_has_segments
-#define cpu_has_segments	(cpu_data[0].options & MIPS_CPU_SEGMENTS)
+#define cpu_has_segments	__opt(MIPS_CPU_SEGMENTS)
 #endif
 #ifndef cpu_has_eva
-#define cpu_has_eva		(cpu_data[0].options & MIPS_CPU_EVA)
+#define cpu_has_eva		__opt(MIPS_CPU_EVA)
 #endif
 #ifndef cpu_has_htw
-#define cpu_has_htw		(cpu_data[0].options & MIPS_CPU_HTW)
+#define cpu_has_htw		__opt(MIPS_CPU_HTW)
 #endif
 #ifndef cpu_has_ldpte
-#define cpu_has_ldpte		(cpu_data[0].options & MIPS_CPU_LDPTE)
+#define cpu_has_ldpte		__opt(MIPS_CPU_LDPTE)
 #endif
 #ifndef cpu_has_rixiex
-#define cpu_has_rixiex		(cpu_data[0].options & MIPS_CPU_RIXIEX)
+#define cpu_has_rixiex		__isa_ge_or_opt(6, MIPS_CPU_RIXIEX)
 #endif
 #ifndef cpu_has_maar
-#define cpu_has_maar		(cpu_data[0].options & MIPS_CPU_MAAR)
+#define cpu_has_maar		__opt(MIPS_CPU_MAAR)
 #endif
 #ifndef cpu_has_rw_llb
-#define cpu_has_rw_llb		(cpu_data[0].options & MIPS_CPU_RW_LLB)
+#define cpu_has_rw_llb		__isa_ge_or_opt(6, MIPS_CPU_RW_LLB)
 #endif
 
 /*
@@ -58,18 +97,18 @@
 #define cpu_has_3kex		(!cpu_has_4kex)
 #endif
 #ifndef cpu_has_4kex
-#define cpu_has_4kex		(cpu_data[0].options & MIPS_CPU_4KEX)
+#define cpu_has_4kex		__isa_ge_or_opt(1, MIPS_CPU_4KEX)
 #endif
 #ifndef cpu_has_3k_cache
-#define cpu_has_3k_cache	(cpu_data[0].options & MIPS_CPU_3K_CACHE)
+#define cpu_has_3k_cache	__isa_lt_and_opt(1, MIPS_CPU_3K_CACHE)
 #endif
 #define cpu_has_6k_cache	0
 #define cpu_has_8k_cache	0
 #ifndef cpu_has_4k_cache
-#define cpu_has_4k_cache	(cpu_data[0].options & MIPS_CPU_4K_CACHE)
+#define cpu_has_4k_cache	__isa_ge_or_opt(1, MIPS_CPU_4K_CACHE)
 #endif
 #ifndef cpu_has_tx39_cache
-#define cpu_has_tx39_cache	(cpu_data[0].options & MIPS_CPU_TX39_CACHE)
+#define cpu_has_tx39_cache	__opt(MIPS_CPU_TX39_CACHE)
 #endif
 #ifndef cpu_has_octeon_cache
 #define cpu_has_octeon_cache	0
@@ -82,89 +121,89 @@
 #define raw_cpu_has_fpu		cpu_has_fpu
 #endif
 #ifndef cpu_has_32fpr
-#define cpu_has_32fpr		(cpu_data[0].options & MIPS_CPU_32FPR)
+#define cpu_has_32fpr		__isa_ge_or_opt(1, MIPS_CPU_32FPR)
 #endif
 #ifndef cpu_has_counter
-#define cpu_has_counter		(cpu_data[0].options & MIPS_CPU_COUNTER)
+#define cpu_has_counter		__opt(MIPS_CPU_COUNTER)
 #endif
 #ifndef cpu_has_watch
-#define cpu_has_watch		(cpu_data[0].options & MIPS_CPU_WATCH)
+#define cpu_has_watch		__opt(MIPS_CPU_WATCH)
 #endif
 #ifndef cpu_has_divec
-#define cpu_has_divec		(cpu_data[0].options & MIPS_CPU_DIVEC)
+#define cpu_has_divec		__isa_ge_or_opt(1, MIPS_CPU_DIVEC)
 #endif
 #ifndef cpu_has_vce
-#define cpu_has_vce		(cpu_data[0].options & MIPS_CPU_VCE)
+#define cpu_has_vce		__opt(MIPS_CPU_VCE)
 #endif
 #ifndef cpu_has_cache_cdex_p
-#define cpu_has_cache_cdex_p	(cpu_data[0].options & MIPS_CPU_CACHE_CDEX_P)
+#define cpu_has_cache_cdex_p	__opt(MIPS_CPU_CACHE_CDEX_P)
 #endif
 #ifndef cpu_has_cache_cdex_s
-#define cpu_has_cache_cdex_s	(cpu_data[0].options & MIPS_CPU_CACHE_CDEX_S)
+#define cpu_has_cache_cdex_s	__opt(MIPS_CPU_CACHE_CDEX_S)
 #endif
 #ifndef cpu_has_prefetch
-#define cpu_has_prefetch	(cpu_data[0].options & MIPS_CPU_PREFETCH)
+#define cpu_has_prefetch	__isa_ge_or_opt(1, MIPS_CPU_PREFETCH)
 #endif
 #ifndef cpu_has_mcheck
-#define cpu_has_mcheck		(cpu_data[0].options & MIPS_CPU_MCHECK)
+#define cpu_has_mcheck		__isa_ge_or_opt(1, MIPS_CPU_MCHECK)
 #endif
 #ifndef cpu_has_ejtag
-#define cpu_has_ejtag		(cpu_data[0].options & MIPS_CPU_EJTAG)
+#define cpu_has_ejtag		__opt(MIPS_CPU_EJTAG)
 #endif
 #ifndef cpu_has_llsc
-#define cpu_has_llsc		(cpu_data[0].options & MIPS_CPU_LLSC)
+#define cpu_has_llsc		__isa_ge_or_opt(1, MIPS_CPU_LLSC)
 #endif
 #ifndef cpu_has_bp_ghist
-#define cpu_has_bp_ghist	(cpu_data[0].options & MIPS_CPU_BP_GHIST)
+#define cpu_has_bp_ghist	__opt(MIPS_CPU_BP_GHIST)
 #endif
 #ifndef kernel_uses_llsc
 #define kernel_uses_llsc	cpu_has_llsc
 #endif
 #ifndef cpu_has_guestctl0ext
-#define cpu_has_guestctl0ext	(cpu_data[0].options & MIPS_CPU_GUESTCTL0EXT)
+#define cpu_has_guestctl0ext	__opt(MIPS_CPU_GUESTCTL0EXT)
 #endif
 #ifndef cpu_has_guestctl1
-#define cpu_has_guestctl1	(cpu_data[0].options & MIPS_CPU_GUESTCTL1)
+#define cpu_has_guestctl1	__opt(MIPS_CPU_GUESTCTL1)
 #endif
 #ifndef cpu_has_guestctl2
-#define cpu_has_guestctl2	(cpu_data[0].options & MIPS_CPU_GUESTCTL2)
+#define cpu_has_guestctl2	__opt(MIPS_CPU_GUESTCTL2)
 #endif
 #ifndef cpu_has_guestid
-#define cpu_has_guestid		(cpu_data[0].options & MIPS_CPU_GUESTID)
+#define cpu_has_guestid		__opt(MIPS_CPU_GUESTID)
 #endif
 #ifndef cpu_has_drg
-#define cpu_has_drg		(cpu_data[0].options & MIPS_CPU_DRG)
+#define cpu_has_drg		__opt(MIPS_CPU_DRG)
 #endif
 #ifndef cpu_has_mips16
-#define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
+#define cpu_has_mips16		__isa_lt_and_ase(6, MIPS_ASE_MIPS16)
 #endif
 #ifndef cpu_has_mdmx
-#define cpu_has_mdmx		(cpu_data[0].ases & MIPS_ASE_MDMX)
+#define cpu_has_mdmx		__isa_lt_and_ase(6, MIPS_ASE_MDMX)
 #endif
 #ifndef cpu_has_mips3d
-#define cpu_has_mips3d		(cpu_data[0].ases & MIPS_ASE_MIPS3D)
+#define cpu_has_mips3d		__isa_lt_and_ase(6, MIPS_ASE_MIPS3D)
 #endif
 #ifndef cpu_has_smartmips
-#define cpu_has_smartmips	(cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
+#define cpu_has_smartmips	__isa_lt_and_ase(6, MIPS_ASE_SMARTMIPS)
 #endif
 
 #ifndef cpu_has_rixi
-#define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
+#define cpu_has_rixi		__isa_ge_or_opt(6, MIPS_CPU_RIXI)
 #endif
 
 #ifndef cpu_has_mmips
 # ifdef CONFIG_SYS_SUPPORTS_MICROMIPS
-#  define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
+#  define cpu_has_mmips		__opt(MIPS_CPU_MICROMIPS)
 # else
 #  define cpu_has_mmips		0
 # endif
 #endif
 
 #ifndef cpu_has_lpa
-#define cpu_has_lpa		(cpu_data[0].options & MIPS_CPU_LPA)
+#define cpu_has_lpa		__opt(MIPS_CPU_LPA)
 #endif
 #ifndef cpu_has_mvh
-#define cpu_has_mvh		(cpu_data[0].options & MIPS_CPU_MVH)
+#define cpu_has_mvh		__opt(MIPS_CPU_MVH)
 #endif
 #ifndef cpu_has_xpa
 #define cpu_has_xpa		(cpu_has_lpa && cpu_has_mvh)
@@ -334,32 +373,32 @@
 #endif
 
 #ifndef cpu_has_dsp
-#define cpu_has_dsp		(cpu_data[0].ases & MIPS_ASE_DSP)
+#define cpu_has_dsp		__ase(MIPS_ASE_DSP)
 #endif
 
 #ifndef cpu_has_dsp2
-#define cpu_has_dsp2		(cpu_data[0].ases & MIPS_ASE_DSP2P)
+#define cpu_has_dsp2		__ase(MIPS_ASE_DSP2P)
 #endif
 
 #ifndef cpu_has_dsp3
-#define cpu_has_dsp3		(cpu_data[0].ases & MIPS_ASE_DSP3)
+#define cpu_has_dsp3		__ase(MIPS_ASE_DSP3)
 #endif
 
 #ifndef cpu_has_mipsmt
-#define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
+#define cpu_has_mipsmt		__isa_lt_and_ase(6, MIPS_ASE_MIPSMT)
 #endif
 
 #ifndef cpu_has_vp
-#define cpu_has_vp		(cpu_data[0].options & MIPS_CPU_VP)
+#define cpu_has_vp		__isa_ge_and_opt(6, MIPS_CPU_VP)
 #endif
 
 #ifndef cpu_has_userlocal
-#define cpu_has_userlocal	(cpu_data[0].options & MIPS_CPU_ULRI)
+#define cpu_has_userlocal	__isa_ge_or_opt(6, MIPS_CPU_ULRI)
 #endif
 
 #ifdef CONFIG_32BIT
 # ifndef cpu_has_nofpuex
-# define cpu_has_nofpuex	(cpu_data[0].options & MIPS_CPU_NOFPUEX)
+# define cpu_has_nofpuex	__isa_lt_and_opt(1, MIPS_CPU_NOFPUEX)
 # endif
 # ifndef cpu_has_64bits
 # define cpu_has_64bits		(cpu_data[0].isa_level & MIPS_CPU_ISA_64BIT)
@@ -401,19 +440,19 @@
 #endif
 
 #if defined(CONFIG_CPU_MIPSR2_IRQ_VI) && !defined(cpu_has_vint)
-# define cpu_has_vint		(cpu_data[0].options & MIPS_CPU_VINT)
+# define cpu_has_vint		__opt(MIPS_CPU_VINT)
 #elif !defined(cpu_has_vint)
 # define cpu_has_vint			0
 #endif
 
 #if defined(CONFIG_CPU_MIPSR2_IRQ_EI) && !defined(cpu_has_veic)
-# define cpu_has_veic		(cpu_data[0].options & MIPS_CPU_VEIC)
+# define cpu_has_veic		__opt(MIPS_CPU_VEIC)
 #elif !defined(cpu_has_veic)
 # define cpu_has_veic			0
 #endif
 
 #ifndef cpu_has_inclusive_pcaches
-#define cpu_has_inclusive_pcaches	(cpu_data[0].options & MIPS_CPU_INCLUSIVE_CACHES)
+#define cpu_has_inclusive_pcaches	__opt(MIPS_CPU_INCLUSIVE_CACHES)
 #endif
 
 #ifndef cpu_dcache_line_size
@@ -431,60 +470,60 @@
 #endif
 
 #ifndef cpu_has_perf_cntr_intr_bit
-#define cpu_has_perf_cntr_intr_bit	(cpu_data[0].options & MIPS_CPU_PCI)
+#define cpu_has_perf_cntr_intr_bit	__opt(MIPS_CPU_PCI)
 #endif
 
 #ifndef cpu_has_vz
-#define cpu_has_vz		(cpu_data[0].ases & MIPS_ASE_VZ)
+#define cpu_has_vz		__ase(MIPS_ASE_VZ)
 #endif
 
 #if defined(CONFIG_CPU_HAS_MSA) && !defined(cpu_has_msa)
-# define cpu_has_msa		(cpu_data[0].ases & MIPS_ASE_MSA)
+# define cpu_has_msa		__ase(MIPS_ASE_MSA)
 #elif !defined(cpu_has_msa)
 # define cpu_has_msa		0
 #endif
 
 #ifndef cpu_has_ufr
-# define cpu_has_ufr		(cpu_data[0].options & MIPS_CPU_UFR)
+# define cpu_has_ufr		__opt(MIPS_CPU_UFR)
 #endif
 
 #ifndef cpu_has_fre
-# define cpu_has_fre		(cpu_data[0].options & MIPS_CPU_FRE)
+# define cpu_has_fre		__opt(MIPS_CPU_FRE)
 #endif
 
 #ifndef cpu_has_cdmm
-# define cpu_has_cdmm		(cpu_data[0].options & MIPS_CPU_CDMM)
+# define cpu_has_cdmm		__opt(MIPS_CPU_CDMM)
 #endif
 
 #ifndef cpu_has_small_pages
-# define cpu_has_small_pages	(cpu_data[0].options & MIPS_CPU_SP)
+# define cpu_has_small_pages	__opt(MIPS_CPU_SP)
 #endif
 
 #ifndef cpu_has_nan_legacy
-#define cpu_has_nan_legacy	(cpu_data[0].options & MIPS_CPU_NAN_LEGACY)
+#define cpu_has_nan_legacy	__isa_lt_and_opt(6, MIPS_CPU_NAN_LEGACY)
 #endif
 #ifndef cpu_has_nan_2008
-#define cpu_has_nan_2008	(cpu_data[0].options & MIPS_CPU_NAN_2008)
+#define cpu_has_nan_2008	__isa_ge_or_opt(6, MIPS_CPU_NAN_2008)
 #endif
 
 #ifndef cpu_has_ebase_wg
-# define cpu_has_ebase_wg	(cpu_data[0].options & MIPS_CPU_EBASE_WG)
+# define cpu_has_ebase_wg	__opt(MIPS_CPU_EBASE_WG)
 #endif
 
 #ifndef cpu_has_badinstr
-# define cpu_has_badinstr	(cpu_data[0].options & MIPS_CPU_BADINSTR)
+# define cpu_has_badinstr	__isa_ge_or_opt(6, MIPS_CPU_BADINSTR)
 #endif
 
 #ifndef cpu_has_badinstrp
-# define cpu_has_badinstrp	(cpu_data[0].options & MIPS_CPU_BADINSTRP)
+# define cpu_has_badinstrp	__isa_ge_or_opt(6, MIPS_CPU_BADINSTRP)
 #endif
 
 #ifndef cpu_has_contextconfig
-# define cpu_has_contextconfig	(cpu_data[0].options & MIPS_CPU_CTXTC)
+# define cpu_has_contextconfig	__opt(MIPS_CPU_CTXTC)
 #endif
 
 #ifndef cpu_has_perf
-# define cpu_has_perf		(cpu_data[0].options & MIPS_CPU_PERF)
+# define cpu_has_perf		__opt(MIPS_CPU_PERF)
 #endif
 
 /*
-- 
2.13.1
