Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 15:46:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:48338 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022753AbXEUOqi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 15:46:38 +0100
Received: from localhost (p1031-ipad32funabasi.chiba.ocn.ne.jp [221.189.133.31])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 16EC59EE0; Mon, 21 May 2007 23:45:19 +0900 (JST)
Date:	Mon, 21 May 2007 23:45:38 +0900 (JST)
Message-Id: <20070521.234538.15687337.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Move do_default_vi inside of CONFIG_CPU_MIPSR2_SRS
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
X-archive-position: 15108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes the warning:

arch/mips/kernel/traps.c:931: warning: 'do_default_vi' defined but not used

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 200de02..3f58b6a 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -927,12 +927,6 @@ asmlinkage void do_reserved(struct pt_regs *regs)
 	      (regs->cp0_cause & 0x7f) >> 2);
 }
 
-static asmlinkage void do_default_vi(void)
-{
-	show_regs(get_irq_regs());
-	panic("Caught unexpected vectored interrupt.");
-}
-
 /*
  * Some MIPS CPUs can enable/disable for cache parity detection, but do
  * it different ways.
@@ -1128,6 +1122,12 @@ void mips_srs_free(int set)
 	clear_bit(set, &sr->sr_allocated);
 }
 
+static asmlinkage void do_default_vi(void)
+{
+	show_regs(get_irq_regs());
+	panic("Caught unexpected vectored interrupt.");
+}
+
 static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 {
 	unsigned long handler;
