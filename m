Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 20:26:24 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:64684 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903778Ab2B1TZH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 20:25:07 +0100
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.ottawa.windriver.com [128.224.149.8])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1SJOuvU014095;
        Tue, 28 Feb 2012 11:24:59 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/5] MIPS: fix several implicit uses of export.h/module.h
Date:   Tue, 28 Feb 2012 14:24:46 -0500
Message-Id: <1330457088-14587-4-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
X-archive-position: 32574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

These will show up as a build failure once we clean up a
misuse of module.h in the mips termios header.

Uses export.h: (EXPORT_SYMBOL)
   arch/mips/cavium-octeon/setup.c
   arch/mips/pmc-sierra/yosemite/setup.c
   arch/mips/rb532/devices.c
   arch/mips/sni/setup.c

Uses module.h: (symbol_get/put)
   arch/mips/alchemy/devboards/db1200.c

Uses module.h: (print_modules)
   arch/mips/kernel/traps.c

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/alchemy/devboards/db1200.c  |    1 +
 arch/mips/cavium-octeon/setup.c       |    1 +
 arch/mips/kernel/traps.c              |    1 +
 arch/mips/pmc-sierra/yosemite/setup.c |    1 +
 arch/mips/rb532/devices.c             |    1 +
 arch/mips/sni/setup.c                 |    1 +
 6 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index a83302b..7dde016 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/leds.h>
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 260b273..3a01231 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/serial.h>
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cc4a3f1..62cbffd 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
index 3498ac9..b6472fc 100644
--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -27,6 +27,7 @@
 #include <linux/bcd.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index a969eb8..ea77428 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -15,6 +15,7 @@
  *  GNU General Public License for more details.
  */
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index d16b462..413f17f 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -10,6 +10,7 @@
  */
 #include <linux/eisa.h>
 #include <linux/init.h>
+#include <linux/export.h>
 #include <linux/console.h>
 #include <linux/fb.h>
 #include <linux/screen_info.h>
-- 
1.7.9.1
