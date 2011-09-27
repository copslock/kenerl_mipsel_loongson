Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2011 10:29:45 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1552 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491803Ab1I0I3P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2011 10:29:15 +0200
X-TM-IMSS-Message-ID: <326328530000108d@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 326328530000108d ; Tue, 27 Sep 2011 01:29:08 -0700
Received: from orion8.netlogicmicro.com (10.10.16.60) by
 hqcas01.netlogicmicro.com (10.10.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 27 Sep 2011 01:29:07 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by
 orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);         Tue, 27 Sep
 2011 01:28:37 -0700
Date:   Tue, 27 Sep 2011 14:07:27 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 2/9] MIPS: Netlogic: Use CPU_XLR instead of NLM_XLR
Message-ID: <e6d2bdd6dce46c98ac64caa62048d3f34dce0d39.1317111127.git.jayachandranc@netlogicmicro.com>
References: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 27 Sep 2011 08:28:37.0685 (UTC) FILETIME=[7448AE50:01CC7CEF]
X-archive-position: 31173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15273

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
