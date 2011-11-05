Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 22:34:02 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:41218 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904166Ab1KEVd3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Nov 2011 22:33:29 +0100
Received: (qmail 28059 invoked from network); 5 Nov 2011 17:28:30 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Nov 2011 17:28:30 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 10:28:30 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/9] MIPS: BMIPS: Fix up Kconfig settings
Date:   Sat, 05 Nov 2011 14:21:11 -0700
Message-Id: <a1e7d0cd453db3fed48abd2cf5e7a5c6@localhost>
In-Reply-To: <c2c8833593cb8eeef5c102468e105497@localhost>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4399

Factor out common BMIPS options into "CPU_BMIPS".  Add L2 cache for
BMIPS5000.  Add CPU_MIPS32 to satisfy checks in page.h, r4k_switch.S,
tlb-r4k.c, etc.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig |   34 ++++++++++++++--------------------
 1 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 62b9677..8b231ba 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1417,51 +1417,36 @@ config CPU_CAVIUM_OCTEON
 config CPU_BMIPS3300
 	bool "BMIPS3300"
 	depends on SYS_HAS_CPU_BMIPS3300
-	select DMA_NONCOHERENT
-	select IRQ_CPU
-	select SWAP_IO_SPACE
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select WEAK_ORDERING
+	select CPU_BMIPS
 	help
 	  Broadcom BMIPS3300 processors.
 
 config CPU_BMIPS4350
 	bool "BMIPS4350"
 	depends on SYS_HAS_CPU_BMIPS4350
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select DMA_NONCOHERENT
-	select IRQ_CPU
-	select SWAP_IO_SPACE
+	select CPU_BMIPS
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
-	select WEAK_ORDERING
 	help
 	  Broadcom BMIPS4350 ("VIPER") processors.
 
 config CPU_BMIPS4380
 	bool "BMIPS4380"
 	depends on SYS_HAS_CPU_BMIPS4380
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select DMA_NONCOHERENT
-	select IRQ_CPU
-	select SWAP_IO_SPACE
+	select CPU_BMIPS
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
-	select WEAK_ORDERING
 	help
 	  Broadcom BMIPS4380 processors.
 
 config CPU_BMIPS5000
 	bool "BMIPS5000"
 	depends on SYS_HAS_CPU_BMIPS5000
-	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_BMIPS
 	select CPU_SUPPORTS_HIGHMEM
-	select DMA_NONCOHERENT
-	select IRQ_CPU
-	select SWAP_IO_SPACE
+	select MIPS_CPU_SCACHE
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
-	select WEAK_ORDERING
 	help
 	  Broadcom BMIPS5000 processors.
 
@@ -1522,6 +1507,15 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 
+config CPU_BMIPS
+	bool
+	select CPU_MIPS32
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select WEAK_ORDERING
+
 config SYS_HAS_CPU_LOONGSON2E
 	bool
 
-- 
1.7.6.3
