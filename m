Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 17:02:23 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:2280 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832092Ab3HUPCRHMpV8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 17:02:17 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Kconfig: Drop obsolete NR_CPUS_DEFAULT_{1,2} options
Date:   Wed, 21 Aug 2013 16:01:48 +0100
Message-ID: <1377097308-24215-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.130]
X-SEF-Processed: 7_3_0_01192__2013_08_21_16_02_10
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The NR_CPUS_DEFAULT_1 introduced as an aid for the QEMU
platform in 72ede9b18967e7a8a62a88f164f003193f6d891f
"[MIPS] Qemu: Fix Symmetric Uniprocessor support"
which was later removed in
302922e5f6901eb6f29c58539631f71b3d9746b8
"[MIPS] Qemu: Remove platform."

On certain randconfigs it may happen for NR_CPUS to have an
empty value because not all SMP platforms select a suitable
NR_CPUS_DEFAULT_* value. We fix this by restoring the range
of NR_CPUS to 2..64 and drop the NR_CPUS_DEFAULT_{1,2} symbols.
The first one is no longer used and the latter is not needed since
NR_CPUS=2 is now the default value.

Fixes the following problem on a randconfig:
.config:164:warning: symbol value '' invalid for NR_CPUS

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com> 
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/Kconfig | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e12764c..b69b4e4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -131,7 +131,6 @@ config BCM63XX
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_BMIPS4350 if !BCM63XX_CPU_6338 && !BCM63XX_CPU_6345 && !BCM63XX_CPU_6348
-	select NR_CPUS_DEFAULT_2
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
@@ -609,7 +608,6 @@ config SIBYTE_SWARM
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
-	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -623,7 +621,6 @@ config SIBYTE_LITTLESUR
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
-	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -635,7 +632,6 @@ config SIBYTE_SENTOSA
 	bool "Sibyte BCM91250E-Sentosa"
 	select BOOT_ELF32
 	select DMA_COHERENT
-	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -1862,7 +1858,6 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
-	select NR_CPUS_DEFAULT_2
 	select SMP
 	select SYS_SUPPORTS_SCHED_SMT if SMP
 	select SYS_SUPPORTS_SMP
@@ -2173,12 +2168,6 @@ config SYS_SUPPORTS_MIPS_CMP
 config SYS_SUPPORTS_SMP
 	bool
 
-config NR_CPUS_DEFAULT_1
-	bool
-
-config NR_CPUS_DEFAULT_2
-	bool
-
 config NR_CPUS_DEFAULT_4
 	bool
 
@@ -2196,10 +2185,8 @@ config NR_CPUS_DEFAULT_64
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
-	range 1 64 if NR_CPUS_DEFAULT_1
+	range 2 64
 	depends on SMP
-	default "1" if NR_CPUS_DEFAULT_1
-	default "2" if NR_CPUS_DEFAULT_2
 	default "4" if NR_CPUS_DEFAULT_4
 	default "8" if NR_CPUS_DEFAULT_8
 	default "16" if NR_CPUS_DEFAULT_16
-- 
1.8.3.2
