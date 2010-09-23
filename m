Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2010 08:52:04 +0200 (CEST)
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:51049 "EHLO
        qmta10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490949Ab0IWGwA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Sep 2010 08:52:00 +0200
Received: from omta07.emeryville.ca.mail.comcast.net ([76.96.30.59])
        by qmta10.emeryville.ca.mail.comcast.net with comcast
        id A6k01f0041GXsucAA6rscU; Thu, 23 Sep 2010 06:51:52 +0000
Received: from haskell.muteddisk.com ([98.239.78.58])
        by omta07.emeryville.ca.mail.comcast.net with comcast
        id A6rr1f00A1FUwZe8U6rrUD; Thu, 23 Sep 2010 06:51:52 +0000
Received: by haskell.muteddisk.com (Postfix, from userid 1000)
        id A39AE412AC; Wed, 22 Sep 2010 23:51:03 -0700 (PDT)
From:   matt mooney <mfm@muteddisk.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 10/20] mips: change to new flag variable
Date:   Wed, 22 Sep 2010 23:51:01 -0700
Message-Id: <1285224661-29797-1-git-send-email-mfm@muteddisk.com>
X-Mailer: git-send-email 1.6.4.2
X-archive-position: 27798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mfm@muteddisk.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18017

Replace EXTRA_CFLAGS with ccflags-y.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 arch/mips/Makefile                     |    4 ++--
 arch/mips/bcm63xx/boards/Makefile      |    2 +-
 arch/mips/fw/arc/Makefile              |    2 +-
 arch/mips/jz4740/Makefile              |    2 +-
 arch/mips/oprofile/Makefile            |    2 +-
 arch/mips/pmc-sierra/yosemite/Makefile |    2 +-
 arch/mips/powertv/Makefile             |    2 +-
 arch/mips/powertv/asic/Makefile        |    2 +-
 arch/mips/powertv/pci/Makefile         |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index f4a4b66..c14c392 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -288,11 +288,11 @@ CLEAN_FILES += vmlinux.32 vmlinux.64
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
-	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=n32"
+	$(Q)$(MAKE) $(build)=. missing-syscalls ccflags-y="-mabi=n32"
 endif
 ifdef CONFIG_MIPS32_O32
 	@echo '  Checking missing-syscalls for O32'
-	$(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
+	$(Q)$(MAKE) $(build)=. missing-syscalls ccflags-y="-mabi=32"
 endif
 
 install:
diff --git a/arch/mips/bcm63xx/boards/Makefile b/arch/mips/bcm63xx/boards/Makefile
index e5cc86d..9f64fb4 100644
--- a/arch/mips/bcm63xx/boards/Makefile
+++ b/arch/mips/bcm63xx/boards/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_BOARD_BCM963XX)		+= board_bcm963xx.o
 
-EXTRA_CFLAGS += -Werror
+ccflags-y := -Werror
diff --git a/arch/mips/fw/arc/Makefile b/arch/mips/fw/arc/Makefile
index e0aaad4..5314b37 100644
--- a/arch/mips/fw/arc/Makefile
+++ b/arch/mips/fw/arc/Makefile
@@ -9,4 +9,4 @@ lib-$(CONFIG_ARC_MEMORY)	+= memory.o
 lib-$(CONFIG_ARC_CONSOLE)	+= arc_con.o
 lib-$(CONFIG_ARC_PROMLIB)	+= promlib.o
 
-EXTRA_CFLAGS			+= -Werror
+ccflags-y			:= -Werror
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index a604eae..a9dff33 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -17,4 +17,4 @@ obj-$(CONFIG_JZ4740_QI_LB60)	+= board-qi_lb60.o
 
 obj-$(CONFIG_PM) += pm.o
 
-EXTRA_CFLAGS += -Werror -Wall
+ccflags-y := -Werror -Wall
diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index 02cc65e..4b9d704 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -1,4 +1,4 @@
-EXTRA_CFLAGS := -Werror
+ccflags-y := -Werror
 
 obj-$(CONFIG_OPROFILE) += oprofile.o
 
diff --git a/arch/mips/pmc-sierra/yosemite/Makefile b/arch/mips/pmc-sierra/yosemite/Makefile
index b16f95c..02f5fb9 100644
--- a/arch/mips/pmc-sierra/yosemite/Makefile
+++ b/arch/mips/pmc-sierra/yosemite/Makefile
@@ -6,4 +6,4 @@ obj-y    += irq.o prom.o py-console.o setup.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 
-EXTRA_CFLAGS += -Werror
+ccflags-y := -Werror
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
index baf6e90..348d2e8 100644
--- a/arch/mips/powertv/Makefile
+++ b/arch/mips/powertv/Makefile
@@ -28,4 +28,4 @@ obj-y += init.o ioremap.o memory.o powertv_setup.o reset.o time.o \
 
 obj-$(CONFIG_USB) += powertv-usb.o
 
-EXTRA_CFLAGS += -Wall
+ccflags-y := -Wall
diff --git a/arch/mips/powertv/asic/Makefile b/arch/mips/powertv/asic/Makefile
index f0e95dc..d810a33 100644
--- a/arch/mips/powertv/asic/Makefile
+++ b/arch/mips/powertv/asic/Makefile
@@ -20,4 +20,4 @@ obj-y += asic-calliope.o asic-cronus.o asic-gaia.o asic-zeus.o \
 	asic_devices.o asic_int.o irq_asic.o prealloc-calliope.o \
 	prealloc-cronus.o prealloc-cronuslite.o prealloc-gaia.o prealloc-zeus.o
 
-EXTRA_CFLAGS += -Wall -Werror
+ccflags-y := -Wall -Werror
diff --git a/arch/mips/powertv/pci/Makefile b/arch/mips/powertv/pci/Makefile
index f5c6246..5783201 100644
--- a/arch/mips/powertv/pci/Makefile
+++ b/arch/mips/powertv/pci/Makefile
@@ -18,4 +18,4 @@
 
 obj-$(CONFIG_PCI)	+= fixup-powertv.o
 
-EXTRA_CFLAGS += -Wall -Werror
+ccflags-y := -Wall -Werror
-- 
1.7.2.1
