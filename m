Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 12:23:14 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:47612 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029602AbYANMXE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2008 12:23:04 +0000
Received: from localhost (p1181-ipad210funabasi.chiba.ocn.ne.jp [58.88.120.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AF88D9B23; Mon, 14 Jan 2008 21:22:58 +0900 (JST)
Date:	Mon, 14 Jan 2008 21:22:53 +0900 (JST)
Message-Id: <20080114.212253.126142719.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] prom_free_prom_memory for QEMU
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
X-archive-position: 18019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

You can get 60kb more memory by this patch.  Note that this patch
might cause segfault on some intermediate version of qemu 0.9.0 and
0.9.1 (For example Debian qemu-0.9.0+20070816-1).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/qemu/q-mem.c b/arch/mips/qemu/q-mem.c
index dae39b5..84cbee2 100644
--- a/arch/mips/qemu/q-mem.c
+++ b/arch/mips/qemu/q-mem.c
@@ -1,5 +1,9 @@
 #include <linux/init.h>
+#include <asm/bootinfo.h>
+#include <asm/sections.h>
+#include <asm/page.h>
 
 void __init prom_free_prom_memory(void)
 {
+	free_init_pages("prom memory", PAGE_SIZE, __pa_symbol(&_text));
 }
