Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 05:01:06 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33162 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991932AbcJKDBAHcPQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2016 05:01:00 +0200
Received: by mail-pa0-f67.google.com with SMTP id hh10so636991pac.0;
        Mon, 10 Oct 2016 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Dal7ovpooqCrYkeMM+z2W88QB4MSqg72cvozfHshx8o=;
        b=0lNz4FFV+p5K1+EHAG1mcdHMCFB7k9FHxJL/ZmRR7ezweobO8sv8A++EN3iNZZ7VBY
         hpEd9ITRsXfHCSay7AblDkEwq7dLTF0YC2hdc7Bhim13XGXZpKv3wMSQdaChN8oAZDYz
         J3J9gjsdbJGTfWkh+43dAMwv7bpd86Qi3NCCDLPbjRuMmyeYRRK70InNXTCiplzA41H+
         9JuU9Th9R17KUNQmSBKUaGUM2ARue2YfVe8awAr6yx6ERNOQXGT06y1y9eY7pxRY9MRa
         GqqRxmJIcpp/V8kM+ItNu/7qBdVdHNC/cTtCrZdFiwACA5cwyEoH/czpzhBQFihMZuyt
         tvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Dal7ovpooqCrYkeMM+z2W88QB4MSqg72cvozfHshx8o=;
        b=hPdHUDvS2oAvVOwj4vvY5QvaO5C97Izd6bdF95zeTLYUtd0ft+k1JTF7pt4H0YURv0
         lf2Xnqtc10n8ARgcNqbLGSOUr+QUEd52306po1eVXx0T4yy51l8sdR1EocWC7zUYb56J
         4Ins+FRYh660GzW4X11LU6mm0OLyo5N673IuJ5kDOslRpCdxKw+IIMdiOSyDzgkW8tBV
         z7RDLELTdir0OpuuxaDe3rDYf3QqigprPkc0/9gvYSInKPq8IDjNUDtxxYmvo38q8lFl
         cotcUgnr7YVJgfJCtiy6qr2K2xoYCE5ANkEOCzN+umdInEAKsoHqSnXNDvZX3y2OudJT
         sEaw==
X-Gm-Message-State: AA6/9RnRYBrJPXyOazZFb9+n5R46MulIPVc+XHMCZIWrcyvkZyER8KXVuOX2tarfe1/FvQ==
X-Received: by 10.66.26.229 with SMTP id o5mr2721355pag.197.1476154854308;
        Mon, 10 Oct 2016 20:00:54 -0700 (PDT)
Received: from ly-pc (ec2-52-77-214-225.ap-southeast-1.compute.amazonaws.com. [52.77.214.225])
        by smtp.gmail.com with ESMTPSA id i191sm1011052pfe.27.2016.10.10.20.00.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 20:00:53 -0700 (PDT)
Date:   Tue, 11 Oct 2016 11:00:36 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org, keguang.zhang@gmail.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        gnaygnil@gmail.com
Subject: [PATCH v1 2/2] MIPS: loongson1: Add watchdog support for Loongson1C
 board
Message-ID: <20161011030036.GA25666@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55381
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

The patch adds watchdog support for Loongson1C board.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/configs/loongson1c_defconfig           |  4 ++++
 arch/mips/include/asm/mach-loongson32/platform.h |  1 +
 arch/mips/loongson32/common/platform.c           | 16 ++++++++++++++++
 arch/mips/loongson32/ls1c/board.c                |  1 +
 4 files changed, 22 insertions(+)

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
