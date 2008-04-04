Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 17:56:03 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:16607 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S529355AbYDDPz6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2008 17:55:58 +0200
Received: from localhost (p2014-ipad306funabasi.chiba.ocn.ne.jp [123.217.172.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E4291AB76; Sat,  5 Apr 2008 00:54:36 +0900 (JST)
Date:	Sat, 05 Apr 2008 00:55:24 +0900 (JST)
Message-Id: <20080405.005524.108306693.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/4] make fallback gpio.h gpiolib-friendly
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
X-archive-position: 18815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If gpiolib was selected, asm-generic/gpio.h provides some prototypes
for gpio API and implementation helpers.  With this patch, platform
code can implement its GPIO API using gpiolib without custom gpio.h
file.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/mach-generic/gpio.h b/include/asm-mips/mach-generic/gpio.h
index 6eaf5ef..e6b376b 100644
--- a/include/asm-mips/mach-generic/gpio.h
+++ b/include/asm-mips/mach-generic/gpio.h
@@ -1,12 +1,18 @@
 #ifndef __ASM_MACH_GENERIC_GPIO_H
 #define __ASM_MACH_GENERIC_GPIO_H
 
+#ifdef CONFIG_HAVE_GPIO_LIB
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#else
 int gpio_request(unsigned gpio, const char *label);
 void gpio_free(unsigned gpio);
 int gpio_direction_input(unsigned gpio);
 int gpio_direction_output(unsigned gpio, int value);
 int gpio_get_value(unsigned gpio);
 void gpio_set_value(unsigned gpio, int value);
+#endif
 int gpio_to_irq(unsigned gpio);
 int irq_to_gpio(unsigned irq);
 
