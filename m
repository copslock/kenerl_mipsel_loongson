Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 17:26:54 +0100 (BST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:55724 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28581182AbYGPQ0Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 17:26:25 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 62B7D5BC02E;
	Wed, 16 Jul 2008 19:26:25 +0300 (EEST)
Date:	Wed, 16 Jul 2008 19:26:15 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [2.6 patch] mips: don't leak setup_early_printk() in userspace
	header
Message-ID: <20080716162615.GE17329@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Our userspace headers shouldn't contain prototypes of in-kernel 
functions.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
e584bcde154a4d9cdf8db2fc0b4250751d53f1a0 
diff --git a/include/asm-mips/setup.h b/include/asm-mips/setup.h
index 883f59b..e600ced 100644
--- a/include/asm-mips/setup.h
+++ b/include/asm-mips/setup.h
@@ -3,6 +3,8 @@
 
 #define COMMAND_LINE_SIZE	256
 
+#ifdef  __KERNEL__
 extern void setup_early_printk(void);
+#endif /* __KERNEL__ */
 
 #endif /* __SETUP_H */
