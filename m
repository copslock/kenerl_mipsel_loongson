Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2009 22:43:51 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:59617 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21366187AbZASWnN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2009 22:43:13 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id B8BF1400E125;
	Mon, 19 Jan 2009 23:43:07 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org, florian@openwrt.org
Subject: [PATCH 2/5] MIPS: rb532: fix set_latch_u5()
Date:	Mon, 19 Jan 2009 23:42:51 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1232404974-18497-1-git-send-email-n0-1@freewrt.org>
References: <1232404974-18497-1-git-send-email-n0-1@freewrt.org>
Message-Id: <20090119224307.B8BF1400E125@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

The data to be written is just a byte, so use writeb instead of writel.
Also, dev3.base contains the address, not the data so referencing here
is wrong.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 40deb11..7e0cb4f 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -93,7 +93,7 @@ void set_latch_u5(unsigned char or_mask, unsigned char nand_mask)
 	spin_lock_irqsave(&dev3.lock, flags);
 
 	dev3.state = (dev3.state | or_mask) & ~nand_mask;
-	writel(dev3.state, &dev3.base);
+	writeb(dev3.state, dev3.base);
 
 	spin_unlock_irqrestore(&dev3.lock, flags);
 }
-- 
1.5.6.4
