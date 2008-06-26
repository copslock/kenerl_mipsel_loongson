Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 20:40:49 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:26024 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20025679AbYFZTkm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jun 2008 20:40:42 +0100
Received: (qmail 21860 invoked by uid 1000); 26 Jun 2008 21:40:38 +0200
Date:	Thu, 26 Jun 2008 21:40:38 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH v2 6/8] Alchemy: platform.c is for demoboards.
Message-ID: <20080626194038.GG21604@roarinelk.homelinux.net>
References: <20080626193643.GA21604@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080626193643.GA21604@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mano@roarinelk.homelinux.net>

... so only compile it in if boards actually want it.

It registers stuff my board does not want/need, and
with this change I can use it as a dumping ground for
the Alchemy-PM stuff.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/Makefile   |    2 +-
 arch/mips/au1000/common/platform.c |    7 ++++++-
 arch/mips/au1000/db1x00/Makefile   |    1 +
 arch/mips/au1000/mtx-1/Makefile    |    2 +-
 arch/mips/au1000/pb1000/Makefile   |    1 +
 arch/mips/au1000/pb1100/Makefile   |    1 +
 arch/mips/au1000/pb1200/Makefile   |    2 +-
 arch/mips/au1000/pb1500/Makefile   |    1 +
 arch/mips/au1000/pb1550/Makefile   |    1 +
 arch/mips/au1000/xxs1500/Makefile  |    1 +
 10 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/mips/au1000/common/Makefile b/arch/mips/au1000/common/Makefile
index 850de08..aefb2b8 100644
--- a/arch/mips/au1000/common/Makefile
+++ b/arch/mips/au1000/common/Makefile
@@ -6,7 +6,7 @@
 #
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
-	au1xxx_irqmap.o clocks.o platform.o power.o setup.o \
+	au1xxx_irqmap.o clocks.o power.o setup.o \
 	sleeper.o dma.o dbdma.o gpio.o
 
 obj-$(CONFIG_KGDB)		+= dbg_io.o
diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index 74d6d4a..8018b21 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -1,5 +1,5 @@
 /*
- * Platform device support for Au1x00 SoCs.
+ * Common device support for Au1x00 demoboards.
  *
  * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
  *
@@ -9,6 +9,11 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
+ *
+ * This file is intended to be included by all db1xxx/pb1xxx demoboards,
+ * and is currently used by all the in-tree ones.  If your system does
+ * not want/need all the devices registered in here (like mine) then
+ * simply don't include it in your Makefile ;-)
  */
 
 #include <linux/platform_device.h>
diff --git a/arch/mips/au1000/db1x00/Makefile b/arch/mips/au1000/db1x00/Makefile
index 274db3b..3bfec10 100644
--- a/arch/mips/au1000/db1x00/Makefile
+++ b/arch/mips/au1000/db1x00/Makefile
@@ -6,3 +6,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y := ../common/platform.o
diff --git a/arch/mips/au1000/mtx-1/Makefile b/arch/mips/au1000/mtx-1/Makefile
index 7c67b3d..ef98975 100644
--- a/arch/mips/au1000/mtx-1/Makefile
+++ b/arch/mips/au1000/mtx-1/Makefile
@@ -7,6 +7,6 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
-obj-y := platform.o
+obj-y := platform.o ../common/platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/au1000/pb1000/Makefile b/arch/mips/au1000/pb1000/Makefile
index 99bbec0..41a09be 100644
--- a/arch/mips/au1000/pb1000/Makefile
+++ b/arch/mips/au1000/pb1000/Makefile
@@ -6,3 +6,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y := ../common/platform.o
diff --git a/arch/mips/au1000/pb1100/Makefile b/arch/mips/au1000/pb1100/Makefile
index 793e97c..1a8cd71 100644
--- a/arch/mips/au1000/pb1100/Makefile
+++ b/arch/mips/au1000/pb1100/Makefile
@@ -6,3 +6,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y := ../common/platform.o
diff --git a/arch/mips/au1000/pb1200/Makefile b/arch/mips/au1000/pb1200/Makefile
index d678adf..7b9f2f5 100644
--- a/arch/mips/au1000/pb1200/Makefile
+++ b/arch/mips/au1000/pb1200/Makefile
@@ -3,6 +3,6 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
-obj-y += platform.o
+obj-y += platform.o ../common/platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/au1000/pb1500/Makefile b/arch/mips/au1000/pb1500/Makefile
index 602f38d..c12e1bd 100644
--- a/arch/mips/au1000/pb1500/Makefile
+++ b/arch/mips/au1000/pb1500/Makefile
@@ -6,3 +6,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y := ../common/platform.o
diff --git a/arch/mips/au1000/pb1550/Makefile b/arch/mips/au1000/pb1550/Makefile
index 7d8beca..8df0890 100644
--- a/arch/mips/au1000/pb1550/Makefile
+++ b/arch/mips/au1000/pb1550/Makefile
@@ -6,3 +6,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y := ../common/platform.o
diff --git a/arch/mips/au1000/xxs1500/Makefile b/arch/mips/au1000/xxs1500/Makefile
index db3c526..86db0f7 100644
--- a/arch/mips/au1000/xxs1500/Makefile
+++ b/arch/mips/au1000/xxs1500/Makefile
@@ -6,3 +6,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y := ../common/platform.o
-- 
1.5.5.4
