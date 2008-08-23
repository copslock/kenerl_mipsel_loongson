Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2008 17:56:12 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:6539 "EHLO smtp4.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20027340AbYHWQzJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2008 17:55:09 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 28958FE2E7A;
	Sat, 23 Aug 2008 18:55:04 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 481103F0BA1;
	Sat, 23 Aug 2008 18:54:08 +0200 (CEST)
Received: from florian.maisel.int-evry.fr (unknown [157.159.47.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 336E490004;
	Sat, 23 Aug 2008 18:54:08 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sat, 23 Aug 2008 18:54:04 +0200
Subject: [PATCH 3/5] rb532: remove unused rc32434_sync_delay and rc32434_sync_udelay
MIME-Version: 1.0
X-UID:	1150
X-Length: 1467
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808231854.04839.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 481103F0BA1.2B4C0
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch removes these two unused functions :
rc32434_sync_delay and rc32434_sync_udelay

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/include/asm-mips/mach-rc32434/rc32434.h b/include/asm-mips/mach-rc32434/rc32434.h
index 9df04b7..fce25d4 100644
--- a/include/asm-mips/mach-rc32434/rc32434.h
+++ b/include/asm-mips/mach-rc32434/rc32434.h
@@ -16,16 +16,4 @@ static inline void rc32434_sync(void)
 	__asm__ volatile ("sync");
 }
 
-static inline void rc32434_sync_udelay(int us)
-{
-	__asm__ volatile ("sync");
-	udelay(us);
-}
-
-static inline void rc32434_sync_delay(int ms)
-{
-	__asm__ volatile ("sync");
-	mdelay(ms);
-}
-
 #endif  /* _ASM_RC32434_RC32434_H_ */
