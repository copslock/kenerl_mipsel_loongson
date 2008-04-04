Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 17:58:24 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:21229 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S529379AbYDDP5A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 17:57:00 +0200
Received: from localhost (p2014-ipad306funabasi.chiba.ocn.ne.jp [123.217.172.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EDBF3AB9E; Sat,  5 Apr 2008 00:55:39 +0900 (JST)
Date:	Sat, 05 Apr 2008 00:56:27 +0900 (JST)
Message-Id: <20080405.005627.30186902.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 4/4] jmr3927: use generic txx9 gpio
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use generic txx9 gpio (and gpiolib) for JMR3927 board.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                   |    1 +
 arch/mips/jmr3927/rbhma3100/setup.c |   11 ++++++++---
 include/asm-mips/jmr3927/jmr3927.h  |    4 ++--
 include/asm-mips/jmr3927/tx3927.h   |    2 +-
 include/asm-mips/jmr3927/txx927.h   |   12 ------------
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 340a31d..25df3fc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -612,6 +612,7 @@ config TOSHIBA_JMR3927
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GPIO_TXX9
 
 config TOSHIBA_RBTX4927
 	bool "Toshiba RBTX49[23]7 board"
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index c886d80..f39c444 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -36,11 +36,13 @@
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #ifdef CONFIG_SERIAL_TXX9
 #include <linux/serial_core.h>
 #endif
 
 #include <asm/txx9tmr.h>
+#include <asm/txx9pio.h>
 #include <asm/reboot.h>
 #include <asm/jmr3927/jmr3927.h>
 #include <asm/mipsregs.h>
@@ -340,9 +342,12 @@ static void __init tx3927_setup(void)
 
 	/* PIO */
 	/* PIO[15:12] connected to LEDs */
-	tx3927_pioptr->dir = 0x0000f000;
-	tx3927_pioptr->maskcpu = 0;
-	tx3927_pioptr->maskext = 0;
+	__raw_writel(0x0000f000, &tx3927_pioptr->dir);
+	__raw_writel(0, &tx3927_pioptr->maskcpu);
+	__raw_writel(0, &tx3927_pioptr->maskext);
+	txx9_gpio_init(TX3927_PIO_REG, 0, 16);
+	gpio_request(11, "dipsw1");
+	gpio_request(10, "dipsw2");
 	{
 		unsigned int conf;
 
diff --git a/include/asm-mips/jmr3927/jmr3927.h b/include/asm-mips/jmr3927/jmr3927.h
index 81602c8..a162268 100644
--- a/include/asm-mips/jmr3927/jmr3927.h
+++ b/include/asm-mips/jmr3927/jmr3927.h
@@ -99,8 +99,8 @@
 #define jmr3927_led_and_set(n/*0-16*/)	jmr3927_ioc_reg_out((~(n)) & jmr3927_ioc_reg_in(JMR3927_IOC_LED_ADDR), JMR3927_IOC_LED_ADDR)
 
 /* DIPSW4 macro */
-#define jmr3927_dipsw1()	((tx3927_pioptr->din & (1 << 11)) == 0)
-#define jmr3927_dipsw2()	((tx3927_pioptr->din & (1 << 10)) == 0)
+#define jmr3927_dipsw1()	(gpio_get_value(11) == 0)
+#define jmr3927_dipsw2()	(gpio_get_value(10) == 0)
 #define jmr3927_dipsw3()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 2) == 0)
 #define jmr3927_dipsw4()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 1) == 0)
 
diff --git a/include/asm-mips/jmr3927/tx3927.h b/include/asm-mips/jmr3927/tx3927.h
index 338f998..fb58033 100644
--- a/include/asm-mips/jmr3927/tx3927.h
+++ b/include/asm-mips/jmr3927/tx3927.h
@@ -314,6 +314,6 @@ struct tx3927_ccfg_reg {
 #define tx3927_ccfgptr		((struct tx3927_ccfg_reg *)TX3927_CCFG_REG)
 #define tx3927_tmrptr(ch)	((struct txx927_tmr_reg *)TX3927_TMR_REG(ch))
 #define tx3927_sioptr(ch)	((struct txx927_sio_reg *)TX3927_SIO_REG(ch))
-#define tx3927_pioptr		((struct txx927_pio_reg *)TX3927_PIO_REG)
+#define tx3927_pioptr		((struct txx9_pio_reg __iomem *)TX3927_PIO_REG)
 
 #endif /* __ASM_TX3927_H */
diff --git a/include/asm-mips/jmr3927/txx927.h b/include/asm-mips/jmr3927/txx927.h
index 0474fe8..25dcf2f 100644
--- a/include/asm-mips/jmr3927/txx927.h
+++ b/include/asm-mips/jmr3927/txx927.h
@@ -22,18 +22,6 @@ struct txx927_sio_reg {
 	volatile unsigned long rfifo;
 };
 
-struct txx927_pio_reg {
-	volatile unsigned long dout;
-	volatile unsigned long din;
-	volatile unsigned long dir;
-	volatile unsigned long od;
-	volatile unsigned long flag[2];
-	volatile unsigned long pol;
-	volatile unsigned long intc;
-	volatile unsigned long maskcpu;
-	volatile unsigned long maskext;
-};
-
 /*
  * SIO
  */
