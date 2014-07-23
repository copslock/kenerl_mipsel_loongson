Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:41:55 +0200 (CEST)
Received: from mail-we0-f170.google.com ([74.125.82.170]:42824 "EHLO
        mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842531AbaGWOh00GgX5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:26 +0200
Received: by mail-we0-f170.google.com with SMTP id w62so1263580wes.29
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BEhsvvkIQ6PCUX6nP8GT33Bm2u6WXgoKa3fcnZRi58w=;
        b=sVn0E/tYmcA/1SMSWZZkqHBTgbip3jmGV6dSamJRmygwLiOnL63ov7CFZn4NaoH3MZ
         siTHmIul7ZwggT94iBYJ8FcjQeHjJjkkCeld5CGDlZSjMBm0LlTGS+XDdHxcZ5iBcHKT
         KCAx5DnKpwkR3r1unGUePxRTvu7y5dj1sghE35o8vVVRxEklyXVS2A9Q9Zz5oOL9i8t7
         gOMiOjMZ8+/ZZYoauE8HVyD0IzOVNH88vFUQ8opyDlypcme032mOe7C6i/uuSJ8o3m6J
         Szrfxd8s/Ra7AZhIvVQYRZb/3hHxv4Z6T1FfQwgrnhJQXqlf3StIMQHPX+lw4ESx4f9w
         BEBw==
X-Received: by 10.180.187.7 with SMTP id fo7mr5259686wic.4.1406126235761;
        Wed, 23 Jul 2014 07:37:15 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:14 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 02/10] MIPS: Alchemy: platform: use clk framework for uarts
Date:   Wed, 23 Jul 2014 16:36:49 +0200
Message-Id: <1406126217-471265-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41539
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

Use the clock framework to get the rate of the peripheral clock.
Remove the now obsolete get_uart_baud_base function.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/clocks.c          | 19 -------------------
 arch/mips/alchemy/common/platform.c        | 13 ++++++++++++-
 arch/mips/include/asm/mach-au1x00/au1000.h |  2 --
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/mips/alchemy/common/clocks.c b/arch/mips/alchemy/common/clocks.c
index 0e41416..a4c7cd7 100644
--- a/arch/mips/alchemy/common/clocks.c
+++ b/arch/mips/alchemy/common/clocks.c
@@ -38,7 +38,6 @@
 #define AU1000_SRC_CLK	12000000
 
 static unsigned int au1x00_clock; /*  Hz */
-static unsigned long uart_baud_base;
 
 /*
  * Set the au1000_clock
@@ -55,21 +54,6 @@ unsigned int get_au1x00_speed(void)
 EXPORT_SYMBOL(get_au1x00_speed);
 
 /*
- * The UART baud base is not known at compile time ... if
- * we want to be able to use the same code on different
- * speed CPUs.
- */
-unsigned long get_au1x00_uart_baud_base(void)
-{
-	return uart_baud_base;
-}
-
-void set_au1x00_uart_baud_base(unsigned long new_baud_base)
-{
-	uart_baud_base = new_baud_base;
-}
-
-/*
  * We read the real processor speed from the PLL.  This is important
  * because it is more accurate than computing it from the 32 KHz
  * counter, if it exists.  If we don't have an accurate processor
@@ -95,9 +79,6 @@ unsigned long au1xxx_calc_clock(void)
 
 	/* On Alchemy CPU:counter ratio is 1:1 */
 	mips_hpt_frequency = cpu_speed;
-	/* Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16) */
-	set_au1x00_uart_baud_base(cpu_speed / (2 *
-		((alchemy_rdsys(AU1000_SYS_POWERCTRL) & 0x03) + 2) * 16));
 
 	set_au1x00_speed(cpu_speed);
 
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index fb89d21..d77a64f 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/init.h>
@@ -99,10 +100,20 @@ static struct platform_device au1xx0_uart_device = {
 
 static void __init alchemy_setup_uarts(int ctype)
 {
-	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	long uartclk;
 	int s = sizeof(struct plat_serial8250_port);
 	int c = alchemy_get_uarts(ctype);
 	struct plat_serial8250_port *ports;
+	struct clk *clk = clk_get(NULL, ALCHEMY_PERIPH_CLK);
+
+	if (IS_ERR(clk))
+		return;
+	if (clk_prepare_enable(clk)) {
+		clk_put(clk);
+		return;
+	}
+	uartclk = clk_get_rate(clk);
+	clk_put(clk);
 
 	ports = kzalloc(s * (c + 1), GFP_KERNEL);
 	if (!ports) {
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 1f40c0a..e77b920 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -844,8 +844,6 @@ static inline int alchemy_get_macs(int type)
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
-extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
-extern unsigned long get_au1x00_uart_baud_base(void);
 extern unsigned long au1xxx_calc_clock(void);
 
 /* PM: arch/mips/alchemy/common/sleeper.S, power.c, irq.c */
-- 
2.0.1
