Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 16:07:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:38109 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022395AbXGVPHx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2007 16:07:53 +0100
Received: from localhost (p4196-ipad02funabasi.chiba.ocn.ne.jp [61.207.151.196])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 79F9CB71A; Mon, 23 Jul 2007 00:06:33 +0900 (JST)
Date:	Mon, 23 Jul 2007 00:07:34 +0900 (JST)
Message-Id: <20070723.000734.08075709.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix marge error due to conflict in arch/mips/kernel/head.S
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

__INIT directive just before kernel_entry was dropped for most
(i.e. BOOT_RAW=n) platforms by merge accident (perhaps).  This patch
fixes it and get rid of this warning:

WARNING: vmlinux.o(.text+0x478): Section mismatch: reference to .init.text:start_kernel (between '_stext' and 'run_init_process')

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index f78538e..c15bbc4 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -141,7 +141,7 @@
 EXPORT(stext)					# used for profiling
 EXPORT(_stext)
 
-#ifdef CONFIG_BOOT_RAW
+#ifndef CONFIG_BOOT_RAW
 	/*
 	 * Give us a fighting chance of running if execution beings at the
 	 * kernel load address.  This is needed because this platform does
