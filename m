Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 16:06:57 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:33786 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022947AbXKFQGs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2007 16:06:48 +0000
Received: from localhost (p4065-ipad306funabasi.chiba.ocn.ne.jp [123.217.174.65])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 946AC971B; Wed,  7 Nov 2007 01:06:44 +0900 (JST)
Date:	Wed, 07 Nov 2007 01:08:48 +0900 (JST)
Message-Id: <20071107.010848.37531337.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix typo in R3000 TRACE_IRQFLAGS code
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
X-archive-position: 17423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index c0f19d6..e76a76b 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -146,7 +146,7 @@ NESTED(handle_int, PT_SIZE, sp)
 	and	k0, ST0_IEP
 	bnez	k0, 1f
 
-	mfc0	k0, EP0_EPC
+	mfc0	k0, CP0_EPC
 	.set	noreorder
 	j	k0
 	rfe
