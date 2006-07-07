Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 06:26:59 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:53713 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S3466138AbWGGF0u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Jul 2006 06:26:50 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 7 Jul 2006 14:26:48 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B40A9202F9;
	Fri,  7 Jul 2006 14:26:42 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A01A41F5D9;
	Fri,  7 Jul 2006 14:26:42 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k675QfW0005409;
	Fri, 7 Jul 2006 14:26:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 07 Jul 2006 14:26:41 +0900 (JST)
Message-Id: <20060707.142641.122254596.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, ths@networkno.de
Subject: [PATCH] fix rdhwr_op definition
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/inst.h b/include/asm-mips/inst.h
index 1ed8d0f..6489f00 100644
--- a/include/asm-mips/inst.h
+++ b/include/asm-mips/inst.h
@@ -74,7 +74,7 @@ enum spec3_op {
 	ins_op, dinsm_op, dinsu_op, dins_op,
 	bshfl_op = 0x20,
 	dbshfl_op = 0x24,
-	rdhwr_op = 0x3f
+	rdhwr_op = 0x3b
 };
 
 /*
