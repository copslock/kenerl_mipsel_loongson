Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 18:00:29 +0000 (GMT)
Received: from smtp1.int-evry.fr ([157.159.10.44]:17044 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20031575AbYANSAV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 18:00:21 +0000
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id DC32E8E97E6;
	Mon, 14 Jan 2008 19:00:05 +0100 (CET)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id E65C38D1696;
	Mon, 14 Jan 2008 19:00:05 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Mon, 14 Jan 2008 19:00:01 +0100
Subject: [PATCH] Kill Broadcom machine group
MIME-Version: 1.0
X-UID:	270
X-Length: 1248
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801141900.02601.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch removes the remaining MACH_GROUP that
was still present for Broadcom boards.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index b2dd9b3..070a957 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -195,8 +195,7 @@
 /*
  * Valid machtype for group Broadcom
  */
-#define MACH_GROUP_BRCM		23	/* Broadcom			*/
-#define  MACH_BCM47XX		1	/* Broadcom BCM47XX		*/
+#define MACH_BCM47XX		1	/* Broadcom BCM47XX		*/
 
 #define CL_SIZE			COMMAND_LINE_SIZE
 
