Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2003 08:12:06 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:42773
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225208AbTG2HMC>; Tue, 29 Jul 2003 08:12:02 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 29 Jul 2003 07:12:00 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h6T7BoDV067690;
	Tue, 29 Jul 2003 16:11:50 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 29 Jul 2003 16:13:03 +0900 (JST)
Message-Id: <20030729.161303.130243885.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: 64bit _syscall6 fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Here is a small fix for 64bit (N32 or ABI64) version of _syscall6().
"__NR_##name" is 7th parameter not 6th.

This is for 2.4 branch.  

diff -u linux-mips-cvs/include/asm-mips64/unistd.h linux.new/include/asm-mips64/unistd.h
--- linux-mips-cvs/include/asm-mips64/unistd.h	Tue Jul 22 09:48:19 2003
+++ linux.new/include/asm-mips64/unistd.h	Tue Jul 29 16:03:31 2003
@@ -883,7 +883,7 @@
 	\
 	__asm__ volatile ( \
 	".set\tnoreorder\n\t" \
-	"li\t$2, %6\t\t\t# " #name "\n\t" \
+	"li\t$2, %7\t\t\t# " #name "\n\t" \
 	"syscall\n\t" \
 	"move\t%0, $2\n\t" \
 	".set\treorder" \

And this is for 2.6.

diff -u linux-mips-cvs-2.6/include/asm-mips/unistd.h linux.new-2.6/include/asm-mips/unistd.h
--- linux-mips-cvs-2.6/include/asm-mips/unistd.h	Tue Jul 29 16:08:13 2003
+++ linux.new-2.6/include/asm-mips/unistd.h	Tue Jul 29 16:10:43 2003
@@ -1028,7 +1028,7 @@
 	\
 	__asm__ volatile ( \
 	".set\tnoreorder\n\t" \
-	"li\t$2, %6\t\t\t# " #name "\n\t" \
+	"li\t$2, %7\t\t\t# " #name "\n\t" \
 	"syscall\n\t" \
 	"move\t%0, $2\n\t" \
 	".set\treorder" \
---
Atsushi Nemoto
