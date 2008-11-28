Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2008 19:44:03 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:54687 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23974375AbYK1Tnv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Nov 2008 19:43:51 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 5A883386DBBE;
	Fri, 28 Nov 2008 20:43:46 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: rb532: remove useless CF GPIO initialisation
Date:	Fri, 28 Nov 2008 20:46:22 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Message-Id: <20081128194346.5A883386DBBE@mail.ifyouseekate.net>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

As the pata-rb532-cf driver calls gpio_set_direction_input(), the calls
to rb532_gpio_set_func() and rb532_gpio_direction_input() are not needed
since the alternate function is automatically being disabled when
changing the GPIO pin direction.
The later two calls to rb532_gpio_set_{ilevel,istat}() are implicitly
being done by the IRQ initialisation of pata-rb532-cf.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index f5b15a1..b195f79 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -259,12 +259,6 @@ int __init rb532_gpio_init(void)
 		return -ENXIO;
 	}
 
-	/* configure CF_GPIO_NUM as CFRDY IRQ source */
-	rb532_gpio_set_func(0, CF_GPIO_NUM);
-	rb532_gpio_direction_input(&rb532_gpio_chip->chip, CF_GPIO_NUM);
-	rb532_gpio_set_ilevel(1, CF_GPIO_NUM);
-	rb532_gpio_set_istat(0, CF_GPIO_NUM);
-
 	return 0;
 }
 arch_initcall(rb532_gpio_init);
-- 
1.5.6.4
