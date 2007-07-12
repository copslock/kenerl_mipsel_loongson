Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:50:16 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:20189 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022561AbXGLQuO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 17:50:14 +0100
Received: from localhost (p7217-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 62EB2A19F; Fri, 13 Jul 2007 01:48:54 +0900 (JST)
Date:	Fri, 13 Jul 2007 01:49:49 +0900 (JST)
Message-Id: <20070713.014949.55147875.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Use NULL for pointer
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
X-archive-position: 15743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes a sparse warning:

arch/mips/kernel/traps.c:376:44: warning: Using plain integer as NULL pointer

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 80ea4fa..5e9fa83 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -373,7 +373,7 @@ asmlinkage void do_be(struct pt_regs *regs)
 		action = MIPS_BE_FIXUP;
 
 	if (board_be_handler)
-		action = board_be_handler(regs, fixup != 0);
+		action = board_be_handler(regs, fixup != NULL);
 
 	switch (action) {
 	case MIPS_BE_DISCARD:
