Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:52:21 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37395 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011208AbbKDKug1OHxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:36 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 145BE28098D;
        Wed,  4 Nov 2015 11:48:46 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:46 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 8/9] arch: mips: ralink: put the pci bus into reset state before rebooting the SoC
Date:   Wed,  4 Nov 2015 11:50:13 +0100
Message-Id: <1446634214-11564-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Some pcie cards have problems after a reboot without this.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/reset.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index ee26d45..ee117c4 100644
--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/delay.h>
 #include <linux/reset-controller.h>
 
 #include <asm/reboot.h>
@@ -18,8 +19,10 @@
 #include <asm/mach-ralink/ralink_regs.h>
 
 /* Reset Control */
-#define SYSC_REG_RESET_CTRL     0x034
-#define RSTCTL_RESET_SYSTEM     BIT(0)
+#define SYSC_REG_RESET_CTRL	0x034
+
+#define RSTCTL_RESET_PCI	BIT(26)
+#define RSTCTL_RESET_SYSTEM	BIT(0)
 
 static int ralink_assert_device(struct reset_controller_dev *rcdev,
 				unsigned long id)
@@ -83,6 +86,11 @@ void ralink_rst_init(void)
 
 static void ralink_restart(char *command)
 {
+	if (IS_ENABLED(CONFIG_PCI)) {
+		rt_sysc_m32(0, RSTCTL_RESET_PCI, SYSC_REG_RESET_CTRL);
+		mdelay(50);
+	}
+
 	local_irq_disable();
 	rt_sysc_w32(RSTCTL_RESET_SYSTEM, SYSC_REG_RESET_CTRL);
 	unreachable();
-- 
1.7.10.4
