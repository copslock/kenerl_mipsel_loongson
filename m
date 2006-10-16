Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 14:46:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34546 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039602AbWJPNqd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2006 14:46:33 +0100
Received: from localhost (p8069-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.69])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F2C2D734C; Mon, 16 Oct 2006 22:46:29 +0900 (JST)
Date:	Mon, 16 Oct 2006 22:48:49 +0900 (JST)
Message-Id: <20061016.224849.108121676.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] save_context_stack fix
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
X-archive-position: 12965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

CONFIG_KALLSYMS=n case is obviously wrong, though it is harmless since
CONFIG_KALLSYMS is always enabled with CONFIG_STACKTRACE for now.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/stacktrace.c b/arch/mips/kernel/stacktrace.c
index 4aabe52..a586aba 100644
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -57,7 +57,7 @@ #ifdef CONFIG_KALLSYMS
 		pc = unwind_stack(task, &sp, pc, &ra);
 	} while (pc);
 #else
-	save_raw_context_stack(sp);
+	save_raw_context_stack(trace, sp);
 #endif
 }
 
