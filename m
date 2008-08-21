Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 23:16:37 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:17859 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28587002AbYHUWPk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 23:15:40 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 5C21AFE2E23;
	Fri, 22 Aug 2008 00:15:39 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 6E7453F00B2;
	Fri, 22 Aug 2008 00:15:03 +0200 (CEST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 490C790004;
	Fri, 22 Aug 2008 00:15:03 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 00:15:01 +0200
Subject: [PATCH 5/6] rb532: replace volatile rough read with a readl
MIME-Version: 1.0
X-UID:	1121
X-Length: 1366
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808220015.02151.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 6E7453F00B2.6BE60
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch replaces a rough read using volatiles
with a readl.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 3d1632c..d44a703 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -70,7 +70,7 @@ void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val)
 
 	spin_lock_irqsave(&dev3.lock, flags);
 
-	data = *(volatile unsigned *) (IDT434_REG_BASE + reg_offs);
+	data = readl(IDT434_REG_BASE + reg_offs);
 	for (i = 0; i != len; ++i) {
 		if (val & (1 << i))
 			data |= (1 << (i + bit));
