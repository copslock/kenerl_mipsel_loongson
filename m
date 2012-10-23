Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 08:18:14 +0200 (CEST)
Received: from mail-da0-f49.google.com ([209.85.210.49]:39944 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817037Ab2JWGRdTaNg8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 08:17:33 +0200
Received: by mail-da0-f49.google.com with SMTP id q27so1645229daj.36
        for <multiple recipients>; Mon, 22 Oct 2012 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EHso87Fw/j6JVhY6xnZlL4+bvZTex3NBaWrTXCodQpA=;
        b=MIfU5fwB0+YyLru81x+82NmwL3jS0AOdahiGQcoLM4iGrkSsVjlGg/anQjpkl5NQTi
         eQsoyTOqie9/1HZIY0girIvWO4PGjqPwmmC3s/GLXXxcJt2gi+Iu8q4ilOYVY4LJYJjO
         YVTyy5oBPx7cgSPzvHkZljIp8KhAbfGfJ2VhjM4DHyonOkckq5F7Y4B6WJHUncAsUHw4
         yNWD+vf/nh3ZfJXTgKGtP/+P6aqI6PHsgJ3Ha2B7llUeDZPt6R7cSugiLY84eO65aQzf
         EfkCIZFGIjFsXghlKS42UTpY2KWMuQ9pZcIm0x2H597uCigdRx2pR772ShGhkNM3H1Zq
         Pbnw==
Received: by 10.68.209.200 with SMTP id mo8mr37028625pbc.102.1350973046739;
        Mon, 22 Oct 2012 23:17:26 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id bc8sm7185918pab.5.2012.10.22.23.17.22
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 23:17:25 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     mturquette@linaro.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 2/4] MIPS: Loongson1B: improve ls1x_serial_setup()
Date:   Tue, 23 Oct 2012 14:17:01 +0800
Message-Id: <1350973023-7667-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1350973023-7667-1-git-send-email-keguang.zhang@gmail.com>
References: <1350973023-7667-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 34740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

Improve ls1x_serial_setup().

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson1/platform.h |    2 +-
 arch/mips/loongson1/common/platform.c           |    9 +++++----
 arch/mips/loongson1/ls1b/board.c                |    5 +----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson1/platform.h b/arch/mips/include/asm/mach-loongson1/platform.h
index f584017..718a122 100644
--- a/arch/mips/include/asm/mach-loongson1/platform.h
+++ b/arch/mips/include/asm/mach-loongson1/platform.h
@@ -19,6 +19,6 @@ extern struct platform_device ls1x_ehci_device;
 extern struct platform_device ls1x_rtc_device;
 
 extern void __init ls1x_clk_init(void);
-void ls1x_serial_setup(void);
+extern void __init ls1x_serial_setup(struct platform_device *pdev);
 
 #endif /* __ASM_MACH_LOONGSON1_PLATFORM_H */
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/common/platform.c
index e92d59c..5ca38dc 100644
--- a/arch/mips/loongson1/common/platform.c
+++ b/arch/mips/loongson1/common/platform.c
@@ -42,16 +42,17 @@ struct platform_device ls1x_uart_device = {
 	},
 };
 
-void __init ls1x_serial_setup(void)
+void __init ls1x_serial_setup(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct plat_serial8250_port *p;
 
-	clk = clk_get(NULL, "dc");
+	clk = clk_get(NULL, pdev->name);
 	if (IS_ERR(clk))
-		panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
+		panic("unable to get %s clock, err=%ld",
+			pdev->name, PTR_ERR(clk));
 
-	for (p = ls1x_serial8250_port; p->flags != 0; ++p)
+	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
 		p->uartclk = clk_get_rate(clk);
 }
 
diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson1/ls1b/board.c
index 295b1be..1fbd526 100644
--- a/arch/mips/loongson1/ls1b/board.c
+++ b/arch/mips/loongson1/ls1b/board.c
@@ -9,9 +9,6 @@
 
 #include <platform.h>
 
-#include <linux/serial_8250.h>
-#include <loongson1.h>
-
 static struct platform_device *ls1b_platform_devices[] __initdata = {
 	&ls1x_uart_device,
 	&ls1x_eth0_device,
@@ -23,7 +20,7 @@ static int __init ls1b_platform_init(void)
 {
 	int err;
 
-	ls1x_serial_setup();
+	ls1x_serial_setup(&ls1x_uart_device);
 
 	err = platform_add_devices(ls1b_platform_devices,
 				   ARRAY_SIZE(ls1b_platform_devices));
-- 
1.7.1
