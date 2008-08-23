Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2008 17:54:59 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:16044 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20027061AbYHWQyu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 Aug 2008 17:54:50 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id B293EFE2E7A;
	Sat, 23 Aug 2008 18:54:45 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 795703F0BB0;
	Sat, 23 Aug 2008 18:53:29 +0200 (CEST)
Received: from florian.maisel.int-evry.fr (unknown [157.159.47.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 2784790004;
	Sat, 23 Aug 2008 18:53:29 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sat, 23 Aug 2008 18:53:24 +0200
Subject: [PATCH 1/5] rb532: remove obsolute reference to setup_serial_port
MIME-Version: 1.0
X-UID:	1148
X-Length: 1270
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808231853.25310.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 795703F0BB0.21545
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

We are no longer using setup_serial_port. So just remove it
from the prom code.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index c5d8868..46ca24d 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -37,8 +37,6 @@
 #include <asm/mach-rc32434/ddr.h>
 #include <asm/mach-rc32434/prom.h>
 
-extern void __init setup_serial_port(void);
-
 unsigned int idt_cpu_freq = 132000000;
 EXPORT_SYMBOL(idt_cpu_freq);
