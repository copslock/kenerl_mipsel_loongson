Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 20:10:22 +0100 (BST)
Received: from mx1.minet.net ([157.159.40.25]:26055 "EHLO mx1.minet.net")
	by ftp.linux-mips.org with ESMTP id S20024546AbXJYTKO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2007 20:10:14 +0100
Received: from localhost (unknown [192.168.1.97])
	by mx1.minet.net (Postfix) with ESMTP id 6ADC65CD87
	for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 21:09:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at minet.net
Received: from smtp.minet.net (imap.minet.net [192.168.1.27])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.minet.net (Postfix) with ESMTP id 944345CD20
	for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 21:08:50 +0200 (CEST)
Received: from [192.168.254.22] (vpn1.minet.net [192.168.1.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: florian)
	by smtp.minet.net (Postfix) with ESMTP id 4C059D951
	for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 10:24:34 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Thu, 25 Oct 2007 21:08:42 +0200
Subject: [PATCH][au1000] Remove useless EXTRA_CFLAGS
MIME-Version: 1.0
X-UID:	134
X-Length: 1256
To:	linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710252108.43357.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Remove the EXTRA_CFLAGS because it is useless (code compiles without warnings).

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/arch/mips/au1000/common/Makefile b/arch/mips/au1000/common/Makefile
index 90e2d7a..4c35525 100644
--- a/arch/mips/au1000/common/Makefile
+++ b/arch/mips/au1000/common/Makefile
@@ -12,5 +12,3 @@ obj-y += prom.o irq.o puts.o time.o reset.o \
 
 obj-$(CONFIG_KGDB)		+= dbg_io.o
 obj-$(CONFIG_PCI)		+= pci.o
-
-EXTRA_CFLAGS += -Werror
