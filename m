Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2008 17:33:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:43772 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S30624753AbYDYQdm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2008 17:33:42 +0100
Received: from localhost (p6035-ipad308funabasi.chiba.ocn.ne.jp [123.217.192.35])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5A9FCBD94; Sat, 26 Apr 2008 01:33:33 +0900 (JST)
Date:	Sat, 26 Apr 2008 01:34:35 +0900 (JST)
Message-Id: <20080426.013435.70475327.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix some sparse warnings
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
X-archive-position: 19020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix some sparse warnings introduced by "[MIPS] Add support for MIPS
CMP platform." patch.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/kernel/traps.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 070f787..8686133 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -196,12 +196,12 @@ EXPORT_SYMBOL(dump_stack);
 static void show_code(unsigned int __user *pc)
 {
 	long i;
-	unsigned short *pc16 = NULL;
+	unsigned short __user *pc16 = NULL;
 
 	printk("\nCode:");
 
-	if ((unsigned int)pc & 1)
-		pc16 = (unsigned short *)((unsigned int)pc & ~1);
+	if ((unsigned long)pc & 1)
+		pc16 = (unsigned short __user *)((unsigned long)pc & ~1);
 	for(i = -3 ; i < 6 ; i++) {
 		unsigned int insn;
 		if (pc16 ? __get_user(insn, pc16 + i) : __get_user(insn, pc + i)) {
