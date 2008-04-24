Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2008 15:08:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:32706 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28780189AbYDXOH6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Apr 2008 15:07:58 +0100
Received: from localhost (p8067-ipad312funabasi.chiba.ocn.ne.jp [123.217.226.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B578799BC; Thu, 24 Apr 2008 23:07:54 +0900 (JST)
Date:	Thu, 24 Apr 2008 23:08:55 +0900 (JST)
Message-Id: <20080424.230855.18313404.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] kill unnecessary include
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
X-archive-position: 19012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/cevt-gt641xx.c b/arch/mips/kernel/cevt-gt641xx.c
index c367726..6e2f585 100644
--- a/arch/mips/kernel/cevt-gt641xx.c
+++ b/arch/mips/kernel/cevt-gt641xx.c
@@ -25,8 +25,6 @@
 #include <asm/gt64120.h>
 #include <asm/time.h>
 
-#include <irq.h>
-
 static DEFINE_SPINLOCK(gt641xx_timer_lock);
 static unsigned int gt641xx_base_clock;
 
