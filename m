Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2008 19:44:27 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:55199 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23974380AbYK1Tn7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Nov 2008 19:43:59 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id DC55A386DBBE;
	Fri, 28 Nov 2008 20:43:53 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: rb532: remove unused rb532_gpio_set_func()
Date:	Fri, 28 Nov 2008 20:46:29 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Message-Id: <20081128194353.DC55A386DBBE@mail.ifyouseekate.net>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Since disabling of the alternate function of a GPIO pin is being done
implicitly when changing it's direction, the above mentioned function is
not being called anymore and can be removed.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index b195f79..d75eb19 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -228,14 +228,6 @@ void rb532_gpio_set_istat(int bit, unsigned gpio)
 }
 EXPORT_SYMBOL(rb532_gpio_set_istat);
 
-/*
- * Configure GPIO alternate function
- */
-static void rb532_gpio_set_func(int bit, unsigned gpio)
-{
-       rb532_set_bit(bit, gpio, rb532_gpio_chip->regbase + GPIOFUNC);
-}
-
 int __init rb532_gpio_init(void)
 {
 	struct resource *r;
-- 
1.5.6.4
