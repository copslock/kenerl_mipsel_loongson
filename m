Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2007 02:03:36 +0100 (BST)
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43215 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20022406AbXGGBDc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Jul 2007 02:03:32 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 9A94D181C2E;
	Sat,  7 Jul 2007 03:04:14 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 235625E68F8; Sat,  7 Jul 2007 03:03:26 +0200 (CEST)
Date:	Sat, 7 Jul 2007 03:03:27 +0200
From:	Adrian Bunk <bunk@stusta.de>
To:	James.Bottomley@HansenPartnership.com, ak@suse.de,
	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] cpu_callout_map cleanups
Message-ID: <20070707010327.GX3492@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

This patch contains the following cleanups regarding cpu_callout_map:
- i386/x86_64: removed unused EXPORT_SYMBOL's
- m32r: made static
- mips: removed extern for non-existing variable from header

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/smpboot.c           |    1 -
 arch/i386/mach-voyager/voyager_smp.c |    1 -
 arch/m32r/kernel/smpboot.c           |    3 +--
 arch/x86_64/kernel/smpboot.c         |    2 --
 include/asm-m32r/smp.h               |    6 ------
 include/asm-mips/smp.h               |    7 -------
 6 files changed, 1 insertion(+), 19 deletions(-)

--- linux-2.6.22-rc6-mm1/arch/i386/kernel/smpboot.c.old	2007-07-06 01:11:32.000000000 +0200
+++ linux-2.6.22-rc6-mm1/arch/i386/kernel/smpboot.c	2007-07-06 01:13:01.000000000 +0200
@@ -83,7 +83,6 @@
 
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
-EXPORT_SYMBOL(cpu_callout_map);
 cpumask_t cpu_possible_map;
 EXPORT_SYMBOL(cpu_possible_map);
 static cpumask_t smp_commenced_mask;
--- linux-2.6.22-rc6-mm1/arch/i386/mach-voyager/voyager_smp.c.old	2007-07-06 01:14:20.000000000 +0200
+++ linux-2.6.22-rc6-mm1/arch/i386/mach-voyager/voyager_smp.c	2007-07-06 01:14:25.000000000 +0200
@@ -235,7 +235,6 @@
 /* This is for the new dynamic CPU boot code */
 cpumask_t cpu_callin_map = CPU_MASK_NONE;
 cpumask_t cpu_callout_map = CPU_MASK_NONE;
-EXPORT_SYMBOL(cpu_callout_map);
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 EXPORT_SYMBOL(cpu_possible_map);
 
--- linux-2.6.22-rc6-mm1/include/asm-m32r/smp.h.old	2007-07-06 01:15:59.000000000 +0200
+++ linux-2.6.22-rc6-mm1/include/asm-m32r/smp.h	2007-07-06 01:16:10.000000000 +0200
@@ -62,7 +62,6 @@
 
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
-extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_possible_map;
 extern cpumask_t cpu_present_map;
 
@@ -81,11 +80,6 @@
 	return cpu;
 }
 
-static __inline__ unsigned int num_booting_cpus(void)
-{
-	return cpus_weight(cpu_callout_map);
-}
-
 extern void smp_send_timer(void);
 extern unsigned long send_IPI_mask_phys(cpumask_t, int, int);
 
--- linux-2.6.22-rc6-mm1/arch/m32r/kernel/smpboot.c.old	2007-07-06 01:15:35.000000000 +0200
+++ linux-2.6.22-rc6-mm1/arch/m32r/kernel/smpboot.c	2007-07-06 01:15:43.000000000 +0200
@@ -77,8 +77,7 @@
 cpumask_t cpu_bootout_map;
 cpumask_t cpu_bootin_map;
 static cpumask_t cpu_callin_map;
-cpumask_t cpu_callout_map;
-EXPORT_SYMBOL(cpu_callout_map);
+static cpumask_t cpu_callout_map;
 cpumask_t cpu_possible_map = CPU_MASK_ALL;
 EXPORT_SYMBOL(cpu_possible_map);
 
--- linux-2.6.22-rc6-mm1/include/asm-mips/smp.h.old	2007-07-06 01:16:22.000000000 +0200
+++ linux-2.6.22-rc6-mm1/include/asm-mips/smp.h	2007-07-06 01:16:31.000000000 +0200
@@ -49,13 +49,6 @@
 extern cpumask_t phys_cpu_present_map;
 #define cpu_possible_map	phys_cpu_present_map
 
-extern cpumask_t cpu_callout_map;
-/* We don't mark CPUs online until __cpu_up(), so we need another measure */
-static inline int num_booting_cpus(void)
-{
-	return cpus_weight(cpu_callout_map);
-}
-
 /*
  * These are defined by the board-specific code.
  */
--- linux-2.6.22-rc6-mm1/arch/x86_64/kernel/smpboot.c.old	2007-07-06 01:16:47.000000000 +0200
+++ linux-2.6.22-rc6-mm1/arch/x86_64/kernel/smpboot.c	2007-07-06 01:17:02.000000000 +0200
@@ -78,8 +78,6 @@
  */
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
-EXPORT_SYMBOL(cpu_callout_map);
-
 cpumask_t cpu_possible_map;
 EXPORT_SYMBOL(cpu_possible_map);
 
