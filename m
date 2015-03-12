Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 17:01:33 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:59350 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006767AbbCLQBcJBjGM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Mar 2015 17:01:32 +0100
Received: from daria.iliad.local (unknown [213.36.7.13])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 010EDA6353;
        Thu, 12 Mar 2015 17:00:38 +0100 (CET)
From:   Nicolas Schichan <nschichan@freebox.fr>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Nicolas Schichan <nschichan@freebox.fr>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH] MIPS: bcm63xx: move bcm63xx_gpio_init() to bcm63xx_register_devices().
Date:   Thu, 12 Mar 2015 17:00:58 +0100
Message-Id: <1426176058-26114-1-git-send-email-nschichan@freebox.fr>
X-Mailer: git-send-email 1.9.1
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
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

When called from prom init code, bcm63xx_gpio_init() will fail as it
will call gpiochip_add() which relies on a working kmalloc() to alloc
the gpio_desc array and kmalloc is not useable yet at prom init time.

Move bcm63xx_gpio_init() to bcm63xx_register_devices() (an
arch_initcall) where kmalloc works.

Fixes: 14e85c0e69d5 ("gpio: remove gpio_descs global array")

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 arch/mips/bcm63xx/prom.c  | 4 ----
 arch/mips/bcm63xx/setup.c | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index e1f27d6..7019e29 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -17,7 +17,6 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
-#include <bcm63xx_gpio.h>
 
 void __init prom_init(void)
 {
@@ -53,9 +52,6 @@ void __init prom_init(void)
 	reg &= ~mask;
 	bcm_perf_writel(reg, PERF_CKCTL_REG);
 
-	/* register gpiochip */
-	bcm63xx_gpio_init();
-
 	/* do low level board init */
 	board_prom_init();
 
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 6660c7d..240fb4f 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -20,6 +20,7 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
+#include <bcm63xx_gpio.h>
 
 void bcm63xx_machine_halt(void)
 {
@@ -160,6 +161,9 @@ void __init plat_mem_setup(void)
 
 int __init bcm63xx_register_devices(void)
 {
+	/* register gpiochip */
+	bcm63xx_gpio_init();
+
 	return board_register_devices();
 }
 
-- 
1.9.1
