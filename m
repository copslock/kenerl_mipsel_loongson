Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 04:10:37 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:1067 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037521AbWH2DKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 04:10:34 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 29 Aug 2006 12:10:32 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A59B320483;
	Tue, 29 Aug 2006 12:10:23 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9926220178;
	Tue, 29 Aug 2006 12:10:23 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7T3AMW0036732;
	Tue, 29 Aug 2006 12:10:23 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 29 Aug 2006 12:10:22 +0900 (JST)
Message-Id: <20060829.121022.130240504.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, vagabon.xyz@gmail.com
Subject: [PATCH] make prepare_frametrace() not clobber v0
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Since lmo commit 323a380bf9e1a1679a774a2b053e3c1f2aa3f179 ("Simplify
dump_stack()") made prepare_frametrace() always inlined, using $2 (v0)
in __asm__ is not safe anymore.  We can use $1 (at) instead.  Also we
should use "dla" instead of "la" for 64-bit kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 traps.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ab77034..e51d8fd 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -161,16 +161,20 @@ static void show_stacktrace(struct task_
 static __always_inline void prepare_frametrace(struct pt_regs *regs)
 {
 	__asm__ __volatile__(
-		"1: la $2, 1b\n\t"
+		".set push\n\t"
+		".set noat\n\t"
 #ifdef CONFIG_64BIT
-		"sd $2, %0\n\t"
+		"1: dla $1, 1b\n\t"
+		"sd $1, %0\n\t"
 		"sd $29, %1\n\t"
 		"sd $31, %2\n\t"
 #else
-		"sw $2, %0\n\t"
+		"1: la $1, 1b\n\t"
+		"sw $1, %0\n\t"
 		"sw $29, %1\n\t"
 		"sw $31, %2\n\t"
 #endif
+		".set pop\n\t"
 		: "=m" (regs->cp0_epc),
 		"=m" (regs->regs[29]), "=m" (regs->regs[31])
 		: : "memory");
