Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2009 18:32:59 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:22739 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21103489AbZAVSc4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2009 18:32:56 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id 39B48400E106;
	Thu, 22 Jan 2009 19:32:51 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: rb532: export rb532_gpio_set_func()
Date:	Thu, 22 Jan 2009 19:32:43 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Message-Id: <20090122183251.39B48400E106@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

This kernel symbol provides a way for drivers to switch on alternate
function for a certain GPIO pin. Turning it off is done implicitly when
changing the GPIO direction, as that would be fixed when using the given
pin als alternate function.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/include/asm/mach-rc32434/gpio.h |    1 +
 arch/mips/rb532/gpio.c                    |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/gpio.h b/arch/mips/include/asm/mach-rc32434/gpio.h
index ca92c81..3cb50d1 100644
--- a/arch/mips/include/asm/mach-rc32434/gpio.h
+++ b/arch/mips/include/asm/mach-rc32434/gpio.h
@@ -82,5 +82,6 @@ struct rb532_gpio_reg {
 
 extern void rb532_gpio_set_ilevel(int bit, unsigned gpio);
 extern void rb532_gpio_set_istat(int bit, unsigned gpio);
+extern void rb532_gpio_set_func(unsigned gpio);
 
 #endif /* _RC32434_GPIO_H_ */
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index f338681..37de05d 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -174,10 +174,11 @@ EXPORT_SYMBOL(rb532_gpio_set_istat);
 /*
  * Configure GPIO alternate function
  */
-static void rb532_gpio_set_func(int bit, unsigned gpio)
+void rb532_gpio_set_func(unsigned gpio)
 {
-       rb532_set_bit(bit, gpio, rb532_gpio_chip->regbase + GPIOFUNC);
+       rb532_set_bit(1, gpio, rb532_gpio_chip->regbase + GPIOFUNC);
 }
+EXPORT_SYMBOL(rb532_gpio_set_func);
 
 int __init rb532_gpio_init(void)
 {
-- 
1.5.6.4
