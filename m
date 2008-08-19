Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 20:28:55 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:3990 "EHLO smtp4.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S28580874AbYHST2p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 20:28:45 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id C7476FE2E28;
	Tue, 19 Aug 2008 21:28:39 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 8FF8E3EE0E5;
	Tue, 19 Aug 2008 21:28:23 +0200 (CEST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 672A390002;
	Tue, 19 Aug 2008 21:28:23 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
Date:	Tue, 19 Aug 2008 21:28:21 +0200
Subject: [PATCH] Ignore vmlinux.lds generated files
MIME-Version: 1.0
X-UID:	1111
X-Length: 1159
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808192128.21386.florian.fainelli@telecomint.eu>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 8FF8E3EE0E5.9D662
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

This patch adds the proper .gitignore file to ignore
vmlinux.lds generated in arch/mips/kernel/.

Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
---
diff --git a/arch/mips/kernel/.gitignore b/arch/mips/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/mips/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
