Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2016 09:58:29 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51759 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027805AbcEEH6HE28w7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 May 2016 09:58:07 +0200
From:   John Crispin <john@phrozen.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] arch: mips: change my email address
Date:   Thu,  5 May 2016 09:57:56 +0200
Message-Id: <1462435076-48703-2-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1462435076-48703-1-git-send-email-john@phrozen.org>
References: <1462435076-48703-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The old address is no longer valid. Use the my new one instead.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h |    2 +-
 arch/mips/include/asm/mach-lantiq/lantiq.h            |    2 +-
 arch/mips/include/asm/mach-lantiq/lantiq_platform.h   |    2 +-
 arch/mips/include/asm/mach-lantiq/xway/irq.h          |    2 +-
 arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h   |    2 +-
 arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h   |    2 +-
 arch/mips/include/asm/mach-lantiq/xway/xway_dma.h     |    2 +-
 arch/mips/include/asm/mach-ralink/mt7620.h            |    2 +-
 arch/mips/include/asm/mach-ralink/mt7621.h            |    2 +-
 arch/mips/include/asm/mach-ralink/pinmux.h            |    2 +-
 arch/mips/include/asm/mach-ralink/ralink_regs.h       |    2 +-
 arch/mips/include/asm/mach-ralink/rt288x.h            |    2 +-
 arch/mips/include/asm/mach-ralink/rt305x.h            |    2 +-
 arch/mips/lantiq/Makefile                             |    2 +-
 arch/mips/lantiq/clk.c                                |    2 +-
 arch/mips/lantiq/clk.h                                |    2 +-
 arch/mips/lantiq/early_printk.c                       |    2 +-
 arch/mips/lantiq/falcon/prom.c                        |    2 +-
 arch/mips/lantiq/falcon/reset.c                       |    2 +-
 arch/mips/lantiq/falcon/sysctrl.c                     |    2 +-
 arch/mips/lantiq/irq.c                                |    2 +-
 arch/mips/lantiq/prom.c                               |    2 +-
 arch/mips/lantiq/prom.h                               |    2 +-
 arch/mips/lantiq/xway/clk.c                           |    2 +-
 arch/mips/lantiq/xway/dcdc.c                          |    2 +-
 arch/mips/lantiq/xway/dma.c                           |    2 +-
 arch/mips/lantiq/xway/gptu.c                          |    2 +-
 arch/mips/lantiq/xway/prom.c                          |    2 +-
 arch/mips/lantiq/xway/reset.c                         |    2 +-
 arch/mips/lantiq/xway/sysctrl.c                       |    2 +-
 arch/mips/lantiq/xway/vmmc.c                          |    2 +-
 arch/mips/lantiq/xway/xrx200_phy_fw.c                 |    4 ++--
 arch/mips/pci/fixup-lantiq.c                          |    2 +-
 arch/mips/pci/ops-lantiq.c                            |    2 +-
 arch/mips/pci/pci-lantiq.c                            |    2 +-
 arch/mips/pci/pci-lantiq.h                            |    2 +-
 arch/mips/pci/pci-mt7620.c                            |    2 +-
 arch/mips/pci/pci-rt2880.c                            |    2 +-
 arch/mips/ralink/Makefile                             |    2 +-
 arch/mips/ralink/bootrom.c                            |    2 +-
 arch/mips/ralink/cevt-rt3352.c                        |    2 +-
 arch/mips/ralink/clk.c                                |    2 +-
 arch/mips/ralink/common.h                             |    2 +-
 arch/mips/ralink/ill_acc.c                            |    2 +-
 arch/mips/ralink/irq-gic.c                            |    2 +-
 arch/mips/ralink/irq.c                                |    2 +-
 arch/mips/ralink/mt7620.c                             |    2 +-
 arch/mips/ralink/mt7621.c                             |    2 +-
 arch/mips/ralink/of.c                                 |    2 +-
 arch/mips/ralink/prom.c                               |    2 +-
 arch/mips/ralink/reset.c                              |    2 +-
 arch/mips/ralink/rt288x.c                             |    2 +-
 arch/mips/ralink/rt305x.c                             |    2 +-
 arch/mips/ralink/rt3883.c                             |    2 +-
 arch/mips/ralink/timer-gic.c                          |    2 +-
 arch/mips/ralink/timer.c                              |    4 ++--
 56 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
