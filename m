Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2006 16:17:47 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52203 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20050072AbWLRQRm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2006 16:17:42 +0000
Received: from localhost (p8230-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A773FBC42; Tue, 19 Dec 2006 01:17:35 +0900 (JST)
Date:	Tue, 19 Dec 2006 01:17:35 +0900 (JST)
Message-Id: <20061219.011735.35857841.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix csum_partial_copy_from_user
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
X-archive-position: 13463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found that asm version of csum_partial_copy_from_user() introduced
in e9e016815f264227b6260f77ca84f1c43cf8b9bd was less effective.

For csum_partial_copy_from_user() case, "both_aligned" 8-word copy/sum
loop block is skipped to handle LOAD failure properly.  So we should
iterate 4-word copy/sum block for that case, otherwize we will loop at
ineffective "less_than_4units" block.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index ec0744d..0d6e9ae 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -488,8 +488,11 @@ EXC(	STORE	t2, UNIT(2)(dst),	s_exc)
 	ADDC(sum, t2)
 EXC(	STORE	t3, UNIT(3)(dst),	s_exc)
 	ADDC(sum, t3)
-	beqz	len, done
+	/* If we skipped both_aligned 8-word loop, iterate here */
+	bnez	AT, cleanup_both_aligned
 	 ADD	dst, dst, 4*NBYTES
+	beqz	len, done
+	 nop
 less_than_4units:
 	/*
 	 * rem = len % NBYTES
