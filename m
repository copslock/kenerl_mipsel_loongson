Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2009 22:44:10 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:60641 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21366188AbZASWnW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2009 22:43:22 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id C4A6B400E106;
	Mon, 19 Jan 2009 23:43:16 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org, florian@openwrt.org
Subject: [PATCH 4/5] MIPS: rb532: remove {get,set}_434_reg()
Date:	Mon, 19 Jan 2009 23:42:53 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1232404974-18497-3-git-send-email-n0-1@freewrt.org>
References: <1232404974-18497-1-git-send-email-n0-1@freewrt.org>
 <1232404974-18497-2-git-send-email-n0-1@freewrt.org>
 <1232404974-18497-3-git-send-email-n0-1@freewrt.org>
Message-Id: <20090119224316.C4A6B400E106@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

These kernel symbols are unused. Also, since dev3 init has been moved to
devices.c, set_434_reg() breaks compiling as it uses dev3.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index b9cb428..a916ac8 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -50,33 +50,6 @@ static struct resource rb532_gpio_reg0_res[] = {
 	}
 };
 
-void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val)
-{
-	unsigned long flags;
-	unsigned data;
-	unsigned i = 0;
-
-	spin_lock_irqsave(&dev3.lock, flags);
-
-	data = readl(IDT434_REG_BASE + reg_offs);
-	for (i = 0; i != len; ++i) {
-		if (val & (1 << i))
-			data |= (1 << (i + bit));
-		else
-			data &= ~(1 << (i + bit));
-	}
-	writel(data, (IDT434_REG_BASE + reg_offs));
-
-	spin_unlock_irqrestore(&dev3.lock, flags);
-}
-EXPORT_SYMBOL(set_434_reg);
-
-unsigned get_434_reg(unsigned reg_offs)
-{
-	return readl(IDT434_REG_BASE + reg_offs);
-}
-EXPORT_SYMBOL(get_434_reg);
-
 /* rb532_set_bit - sanely set a bit
  *
  * bitval: new value for the bit
-- 
1.5.6.4
