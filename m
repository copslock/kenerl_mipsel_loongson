Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 16:56:31 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:46224 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20191411AbYIKP41 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Sep 2008 16:56:27 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 9C3A0FE205A;
	Thu, 11 Sep 2008 17:56:21 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 4E5913F06DB;
	Thu, 11 Sep 2008 17:55:54 +0200 (CEST)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 3D8CB90003;
	Thu, 11 Sep 2008 17:55:54 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 11 Sep 2008 17:55:41 +0200
Subject: [PATCH] rb532: do not use phys_t
MIME-Version: 1.0
X-UID:	1218
X-Length: 1358
To:	ralf@linux-mips.org
Cc:	Linux MIPS Org <linux-mips@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809111755.41730.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 4E5913F06DB.E0BCD
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

MIPS include types.h says that using phys_t is bad, which in
fact is an unsigned long, so use an unsigned long directly.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 46ca24d..c37ceda 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -123,8 +123,8 @@ void __init prom_setup_cmdline(void)
 void __init prom_init(void)
 {
 	struct ddr_ram __iomem *ddr;
-	phys_t memsize;
-	phys_t ddrbase;
+	unsigned long memsize;
+	unsigned long ddrbase;
 
 	ddr = ioremap_nocache(ddr_reg[0].start,
 			ddr_reg[0].end - ddr_reg[0].start);
