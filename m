Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 16:52:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:35048 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023088AbXGXPwb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 16:52:31 +0100
Received: from localhost (p1202-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.202])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B6F70B498; Wed, 25 Jul 2007 00:52:27 +0900 (JST)
Date:	Wed, 25 Jul 2007 00:53:29 +0900 (JST)
Message-Id: <20070725.005329.52130535.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/2] rbtx4927: fix a build error
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
X-archive-position: 15886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch fixes a build error caused by
-Werror-implicit-function-declaration.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/tx4927/common/tx4927_irq.c       |    3 +++
 include/asm-mips/tx4927/toshiba_rbtx4927.h |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
index 3d25d01..00b0b97 100644
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ b/arch/mips/tx4927/common/tx4927_irq.c
@@ -43,6 +43,9 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 #include <asm/tx4927/tx4927.h>
+#ifdef CONFIG_TOSHIBA_RBTX4927
+#include <asm/tx4927/toshiba_rbtx4927.h>
+#endif
 
 /*
  * DEBUG
diff --git a/include/asm-mips/tx4927/toshiba_rbtx4927.h b/include/asm-mips/tx4927/toshiba_rbtx4927.h
index 94bef03..5dc40a8 100644
--- a/include/asm-mips/tx4927/toshiba_rbtx4927.h
+++ b/include/asm-mips/tx4927/toshiba_rbtx4927.h
@@ -52,4 +52,6 @@
 #define RBTX4927_RTL_8019_BASE (0x1c020280-TBTX4927_ISA_IO_OFFSET)
 #define RBTX4927_RTL_8019_IRQ  (29)
 
+int toshiba_rbtx4927_irq_nested(int sw_irq);
+
 #endif /* __ASM_TX4927_TOSHIBA_RBTX4927_H */
