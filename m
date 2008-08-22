Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 16:02:26 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:4826 "EHLO smtp4.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20034754AbYHVPCV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 16:02:21 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 9DCCAFE2EE3;
	Fri, 22 Aug 2008 17:02:15 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 41A2C3ED4BD;
	Fri, 22 Aug 2008 17:02:06 +0200 (CEST)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 5026290004;
	Fri, 22 Aug 2008 17:02:06 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 17:02:03 +0200
Subject: [PATCH 4/5] rb532: replace raw volatile read with a readl
MIME-Version: 1.0
X-UID:	1141
X-Length: 1361
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808221702.03384.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 41A2C3ED4BD.E7283
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch replaces a raw read using volatiles
with a readl.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 0628d8d..6782127 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -70,7 +70,7 @@ void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val)
 
 	spin_lock_irqsave(&dev3.lock, flags);
 
-	data = *(volatile unsigned *) (IDT434_REG_BASE + reg_offs);
+	data = readl(IDT434_REG_BASE + reg_offs);
 	for (i = 0; i != len; ++i) {
 		if (val & (1 << i))
 			data |= (1 << (i + bit));
