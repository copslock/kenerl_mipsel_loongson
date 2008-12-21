Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:28:27 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:13012 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24049148AbYLUI0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:30 +0000
Received: (qmail 3966 invoked from network); 21 Dec 2008 09:24:58 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:58 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 07/14] Alchemy: remove get/set_au1x00_lcd_clock().
Date:	Sun, 21 Dec 2008 09:26:20 +0100
Message-Id: <ad6889e72585d9fa5bedeb080d6d78d91c9e23c9.1229846414.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
 <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
 <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

There are no in-tree users, so remove them.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/clocks.c          |   31 ----------------------------
 arch/mips/alchemy/common/time.c            |    1 -
 arch/mips/include/asm/mach-au1x00/au1000.h |    2 -
 3 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/mips/alchemy/common/clocks.c b/arch/mips/alchemy/common/clocks.c
index 043429d..a8170fd 100644
--- a/arch/mips/alchemy/common/clocks.c
+++ b/arch/mips/alchemy/common/clocks.c
@@ -30,7 +30,6 @@
 #include <asm/mach-au1x00/au1000.h>
 
 static unsigned int au1x00_clock; /*  Hz */
-static unsigned int lcd_clock;    /* KHz */
 static unsigned long uart_baud_base;
 
 /*
@@ -61,33 +60,3 @@ void set_au1x00_uart_baud_base(unsigned long new_baud_base)
 {
 	uart_baud_base = new_baud_base;
 }
-
-/*
- * Calculate the Au1x00's LCD clock based on the current
- * cpu clock and the system bus clock, and try to keep it
- * below 40 MHz (the Pb1000 board can lock-up if the LCD
- * clock is over 40 MHz).
- */
-void set_au1x00_lcd_clock(void)
-{
-	unsigned int static_cfg0;
-	unsigned int sys_busclk = (get_au1x00_speed() / 1000) /
-				  ((int)(au_readl(SYS_POWERCTRL) & 0x03) + 2);
-
-	static_cfg0 = au_readl(MEM_STCFG0);
-
-	if (static_cfg0 & (1 << 11))
-		lcd_clock = sys_busclk / 5; /* note: BCLK switching fails with D5 */
-	else
-		lcd_clock = sys_busclk / 4;
-
-	if (lcd_clock > 50000) /* Epson MAX */
-		printk(KERN_WARNING "warning: LCD clock too high (%u KHz)\n",
-				    lcd_clock);
-}
-
-unsigned int get_au1x00_lcd_clock(void)
-{
-	return lcd_clock;
-}
-EXPORT_SYMBOL(get_au1x00_lcd_clock);
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 563d939..68d7142 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -224,7 +224,6 @@ void __init plat_time_init(void)
 	printk(KERN_INFO "CPU frequency %u.%02u MHz\n",
 	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
 	set_au1x00_speed(est_freq);
-	set_au1x00_lcd_clock(); /* program the LCD clock */
 
 #ifdef CONFIG_PM
 	/*
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index a7ba352..d07632e 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -97,8 +97,6 @@ extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
 extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
 extern unsigned long get_au1x00_uart_baud_base(void);
-extern void set_au1x00_lcd_clock(void);
-extern unsigned int get_au1x00_lcd_clock(void);
 
 /*
  * Every board describes its IRQ mapping with this table.
-- 
1.6.0.4
