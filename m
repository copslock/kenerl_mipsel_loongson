Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 21:12:21 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:16787 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023887AbYFXUMM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 21:12:12 +0100
Received: (qmail 2946 invoked by uid 1000); 24 Jun 2008 22:12:10 +0200
Date:	Tue, 24 Jun 2008 22:12:10 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [RFC PATCH 5/7] Alchemy: I hate au1000/common/platform.c ...
Message-ID: <20080624201210.GF2463@roarinelk.homelinux.net>
References: <20080624200810.GA2463@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080624200810.GA2463@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19621
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
other demoboard-specific stuff spread around in the
au1000/common/ directory (PM code mainly).

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
index 74d6d4a..a147c2d 100644
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
+ * This file is intended to be included by all db1xxx/pb1xxx demoboards.
+ * It is currently used by all in-tree au1x-based boards.  If your
+ * board does not want/need all the stuff registered in here (like mine)
+ * then simply don't include it in your board's Makefile ;-)	--mlau
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
