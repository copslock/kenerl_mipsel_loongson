Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 18:09:38 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:34445 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28588295AbYGRRJg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 18:09:36 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m6IH8is6023206;
	Fri, 18 Jul 2008 10:09:20 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 Jul 2008 10:08:48 -0700
Received: from localhost.localdomain ([172.25.32.36]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 Jul 2008 10:08:48 -0700
From:	Jason Wessel <jason.wessel@windriver.com>
To:	linux-kernel@vger.kernel.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Jason Wessel <jason.wessel@windriver.com>
Subject: [PATCH 3/3] kgdb, mips: pad pt_regs on MIPS64 for function arguments in an exception
Date:	Fri, 18 Jul 2008 12:08:48 -0500
Message-Id: <1216400928-29097-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1216400928-29097-3-git-send-email-jason.wessel@windriver.com>
References: <1216400928-29097-1-git-send-email-jason.wessel@windriver.com>
 <1216400928-29097-2-git-send-email-jason.wessel@windriver.com>
 <1216400928-29097-3-git-send-email-jason.wessel@windriver.com>
X-OriginalArrivalTime: 18 Jul 2008 17:08:48.0301 (UTC) FILETIME=[F19A3DD0:01C8E8F8]
Return-Path: <jason.wessel@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.wessel@windriver.com
Precedence: bulk
X-list: linux-mips

When using KGDB the pt_regs structure has the function arguments saved
to the stack.  48 bytes are required for MIPS 64 for this purpose.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 include/asm-mips/ptrace.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/ptrace.h b/include/asm-mips/ptrace.h
index 786f7e3..c3f535f 100644
--- a/include/asm-mips/ptrace.h
+++ b/include/asm-mips/ptrace.h
@@ -28,7 +28,7 @@
  * system call/exception. As usual the registers k0/k1 aren't being saved.
  */
 struct pt_regs {
-#ifdef CONFIG_32BIT
+#if defined(CONFIG_32BIT) || defined(CONFIG_KGDB)
 	/* Pad bytes for argument save space on the stack. */
 	unsigned long pad0[6];
 #endif
-- 
1.5.5.1
