Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:32:21 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025294AbbDCW0ETNir6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:04 +0200
Date:   Fri, 3 Apr 2015 23:26:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 30/48] MIPS: Correct `nofpu' non-functionality
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031619570.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46747
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

The `cpu_has_fpu' feature flag must not be hardcoded to 1 or the `nofpu'
kernel option will be ignored.  Remove any such overrides and add a 
cautionary note.  Hardcoding to 0 is fine for FPU-less platforms.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-cpu-has-fpu.patch
Index: linux/arch/mips/include/asm/cpu-features.h
===================================================================
--- linux.orig/arch/mips/include/asm/cpu-features.h	2015-04-02 20:18:50.163509000 +0100
+++ linux/arch/mips/include/asm/cpu-features.h	2015-04-02 20:27:56.252205000 +0100
@@ -68,6 +68,7 @@
 #ifndef cpu_has_octeon_cache
 #define cpu_has_octeon_cache	0
 #endif
+/* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */
 #ifndef cpu_has_fpu
 #define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
 #define raw_cpu_has_fpu		(raw_current_cpu_data.options & MIPS_CPU_FPU)
Index: linux/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
===================================================================
--- linux.orig/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h	2015-04-02 20:18:50.166512000 +0100
+++ linux/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h	2015-04-02 20:27:56.276209000 +0100
@@ -14,7 +14,6 @@
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
 #define cpu_has_tx39_cache	0
-#define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
 #define cpu_has_watch		0
Index: linux/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
===================================================================
--- linux.orig/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h	2015-04-02 20:18:50.169511000 +0100
+++ linux/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h	2015-04-02 20:27:56.289206000 +0100
@@ -15,7 +15,6 @@
 /* Generic ones first.  */
 #define cpu_has_tlb			1
 #define cpu_has_tx39_cache		0
-#define cpu_has_fpu			1
 #define cpu_has_divec			0
 #define cpu_has_prefetch		0
 #define cpu_has_mcheck			0
Index: linux/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
===================================================================
--- linux.orig/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h	2015-04-02 20:18:50.172504000 +0100
+++ linux/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h	2015-04-02 20:27:56.299204000 +0100
@@ -16,7 +16,6 @@
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
 #define cpu_has_4k_cache	1
-#define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
 #define cpu_has_mips16		0
Index: linux/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
===================================================================
--- linux.orig/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h	2015-04-02 20:18:50.175504000 +0100
+++ linux/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h	2015-04-02 20:27:56.306207000 +0100
@@ -26,7 +26,6 @@
 /* Settings which are common for all ip32 CPUs */
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
-#define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
 #define cpu_has_mips16		0
Index: linux/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
===================================================================
--- linux.orig/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h	2015-04-02 20:18:50.178504000 +0100
+++ linux/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h	2015-04-02 20:27:56.323205000 +0100
@@ -34,7 +34,6 @@
 #define cpu_has_dsp		0
 #define cpu_has_dsp2		0
 #define cpu_has_ejtag		0
-#define cpu_has_fpu		1
 #define cpu_has_ic_fills_f_dc	0
 #define cpu_has_inclusive_pcaches	1
 #define cpu_has_llsc		1
Index: linux/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
===================================================================
--- linux.orig/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h	2015-04-02 20:18:50.182511000 +0100
+++ linux/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h	2015-04-02 20:27:56.333207000 +0100
@@ -15,7 +15,6 @@
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
 #define cpu_has_4k_cache	1
-#define cpu_has_fpu		1
 #define cpu_has_32fpr		1
 #define cpu_has_counter		1
 #define cpu_has_watch		0
