Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 13:11:00 +0200 (CEST)
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33560 "EHLO
        mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819546Ab3FULK7FSpLe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jun 2013 13:10:59 +0200
Received: by mail-pb0-f43.google.com with SMTP id md12so7640866pbc.2
        for <multiple recipients>; Fri, 21 Jun 2013 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=0S+KxSIR0Z60Svv6u9LtF+R2arJwVddC7QPaeElvI3w=;
        b=ULlg32FS9P9QDQLdZWUkhb7tZPxbuQKlh29VYf/VXFtKht3F2acXSOj2etz2NB0P1p
         rdRui2VivZ3SBwtQDpuSG54X3SxCB65zA3REgXGyLl0UE40pv8nKV2s2tsAZblhHD1Ac
         EELDYzbgy1TQL2TWChvJPhhbZMF8xgDUYivo61Y9b2VvlmNB4PpCWcmxayDeNCEMRUs4
         uuvl+iJYp9pbfPl0WO511rvZcvbvQlGtTPX9qtKcmrTFQpIevSau+Ve0fRAFImv8Bl8F
         3lY4XV8+NX77koLiohyHxdKPboR2i0koT+sJiV5QoGlK6eJ3ttlFxV2ul5AyhcP5y1P2
         Oz9w==
X-Received: by 10.66.121.169 with SMTP id ll9mr15696954pab.126.1371813052432;
        Fri, 21 Jun 2013 04:10:52 -0700 (PDT)
Received: from hades.local (111-243-154-157.dynamic.hinet.net. [111.243.154.157])
        by mx.google.com with ESMTPSA id iq6sm4500993pbc.1.2013.06.21.04.10.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:10:51 -0700 (PDT)
Date:   Fri, 21 Jun 2013 19:10:46 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Cleanup indentation and whitespace
Message-ID: <20130621111046.GB23231@hades.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/include/asm/cpu-features.h               |   32 ++++++++++----------
 .../include/asm/mach-generic/kernel-entry-init.h   |    4 +--
 arch/mips/include/asm/processor.h                  |    4 +--
 arch/mips/kernel/branch.c                          |    1 -
 arch/mips/kernel/unaligned.c                       |    1 +
 arch/mips/mm/page.c                                |    2 +-
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index df5e523..aee9bc1 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -87,13 +87,13 @@
 #define cpu_has_mips16		(cpu_data[0].ases & MIPS_ASE_MIPS16)
 #endif
 #ifndef cpu_has_mdmx
-#define cpu_has_mdmx	       (cpu_data[0].ases & MIPS_ASE_MDMX)
+#define cpu_has_mdmx		(cpu_data[0].ases & MIPS_ASE_MDMX)
 #endif
 #ifndef cpu_has_mips3d
-#define cpu_has_mips3d	       (cpu_data[0].ases & MIPS_ASE_MIPS3D)
+#define cpu_has_mips3d		(cpu_data[0].ases & MIPS_ASE_MIPS3D)
 #endif
 #ifndef cpu_has_smartmips
-#define cpu_has_smartmips      (cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
+#define cpu_has_smartmips	(cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
 #endif
 #ifndef cpu_has_rixi
 #define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
@@ -111,7 +111,7 @@
 #define cpu_has_ic_fills_f_dc	(cpu_data[0].icache.flags & MIPS_CACHE_IC_F_DC)
 #endif
 #ifndef cpu_has_pindexed_dcache
-#define cpu_has_pindexed_dcache (cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
+#define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
 #endif
 #ifndef cpu_has_local_ebase
 #define cpu_has_local_ebase	1
@@ -151,18 +151,18 @@
 #ifndef cpu_has_mips_5
 # define cpu_has_mips_5		(cpu_data[0].isa_level & MIPS_CPU_ISA_V)
 #endif
-# ifndef cpu_has_mips32r1
+#ifndef cpu_has_mips32r1
 # define cpu_has_mips32r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R1)
