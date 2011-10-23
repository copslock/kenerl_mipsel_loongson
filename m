Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2011 15:45:10 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1372 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491005Ab1JWNoJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Oct 2011 15:44:09 +0200
X-TM-IMSS-Message-ID: <b968608d0004e55b@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id b968608d0004e55b ; Sun, 23 Oct 2011 06:44:00 -0700
Date:   Sun, 23 Oct 2011 19:08:42 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 02/12] MIPS: Netlogic: Use CPU_XLR instead of NLM_XLR
Message-ID: <20111023133836.GA22364@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Oct 2011 13:36:40.0487 (UTC) FILETIME=[CBA1F370:01CC9188]
X-archive-position: 31272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16577

The CPU_XLR config variable is sufficient for XLR compilation, the
variable NLM_XLR can be removed.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig           |    1 -
 arch/mips/netlogic/Kconfig  |    3 ---
 arch/mips/netlogic/Platform |    4 ++--
 arch/mips/pci/Makefile      |    2 +-
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2bb1c85..bbc4e0e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -765,7 +765,6 @@ config NLM_XLR_BOARD
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select NLM_COMMON
-	select NLM_XLR
 	select SYS_HAS_CPU_XLR
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index a5ca743..75bec44 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -1,5 +1,2 @@
 config NLM_COMMON
 	bool
-
-config NLM_XLR
-	bool
diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index 4fb6b83..18aaf43 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -7,10 +7,10 @@ cflags-$(CONFIG_NLM_COMMON)	+= -I$(srctree)/arch/mips/include/asm/netlogic
 #
 # use mips64 if xlr is not available
 #
-cflags-$(CONFIG_NLM_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
+cflags-$(CONFIG_CPU_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
 
 #
 # NETLOGIC processor support
 #
-platform-$(CONFIG_NLM_XLR)  	+= netlogic/xlr
+platform-$(CONFIG_CPU_XLR)  	+= netlogic/xlr
 load-$(CONFIG_NLM_COMMON)  	+= 0xffffffff80100000
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 4df8799..3141e141 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -56,7 +56,7 @@ obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= pci-octeon.o pcie-octeon.o
-obj-$(CONFIG_NLM_XLR)		+= pci-xlr.o
+obj-$(CONFIG_CPU_XLR)		+= pci-xlr.o
 
 ifdef CONFIG_PCI_MSI
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= msi-octeon.o
-- 
1.7.4.1
