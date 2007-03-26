Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 16:50:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:31192 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022845AbXCZPt7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 16:49:59 +0100
Received: from localhost (p8030-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.30])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0A898BC04; Tue, 27 Mar 2007 00:48:40 +0900 (JST)
Date:	Tue, 27 Mar 2007 00:48:39 +0900 (JST)
Message-Id: <20070327.004839.61947600.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] cleanup ret_from_exception
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
X-archive-position: 14700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Remove unnecessary local_irq_disable() from ret_from_exception.  The
local_irq_disable() came from preempt_stop macro which was removed by
recent cleanup.  And perhaps the preempt_stop macro had been wrong
since bf0b3bb876115b1e69b2266477128d8270d0b356.

This patch also cleanup __ret_from_irq which is not used now.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index 0b78fcb..6e4f766 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -22,20 +22,13 @@
 
 #ifndef CONFIG_PREEMPT
 #define resume_kernel	restore_all
-#else
-#define __ret_from_irq	ret_from_exception
 #endif
 
 	.text
 	.align	5
-#ifndef CONFIG_PREEMPT
-FEXPORT(ret_from_exception)
-	local_irq_disable			# preempt stop
-	b	__ret_from_irq
-#endif
 FEXPORT(ret_from_irq)
 	LONG_S	s0, TI_REGS($28)
-FEXPORT(__ret_from_irq)
+FEXPORT(ret_from_exception)
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER
 	beqz	t0, resume_kernel
