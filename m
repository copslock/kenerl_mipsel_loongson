Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2017 03:07:08 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:34081 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993889AbdA2CHAPW5vJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jan 2017 03:07:00 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v0T26YdC021105
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 28 Jan 2017 18:06:39 -0800 (PST)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.294.0; Sat, 28 Jan 2017 18:06:34 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] mips: audit and remove any unnecessary uses of module.h
Date:   Sat, 28 Jan 2017 21:05:57 -0500
Message-ID: <20170129020557.1336-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

Historically a lot of these existed because we did not have
a distinction between what was modular code and what was providing
support to modules via EXPORT_SYMBOL and friends.  That changed
when we forked out support for the latter into the export.h file.

This means we should be able to reduce the usage of module.h
in code that is obj-y Makefile or bool Kconfig.  In the case of
some code where it is modular, we can extend that to also include
files that are building basic support functionality but not related
to loading or registering the final module; such files also have
no need whatsoever for module.h

The advantage in removing such instances is that module.h itself
sources about 15 other headers; adding significantly to what we feed
cpp, and it can obscure what headers we are effectively using.

Since module.h might have been the implicit source for init.h
(for __init) and for export.h (for EXPORT_SYMBOL) we consider each
instance for the presence of either and replace/add as needed.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Build coverage of all the mips defconfigs revealed the module.h
header was masking a couple of implicit include instances, so
we add the appropriate headers there.

