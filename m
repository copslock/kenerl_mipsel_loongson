Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2008 14:30:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:60623 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025856AbYGaNaC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2008 14:30:02 +0100
Received: from localhost (p6107-ipad313funabasi.chiba.ocn.ne.jp [123.217.232.107])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C1194C330; Thu, 31 Jul 2008 22:29:55 +0900 (JST)
Date:	Thu, 31 Jul 2008 22:29:53 +0900 (JST)
Message-Id: <20080731.222953.128619433.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: Fix mips_hpt_frequency initialization
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
X-archive-position: 20062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The mips_hpt_frequency initialization code was lost in commit
94a4c32939dede9328c6e4face335eb8441fc18d ("TXx9: Add 64-bit support").

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 1bc57d0..0afe94c 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -328,6 +328,9 @@ void __init arch_init_irq(void)
 
 void __init plat_time_init(void)
 {
+#ifdef CONFIG_CPU_TX49XX
+	mips_hpt_frequency = txx9_cpu_clock / 2;
+#endif
 	txx9_board_vec->time_init();
 }
 
