Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 17:17:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:58593 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22304553AbYJXQRM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 17:17:12 +0100
Received: from localhost.localdomain (p4039-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A50AAAD22; Sat, 25 Oct 2008 01:17:05 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Set positive error number to errno on illegal_syscall
Date:	Sat, 25 Oct 2008 01:17:22 +0900
Message-Id: <1224865043-3430-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/scall32-o32.S |    2 +-
 arch/mips/kernel/scall64-64.S  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 5e75a31..ffa23bd 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -180,7 +180,7 @@ bad_stack:
 	 * The system call does not exist in this kernel
 	 */
 illegal_syscall:
-	li	v0, -ENOSYS			# error
+	li	v0, ENOSYS			# error
 	sw	v0, PT_R2(sp)
 	li	t0, 1				# set error flag
 	sw	t0, PT_R7(sp)
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 3d58204..a9e1716 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -117,7 +117,7 @@ syscall_trace_entry:
 
 illegal_syscall:
 	/* This also isn't a 64-bit syscall, throw an error.  */
-	li	v0, -ENOSYS			# error
+	li	v0, ENOSYS			# error
 	sd	v0, PT_R2(sp)
 	li	t0, 1				# set error flag
 	sd	t0, PT_R7(sp)
-- 
1.5.6.3
