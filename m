Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2008 15:05:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:5077 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029867AbYHKOFh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2008 15:05:37 +0100
Received: from localhost (p7054-ipad312funabasi.chiba.ocn.ne.jp [123.217.225.54])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 03C49A9A3; Mon, 11 Aug 2008 23:05:31 +0900 (JST)
Date:	Mon, 11 Aug 2008 23:05:35 +0900 (JST)
Message-Id: <20080811.230535.25909452.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	Jason Wessel <jason.wessel@windriver.com>, ralf@linux-mips.org
Subject: [PATCH] kgdb: Do not call fixup_exception
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
X-archive-position: 20169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

kgdb_mips_notify is called on IBE/DBE/FPE/BP/TRAP/RI exception.  None
of them need fixup.  And doing fixup for a breakpoint exception will
confuse gdb.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This is a patch against current kernel.org git tree.

diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index c5a8b2d..cdaa4e3 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -190,9 +190,6 @@ static int kgdb_mips_notify(struct notifier_block *self, unsigned long cmd,
 	struct pt_regs *regs = args->regs;
 	int trap = (regs->cp0_cause & 0x7c) >> 2;
 
-	if (fixup_exception(regs))
-		return NOTIFY_DONE;
-
 	/* Userpace events, ignore. */
 	if (user_mode(regs))
 		return NOTIFY_DONE;
