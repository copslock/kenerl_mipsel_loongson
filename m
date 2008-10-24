Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 17:17:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:738 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22304552AbYJXQRM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 17:17:12 +0100
Received: from localhost.localdomain (p4039-ipad210funabasi.chiba.ocn.ne.jp [58.88.123.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E34CBA9C7; Sat, 25 Oct 2008 01:17:05 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Set ENOSYS to errno on illegal system call number for syscall(2)
Date:	Sat, 25 Oct 2008 01:17:23 +0900
Message-Id: <1224865043-3430-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/scall32-o32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index ffa23bd..759f680 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -293,7 +293,7 @@ bad_alignment:
 	jr	t2
 	/* Unreached */
 
-einval:	li	v0, -EINVAL
+einval:	li	v0, -ENOSYS
 	jr	ra
 	END(sys_syscall)
 
-- 
1.5.6.3
