Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Feb 2011 03:23:48 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15390 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491120Ab1BRCXn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Feb 2011 03:23:43 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5dd85f0000>; Thu, 17 Feb 2011 18:24:31 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 18:23:39 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 18:23:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1I2NZgP004039;
        Thu, 17 Feb 2011 18:23:35 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1I2NYIK004038;
        Thu, 17 Feb 2011 18:23:34 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Guard the body of arch/mips/cavium-octeon/Kconfig with CPU_CAVIUM_OCTEON
Date:   Thu, 17 Feb 2011 18:23:32 -0800
Message-Id: <1297995812-4006-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 18 Feb 2011 02:23:39.0114 (UTC) FILETIME=[DA6D2CA0:01CBCF12]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Instead of making each Octeon specific option depend on
CPU_CAVIUM_OCTEON, gate the body of the entire file with
CPU_CAVIUM_OCTEON.  With this change, CAVIUM_OCTEON_SPECIFIC_OPTIONS
becomes useless, so get rid of it as well.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This patch replaces:
http://patchwork.linux-mips.org/patch/2080

And should be applied before 
http://patchwork.linux-mips.org/patch/2081
.
.
.
http://patchwork.linux-mips.org/patch/2090


 arch/mips/cavium-octeon/Kconfig |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index caae228..cad555e 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -1,11 +1,7 @@
-config CAVIUM_OCTEON_SPECIFIC_OPTIONS
-	bool "Enable Octeon specific options"
-	depends on CPU_CAVIUM_OCTEON
-	default "y"
+if CPU_CAVIUM_OCTEON
 
 config CAVIUM_CN63XXP1
 	bool "Enable CN63XXP1 errata worarounds"
-	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
 	default "n"
 	help
 	  The CN63XXP1 chip requires build time workarounds to
@@ -16,7 +12,6 @@ config CAVIUM_CN63XXP1
 
 config CAVIUM_OCTEON_2ND_KERNEL
 	bool "Build the kernel to be used as a 2nd kernel on the same chip"
-	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
 	default "n"
 	help
 	  This option configures this kernel to be linked at a different
@@ -26,7 +21,6 @@ config CAVIUM_OCTEON_2ND_KERNEL
 
 config CAVIUM_OCTEON_HW_FIX_UNALIGNED
 	bool "Enable hardware fixups of unaligned loads and stores"
-	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
 	default "y"
 	help
 	  Configure the Octeon hardware to automatically fix unaligned loads
@@ -38,7 +32,6 @@ config CAVIUM_OCTEON_HW_FIX_UNALIGNED
 
 config CAVIUM_OCTEON_CVMSEG_SIZE
 	int "Number of L1 cache lines reserved for CVMSEG memory"
-	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
 	range 0 54
 	default 1
 	help
@@ -50,7 +43,6 @@ config CAVIUM_OCTEON_CVMSEG_SIZE
 
 config CAVIUM_OCTEON_LOCK_L2
 	bool "Lock often used kernel code in the L2"
-	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
 	default "y"
 	help
 	  Enable locking parts of the kernel into the L2 cache.
@@ -93,7 +85,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC
-	depends on CPU_CAVIUM_OCTEON
 
 config CAVIUM_OCTEON_HELPER
 	def_bool y
@@ -107,6 +98,8 @@ config NEED_SG_DMA_LENGTH
 
 config SWIOTLB
 	def_bool y
-	depends on CPU_CAVIUM_OCTEON
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
+
+
+endif # CPU_CAVIUM_OCTEON
-- 
1.7.2.3
