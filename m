Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:26:45 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:49433 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903631Ab2FLIYi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:38 +0200
Received: by bkwj4 with SMTP id j4so5334481bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mrwixR2QFhMztxRZon6CO9h/RDkm9+pcAAtPL674NX8=;
        b=m1PBN7JhoBP+uY8os473SmTL7ngBKInTVT243J0TJf2UzFpAQcGAjFzqysPktRzpjn
         0HalLb32+TMBwO9JeAq47+rGwOzU6qLFqKWGTTkzT2lUD9zkKKjKtz5rQsGqi3brVhUv
         5AtcGUT5S2k6mi88JcN5hYgrzCjLH3lPa3YP4qleBiGNSs6py0W+bNvBw+wpLTQv+EL7
         hRt/UWayXVL+u8qGB3hya5Dc9tAjJ/rV4cO2YrxdX6N8NwsexORTfZINoXFPSpJx5PeS
         u/cpiUYnXdUrZX2VXih+37vHmOpJq+DskrmoPuHiUCsVyRdJtRTeS3uW5Qzsp/V+l2qy
         Vj7Q==
Received: by 10.204.151.200 with SMTP id d8mr11810172bkw.82.1339489472579;
        Tue, 12 Jun 2012 01:24:32 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.31
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:31 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/8] MIPS: BCM63XX: add flash type detection
Date:   Tue, 12 Jun 2012 10:23:39 +0200
Message-Id: <1339489425-19037-3-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On BCM6358 and BCM6368 the attached flash type is exposed through a
bootstrapping register. Use it for auto detecting the flash type on
those and default to parallel flash for earlier SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/dev-flash.c                      |   60 ++++++++++++++++++--
 .../include/asm/mach-bcm63xx/bcm63xx_dev_flash.h   |    6 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |    9 +++
 3 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-flash.c b/arch/mips/bcm63xx/dev-flash.c
index af52738..1051fae 100644
--- a/arch/mips/bcm63xx/dev-flash.c
+++ b/arch/mips/bcm63xx/dev-flash.c
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
  * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2012 Jonas Gorski <jonas.gorski@gmail.com>
  */
 
 #include <linux/init.h>
@@ -54,16 +55,63 @@ static struct platform_device mtd_dev = {
 	},
 };
 
+static int __init bcm63xx_detect_flash_type(void)
+{
+	u32 val;
+
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6338_CPU_ID:
+	case BCM6345_CPU_ID:
+	case BCM6348_CPU_ID:
+		/* no way to auto detect so assume parallel */
+		return BCM63XX_FLASH_TYPE_PARALLEL;
+	case BCM6358_CPU_ID:
+		val = bcm_gpio_readl(GPIO_STRAPBUS_REG);
+		if (val & STRAPBUS_6358_BOOT_SEL_PARALLEL)
+			return BCM63XX_FLASH_TYPE_PARALLEL;
+		else
+			return BCM63XX_FLASH_TYPE_SERIAL;
+	case BCM6368_CPU_ID:
+		val = bcm_gpio_readl(GPIO_STRAPBUS_REG);
+		switch (val & STRAPBUS_6368_BOOT_SEL_MASK) {
+		case STRAPBUS_6368_BOOT_SEL_NAND:
+			return BCM63XX_FLASH_TYPE_NAND;
+		case STRAPBUS_6368_BOOT_SEL_SERIAL:
+			return BCM63XX_FLASH_TYPE_SERIAL;
+		case STRAPBUS_6368_BOOT_SEL_PARALLEL:
+			return BCM63XX_FLASH_TYPE_PARALLEL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 int __init bcm63xx_flash_register(void)
 {
+	int flash_type;
 	u32 val;
 
-	/* read base address of boot chip select (0) */
-	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
-	val &= MPI_CSBASE_BASE_MASK;
+	flash_type = bcm63xx_detect_flash_type();
 
-	mtd_resources[0].start = val;
-	mtd_resources[0].end = 0x1FFFFFFF;
+	switch (flash_type) {
+	case BCM63XX_FLASH_TYPE_PARALLEL:
+		/* read base address of boot chip select (0) */
+		val = bcm_mpi_readl(MPI_CSBASE_REG(0));
+		val &= MPI_CSBASE_BASE_MASK;
 
-	return platform_device_register(&mtd_dev);
+		mtd_resources[0].start = val;
+		mtd_resources[0].end = 0x1FFFFFFF;
+
+		return platform_device_register(&mtd_dev);
+	case BCM63XX_FLASH_TYPE_SERIAL:
+		pr_warn("unsupported serial flash detected\n");
+		return -ENODEV;
+	case BCM63XX_FLASH_TYPE_NAND:
+		pr_warn("unsupported NAND flash detected\n");
+		return -ENODEV;
+	default:
+		pr_err("flash detection failed for BCM%x: %d\n",
+		       bcm63xx_get_cpu_id(), flash_type);
+		return -ENODEV;
+	}
 }
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
index 8dcb541..354b848 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
@@ -1,6 +1,12 @@
 #ifndef __BCM63XX_FLASH_H
 #define __BCM63XX_FLASH_H
 
+enum {
+	BCM63XX_FLASH_TYPE_PARALLEL,
+	BCM63XX_FLASH_TYPE_SERIAL,
+	BCM63XX_FLASH_TYPE_NAND,
+};
+
 int __init bcm63xx_flash_register(void);
 
 #endif /* __BCM63XX_FLASH_H */
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 6a8df56..849fd97 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -507,6 +507,15 @@
 #define GPIO_BASEMODE_6368_MASK		0x7
 /* those bits must be kept as read in gpio basemode register*/
 
+#define GPIO_STRAPBUS_REG		0x40
+#define STRAPBUS_6358_BOOT_SEL_PARALLEL	(1 << 1)
+#define STRAPBUS_6358_BOOT_SEL_SERIAL	(0 << 1)
+#define STRAPBUS_6368_BOOT_SEL_MASK	0x3
+#define STRAPBUS_6368_BOOT_SEL_NAND	0
+#define STRAPBUS_6368_BOOT_SEL_SERIAL	1
+#define STRAPBUS_6368_BOOT_SEL_PARALLEL	3
+
+
 /*************************************************************************
  * _REG relative to RSET_ENET
  *************************************************************************/
-- 
1.7.2.5