index 98d6a2f..7023883 100644
--- a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
@@ -3,7 +3,7 @@
  * under the terms of the GNU General Public License version 2 as published
  * by the Free Software Foundation.
  *
- * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef _LTQ_FALCON_H__
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 4e5ae65..8064d7a 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 #ifndef _LANTIQ_H__
 #define _LANTIQ_H__
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq_platform.h b/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
index e23bf7c..17d2fdc 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq_platform.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef _LANTIQ_PLATFORM_H__
diff --git a/arch/mips/include/asm/mach-lantiq/xway/irq.h b/arch/mips/include/asm/mach-lantiq/xway/irq.h
index a1471d2..83e5f03 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/irq.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/irq.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef __LANTIQ_IRQ_H
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
index 5eadfe5..1410763 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_irq.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef _LANTIQ_XWAY_IRQ_H__
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index dd6005b..f873107 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef _LTQ_XWAY_H__
diff --git a/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h b/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
index 5f8693d..4901833 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
@@ -12,7 +12,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
  *
- *   Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2011 John Crispin <john@phrozen.org>
  */
 
 #ifndef LTQ_DMA_H__
diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 455d406..ece7420 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #ifndef _MT7620_REGS_H_
diff --git a/arch/mips/include/asm/mach-ralink/mt7621.h b/arch/mips/include/asm/mach-ralink/mt7621.h
index 610b61e..a672e06 100644
--- a/arch/mips/include/asm/mach-ralink/mt7621.h
+++ b/arch/mips/include/asm/mach-ralink/mt7621.h
@@ -3,7 +3,7 @@
  * under the terms of the GNU General Public License version 2 as published
  * by the Free Software Foundation.
  *
- * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2015 John Crispin <john@phrozen.org>
  */
 
 #ifndef _MT7621_REGS_H_
diff --git a/arch/mips/include/asm/mach-ralink/pinmux.h b/arch/mips/include/asm/mach-ralink/pinmux.h
index be106cb..ba8ac33 100644
--- a/arch/mips/include/asm/mach-ralink/pinmux.h
+++ b/arch/mips/include/asm/mach-ralink/pinmux.h
@@ -3,7 +3,7 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  publishhed by the Free Software Foundation.
  *
- *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
 #ifndef _RT288X_PINMUX_H__
diff --git a/arch/mips/include/asm/mach-ralink/ralink_regs.h b/arch/mips/include/asm/mach-ralink/ralink_regs.h
index 4c9fba6..9df1a53 100644
--- a/arch/mips/include/asm/mach-ralink/ralink_regs.h
+++ b/arch/mips/include/asm/mach-ralink/ralink_regs.h
@@ -1,7 +1,7 @@
 /*
  *  Ralink SoC register definitions
  *
- *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2013 John Crispin <john@phrozen.org>
  *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
diff --git a/arch/mips/include/asm/mach-ralink/rt288x.h b/arch/mips/include/asm/mach-ralink/rt288x.h
index 03ad716..25ae104 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x.h
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #ifndef _RT288X_REGS_H_
diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index 2eea793..ac2d65c 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #ifndef _RT305X_REGS_H_
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index 690257a..2718652 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -1,4 +1,4 @@
-# Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+# Copyright (C) 2010 John Crispin <john@phrozen.org>
 #
 # This program is free software; you can redistribute it and/or modify it
 # under the terms of the GNU General Public License version 2 as published
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index a0706fd..149f051 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -4,7 +4,7 @@
  *  by the Free Software Foundation.
  *
  * Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
- * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 #include <linux/io.h>
 #include <linux/export.h>
diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
index 7376ce8..e806e04 100644
--- a/arch/mips/lantiq/clk.h
+++ b/arch/mips/lantiq/clk.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef _LTQ_CLK_H__
diff --git a/arch/mips/lantiq/early_printk.c b/arch/mips/lantiq/early_printk.c
index 9b28d09..44bccae 100644
--- a/arch/mips/lantiq/early_printk.c
+++ b/arch/mips/lantiq/early_printk.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #include <linux/cpu.h>
diff --git a/arch/mips/lantiq/falcon/prom.c b/arch/mips/lantiq/falcon/prom.c
index aa94979..75315c0 100644
--- a/arch/mips/lantiq/falcon/prom.c
+++ b/arch/mips/lantiq/falcon/prom.c
@@ -4,7 +4,7 @@
  * by the Free Software Foundation.
  *
  * Copyright (C) 2012 Thomas Langer <thomas.langer@lantiq.com>
- * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
 #include <linux/kernel.h>
diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
index 5682482..7a535d7 100644
--- a/arch/mips/lantiq/falcon/reset.c
+++ b/arch/mips/lantiq/falcon/reset.c
@@ -4,7 +4,7 @@
  * by the Free Software Foundation.
  *
  * Copyright (C) 2012 Thomas Langer <thomas.langer@lantiq.com>
- * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
 #include <linux/init.h>
diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 7edcd49..2a1b302 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -4,7 +4,7 @@
  * by the Free Software Foundation.
  *
  * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
- * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2011 John Crispin <john@phrozen.org>
  */
 
 #include <linux/ioport.h>
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 2e7f60c..ff17669e 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2010 John Crispin <john@phrozen.org>
  * Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
  */
 
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 297bcaa..f2518e9 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #include <linux/export.h>
diff --git a/arch/mips/lantiq/prom.h b/arch/mips/lantiq/prom.h
index bfd2d58..4b6576c 100644
--- a/arch/mips/lantiq/prom.h
+++ b/arch/mips/lantiq/prom.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef _LTQ_PROM_H__
diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index 07f6d5b..41fc30d 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
  */
 
diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
index ae8e930..08f7aba 100644
--- a/arch/mips/lantiq/xway/dcdc.c
+++ b/arch/mips/lantiq/xway/dcdc.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  *  Copyright (C) 2010 Sameer Ahmad, Lantiq GmbH
  */
 
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 34a116e..cef8117 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -12,7 +12,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
  *
- *   Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2011 John Crispin <john@phrozen.org>
  */
 
 #include <linux/init.h>
diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index f1492b2..0f1bbea 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  *  Copyright (C) 2012 Lantiq GmbH
  */
 
diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
index 8f6e02f..9475b25 100644
--- a/arch/mips/lantiq/xway/prom.c
+++ b/arch/mips/lantiq/xway/prom.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
  */
 
diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index bc29bb3..86edea9 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
  */
 
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 80554e8..236193b 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2011-2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2011-2012 John Crispin <john@phrozen.org>
  *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
  */
 
diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index d001bc3..4625495 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
 #include <linux/module.h>
diff --git a/arch/mips/lantiq/xway/xrx200_phy_fw.c b/arch/mips/lantiq/xway/xrx200_phy_fw.c
index 199094a..71e518c 100644
--- a/arch/mips/lantiq/xway/xrx200_phy_fw.c
+++ b/arch/mips/lantiq/xway/xrx200_phy_fw.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
 #include <linux/delay.h>
