Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2008 21:02:54 +0100 (BST)
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58779 "EHLO
	atlas.informatik.uni-freiburg.de") by ftp.linux-mips.org with ESMTP
	id S23861647AbYIOUCu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Sep 2008 21:02:50 +0100
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1KfKHZ-0001uF-GR; Mon, 15 Sep 2008 22:02:49 +0200
Received: from zeisberg by login.informatik.uni-freiburg.de with local (Exim 4.63)
	(envelope-from <zeisberg@login.informatik.uni-freiburg.de>)
	id 1KfKHY-0000QE-NY; Mon, 15 Sep 2008 22:02:48 +0200
From:	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To:	linux-kernel@vger.kernel.org
Cc:	David Brownell <david-b@pacbell.net>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>,
	Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] gpio_free might sleep, mips architecture
Date:	Mon, 15 Sep 2008 22:02:41 +0200
Message-Id: <1221508963-27259-3-git-send-email-ukleinek@informatik.uni-freiburg.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1221508963-27259-2-git-send-email-ukleinek@informatik.uni-freiburg.de>
References: <1216884515-12084-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
 <1221508963-27259-1-git-send-email-ukleinek@informatik.uni-freiburg.de>
 <1221508963-27259-2-git-send-email-ukleinek@informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Organization: Universitaet Freiburg, Institut f. Informatik
Return-Path: <zeisberg@informatik.uni-freiburg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zeisberg@informatik.uni-freiburg.de
Precedence: bulk
X-list: linux-mips

According to the documentation gpio_free should only be called from task
context only.  To make this more explicit add a might sleep to all
implementations.

This patch changes the gpio_free implementations for the mips
architecture.

Signed-off-by: Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
Cc: David Brownell <david-b@pacbell.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Cc: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/asm-mips/mach-au1x00/gpio.h  |    2 ++
 include/asm-mips/mach-bcm47xx/gpio.h |    3 +++
 include/asm-mips/mach-rc32434/gpio.h |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/mach-au1x00/gpio.h b/include/asm-mips/mach-au1x00/gpio.h
index 2dc61e0..31eddba 100644
--- a/include/asm-mips/mach-au1x00/gpio.h
+++ b/include/asm-mips/mach-au1x00/gpio.h
@@ -1,6 +1,7 @@
 #ifndef _AU1XXX_GPIO_H_
 #define _AU1XXX_GPIO_H_
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 #define AU1XXX_GPIO_BASE	200
@@ -31,6 +32,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
 static inline void gpio_free(unsigned gpio)
 {
 	/* Not yet implemented */
+	might_sleep();
 }
 
 static inline int gpio_direction_input(unsigned gpio)
diff --git a/include/asm-mips/mach-bcm47xx/gpio.h b/include/asm-mips/mach-bcm47xx/gpio.h
index cfc8f4d..af17ccd 100644
--- a/include/asm-mips/mach-bcm47xx/gpio.h
+++ b/include/asm-mips/mach-bcm47xx/gpio.h
@@ -9,6 +9,8 @@
 #ifndef __BCM47XX_GPIO_H
 #define __BCM47XX_GPIO_H
 
+#include <linux/kernel.h>
+
 #define BCM47XX_EXTIF_GPIO_LINES	5
 #define BCM47XX_CHIPCO_GPIO_LINES	16
 
@@ -25,6 +27,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
 
 static inline void gpio_free(unsigned gpio)
 {
+	might_sleep();
 }
 
 static inline int gpio_to_irq(unsigned gpio)
diff --git a/include/asm-mips/mach-rc32434/gpio.h b/include/asm-mips/mach-rc32434/gpio.h
index f946f5f..9b4722e 100644
--- a/include/asm-mips/mach-rc32434/gpio.h
+++ b/include/asm-mips/mach-rc32434/gpio.h
@@ -13,6 +13,7 @@
 #ifndef _RC32434_GPIO_H_
 #define _RC32434_GPIO_H_
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 struct rb532_gpio_reg {
@@ -88,6 +89,7 @@ static inline int gpio_request(unsigned gpio, const char *label)
 static inline void gpio_free(unsigned gpio)
 {
 	/* Not yet implemented */
+	might_sleep();
 }
 
 static inline int gpio_direction_input(unsigned gpio)
-- 
1.5.6.5
