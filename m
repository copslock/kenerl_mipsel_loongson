Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 15:55:53 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:61381 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039429AbXBRPzs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2007 15:55:48 +0000
Received: from localhost (p2027-ipad11funabasi.chiba.ocn.ne.jp [219.162.37.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 66373AC88; Mon, 19 Feb 2007 00:54:27 +0900 (JST)
Date:	Mon, 19 Feb 2007 00:54:27 +0900 (JST)
Message-Id: <20070219.005427.126141810.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make kernel_thread_helper() static
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 9704c21..a669089 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -213,7 +213,7 @@ int dump_task_fpu (struct task_struct *t
 /*
  * Create a kernel thread
  */
-ATTRIB_NORET void kernel_thread_helper(void *arg, int (*fn)(void *))
+static ATTRIB_NORET void kernel_thread_helper(void *arg, int (*fn)(void *))
 {
 	do_exit(fn(arg));
 }
