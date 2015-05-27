Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 15:16:17 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012099AbbE0NPbqUYtZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 15:15:31 +0200
Date:   Wed, 27 May 2015 14:15:31 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DEC: Update CPU overrides
Message-ID: <alpine.LFD.2.11.1505270214420.11225@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Update CPU overrides for the DEC port with the recent additions, shaving
off some effectively dead code:

   text    data      bss      dec     hex filename
5586952  233132  5990368 11810452  b43694 vmlinux.32-old
5581248  233140  5990368 11804756  b42054 vmlinux.32-new

   text    data      bss      dec     hex filename
6036936  356648 10756544 17150128 105b0b0 vmlinux.64-old
6029896  360752 10756544 17147192 105a538 vmlinux.64-new

The data size increase is due to the special alignment requirement of 
`init_thread_union' aka `.data..init_task' moving it up to the nearest 
page boundary and making the amount of padding at its front rely on how 
far within a page text ends.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-dec-feature-overrides.diff
Index: linux-20150524-3maxp/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
===================================================================
--- linux-20150524-3maxp.orig/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
+++ linux-20150524-3maxp/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
@@ -14,6 +14,13 @@
 
 /* Generic ones first.  */
 #define cpu_has_tlb			1
+#define cpu_has_tlbinv			0
+#define cpu_has_segments		0
+#define cpu_has_eva			0
+#define cpu_has_htw			0
+#define cpu_has_rixiex			0
+#define cpu_has_maar			0
+#define cpu_has_rw_llb			0
 #define cpu_has_tx39_cache		0
 #define cpu_has_divec			0
 #define cpu_has_prefetch		0
@@ -24,6 +31,7 @@
 #define cpu_has_mips3d			0
 #define cpu_has_smartmips		0
 #define cpu_has_rixi			0
+#define cpu_has_xpa			0
 #define cpu_has_vtag_icache		0
 #define cpu_has_ic_fills_f_dc		0
 #define cpu_has_pindexed_dcache		0
@@ -36,11 +44,18 @@
 #define cpu_has_mips64r1		0
 #define cpu_has_mips64r2		0
 #define cpu_has_dsp			0
+#define cpu_has_dsp2			0
 #define cpu_has_mipsmt			0
 #define cpu_has_userlocal		0
+#define cpu_hwrena_impl_bits		0
+#define cpu_has_perf_cntr_intr_bit	0
+#define cpu_has_vz			0
+#define cpu_has_fre			0
+#define cpu_has_cdmm			0
 
 /* R3k-specific ones.  */
 #ifdef CONFIG_CPU_R3000
+#define cpu_has_3kex			1
 #define cpu_has_4kex			0
 #define cpu_has_3k_cache		1
 #define cpu_has_4k_cache		0
@@ -63,6 +78,7 @@
 
 /* R4k-specific ones.  */
 #ifdef CONFIG_CPU_R4X00
+#define cpu_has_3kex			0
 #define cpu_has_4kex			1
 #define cpu_has_3k_cache		0
 #define cpu_has_4k_cache		1