Cc: David Daney <david.daney@cavium.com>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "Steven J. Hill" <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[I had this split along platform lines into 17 separate commits, but
 when I realized there were only 3 platform specific maintainers called
 out, I thought that was probably overkill.  If the split version is
 desired, let me know.

 Also, this is against v4.10-rc5.  The same patch against linux-next
 will have a trivial conflict in xway dma.c due to a spinlock.h
 addition there. ]

 arch/mips/alchemy/common/dbdma.c                       | 2 +-
 arch/mips/alchemy/common/dma.c                         | 2 +-
 arch/mips/alchemy/common/gpiolib.c                     | 1 -
 arch/mips/alchemy/common/prom.c                        | 1 -
 arch/mips/alchemy/common/usb.c                         | 2 +-
 arch/mips/alchemy/common/vss.c                         | 2 +-
 arch/mips/alchemy/devboards/bcsr.c                     | 3 ++-
 arch/mips/ar7/clock.c                                  | 2 +-
 arch/mips/ar7/gpio.c                                   | 3 ++-
 arch/mips/ar7/memory.c                                 | 1 -
 arch/mips/ar7/platform.c                               | 1 -
 arch/mips/ar7/prom.c                                   | 2 +-
 arch/mips/ath79/clock.c                                | 1 -
 arch/mips/ath79/common.c                               | 2 +-
 arch/mips/bcm63xx/clk.c                                | 3 ++-
 arch/mips/bcm63xx/cpu.c                                | 2 +-
 arch/mips/bcm63xx/cs.c                                 | 3 ++-
 arch/mips/bcm63xx/gpio.c                               | 2 +-
 arch/mips/bcm63xx/irq.c                                | 1 -
 arch/mips/bcm63xx/reset.c                              | 3 ++-
 arch/mips/bcm63xx/timer.c                              | 3 ++-
 arch/mips/cavium-octeon/crypto/octeon-crypto.c         | 2 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c       | 2 +-
 arch/mips/cavium-octeon/executive/cvmx-helper-errata.c | 2 +-
 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c       | 2 +-
 arch/mips/cavium-octeon/smp.c                          | 3 ++-
 arch/mips/dec/prom/identify.c                          | 2 +-
 arch/mips/dec/setup.c                                  | 2 +-
 arch/mips/dec/wbflush.c                                | 4 +---
 arch/mips/jazz/jazzdma.c                               | 2 +-
 arch/mips/jz4740/gpio.c                                | 2 +-
 arch/mips/jz4740/prom.c                                | 1 -
 arch/mips/jz4740/timer.c                               | 3 ++-
 arch/mips/lantiq/xway/dma.c                            | 3 +--
 arch/mips/lantiq/xway/gptu.c                           | 3 +--
 arch/mips/lasat/at93c.c                                | 1 -
 arch/mips/lasat/sysctl.c                               | 1 -
 arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c      | 2 +-
 arch/mips/loongson64/common/env.c                      | 2 +-
 arch/mips/loongson64/common/setup.c                    | 3 ++-
 arch/mips/loongson64/common/uart_base.c                | 2 +-
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c            | 3 ++-
 arch/mips/loongson64/lemote-2f/irq.c                   | 3 ++-
 arch/mips/loongson64/lemote-2f/pm.c                    | 2 +-
 arch/mips/loongson64/loongson-3/irq.c                  | 2 +-
 arch/mips/loongson64/loongson-3/numa.c                 | 2 +-
 arch/mips/mti-malta/malta-platform.c                   | 1 -
 arch/mips/pmcs-msp71xx/msp_prom.c                      | 2 +-
 arch/mips/pmcs-msp71xx/msp_time.c                      | 1 -
 arch/mips/ralink/clk.c                                 | 3 ++-
 arch/mips/ralink/mt7620.c                              | 1 -
 arch/mips/ralink/mt7621.c                              | 1 -
 arch/mips/ralink/rt288x.c                              | 1 -
 arch/mips/ralink/rt305x.c                              | 3 ++-
 arch/mips/ralink/rt3883.c                              | 1 -
 arch/mips/rb532/irq.c                                  | 1 -
 arch/mips/rb532/prom.c                                 | 2 +-
 arch/mips/sgi-ip22/ip22-hpc.c                          | 2 +-
 arch/mips/sgi-ip22/ip22-mc.c                           | 3 ++-
 arch/mips/sgi-ip22/ip22-nvram.c                        | 2 +-
 arch/mips/sgi-ip22/ip22-reset.c                        | 1 -
 arch/mips/sgi-ip22/ip22-setup.c                        | 1 -
 arch/mips/sgi-ip27/ip27-berr.c                         | 2 --
 arch/mips/sgi-ip27/ip27-init.c                         | 2 +-
 arch/mips/sgi-ip27/ip27-memory.c                       | 2 +-
 arch/mips/sgi-ip32/crime.c                             | 2 +-
 arch/mips/sibyte/bcm1480/setup.c                       | 2 +-
 arch/mips/sibyte/sb1250/setup.c                        | 2 +-
 arch/mips/txx9/generic/setup.c                         | 2 +-
 arch/mips/vr41xx/common/bcu.c                          | 3 ++-
 arch/mips/vr41xx/common/cmu.c                          | 2 +-
 arch/mips/vr41xx/common/icu.c                          | 2 +-
 arch/mips/vr41xx/common/irq.c                          | 2 +-
 73 files changed, 69 insertions(+), 78 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index f2f264b5aafe..fc482d900ddd 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -35,7 +35,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/syscore_ops.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
diff --git a/arch/mips/alchemy/common/dma.c b/arch/mips/alchemy/common/dma.c
index 4fb6207b883b..973049b5bd61 100644
--- a/arch/mips/alchemy/common/dma.c
+++ b/arch/mips/alchemy/common/dma.c
@@ -31,7 +31,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
diff --git a/arch/mips/alchemy/common/gpiolib.c b/arch/mips/alchemy/common/gpiolib.c
index e6b90e72c23f..7d5da5edd74d 100644
--- a/arch/mips/alchemy/common/gpiolib.c
+++ b/arch/mips/alchemy/common/gpiolib.c
@@ -32,7 +32,6 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/gpio.h>
 #include <asm/mach-au1x00/gpio-au1000.h>
diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index 534021059629..af312b5e33f6 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -33,7 +33,6 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
 
diff --git a/arch/mips/alchemy/common/usb.c b/arch/mips/alchemy/common/usb.c
index 297805ade849..67d1293cca73 100644
--- a/arch/mips/alchemy/common/usb.c
+++ b/arch/mips/alchemy/common/usb.c
@@ -12,7 +12,7 @@
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 #include <asm/cpu.h>
diff --git a/arch/mips/alchemy/common/vss.c b/arch/mips/alchemy/common/vss.c
index d23b1444d365..a7bd32e9831b 100644
--- a/arch/mips/alchemy/common/vss.c
+++ b/arch/mips/alchemy/common/vss.c
@@ -6,7 +6,7 @@
  * for various media blocks are enabled/disabled.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <asm/mach-au1x00/au1000.h>
 
diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index faeddf119fd4..c1a2daaf300a 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -9,7 +9,8 @@
 
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <asm/addrspace.h>
diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index 2460f9d23f1b..dda422a0f36c 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/gcd.h>
 #include <linux/io.h>
diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index ed5b3d297caf..4eee7e9e26ee 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -18,7 +18,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/gpio.h>
 
 #include <asm/mach-ar7/ar7.h>
diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
index 92dfa481205b..0332f0514d05 100644
--- a/arch/mips/ar7/memory.c
+++ b/arch/mips/ar7/memory.c
@@ -19,7 +19,6 @@
 #include <linux/bootmem.h>
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/pfn.h>
 #include <linux/proc_fs.h>
 #include <linux/string.h>
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 58fca9ad5fcc..df7acea3747a 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -19,7 +19,6 @@
 
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index a23adc49d50f..4fd83336131a 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/serial_reg.h>
 #include <linux/spinlock.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/string.h>
 #include <linux/io.h>
 #include <asm/bootinfo.h>
diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index cc3a1e33a600..fe080b9fffae 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index d071a3a0f876..10a405d593df 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
 
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index b49fc9cb9cad..73626040e4d6 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -6,7 +6,8 @@
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/clk.h>
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 1c7c3fbfa1f3..f61c16f57a97 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
diff --git a/arch/mips/bcm63xx/cs.c b/arch/mips/bcm63xx/cs.c
index 50d8190bbf7b..29205badcf67 100644
--- a/arch/mips/bcm63xx/cs.c
+++ b/arch/mips/bcm63xx/cs.c
@@ -7,7 +7,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/log2.h>
 #include <bcm63xx_cpu.h>
diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 7c256dadb166..16f353ac3441 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/driver.h>
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index c96139097ae2..ec694b9628c0 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/spinlock.h>
 #include <asm/irq_cpu.h>
diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
index d1fe51edf5e6..a2af38cf28a7 100644
--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -6,7 +6,8 @@
  * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/clk.h>
diff --git a/arch/mips/bcm63xx/timer.c b/arch/mips/bcm63xx/timer.c
index 2110359c00e5..a86065854c0c 100644
--- a/arch/mips/bcm63xx/timer.c
+++ b/arch/mips/bcm63xx/timer.c
@@ -8,7 +8,8 @@
 
 #include <linux/kernel.h>
 #include <linux/err.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.c b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
index f66bd1adc7ff..4d22365844af 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
@@ -7,7 +7,7 @@
  */
 
 #include <asm/cop2.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 
 #include "octeon-crypto.h"
diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index b65a6c1ac016..dba69edadd4c 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -31,7 +31,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <asm/octeon/cvmx.h>
 #include <asm/octeon/cvmx-spinlock.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c b/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
index 868659e64d4a..4b26fedecf46 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
@@ -33,7 +33,7 @@
  * these functions directly.
  *
  */
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <asm/octeon/octeon.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
index cc1b1d2a6fa1..30ecba134e09 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
@@ -29,7 +29,7 @@
  * This module provides system/board/application information obtained
  * by the bootloader.
  */
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <asm/octeon/cvmx.h>
 #include <asm/octeon/cvmx-sysinfo.h>
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 256fe6f65cf2..a57798fd6d81 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -11,7 +11,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 
 #include <asm/mmu_context.h>
 #include <asm/time.h>
diff --git a/arch/mips/dec/prom/identify.c b/arch/mips/dec/prom/identify.c
index 95e26f4bb38f..0c14a9d6a84a 100644
--- a/arch/mips/dec/prom/identify.c
+++ b/arch/mips/dec/prom/identify.c
@@ -7,7 +7,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mc146818rtc.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 1c3bf9fe926f..b529d7493d7b 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -14,7 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/irqnr.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/param.h>
 #include <linux/percpu-defs.h>
 #include <linux/sched.h>
