Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 07:54:18 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35021 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbcJUFyLxI6LM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 07:54:11 +0200
Received: by mail-pf0-f195.google.com with SMTP id s8so7610587pfj.2;
        Thu, 20 Oct 2016 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TuMjOxAh+cIU8CdzjQ71JBrlKySJrtAI9pbTnvn19II=;
        b=qBwyRBsS+sRNJN+HeGiwrmnk04V8LyPWU4SsUbPIltZzUNmI/jnGhXRr9NfP64/5IC
         LmKdIGhsPqbeSn0Z3sxIl3FjXLW+THq3gFUBbFNmurVmahqR55KIeVV9oawYhXBf2YZK
         g96X8vA+VsRUyhgVRnLDLj5iAJtkRuV3rnRbe1jPNy170Xxi4YQOkHVeM/0r5kdfWQnX
         gsWo4zk2u1STdLCGSVFQAHLbBhx5f+mh63IiYXbvvj0ksymkzkAVuPbOP6uh6jt9bbrW
         gkFXltkkt5gu4RYypRTv5GPtTNpEjuwgr5QMD6YQou8WXsJy0uiHhbPPBDB8zN8l9dwQ
         mlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TuMjOxAh+cIU8CdzjQ71JBrlKySJrtAI9pbTnvn19II=;
        b=lp5ZcJmaE9gLiAMYLF+u65FDD/Bs8hubBFBHkV1kP+wIfMR1P9q+0Fj9nbMbc0LUOP
         SZUnGKix72rPZxO5VfIzsYejCLSoMdHF01uObS23Hd5vVYuoWjdrODgfDNOEglSiQXeV
         Z0hjM4I6kjS1eyDPNZJFOh30lCbRETacVgvYml2Edto5pLcb5Bo5WYPb2JJX/T4eLxn9
         oC4nuISfWfRAqLsI2PVXrKZcZvrZmZRLUCsuiud8qrQLA6lHwkXewrrqIHQdJldZZ9Wx
         kn86YV855khOZ9hRyvw+blywdQaKY7Q+ztsNd9BR8/PwlVbZI1peU0OhljVTtrCsX7pk
         OS8w==
X-Gm-Message-State: AA6/9RkjhDb7qe4JDamn8UqsfxZSEodT0i30BZtxdlaXzdcgHszUnRM341RggfMBXko2Bg==
X-Received: by 10.98.15.134 with SMTP id 6mr8259705pfp.117.1477029246121;
        Thu, 20 Oct 2016 22:54:06 -0700 (PDT)
Received: from ly-pc ([180.110.201.1])
        by smtp.gmail.com with ESMTPSA id r77sm1502341pfb.2.2016.10.20.22.54.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 22:54:05 -0700 (PDT)
Date:   Fri, 21 Oct 2016 13:53:58 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Yang Ling <gnaygnil@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2.1 2/2] MIPS: loongson1: Add watchdog support for Loongson1
 board
Message-ID: <20161021055358.GA6365@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55538
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
V2.1:
  No change.
V2.0:
  Add watchdog support for loongson1b_defconfig.
V1.1:
  Add watchdog support for Loongson1B.
---
 arch/mips/configs/loongson1b_defconfig           |  4 ++++
 arch/mips/configs/loongson1c_defconfig           |  4 ++++
 arch/mips/include/asm/mach-loongson32/platform.h |  3 ++-
 arch/mips/loongson32/common/platform.c           | 16 ++++++++++++++++
 arch/mips/loongson32/ls1b/board.c                |  1 +
 arch/mips/loongson32/ls1c/board.c                |  1 +
 6 files changed, 28 insertions(+), 1 deletion(-)

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
index 7adc313..85335fd 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
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
index 4e28e0f..1bfcdcb 100644
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
