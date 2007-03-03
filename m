Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 17:44:38 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:51155 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037679AbXCCRod (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2007 17:44:33 +0000
Received: from localhost (p6054-ipad201funabasi.chiba.ocn.ne.jp [222.146.69.54])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6451BADDE; Sun,  4 Mar 2007 02:43:13 +0900 (JST)
Date:	Sun, 04 Mar 2007 02:43:13 +0900 (JST)
Message-Id: <20070304.024313.63742228.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Cleanup includes in early_printk.c
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
X-archive-position: 14334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 5a5f610..304efdc 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -7,10 +7,8 @@
  * Copyright (C) 2007 MIPS Technologies, Inc.
  *   written by Ralf Baechle (ralf@linux-mips.org)
  */
-#include <stdarg.h>
 #include <linux/console.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 
 extern void prom_putchar(char);
 
