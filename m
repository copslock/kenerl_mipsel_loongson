Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 16:22:06 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36480 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbcJKOV7EqHFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2016 16:21:59 +0200
Received: by mail-pa0-f66.google.com with SMTP id rw4so1741112pab.3;
        Tue, 11 Oct 2016 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9tui6A0N0Jyt0pOQwYGGRS9GTw0P+6hihh27dWzCGZo=;
        b=wNShq0+kEuKfckBKGgUme4IwWh/tzxK5YLpO56M/TrV0fXJuTqTGT6wAGW7HJr+/km
         Z35rOzeKbVeNeLA4Na+NdomIlkOemvCU5+w2yuSwgkRqkWy4CHXj3ksdAbEJhn2t7NEo
         XL/xeI4u1je9L5aVZ/Q6Fo4emlBp31LJIyhm7jt7cicBilp4n/uhrYsYP7Set362Q+vi
         BVDdmwxynUq9im56uWyYk41eU2hdBF/IcfErSk3V//nd2coaUaxfmzW30mK9pYPe1/b4
         eRKneRQE475uQuaS/mjt/Y76oTze2Dix14hZjecoLGcwOnxUuNvWoCGOZcURhAxt7kEB
         IM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9tui6A0N0Jyt0pOQwYGGRS9GTw0P+6hihh27dWzCGZo=;
        b=DdhJwvKZuuWb881Q3yRUiNlu6QeY+AEHRqmiKd9nGmxZGdlFcGrskr8nfu33pxmeo1
         rT8kMQ3HpGLzO6y0F0RpHNI5hk9+TE2ECOb5L6Kc1xW5tx9X1JRoEZZAMLCOF2rpL/Yq
         9lTIb6Nf1wwuDD2aJFizBnNOdzKIYHw45vEQXo3tfYghzAenmHt/VoIUBjjPVO/pAukC
         BD2yQOqH7FoZnggM9r98r5gofUI4SLa7bqioyvArmlhoqvS9DyZT4tXzys4m7+tjt596
         cY5ujt5ZCZhFspiwwEgBztt+WWenyFzQoD8peeOils0ck8Rpx/zwqPnwN5oMlOAH6cGL
         dQLA==
X-Gm-Message-State: AA6/9RnY1HIwKuesi2Jg0twgWzTOK8UZJiBwoL9Z10oCZb5cCTey3GL7tkFg0LDgxLJUWw==
X-Received: by 10.66.142.169 with SMTP id rx9mr7411750pab.122.1476195712900;
        Tue, 11 Oct 2016 07:21:52 -0700 (PDT)
Received: from ubuntu ([180.102.120.140])
        by smtp.gmail.com with ESMTPSA id i191sm4812146pfe.27.2016.10.11.07.21.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 07:21:51 -0700 (PDT)
Date:   Tue, 11 Oct 2016 22:21:46 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Yang Ling <gnaygnil@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1.1 2/2] MIPS: loongson1: Add watchdog support for Loongson1
 board
Message-ID: <20161011142146.GA26313@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55388
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

The patch adds watchdog support for Loongson1B/1C board.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>

---
V1.1:
 Add watchdog support for Loongson1B.
---
 arch/mips/configs/loongson1c_defconfig           |  4 ++++
 arch/mips/include/asm/mach-loongson32/platform.h |  1 +
 arch/mips/loongson32/common/platform.c           | 16 ++++++++++++++++
 arch/mips/loongson32/ls1b/board.c                |  1 +
 arch/mips/loongson32/ls1c/board.c                |  1 +
 5 files changed, 23 insertions(+)

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
index 7adc313..5ead0dc 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -25,6 +25,7 @@
 extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_nand_pdev;
 extern struct platform_device ls1x_rtc_pdev;
+extern struct platform_device ls1x_wdt_pdev;
 
 void __init ls1x_clk_init(void);
 void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 4e28e0f..0521ac9 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -357,3 +357,19 @@ struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
 };
+
+/* Watchdog */
+static struct resource ls1x_wdt_resources[] = {
+	{
+		.start = LS1X_WDT_BASE,
+		.end   = LS1X_WDT_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device ls1x_wdt_pdev = {
+	.name          = "ls1x-wdt",
+	.id            = -1,
+	.num_resources = ARRAY_SIZE(ls1x_wdt_resources),
+	.resource      = ls1x_wdt_resources,
+};
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 38a1d40..d0812a3 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -72,6 +72,7 @@ struct plat_ls1x_nand ls1x_nand_pdata = {
 	&ls1x_gpio1_pdev,
 	&ls1x_nand_pdev,
 	&ls1x_rtc_pdev,
+	&ls1x_wdt_pdev,
 };
 
 static int __init ls1b_platform_init(void)
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index a96bed5..0e02362 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -13,6 +13,7 @@
 	&ls1x_uart_pdev,
 	&ls1x_eth0_pdev,
 	&ls1x_rtc_pdev,
+	&ls1x_wdt_pdev,
 };
 
 static int __init ls1c_platform_init(void)
-- 
1.9.1
