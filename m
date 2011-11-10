Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 20:34:06 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:39371 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903664Ab1KJTdh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 20:33:37 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH V2] MIPS: lantiq: use export.h in favour of module.h
Date:   Thu, 10 Nov 2011 21:33:07 +0100
Message-Id: <1320957187-26693-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320957187-26693-1-git-send-email-blogic@openwrt.org>
References: <1320957187-26693-1-git-send-email-blogic@openwrt.org>
X-archive-position: 31511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9722

The code located at arch/mips/lantiq/ included module.h to be able to use the
EXPORT_SYMBOL* macros. These can now be directly included using export.h.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---

Changes in V2
* adds arch/mips/pci/pci-lantiq.c

 arch/mips/lantiq/clk.c            |    2 +-
 arch/mips/lantiq/devices.c        |    2 +-
 arch/mips/lantiq/prom.c           |    2 +-
 arch/mips/lantiq/setup.c          |    2 +-
 arch/mips/lantiq/xway/clk-ase.c   |    2 +-
 arch/mips/lantiq/xway/clk-xway.c  |    2 +-
 arch/mips/lantiq/xway/devices.c   |    2 +-
 arch/mips/lantiq/xway/dma.c       |    1 +
 arch/mips/lantiq/xway/gpio.c      |    2 +-
 arch/mips/lantiq/xway/gpio_ebu.c  |    2 +-
 arch/mips/lantiq/xway/gpio_stp.c  |    2 +-
 arch/mips/lantiq/xway/prom-ase.c  |    2 +-
 arch/mips/lantiq/xway/prom-xway.c |    2 +-
 arch/mips/lantiq/xway/reset.c     |    2 +-
 arch/mips/pci/pci-lantiq.c        |    1 +
 15 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 7e9c0ff..77ed70f 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
  */
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
index 44a3677..de1cb2b 100644
--- a/arch/mips/lantiq/devices.c
+++ b/arch/mips/lantiq/devices.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 56ba007..e34fcfd 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/clk.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
diff --git a/arch/mips/lantiq/setup.c b/arch/mips/lantiq/setup.c
index 9b8af77..1ff6c9d 100644
--- a/arch/mips/lantiq/setup.c
+++ b/arch/mips/lantiq/setup.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <asm/bootinfo.h>
diff --git a/arch/mips/lantiq/xway/clk-ase.c b/arch/mips/lantiq/xway/clk-ase.c
index 22d823a..6522583 100644
--- a/arch/mips/lantiq/xway/clk-ase.c
+++ b/arch/mips/lantiq/xway/clk-ase.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 
diff --git a/arch/mips/lantiq/xway/clk-xway.c b/arch/mips/lantiq/xway/clk-xway.c
index ddd3959..696b1a3 100644
--- a/arch/mips/lantiq/xway/clk-xway.c
+++ b/arch/mips/lantiq/xway/clk-xway.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
index d0e32ab..d614aa7 100644
--- a/arch/mips/lantiq/xway/devices.c
+++ b/arch/mips/lantiq/xway/devices.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/mtd/physmap.h>
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 4278a45..cbb6ae5 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/export.h>
 
 #include <lantiq_soc.h>
 #include <xway_dma.h>
diff --git a/arch/mips/lantiq/xway/gpio.c b/arch/mips/lantiq/xway/gpio.c
index a321451..d2fa98f 100644
--- a/arch/mips/lantiq/xway/gpio.c
+++ b/arch/mips/lantiq/xway/gpio.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/ioport.h>
diff --git a/arch/mips/lantiq/xway/gpio_ebu.c b/arch/mips/lantiq/xway/gpio_ebu.c
index a479355..b91c7f1 100644
--- a/arch/mips/lantiq/xway/gpio_ebu.c
+++ b/arch/mips/lantiq/xway/gpio_ebu.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index 67d59d6..ff9991c 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -9,7 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
diff --git a/arch/mips/lantiq/xway/prom-ase.c b/arch/mips/lantiq/xway/prom-ase.c
index abe49f4..ae4959a 100644
--- a/arch/mips/lantiq/xway/prom-ase.c
+++ b/arch/mips/lantiq/xway/prom-ase.c
@@ -6,7 +6,7 @@
  *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/clk.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
diff --git a/arch/mips/lantiq/xway/prom-xway.c b/arch/mips/lantiq/xway/prom-xway.c
index 1686692a..2228133 100644
--- a/arch/mips/lantiq/xway/prom-xway.c
+++ b/arch/mips/lantiq/xway/prom-xway.c
@@ -6,7 +6,7 @@
  *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/clk.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index a1be36d..3d41f0b 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/pm.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/reboot.h>
 
 #include <lantiq_soc.h>
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 8656388..be1e1af 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/export.h>
 #include <linux/platform_device.h>
 
 #include <asm/pci.h>
-- 
1.7.7.1
