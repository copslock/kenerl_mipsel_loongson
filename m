Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 17:04:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59615 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039901AbWJJQEt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 17:04:49 +0100
Received: from localhost (p3213-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 201CEA3CC; Wed, 11 Oct 2006 01:04:45 +0900 (JST)
Date:	Wed, 11 Oct 2006 01:07:01 +0900 (JST)
Message-Id: <20061011.010701.108289252.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] asm-mips/irq.h does not need pt_regs anymore
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
X-archive-position: 12875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/irq.h b/include/asm-mips/irq.h
index 1a9804c..0ce2a80 100644
--- a/include/asm-mips/irq.h
+++ b/include/asm-mips/irq.h
@@ -24,8 +24,6 @@ #else
 #define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
-struct pt_regs;
-
 extern asmlinkage unsigned int do_IRQ(unsigned int irq);
 
 #ifdef CONFIG_MIPS_MT_SMTC