diff --git a/arch/mips/dec/wbflush.c b/arch/mips/dec/wbflush.c
index 56bda4a396b5..61e139805d1f 100644
--- a/arch/mips/dec/wbflush.c
+++ b/arch/mips/dec/wbflush.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/export.h>
 
 #include <asm/bootinfo.h>
 #include <asm/wbflush.h>
@@ -88,7 +89,4 @@ static void wbflush_mips(void)
 {
 	__fast_iob();
 }
-
-#include <linux/module.h>
-
 EXPORT_SYMBOL(__wbflush);
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 1900f39588ae..11172fdaeffc 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -9,7 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index b765773ab8aa..cac1ccde2214 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -14,7 +14,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 
 #include <linux/io.h>
diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index 6984683c90d0..47e857194ce6 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -13,7 +13,6 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
diff --git a/arch/mips/jz4740/timer.c b/arch/mips/jz4740/timer.c
index 4992461787aa..fbe8877d4de6 100644
--- a/arch/mips/jz4740/timer.c
+++ b/arch/mips/jz4740/timer.c
@@ -14,8 +14,9 @@
  */
 
 #include <linux/io.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <asm/mach-jz4740/base.h>
 #include <asm/mach-jz4740/timer.h>
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index cef811755123..462a80edbbf6 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
@@ -255,7 +255,6 @@ static const struct of_device_id dma_match[] = {
 	{ .compatible = "lantiq,dma-xway" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, dma_match);
 
 static struct platform_driver dma_driver = {
 	.probe = ltq_dma_init,
diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 0f1bbea1a816..e304aabd6678 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -9,7 +9,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
 
@@ -187,7 +187,6 @@ static const struct of_device_id gptu_match[] = {
 	{ .compatible = "lantiq,gptu-xway" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, dma_match);
 
 static struct platform_driver dma_driver = {
 	.probe = gptu_probe,
diff --git a/arch/mips/lasat/at93c.c b/arch/mips/lasat/at93c.c
index 942f32b91d12..4e272a2622a4 100644
--- a/arch/mips/lasat/at93c.c
+++ b/arch/mips/lasat/at93c.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <asm/lasat/lasat.h>
-#include <linux/module.h>
 
 #include "at93c.h"
 
diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index c710d969938d..6f7422400f32 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -20,7 +20,6 @@
 #include <linux/types.h>
 #include <asm/lasat/lasat.h>
 
-#include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/stddef.h>
 #include <linux/init.h>
diff --git a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
index 9edfa55a0e78..b817d6d3a060 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
@@ -17,7 +17,7 @@
 
 #include <linux/io.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/jiffies.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 57d590ac8004..6afa21850267 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -17,7 +17,7 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/bootinfo.h>
 #include <loongson.h>
 #include <boot_param.h>
diff --git a/arch/mips/loongson64/common/setup.c b/arch/mips/loongson64/common/setup.c
index 2dc5122f0e09..34a0cf68c839 100644
--- a/arch/mips/loongson64/common/setup.c
+++ b/arch/mips/loongson64/common/setup.c
@@ -7,7 +7,8 @@
  *  Free Software Foundation;  either version 2 of the	License, or (at your
  *  option) any later version.
  */
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 
 #include <asm/wbflush.h>
 #include <asm/bootinfo.h>
diff --git a/arch/mips/loongson64/common/uart_base.c b/arch/mips/loongson64/common/uart_base.c
index 9de559d58e1f..d27c41b237a0 100644
--- a/arch/mips/loongson64/common/uart_base.c
+++ b/arch/mips/loongson64/common/uart_base.c
@@ -8,7 +8,7 @@
  * option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
index 2b666d3a3947..321822997e76 100644
--- a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
+++ b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
@@ -10,7 +10,8 @@
  * (at your option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 
diff --git a/arch/mips/loongson64/lemote-2f/irq.c b/arch/mips/loongson64/lemote-2f/irq.c
index cab5f43e0e29..cb5f647558d3 100644
--- a/arch/mips/loongson64/lemote-2f/irq.c
+++ b/arch/mips/loongson64/lemote-2f/irq.c
@@ -9,7 +9,8 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/i8259.h>
diff --git a/arch/mips/loongson64/lemote-2f/pm.c b/arch/mips/loongson64/lemote-2f/pm.c
index cac4d382ea73..6859e934862d 100644
--- a/arch/mips/loongson64/lemote-2f/pm.c
+++ b/arch/mips/loongson64/lemote-2f/pm.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/i8042.h>
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <asm/i8259.h>
 #include <asm/mipsregs.h>
diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 8e7649088353..548f759454dc 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -1,7 +1,7 @@
 #include <loongson.h>
 #include <irq.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/init.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/i8259.h>
diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index 282c5a8c2fcd..f17ef520799a 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/nodemask.h>
 #include <linux/swap.h>
 #include <linux/memblock.h>
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index 516e1233d771..11e9527c6e44 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -23,7 +23,6 @@
  */
 #include <linux/init.h>
 #include <linux/serial_8250.h>
-#include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <asm/mips-boards/maltaint.h>
diff --git a/arch/mips/pmcs-msp71xx/msp_prom.c b/arch/mips/pmcs-msp71xx/msp_prom.c
index ef620a4c82a5..6fdcb3d6fbb5 100644
--- a/arch/mips/pmcs-msp71xx/msp_prom.c
+++ b/arch/mips/pmcs-msp71xx/msp_prom.c
@@ -34,7 +34,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
diff --git a/arch/mips/pmcs-msp71xx/msp_time.c b/arch/mips/pmcs-msp71xx/msp_time.c
index fea917be0ff1..b4c020a80fd7 100644
--- a/arch/mips/pmcs-msp71xx/msp_time.c
+++ b/arch/mips/pmcs-msp71xx/msp_time.c
@@ -26,7 +26,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
-#include <linux/module.h>
 #include <linux/ptrace.h>
 
 #include <asm/cevt-r4k.h>
diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index ebaa7cc0e995..9c3bddac4c72 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -8,7 +8,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/clkdev.h>
 #include <linux/clk.h>
 
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 3c7c9bf57bf3..5bc8bc1ae24e 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
 
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index a45bbbe97ac5..82be2466b436 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -9,7 +9,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
 
 #include <asm/mipsregs.h>
 #include <asm/smp-ops.h>
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 285796e6d75c..6152b938040a 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
 
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index c8a28c4bf29e..7de67f1eacdb 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -12,8 +12,9 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/bug.h>
 
+#include <asm/io.h>
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
 #include <asm/mach-ralink/rt305x.h>
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 4cef9162bd9b..5c55724a4334 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/module.h>
 
 #include <asm/mipsregs.h>
 #include <asm/mach-ralink/ralink_regs.h>
diff --git a/arch/mips/rb532/irq.c b/arch/mips/rb532/irq.c
index 3a431e802bbc..25cc250f2d34 100644
--- a/arch/mips/rb532/irq.c
+++ b/arch/mips/rb532/irq.c
@@ -29,7 +29,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel_stat.h>
-#include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/types.h>
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 657210e767c2..6484e4a4597b 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -26,7 +26,7 @@
 
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/string.h>
 #include <linux/console.h>
 #include <linux/bootmem.h>
diff --git a/arch/mips/sgi-ip22/ip22-hpc.c b/arch/mips/sgi-ip22/ip22-hpc.c
index bb70589b5f74..e8bc33d8cede 100644
--- a/arch/mips/sgi-ip22/ip22-hpc.c
+++ b/arch/mips/sgi-ip22/ip22-hpc.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/types.h>
 
 #include <asm/io.h>
diff --git a/arch/mips/sgi-ip22/ip22-mc.c b/arch/mips/sgi-ip22/ip22-mc.c
index 6b009c45abed..db5a64026443 100644
--- a/arch/mips/sgi-ip22/ip22-mc.c
+++ b/arch/mips/sgi-ip22/ip22-mc.c
@@ -8,8 +8,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/spinlock.h>
 
 #include <asm/io.h>
 #include <asm/bootinfo.h>
diff --git a/arch/mips/sgi-ip22/ip22-nvram.c b/arch/mips/sgi-ip22/ip22-nvram.c
index e077036a676a..cc6133bb57ca 100644
--- a/arch/mips/sgi-ip22/ip22-nvram.c
+++ b/arch/mips/sgi-ip22/ip22-nvram.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2003 Ladislav Michl (ladis@linux-mips.org)
  */
-#include <linux/module.h>
+#include <linux/export.h>
 
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ip22.h>
diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 2f45b0357021..a36f6b87548a 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -8,7 +8,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/rtc/ds1286.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index c7bdfe43df5b..872159970935 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c
+++ b/arch/mips/sgi-ip22/ip22-setup.c
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/types.h>
-#include <linux/module.h>
 #include <linux/console.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
diff --git a/arch/mips/sgi-ip27/ip27-berr.c b/arch/mips/sgi-ip27/ip27-berr.c
index 2e0edb385656..f8919b6a24c8 100644
--- a/arch/mips/sgi-ip27/ip27-berr.c
+++ b/arch/mips/sgi-ip27/ip27-berr.c
@@ -9,11 +9,9 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/signal.h>	/* for SIGBUS */
 #include <linux/sched.h>	/* schow_regs(), force_sig() */
 
-#include <asm/module.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/sn0/hub.h>
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 570098bfdf87..e501c43c02db 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -11,7 +11,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/cpumask.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index f1f88291451e..59133d0abc83 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -15,7 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/nodemask.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
diff --git a/arch/mips/sgi-ip32/crime.c b/arch/mips/sgi-ip32/crime.c
index 563c614ad021..a8e0c776ca6c 100644
--- a/arch/mips/sgi-ip32/crime.c
+++ b/arch/mips/sgi-ip32/crime.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <asm/bootinfo.h>
 #include <asm/io.h>
 #include <asm/mipsregs.h>
diff --git a/arch/mips/sibyte/bcm1480/setup.c b/arch/mips/sibyte/bcm1480/setup.c
index 8e2e04f77870..a05246cbf54c 100644
--- a/arch/mips/sibyte/bcm1480/setup.c
+++ b/arch/mips/sibyte/bcm1480/setup.c
@@ -17,7 +17,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
 
diff --git a/arch/mips/sibyte/sb1250/setup.c b/arch/mips/sibyte/sb1250/setup.c
index 9d3c24efdf4a..d99d088f1636 100644
--- a/arch/mips/sibyte/sb1250/setup.c
+++ b/arch/mips/sibyte/sb1250/setup.c
@@ -16,7 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index a1d98b5c8fd6..1791a44ee570 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/string.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
diff --git a/arch/mips/vr41xx/common/bcu.c b/arch/mips/vr41xx/common/bcu.c
index ff7d1c66cf82..4d01eb9d379b 100644
--- a/arch/mips/vr41xx/common/bcu.c
+++ b/arch/mips/vr41xx/common/bcu.c
@@ -29,10 +29,11 @@
  *  - Added support for NEC VR4133.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
+#include <asm/cpu-type.h>
 #include <asm/cpu.h>
 #include <asm/io.h>
 
diff --git a/arch/mips/vr41xx/common/cmu.c b/arch/mips/vr41xx/common/cmu.c
index 89bac9885695..4d341940eb45 100644
--- a/arch/mips/vr41xx/common/cmu.c
+++ b/arch/mips/vr41xx/common/cmu.c
@@ -30,7 +30,7 @@
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index 41e873bc8474..e0f3230d3a66 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -32,7 +32,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
diff --git a/arch/mips/vr41xx/common/irq.c b/arch/mips/vr41xx/common/irq.c
index ae0e4ee6c617..c9cdeaaceec9 100644
--- a/arch/mips/vr41xx/common/irq.c
+++ b/arch/mips/vr41xx/common/irq.c
@@ -18,7 +18,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/irq.h>
 
 #include <asm/irq_cpu.h>
-- 
2.11.0
