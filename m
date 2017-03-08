Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 08:31:04 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:58827 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991960AbdCHHa52hYaD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 08:30:57 +0100
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MAilT-1cZfGM0hUx-00Bq1X; Wed, 08 Mar 2017 08:29:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     ralf@linux-mips.org
Cc:     mingo@redhat.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mips: add missing include files
Date:   Wed,  8 Mar 2017 08:29:31 +0100
Message-Id: <20170308072931.3836696-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:a28YYja7m3O7JUpj51SSnbwzezXwiTwitPqWF29lg0bowTLNfzT
 qnqKiIbnSeGZ/FuGfV9cZtfm4WbHZ1sNJj9WjAFjEaUl4E4y0Q0V+yE3bxzILKQWNncJyo8
 bp3/xUGAJCVxj+muU3S3ea48qaiFCT0OFDz3veFPe/ZyuBEf+AeQgBTs2IWQ0bZ0dT20Xbi
 by6ITSPRc4XzmlwQhRxIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tF1KVUsbIZ4=:CI+vddAkzZ4K6g+yiGjuXb
 1Auz4XgYFp7mcZTaZmVazTuxkb0ePrLBsw/K631JAvMFRXa9v78PY5/t9aNHH5diwOvSbVWAJ
 r3Mi5G0xAv+rJ9fFtFUFxyJF+hkhVCjhGkbJu93cCelBORuPAU080fRzWcaaKmeEA533JDlUf
 GHav7OinRsDGq85/cM2qsYHwTjUa828cZzA4aRfuuKqhYGUaiiK+3xzKjxy8MUsr5cN/SGKCJ
 YGvmZLe88r+i2mSIS7vHo2PZaI8Pp5wDAH13HzotUeLX/77xxerFvGmDarkHMn3YBdPZdyd19
 7a7v9s6yO5lTa/0eNqU5vl0bIsDH5s54xX6hYLDaqhr8h2P+qo1/X4K3zH5Xm/7co5R6K8Udb
 Qita9QrpQKDJVDIWHPTVh3GrYFHwmCI2RACNyQI2qRXo+6leEW3775HRslnsT2/IvXcTM8Lon
 1gmkLMdp1HxuNwX9Z/NHHWE7wfSp0u/BLU3+TwQtFL6iasepnL4sZk34izu+B2B4rfMKODwE8
 5phuOULySTsyD+nMtJ8i4iQ3sFojw/jwOhlfO0JyvzSx4Q/6sGbVG9Ix+A719F/BA8MEQz7nd
 BbktPB97Es88MGxGOzE0nxR7M2bGJnet61nWenfY8GOxVfJC3hjMcysYk9TfGN2SV/aqmQqpG
 cWCU8LEcwidYKyeHGo+/YahuJ0SmY3T/7hDnmgwrhDE0p4HSffQPdBWl7RPaq8I7dFvo=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

After the split of linux/sched.h, several platforms in arch/mips stopped building,
This add the respective additional #include statements to fix the problem I first
tried adding these into asm/processor.h, but ran into circular header dependencies
with that which I could not figure out.

The commit I listed as causing the problem is the branch merge, as there is
likely a combination of multiple patches in that branch.

