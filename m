Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 15:25:20 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:37314 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20035754AbYFXOZQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2008 15:25:16 +0100
Received: from localhost (p7203-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.203])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3AAEBAD23; Tue, 24 Jun 2008 23:25:09 +0900 (JST)
Date:	Tue, 24 Jun 2008 23:26:38 +0900 (JST)
Message-Id: <20080624.232638.93018712.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] cevt-txx9: Reset timer counter on initialize
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
X-archive-position: 19613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The txx9_tmr_init() will not clear a timer counter register on certain
case.  The counter register is cleared on 1->0 transition of TCE bit
if CRE=1.  So just clearing TCE bit is not enough.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/cevt-txx9.c b/arch/mips/kernel/cevt-txx9.c
index 795cb8f..b5fc4eb 100644
--- a/arch/mips/kernel/cevt-txx9.c
+++ b/arch/mips/kernel/cevt-txx9.c
@@ -161,6 +161,9 @@ void __init txx9_tmr_init(unsigned long baseaddr)
 	struct txx9_tmr_reg __iomem *tmrptr;
 
 	tmrptr = ioremap(baseaddr, sizeof(struct txx9_tmr_reg));
+	/* Start once to make CounterResetEnable effective */
+	__raw_writel(TXx9_TMTCR_CRE | TXx9_TMTCR_TCE, &tmrptr->tcr);
+	/* Stop and reset the counter */
 	__raw_writel(TXx9_TMTCR_CRE, &tmrptr->tcr);
 	__raw_writel(0, &tmrptr->tisr);
 	__raw_writel(0xffffffff, &tmrptr->cpra);
