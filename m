Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2006 15:55:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43716 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28641790AbWLZPzH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2006 15:55:07 +0000
Received: from localhost (p3075-ipad23funabasi.chiba.ocn.ne.jp [220.104.81.75])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E08F9CB0F; Wed, 27 Dec 2006 00:55:03 +0900 (JST)
Date:	Wed, 27 Dec 2006 00:55:03 +0900 (JST)
Message-Id: <20061227.005503.130850571.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/3] Export __csum_partial_copy_user helper function
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
X-archive-position: 13518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Export a helper function for csum_partial_copy_from_user and
csum_and_copy_to_user.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index a896620..2ef857c 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -47,5 +47,6 @@ EXPORT_SYMBOL(__strnlen_user_asm);
 
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
+EXPORT_SYMBOL(__csum_partial_copy_user);
 
 EXPORT_SYMBOL(invalid_pte_table);
