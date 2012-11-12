Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2012 10:50:32 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:40339 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823017Ab2KLJucFXFqO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Nov 2012 10:50:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 8400FB138D4;
        Mon, 12 Nov 2012 10:50:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tgpRlyThBlX8; Mon, 12 Nov 2012 10:50:30 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id BEDEB2C847A;
        Mon, 12 Nov 2012 10:50:30 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: BCM63XX: fix BCM6345 clocks bits
Date:   Mon, 12 Nov 2012 10:48:45 +0100
Message-Id: <1352713725-11727-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

BCM6345 has an intermediate 16-bits wide test control register between the
peripheral identifier register, and its clock control register is only 16-bits
wide contrary to other platforms where it is 32-bits wide. By shifting all
clocks bits by 16-bits to the left we ensure they get written to the proper
clock control register, without adding specific BCM6345 handling in the clock
code.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
There is nothing currently using BCM6345 clocks, so this is not 3.7-rc
material, but 3.8.

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 12963d0..57597ee 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -53,13 +53,18 @@
 					CKCTL_6338_SAR_EN |		\
 					CKCTL_6338_SPI_EN)
 
-#define CKCTL_6345_CPU_EN		(1 << 0)
-#define CKCTL_6345_BUS_EN		(1 << 1)
-#define CKCTL_6345_EBI_EN		(1 << 2)
-#define CKCTL_6345_UART_EN		(1 << 3)
-#define CKCTL_6345_ADSLPHY_EN		(1 << 4)
-#define CKCTL_6345_ENET_EN		(1 << 7)
-#define CKCTL_6345_USBH_EN		(1 << 8)
+/* BCM6345 clock bits are shifted by 16 on the left, because of the test
+ * control register which is 16-bits wide. That way we do not have any
+ * specific BCM6345 code for handling clocks, and writing 0 to the test
+ * control register is fine.
+ */
+#define CKCTL_6345_CPU_EN		(1 << 16)
+#define CKCTL_6345_BUS_EN		(1 << 17)
+#define CKCTL_6345_EBI_EN		(1 << 18)
+#define CKCTL_6345_UART_EN		(1 << 19)
+#define CKCTL_6345_ADSLPHY_EN		(1 << 20)
+#define CKCTL_6345_ENET_EN		(1 << 23)
+#define CKCTL_6345_USBH_EN		(1 << 24)
 
 #define CKCTL_6345_ALL_SAFE_EN		(CKCTL_6345_ENET_EN |	\
 					CKCTL_6345_USBH_EN |	\
-- 
1.7.10.4