Fixes: 1827adb11ad2 ("Merge branch 'WIP.sched-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/cavium-octeon/cpu.c                  | 2 ++
 arch/mips/cavium-octeon/crypto/octeon-crypto.c | 1 +
 arch/mips/cavium-octeon/smp.c                  | 1 +
 arch/mips/include/asm/fpu.h                    | 1 +
 arch/mips/kernel/smp-bmips.c                   | 1 +
 arch/mips/kernel/smp-mt.c                      | 1 +
 arch/mips/loongson64/loongson-3/cop2-ex.c      | 1 +
 arch/mips/netlogic/common/smp.c                | 1 +
 arch/mips/netlogic/xlp/cop2-ex.c               | 3 +++
 arch/mips/sgi-ip22/ip28-berr.c                 | 1 +
 arch/mips/sgi-ip27/ip27-berr.c                 | 2 ++
 arch/mips/sgi-ip27/ip27-smp.c                  | 3 +++
 arch/mips/sgi-ip32/ip32-berr.c                 | 1 +
 arch/mips/sgi-ip32/ip32-reset.c                | 1 +
 14 files changed, 20 insertions(+)

diff --git a/arch/mips/cavium-octeon/cpu.c b/arch/mips/cavium-octeon/cpu.c
index a5b427909b5c..036d56cc4591 100644
--- a/arch/mips/cavium-octeon/cpu.c
+++ b/arch/mips/cavium-octeon/cpu.c
@@ -10,7 +10,9 @@
 #include <linux/irqflags.h>
 #include <linux/notifier.h>
 #include <linux/prefetch.h>
+#include <linux/ptrace.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/cop2.h>
 #include <asm/current.h>
diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.c b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
index 4d22365844af..cfb4a146cf17 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
@@ -9,6 +9,7 @@
 #include <asm/cop2.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/sched/task_stack.h>
 
 #include "octeon-crypto.h"
 
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 4b94b7fbafa3..3de786545ded 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -12,6 +12,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/init.h>
 #include <linux/export.h>
 
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 321752bcbab6..f94455f964ec 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -12,6 +12,7 @@
 
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/ptrace.h>
 #include <linux/thread_info.h>
 #include <linux/bitops.h>
 
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 3daa2cae50b0..1b070a76fcdd 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index e077ea3e11fb..e398cbc3d776 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip/mips-gic.h>
 #include <linux/compiler.h>
+#include <linux/sched/task_stack.h>
 #include <linux/smp.h>
 
 #include <linux/atomic.h>
diff --git a/arch/mips/loongson64/loongson-3/cop2-ex.c b/arch/mips/loongson64/loongson-3/cop2-ex.c
index ea13764d0a03..621d6af5f6eb 100644
--- a/arch/mips/loongson64/loongson-3/cop2-ex.c
+++ b/arch/mips/loongson64/loongson-3/cop2-ex.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/notifier.h>
+#include <linux/ptrace.h>
 
 #include <asm/fpu.h>
 #include <asm/cop2.h>
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 10d86d54880a..bddf1ef553a4 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/sched/task_stack.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
 
diff --git a/arch/mips/netlogic/xlp/cop2-ex.c b/arch/mips/netlogic/xlp/cop2-ex.c
index 52bc5de42005..21e439b3db70 100644
--- a/arch/mips/netlogic/xlp/cop2-ex.c
+++ b/arch/mips/netlogic/xlp/cop2-ex.c
@@ -9,11 +9,14 @@
  * Copyright (C) 2009 Wind River Systems,
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
 #include <linux/notifier.h>
 #include <linux/prefetch.h>
+#include <linux/ptrace.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/cop2.h>
 #include <asm/current.h>
diff --git a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
index 1f2a5bc4779e..75460e1e106b 100644
--- a/arch/mips/sgi-ip22/ip28-berr.c
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/signal.h>
 #include <linux/seq_file.h>
 
 #include <asm/addrspace.h>
diff --git a/arch/mips/sgi-ip27/ip27-berr.c b/arch/mips/sgi-ip27/ip27-berr.c
index d12879eb2b1f..83efe03d5c60 100644
--- a/arch/mips/sgi-ip27/ip27-berr.c
+++ b/arch/mips/sgi-ip27/ip27-berr.c
@@ -12,7 +12,9 @@
 #include <linux/signal.h>	/* for SIGBUS */
 #include <linux/sched.h>	/* schow_regs(), force_sig() */
 #include <linux/sched/debug.h>
+#include <linux/sched/signal.h>
 
+#include <asm/ptrace.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/sn0/hub.h>
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index f5ed45e8f442..4cd47d23d81a 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -8,10 +8,13 @@
  */
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/topology.h>
 #include <linux/nodemask.h>
+
 #include <asm/page.h>
 #include <asm/processor.h>
+#include <asm/ptrace.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/gda.h>
 #include <asm/sn/intr.h>
diff --git a/arch/mips/sgi-ip32/ip32-berr.c b/arch/mips/sgi-ip32/ip32-berr.c
index 57d8c7486fe6..c1f12a9cf305 100644
--- a/arch/mips/sgi-ip32/ip32-berr.c
+++ b/arch/mips/sgi-ip32/ip32-berr.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/signal.h>
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/addrspace.h>
diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index 8bd415c8729f..b3b442def423 100644
--- a/arch/mips/sgi-ip32/ip32-reset.c
+++ b/arch/mips/sgi-ip32/ip32-reset.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/rtc/ds1685.h>
-- 
2.9.0
