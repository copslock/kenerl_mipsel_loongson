Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 16:56:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:6866 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021479AbXGKP4F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 16:56:05 +0100
Received: from localhost (p7242-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 087C5BE1D; Thu, 12 Jul 2007 00:54:46 +0900 (JST)
Date:	Thu, 12 Jul 2007 00:55:40 +0900 (JST)
Message-Id: <20070712.005540.78730346.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Include cacheflush.h in uncache.c
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
X-archive-position: 15704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes this sparse warning:

arch/mips/lib/uncached.c:38:22: warning: symbol 'run_uncached' was not declared. Should it be static?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
index 2388f7f..58d14f4 100644
--- a/arch/mips/lib/uncached.c
+++ b/arch/mips/lib/uncached.c
@@ -12,6 +12,7 @@
 
 #include <asm/addrspace.h>
 #include <asm/bug.h>
+#include <asm/cacheflush.h>
 
 #ifndef CKSEG2
 #define CKSEG2 CKSSEG
