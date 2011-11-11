Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 12:36:11 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1186 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903544Ab1KKLfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 12:35:43 +0100
X-TM-IMSS-Message-ID: <1acb5a630007c9d3@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 1acb5a630007c9d3 ; Fri, 11 Nov 2011 03:35:36 -0800
Date:   Fri, 11 Nov 2011 17:07:40 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 02/12] MIPS: Netlogic: Use CPU_XLR instead of NLM_XLR
Message-ID: <ee3813349f60d889ec73b362c39ae1bcf33f9591.1321011000.git.jayachandranc@netlogicmicro.com>
References: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 11 Nov 2011 11:35:36.0224 (UTC) FILETIME=[07A4A200:01CCA066]
X-archive-position: 31544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10221

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
index 04ac89c..58515fd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -761,7 +761,6 @@ config NLM_XLR_BOARD
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
index bb82cbd..65ca05c 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -55,7 +55,7 @@ obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= pci-octeon.o pcie-octeon.o
-obj-$(CONFIG_NLM_XLR)		+= pci-xlr.o
+obj-$(CONFIG_CPU_XLR)		+= pci-xlr.o
 
 ifdef CONFIG_PCI_MSI
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= msi-octeon.o
-- 
1.7.5.4
