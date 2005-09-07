Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 14:51:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:39911 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225250AbVIGNuu>; Wed, 7 Sep 2005 14:50:50 +0100
Received: from localhost (p5166-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2FD53861A; Wed,  7 Sep 2005 22:57:47 +0900 (JST)
Date:	Wed, 07 Sep 2005 22:58:59 +0900 (JST)
Message-Id: <20050907.225859.108306911.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: uninitialized variable in install_sigtramp()
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
X-archive-position: 8887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This is a simple fix.  Removing the 'err' variable entirely could be
alternative fix while the return value of install_sigtramp().

Index: arch/mips/kernel/signal-common.h
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal-common.h,v
retrieving revision 1.7
diff -u -r1.7 signal-common.h
--- arch/mips/kernel/signal-common.h	14 Jul 2005 12:05:05 -0000	1.7
+++ arch/mips/kernel/signal-common.h	7 Sep 2005 13:38:33 -0000
@@ -182,7 +182,7 @@
 static inline int install_sigtramp(unsigned int __user *tramp,
 	unsigned int syscall)
 {
-	int err;
+	int err = 0;
 
 	/*
 	 * Set up the return code ...
---
Atsushi Nemoto