@@ -112,6 +112,6 @@ static struct platform_driver xway_phy_driver = {
 
 module_platform_driver(xway_phy_driver);
 
-MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_AUTHOR("John Crispin <john@phrozen.org>");
 MODULE_DESCRIPTION("Lantiq XRX200 PHY Firmware Loader");
 MODULE_LICENSE("GPL");
diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
index c2ce41e..2b5427d 100644
--- a/arch/mips/pci/fixup-lantiq.c
+++ b/arch/mips/pci/fixup-lantiq.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
 #include <linux/of_irq.h>
diff --git a/arch/mips/pci/ops-lantiq.c b/arch/mips/pci/ops-lantiq.c
index e5738ee..f51e108 100644
--- a/arch/mips/pci/ops-lantiq.c
+++ b/arch/mips/pci/ops-lantiq.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #include <linux/types.h>
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 6a15dbd..b9deab1 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #include <linux/types.h>
diff --git a/arch/mips/pci/pci-lantiq.h b/arch/mips/pci/pci-lantiq.h
index 66bf6cd..0cc7125 100644
--- a/arch/mips/pci/pci-lantiq.h
+++ b/arch/mips/pci/pci-lantiq.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  */
 
 #ifndef _LTQ_PCI_H__
diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index 1ae932c..6ce8162 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -2,7 +2,7 @@
  *  Ralink MT7620A SoC PCI support
  *
  *  Copyright (C) 2007-2013 Bruce Chang (Mediatek)
- *  Copyright (C) 2013-2016 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2013-2016 John Crispin <john@phrozen.org>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index a245cad..f2a1050 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -1,7 +1,7 @@
 /*
  *  Ralink RT288x SoC PCI register definitions
  *
- *  Copyright (C) 2009 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2009 John Crispin <john@phrozen.org>
  *  Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
  *
  *  Parts of this file are based on Ralink's 2.6.21 BSP
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 0d1795a..fe34715 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -4,7 +4,7 @@
 # Makefile for the Ralink common stuff
 #
 # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
-# Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+# Copyright (C) 2013 John Crispin <john@phrozen.org>
 
 obj-y := prom.o of.o reset.o
 
diff --git a/arch/mips/ralink/bootrom.c b/arch/mips/ralink/bootrom.c
index 5403468..e1fa597 100644
--- a/arch/mips/ralink/bootrom.c
+++ b/arch/mips/ralink/bootrom.c
@@ -3,7 +3,7 @@
  * under the terms of the GNU General Public License version 2 as published
  * by the Free Software Foundation.
  *
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/debugfs.h>
diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
index e46f91f..3ad0b07 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2013 by John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 by John Crispin <john@phrozen.org>
  */
 
 #include <linux/clockchips.h>
diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 25c4a61..ebaa7cc 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -4,7 +4,7 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/kernel.h>
diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 8e7d8e6..b8245d0 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -3,7 +3,7 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #ifndef _RALINK_COMMON_H__
diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index e10d10b..765d5ba 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -3,7 +3,7 @@
  * under the terms of the GNU General Public License version 2 as published
  * by the Free Software Foundation.
  *
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/interrupt.h>
diff --git a/arch/mips/ralink/irq-gic.c b/arch/mips/ralink/irq-gic.c
index 50d6c55..2058280 100644
--- a/arch/mips/ralink/irq-gic.c
+++ b/arch/mips/ralink/irq-gic.c
@@ -4,7 +4,7 @@
  * by the Free Software Foundation.
  *
  * Copyright (C) 2015 Nikolay Martynov <mar.kolya@gmail.com>
- * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2015 John Crispin <john@phrozen.org>
  */
 
 #include <linux/init.h>
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 4cf77f3..4911c14 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -4,7 +4,7 @@
  * by the Free Software Foundation.
  *
  * Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/io.h>
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 0d3d1a9..2c623f6 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/kernel.h>
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index e9b9fa3..a45bbbe 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -4,7 +4,7 @@
  * by the Free Software Foundation.
  *
  * Copyright (C) 2015 Nikolay Martynov <mar.kolya@gmail.com>
- * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2015 John Crispin <john@phrozen.org>
  */
 
 #include <linux/kernel.h>
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index f9eda5d..0aa67a2 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/io.h>
diff --git a/arch/mips/ralink/prom.c b/arch/mips/ralink/prom.c
index 39a9142f..5a73c5e 100644
--- a/arch/mips/ralink/prom.c
+++ b/arch/mips/ralink/prom.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2010 Joonas Lahtinen <joonas.lahtinen@gmail.com>
- *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/string.h>
diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index ee117c4..3d98ce9 100644
--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2008-2009 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/pm.h>
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 3c84166..285796e 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/kernel.h>
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index d7c4ba4..c8a28c4b 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/kernel.h>
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index fafec94..4cef916 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
  */
 
 #include <linux/kernel.h>
diff --git a/arch/mips/ralink/timer-gic.c b/arch/mips/ralink/timer-gic.c
index 5b4f186..069771d 100644
--- a/arch/mips/ralink/timer-gic.c
+++ b/arch/mips/ralink/timer-gic.c
@@ -4,7 +4,7 @@
  * by the Free Software Foundation.
  *
  * Copyright (C) 2015 Nikolay Martynov <mar.kolya@gmail.com>
- * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2015 John Crispin <john@phrozen.org>
  */
 
 #include <linux/init.h>
diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index 82c72a1..b0343ff 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -3,7 +3,7 @@
  * under the terms of the GNU General Public License version 2 as published
  * by the Free Software Foundation.
  *
- * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2013 John Crispin <john@phrozen.org>
 */
 
 #include <linux/module.h>
@@ -180,5 +180,5 @@ static struct platform_driver rt_timer_driver = {
 module_platform_driver(rt_timer_driver);
 
 MODULE_DESCRIPTION("Ralink RT2880 timer");
-MODULE_AUTHOR("John Crispin <blogic@openwrt.org");
+MODULE_AUTHOR("John Crispin <john@phrozen.org");
 MODULE_LICENSE("GPL");
-- 
1.7.10.4
