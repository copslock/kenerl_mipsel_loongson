Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2016 16:06:10 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35699 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993120AbcLDPGDTtEQr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2016 16:06:03 +0100
Received: by mail-pf0-f194.google.com with SMTP id i88so6435476pfk.2;
        Sun, 04 Dec 2016 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o0rCJhnMRgvJgt+wD0UziSjNBhFr3NHrMYfyKiPuLkw=;
        b=d2tirLj4PufzLHhsMj9pPHKQPnj8pInWgXrVjfPMP7e7t0XEBh836VkCq2gw7oZ0i1
         IwyaBNf+RraBAl2hh9oxC8IdKvqeL2CIqxVUKk/qXAcO5wL7+LFisvTjl/VDG0QgZf2j
         8EQqgf6fdRSR0vZ0aKsdrGXUbvRouig4TwI6JWYXnUAipTrcDIWmRAoIGNss4LgurtVc
         RBETA+RnAM5sM6dHR/V2H3scXBLlPlQJd5F6sx5NbQZc3H8OeWp/S2SWDE1tLBUjqbmR
         xIGYcsMVlcIua8V8D0l7yCMN2vvkHuI4xZfopNG2Otg+xOuQCY1LG95ElLGo0dyjNsLe
         zFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o0rCJhnMRgvJgt+wD0UziSjNBhFr3NHrMYfyKiPuLkw=;
        b=FPhbM+Mzg7dcnWZYSKN5iLzsK22A5QdpSNf3o2esRfbqCL+2r+VPqFvMZs6b8nEggj
         f3WzUkMjf/K0J6I0ZQFtgSbK6W6exQoUPsr8z54F2wbDWeFg40DQhePBQM+miM36o0lP
         8gFWIDpjdhA1OzCoTf9z+xDynh6kKQJ9p13VBG1yHMZry27hoPTL65X1PPrjlfbv0uan
         jUOdRi1UMPsbQtBvhqYq0UkvUZU270MO8DfrMLaE8FG2T9SzIxL7HiqsHzkHcTX+NJ5u
         kbyUfLGmZKFcIOaEz/ib0U39Lx5e91MXPWO16ft/+WlL9ZxjIgRqX6R+tLCc1//KPxXL
         nFDA==
X-Gm-Message-State: AKaTC02LhSveQLEpLM3z9PV03tVqHo+tMSLwSzzvPGJobIkiWgQ/POG2NHBsjuSjgC5u3Q==
X-Received: by 10.84.164.231 with SMTP id l36mr116123316plg.33.1480863957391;
        Sun, 04 Dec 2016 07:05:57 -0800 (PST)
Received: from ubuntu (ec2-52-77-214-225.ap-southeast-1.compute.amazonaws.com. [52.77.214.225])
        by smtp.gmail.com with ESMTPSA id b80sm20895905pfe.52.2016.12.04.07.05.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 07:05:56 -0800 (PST)
Date:   Sun, 4 Dec 2016 23:05:40 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org, keguang.zhang@gmail.com
Cc:     gnaygnil@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2.3 3/3] MIPS: loongson1: Add watchdog support for Loongson1
 board
Message-ID: <20161204150523.GA29829@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

The patch adds watchdog support for Loongson1 board.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>

---
V2.3:
  No change.
V2.2:
  Remove the wide character.
V2.1:
  No change.
V2.0:
  Add watchdog support for loongson1b_defconfig.
V1.1:
  Add watchdog support for Loongson1B.
---
 arch/mips/configs/loongson1b_defconfig           |  4 ++++
 arch/mips/configs/loongson1c_defconfig           |  4 ++++
 arch/mips/include/asm/mach-loongson32/platform.h |  9 +++++----
 arch/mips/loongson32/common/platform.c           | 16 ++++++++++++++++
 arch/mips/loongson32/ls1b/board.c                |  7 ++++---
 arch/mips/loongson32/ls1c/board.c                |  7 ++++---
 6 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index c442f27..914c867 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -74,6 +74,10 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_LOONGSON1=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
+CONFIG_WATCHDOG_SYSFS=y
+CONFIG_LOONGSON1_WDT=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_HID_GENERIC=m
 CONFIG_USB_HID=m
diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/loongson1c_defconfig
index 2304d41..68e42ef 100644
--- a/arch/mips/configs/loongson1c_defconfig
+++ b/arch/mips/configs/loongson1c_defconfig
@@ -75,6 +75,10 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_LOONGSON1=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
+CONFIG_WATCHDOG_SYSFS=y
+CONFIG_LOONGSON1_WDT=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_HID_GENERIC=m
 CONFIG_USB_HID=m
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 7adc313..8f8fa43 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -1,9 +1,9 @@
 /*
  * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
 
@@ -25,11 +25,12 @@
 extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_nand_pdev;
 extern struct platform_device ls1x_rtc_pdev;
+extern struct platform_device ls1x_wdt_pdev;
 
 void __init ls1x_clk_init(void);
 void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
 void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata);
-void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
 void __init ls1x_rtc_set_extclk(struct platform_device *pdev);
+void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
 
 #endif /* __ASM_MACH_LOONGSON32_PLATFORM_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 18c2959..a3dabe9 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -356,3 +356,19 @@ struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
 };
+
+/* Watchdog */
+static struct resource ls1x_wdt_resources[] = {
+	{
+		.start	= LS1X_WDT_BASE,
+		.end	= LS1X_WDT_BASE + SZ_16 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_wdt_pdev = {
+	.name		= "ls1x-wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ls1x_wdt_resources),
+	.resource	= ls1x_wdt_resources,
+};
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 38a1d40..01aceaa 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -1,9 +1,9 @@
 /*
  * Copyright (c) 2011-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
 
@@ -72,6 +72,7 @@ struct plat_ls1x_nand ls1x_nand_pdata = {
 	&ls1x_gpio1_pdev,
 	&ls1x_nand_pdev,
 	&ls1x_rtc_pdev,
+	&ls1x_wdt_pdev,
 };
 
 static int __init ls1b_platform_init(void)
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index a96bed5..eb2d913 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -1,9 +1,9 @@
 /*
  * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
 
@@ -13,6 +13,7 @@
 	&ls1x_uart_pdev,
 	&ls1x_eth0_pdev,
 	&ls1x_rtc_pdev,
+	&ls1x_wdt_pdev,
 };
 
 static int __init ls1c_platform_init(void)
-- 
1.9.1
