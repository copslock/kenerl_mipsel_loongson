Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 16:23:49 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:61668 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039334AbXB1QXn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2007 16:23:43 +0000
Received: from localhost (p5152-ipad28funabasi.chiba.ocn.ne.jp [220.107.204.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 58294A704; Thu,  1 Mar 2007 01:22:23 +0900 (JST)
Date:	Thu, 01 Mar 2007 01:22:23 +0900 (JST)
Message-Id: <20070301.012223.129448787.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	netdev@vger.kernel.org
Subject: [PATCH] Fix broken RBTX4927 support in ne.c
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
X-archive-position: 14278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

There are some ifdefs for RBTX4927, but need some more bits.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/drivers/net/ne.c b/drivers/net/ne.c
index a5c4199..02cc78b 100644
--- a/drivers/net/ne.c
+++ b/drivers/net/ne.c
@@ -55,8 +55,10 @@ static const char version2[] =
 #include <asm/system.h>
 #include <asm/io.h>
 
-#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
+#if defined(CONFIG_TOSHIBA_RBTX4938)
 #include <asm/tx4938/rbtx4938.h>
+#elif defined(CONFIG_TOSHIBA_RBTX4927)
+#include <asm/tx4927/toshiba_rbtx4927.h>
 #endif
 
 #include "8390.h"
@@ -229,6 +231,9 @@ struct net_device * __init ne_probe(int unit)
 #ifdef CONFIG_TOSHIBA_RBTX4938
 	dev->base_addr = RBTX4938_RTL_8019_BASE;
 	dev->irq = RBTX4938_RTL_8019_IRQ;
+#elif defined(CONFIG_TOSHIBA_RBTX4927)
+	dev->base_addr = RBTX4927_RTL_8019_BASE;
+	dev->irq = RBTX4927_RTL_8019_IRQ;
 #endif
 	err = do_ne_probe(dev);
 	if (err)
