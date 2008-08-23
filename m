Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2008 17:56:36 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:28544 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20027613AbYHWQzR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 Aug 2008 17:55:17 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 1582FFE2E7A;
	Sat, 23 Aug 2008 18:55:12 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 9213B3F07FD;
	Sat, 23 Aug 2008 18:54:41 +0200 (CEST)
Received: from florian.maisel.int-evry.fr (unknown [157.159.47.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 0CB7090004;
	Sat, 23 Aug 2008 18:54:41 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sat, 23 Aug 2008 18:54:37 +0200
Subject: [PATCH 5/5] Documentation: document the rb532 specific kmac tag
MIME-Version: 1.0
X-UID:	1152
X-Length: 1527
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808231854.37671.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 9213B3F07FD.93937
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

The Routerboard 532 bootloader passes the korina ethernet
MAC adapter address to the kernel on the command line.
Document this in the kernel-parameters file.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a897646..f9fb4e8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1020,6 +1020,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			(only serial suported for now)
 			Format: <serial_device>[,baud]
 
+	kmac=		[MIPS] korina ethernet MAC address.
+			Configure the RouterBoard 532 series on-chip
+			Ethernet adapter MAC address.
+
 	l2cr=		[PPC]
 
 	l3cr=		[PPC]
