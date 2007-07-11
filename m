Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 16:50:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:51946 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021603AbXGKPuK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 16:50:10 +0100
Received: from localhost (p7242-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 99CDBB8E9; Thu, 12 Jul 2007 00:50:06 +0900 (JST)
Date:	Thu, 12 Jul 2007 00:51:00 +0900 (JST)
Message-Id: <20070712.005100.108981009.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Cleanup tlbdebug.h
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
X-archive-position: 15703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Also include tlbdebug.h in dump_tlb.c and r3k_dump_tlb.c.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib/dump_tlb.c     |    1 +
 arch/mips/lib/r3k_dump_tlb.c |    1 +
 include/asm-mips/tlbdebug.h  |    4 ----
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 1a4db7d..465ff0e 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -10,6 +10,7 @@
 #include <asm/mipsregs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/tlbdebug.h>
 
 static inline const char *msk2str(unsigned int mask)
 {
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 52f8779..9cee907 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -11,6 +11,7 @@
 #include <asm/mipsregs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/tlbdebug.h>
 
 extern int r3k_have_wired_reg;	/* defined in tlb-r3k.c */
 
diff --git a/include/asm-mips/tlbdebug.h b/include/asm-mips/tlbdebug.h
index fff7a73..bb8f5c2 100644
--- a/include/asm-mips/tlbdebug.h
+++ b/include/asm-mips/tlbdebug.h
@@ -11,10 +11,6 @@
 /*
  * TLB debugging functions:
  */
-extern void dump_tlb(int first, int last);
 extern void dump_tlb_all(void);
-extern void dump_tlb_wired(void);
-extern void dump_tlb_addr(unsigned long addr);
-extern void dump_tlb_nonwired(void);
 
 #endif /* __ASM_TLBDEBUG_H */
