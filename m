Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 16:58:44 +0200 (CEST)
Received: from p549F5DF2.dip.t-dialin.net ([84.159.93.242]:64960 "EHLO
	p549F5DF2.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133884AbWEIO62 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 May 2006 16:58:28 +0200
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:33034 "EHLO
	topsns2.toshiba-tops.co.jp") by lappi.linux-mips.net with ESMTP
	id S1098926AbWEILYV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 May 2006 04:24:21 -0700
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for p549F5DF2.dip.t-dialin.net [84.159.93.242]) with ESMTP; Tue, 9 May 2006 20:24:19 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1C55420386;
	Tue,  9 May 2006 20:23:50 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0857320361;
	Tue,  9 May 2006 20:23:50 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k49BNn4D095519;
	Tue, 9 May 2006 20:23:49 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 09 May 2006 20:23:49 +0900 (JST)
Message-Id: <20060509.202349.80882976.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix kgdb exception handler from user mode
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
X-archive-position: 11372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix a calculation of saved vector address in trap_low (damage done by
f4c72cc737561aab0d9c7f877abbc0a853f1c465)

diff --git a/arch/mips/kernel/gdb-low.S b/arch/mips/kernel/gdb-low.S
index 10f28fb..5fd7a8a 100644
--- a/arch/mips/kernel/gdb-low.S
+++ b/arch/mips/kernel/gdb-low.S
@@ -54,9 +54,11 @@ #endif
 		 */
 		mfc0	k0, CP0_CAUSE
 		andi	k0, k0, 0x7c
-		add	k1, k1, k0
-		PTR_L	k0, saved_vectors(k1)
-		jr	k0
+#ifdef CONFIG_64BIT
+		dsll	k0, k0, 1
+#endif
+		PTR_L	k1, saved_vectors(k0)
+		jr	k1
 		nop
 1:
 		move	k0, sp
