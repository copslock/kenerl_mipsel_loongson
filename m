Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 18:23:51 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33288 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009685AbbJFQXd2QU2K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 18:23:33 +0200
Received: by wiclk2 with SMTP id lk2so175527296wic.0
        for <linux-mips@linux-mips.org>; Tue, 06 Oct 2015 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fhIIOloh+8z7lx1mWfVgco21xOd7wCVVURMiqiLXZ5s=;
        b=U+n40O+5qMvxlabAgYdO6u5TM9awGzYBvwGY5/1W4h4IRRdakxMg95EzsJfxtdO18U
         dgClHHHvGPFIkEduHctc9eNHdjqAwpyuaLfsDd9KsHF1jiuIK6QG6XA/zwVHs5lIQad2
         ZYHGgBgK+nDq9tXfDP2vxFL6QVR2aFsP0JcBPioALYORigW1ascs25ZKjlLDginJcLIF
         Egb5wRv9MRvCT1BqIVnIMab1vslXaPng10K+qf1Bo/tCF15B3UPLCqdYPdTRkYzjdwV7
         ZTEixGkXpbUTC0DnL+D3y77chwfRoiJuqd66/Io8NKd9z+/a7+kxE+lkrf7ERJvmNrsu
         dpGg==
X-Received: by 10.180.211.39 with SMTP id mz7mr18869394wic.65.1444148607131;
        Tue, 06 Oct 2015 09:23:27 -0700 (PDT)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_00_007 (p200300874C091B9836E6D7FFFE14BFA6.dip0.t-ipconnect.de. [2003:87:4c09:1b98:36e6:d7ff:fe14:bfa6])
        by smtp.gmail.com with ESMTPSA id he3sm33485381wjc.48.2015.10.06.09.23.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Oct 2015 09:23:26 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/3] MIPS: Alchemy: devboards: register CMA memory for Au1200 framebuffer
Date:   Tue,  6 Oct 2015 18:23:22 +0200
Message-Id: <1444148603-45454-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
References: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Use the newly introduced CMA memory setup hook to register a few
megabytes for the Au1200/Au1300 framebuffer.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested on Db1200 and Db1300.

 arch/mips/alchemy/devboards/db1200.c | 62 +++++++++++++++++++++++-------------
 arch/mips/alchemy/devboards/db1300.c | 13 ++++++++
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index bfc2797..eb46676 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/dma-contiguous.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
@@ -37,6 +38,7 @@
 #include <linux/spi/flash.h>
 #include <linux/smc91x.h>
 #include <linux/ata_platform.h>
+#include <asm/bootinfo.h>		/* plat_reserve_mem hook */
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
@@ -128,29 +130,6 @@ static int __init db1200_detect_board(void)
 	return 1;	/* it's neither */
 }
 
-int __init db1200_board_setup(void)
-{
-	unsigned short whoami;
-
-	if (db1200_detect_board())
-		return -ENODEV;
-
-	whoami = bcsr_read(BCSR_WHOAMI);
-	switch (BCSR_WHOAMI_BOARD(whoami)) {
-	case BCSR_WHOAMI_PB1200_DDR1:
-	case BCSR_WHOAMI_PB1200_DDR2:
-	case BCSR_WHOAMI_DB1200:
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	printk(KERN_INFO "Alchemy/AMD/RMI %s Board, CPLD Rev %d"
-		"  Board-ID %d	Daughtercard ID %d\n", get_system_type(),
-		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
-
-	return 0;
-}
 
 /******************************************************************************/
 
@@ -961,3 +940,40 @@ int __init db1200_dev_setup(void)
 
 	return 0;
 }
+
+static void __init db1200_reserve_mem(void)
+{
+	int ret;
+
+	/* reserve 64MB for the framebuffer (2048x2048x32 * 4 windows) */
+	ret = dma_declare_contiguous(&au1200_lcd_dev.dev, 64 << 20, 0, 0);
+	if (ret)
+		pr_err("DB1200: failed to reserve 64MB for LCD\n");
+}
+
+int __init db1200_board_setup(void)
+{
+	unsigned short whoami;
+
+	if (db1200_detect_board())
+		return -ENODEV;
+
+	whoami = bcsr_read(BCSR_WHOAMI);
+	switch (BCSR_WHOAMI_BOARD(whoami)) {
+	case BCSR_WHOAMI_PB1200_DDR1:
+	case BCSR_WHOAMI_PB1200_DDR2:
+	case BCSR_WHOAMI_DB1200:
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "Alchemy/AMD/RMI %s Board, CPLD Rev %d"
+		"  Board-ID %d	Daughtercard ID %d\n", get_system_type(),
+		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
+
+
+	plat_reserve_mem = db1200_reserve_mem;
+
+	return 0;
+}
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index 751a1e2..a844c04 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-contiguous.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/init.h>
@@ -23,6 +24,7 @@
 #include <linux/smsc911x.h>
 #include <linux/wm97xx.h>
 
+#include <asm/bootinfo.h>	/* plat_reserve_mem hook */
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/gpio-au1300.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
@@ -841,6 +843,15 @@ int __init db1300_dev_setup(void)
 	return platform_add_devices(db1300_dev, ARRAY_SIZE(db1300_dev));
 }
 
+static void __init db1300_reserve_mem(void)
+{
+	int ret;
+
+	/* reserve 64MB for the framebuffer (2048x2048x32 * 4 windows) */
+	ret = dma_declare_contiguous(&db1300_lcd_dev.dev, 64 << 20, 0, 0);
+	if (ret)
+		pr_err("DB1300: failed to reserve 64MB for LCD\n");
+}
 
 int __init db1300_board_setup(void)
 {
@@ -865,5 +876,7 @@ int __init db1300_board_setup(void)
 	alchemy_uart_enable(AU1300_UART1_PHYS_ADDR);
 	alchemy_uart_enable(AU1300_UART3_PHYS_ADDR);
 
+	plat_reserve_mem = db1300_reserve_mem;
+
 	return 0;
 }
-- 
2.5.3