-# endif
-# ifndef cpu_has_mips32r2
+#endif
+#ifndef cpu_has_mips32r2
 # define cpu_has_mips32r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R2)
-# endif
-# ifndef cpu_has_mips64r1
+#endif
+#ifndef cpu_has_mips64r1
 # define cpu_has_mips64r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R1)
-# endif
-# ifndef cpu_has_mips64r2
+#endif
+#ifndef cpu_has_mips64r2
 # define cpu_has_mips64r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R2)
-# endif
+#endif
 
 /*
  * Shortcuts ...
@@ -184,9 +184,9 @@
  * has CLO and CLZ but not DCLO nor DCLZ.  For 64-bit kernels
  * cpu_has_clo_clz also indicates the availability of DCLO and DCLZ.
  */
-# ifndef cpu_has_clo_clz
-# define cpu_has_clo_clz	cpu_has_mips_r
-# endif
+#ifndef cpu_has_clo_clz
+#define cpu_has_clo_clz	cpu_has_mips_r
+#endif
 
 #ifndef cpu_has_dsp
 #define cpu_has_dsp		(cpu_data[0].ases & MIPS_ASE_DSP)
@@ -212,7 +212,7 @@
 # define cpu_has_64bits		(cpu_data[0].isa_level & MIPS_CPU_ISA_64BIT)
 # endif
 # ifndef cpu_has_64bit_zero_reg
-# define cpu_has_64bit_zero_reg (cpu_data[0].isa_level & MIPS_CPU_ISA_64BIT)
+# define cpu_has_64bit_zero_reg	(cpu_data[0].isa_level & MIPS_CPU_ISA_64BIT)
 # endif
 # ifndef cpu_has_64bit_gp_regs
 # define cpu_has_64bit_gp_regs		0
diff --git a/arch/mips/include/asm/mach-generic/kernel-entry-init.h b/arch/mips/include/asm/mach-generic/kernel-entry-init.h
index 7e66505..13b0751 100644
--- a/arch/mips/include/asm/mach-generic/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-generic/kernel-entry-init.h
@@ -12,8 +12,8 @@
 /* Intentionally empty macro, used in head.S. Override in
  * arch/mips/mach-xxx/kernel-entry-init.h when necessary.
  */
-.macro	kernel_entry_setup
-.endm
+	.macro	kernel_entry_setup
+	.endm
 
 /*
  * Do SMP slave processor setup necessary before we can savely execute C code.
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 1470b7b..b7d2aa3 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -231,8 +231,8 @@ struct thread_struct {
 	unsigned long cp0_baduaddr;	/* Last kernel fault accessing USEG */
 	unsigned long error_code;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
-    struct octeon_cop2_state cp2 __attribute__ ((__aligned__(128)));
-    struct octeon_cvmseg_state cvmseg __attribute__ ((__aligned__(128)));
+	struct octeon_cop2_state cp2 __attribute__ ((__aligned__(128)));
+	struct octeon_cvmseg_state cvmseg __attribute__ ((__aligned__(128)));
 #endif
 	struct mips_abi *abi;
 };
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 46c2ad0..4d78bf4 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -467,5 +467,4 @@ unaligned:
 	printk("%s: unaligned epc - sending SIGBUS.\n", current->comm);
 	force_sig(SIGBUS, current);
 	return -EFAULT;
-
 }
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 3eaa02a..8eaf310 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -1549,6 +1549,7 @@ sigill:
 	    ("Unhandled kernel unaligned access or invalid instruction", regs);
 	force_sig(SIGILL, current);
 }
+
 asmlinkage void do_ade(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 4eb8dcf..2c0bd58 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -232,7 +232,7 @@ static inline void __cpuinit build_clear_pref(u32 **buf, int off)
 
 			uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
 		}
-		}
+	}
 }
 
 extern u32 __clear_page_start;
-- 
1.7.10.2
