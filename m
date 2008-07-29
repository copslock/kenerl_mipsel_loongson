Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 18:03:00 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:5022 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022102AbYG2RC4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 18:02:56 +0100
Received: (qmail 8959 invoked by uid 1000); 29 Jul 2008 19:02:55 +0200
Date:	Tue, 29 Jul 2008 19:02:54 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH v4 6/10] Alchemy: compile platform.c only when building for
	a demoboard.
Message-ID: <20080729170254.GH8784@roarinelk.homelinux.net>
References: <20080729165853.GB8784@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080729165853.GB8784@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

The platform.c registers devices not all boards might need/want,
and it makes adding platform data to drivers needlessly ugly and
complicated.

Most (all?) in-kernel users of Au1xxx are demoboards, and the file
in question somewhat reflects that.  Remove the platform.c from the
common Alchemy Makefile and add it to the Makefiles of the boards.
Existing behavior of all in-kernel boards is not changed in any way.

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
index dc8a67e..66d6770 100644
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
 
 #include <linux/dma-mapping.h>
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
1.5.6.3
