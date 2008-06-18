Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 18:25:11 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:37343 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20021812AbYFRRYw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jun 2008 18:24:52 +0100
Received: (qmail 14716 invoked by uid 1000); 18 Jun 2008 19:24:48 +0200
Date:	Wed, 18 Jun 2008 19:24:48 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Alchemy: remove unused get/set_au1x00_lcd_clock()
	functions.
Message-ID: <20080618172448.GA14697@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mano@roarinelk.homelinux.net>

They don't do anything except print annoying messages,
and are not called from anywhere interesting.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/clocks.c      |   31 -------------------------------
 arch/mips/au1000/common/time.c        |    1 -
 include/asm-mips/mach-au1x00/au1000.h |    2 --
 3 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/mips/au1000/common/clocks.c b/arch/mips/au1000/common/clocks.c
index 043429d..a8170fd 100644
--- a/arch/mips/au1000/common/clocks.c
+++ b/arch/mips/au1000/common/clocks.c
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
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index f00904b..1159f2c 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -234,7 +234,6 @@ void __init plat_time_init(void)
 	printk(KERN_INFO "CPU frequency %u.%02u MHz\n",
 	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
 	set_au1x00_speed(est_freq);
-	set_au1x00_lcd_clock(); /* program the LCD clock */
 
 #ifdef CONFIG_PM
 	/*
diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-au1x00/au1000.h
index 5004bf9..0879397 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -99,8 +99,6 @@ extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
 extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
 extern unsigned long get_au1x00_uart_baud_base(void);
-extern void set_au1x00_lcd_clock(void);
-extern unsigned int get_au1x00_lcd_clock(void);
 
 /*
  * Every board describes its IRQ mapping with this table.
-- 
1.5.5.4
