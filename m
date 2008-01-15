Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 18:48:25 +0000 (GMT)
Received: from smtp4.int-evry.fr ([157.159.10.71]:6078 "EHLO smtp4.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20037823AbYAOSsP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 18:48:15 +0000
Received: from smtp1.int-evry.fr (smtp1.int-evry.fr [157.159.10.44])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 09AA6350899;
	Tue, 15 Jan 2008 19:48:09 +0100 (CET)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 5C8038E6B87;
	Tue, 15 Jan 2008 19:46:55 +0100 (CET)
Received: from mini.int.alphacore.net (unknown [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 45A728D1696;
	Tue, 15 Jan 2008 19:46:55 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Tue, 15 Jan 2008 19:42:57 +0100
Subject: [PATCH] Cobalt 64-bits kernels can be safely unmarked experimental
MIME-Version: 1.0
X-UID:	272
X-Length: 1265
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801151942.58038.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch removes the condition on
CONFIG_EXPERIMENTAL since 64-bits
cobalt kernels runs fine.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b22c043..da5c723 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -82,7 +82,7 @@ config MIPS_COBALT
 	select SYS_HAS_CPU_NEVADA
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
+	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select GENERIC_HARDIRQS_NO__DO_IRQ
