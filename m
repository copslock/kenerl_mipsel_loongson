Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:16:19 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50041 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3HHJOeJoGiK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:14:34 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 4/4] MIPS: lantiq: falcon: fix asc clock definition
Date:   Thu,  8 Aug 2013 11:07:26 +0200
Message-Id: <1375952846-25812-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37447
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

From: Thomas Langer <thomas.langer@lantiq.com>

The clocks of the serial ports were not setup properly.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/sysctrl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index ff4894a..8f1866d 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -48,6 +48,7 @@
 #define CPU0CC_CPUDIV		0x0001
 
 /* Activation Status Register */
+#define ACTS_ASC0_ACT	0x00001000
 #define ACTS_ASC1_ACT	0x00000800
 #define ACTS_I2C_ACT	0x00004000
 #define ACTS_P0		0x00010000
@@ -108,6 +109,7 @@ static void sysctl_deactivate(struct clk *clk)
 static int sysctl_clken(struct clk *clk)
 {
 	sysctl_w32(clk->module, clk->bits, SYSCTL_CLKEN);
+	sysctl_w32(clk->module, clk->bits, SYSCTL_ACT);
 	sysctl_wait(clk, clk->bits, SYSCTL_CLKS);
 	return 0;
 }
@@ -256,6 +258,7 @@ void __init ltq_soc_init(void)
 	clkdev_add_sys("1e800400.pad", SYSCTL_SYS1, ACTS_PADCTRL1);
 	clkdev_add_sys("1e800500.pad", SYSCTL_SYS1, ACTS_PADCTRL3);
 	clkdev_add_sys("1e800600.pad", SYSCTL_SYS1, ACTS_PADCTRL4);
-	clkdev_add_sys("1e100C00.serial", SYSCTL_SYS1, ACTS_ASC1_ACT);
+	clkdev_add_sys("1e100b00.serial", SYSCTL_SYS1, ACTS_ASC1_ACT);
+	clkdev_add_sys("1e100c00.serial", SYSCTL_SYS1, ACTS_ASC0_ACT);
 	clkdev_add_sys("1e200000.i2c", SYSCTL_SYS1, ACTS_I2C_ACT);
 }
-- 
1.7.10.4
