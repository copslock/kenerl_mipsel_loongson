Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2007 18:49:26 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:29407 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024735AbXIHRtR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Sep 2007 18:49:17 +0100
Received: from localhost (p5230-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 182CED6A1; Sun,  9 Sep 2007 02:49:14 +0900 (JST)
Date:	Sun, 09 Sep 2007 02:50:42 +0900 (JST)
Message-Id: <20070909.025042.59651132.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Kill redundant EXTRA_AFLAGS (again)
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
X-archive-position: 16427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Kill redundant EXTRA_AFLAGS added after the commit
d2af363cfb94f1bacb3e60327bc44a97881a38c2.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lemote/lm2e/Makefile   |    1 -
 arch/mips/sibyte/common/Makefile |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
index dcaf6f4..d34671d 100644
--- a/arch/mips/lemote/lm2e/Makefile
+++ b/arch/mips/lemote/lm2e/Makefile
@@ -4,5 +4,4 @@
 
 obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
 
-EXTRA_AFLAGS := $(CFLAGS)
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sibyte/common/Makefile b/arch/mips/sibyte/common/Makefile
index f8ae300..48a91b9 100644
--- a/arch/mips/sibyte/common/Makefile
+++ b/arch/mips/sibyte/common/Makefile
@@ -2,5 +2,4 @@ obj-y :=
 
 obj-$(CONFIG_SIBYTE_TBPROF)		+= sb_tbprof.o
 
-EXTRA_AFLAGS := $(CFLAGS)
 EXTRA_CFLAGS += -Werror
