Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5980l24771
	for linux-mips-outgoing; Wed, 5 Dec 2001 01:08:00 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB597qo24768;
	Wed, 5 Dec 2001 01:07:52 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 5 Dec 2001 08:07:52 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 1BD6AB476; Wed,  5 Dec 2001 17:07:50 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id RAA47483; Wed, 5 Dec 2001 17:07:49 +0900 (JST)
Date: Wed, 05 Dec 2001 17:12:32 +0900 (JST)
Message-Id: <20011205.171232.115909036.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: a small patch for latest (2.4.15+) unaligned.c
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The latest arch/mips/kernel/unaligned.c loses some jump instructions
in .fixup section.  Here is a patch to fix it.  This patch is created
with linux_2_4 branch but can be applied to MAIN trunk also.


--- linux-sgi-cvs/arch/mips/kernel/unaligned.c	Tue Dec  4 11:40:12 2001
+++ linux.new/arch/mips/kernel/unaligned.c	Wed Dec  5 17:02:57 2001
@@ -217,6 +217,7 @@
 			"3:\t.set\tat\n\t"
 			".section\t.fixup,\"ax\"\n\t"
 			"4:\tli\t%1, %3\n\t"
+			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
@@ -256,6 +257,7 @@
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
 			"4:\tli\t%0, %3\n\t"
+			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
@@ -283,6 +285,7 @@
 			"3:\n\t"
 			".section\t.fixup,\"ax\"\n\t"
 			"4:\tli\t%0, %3\n\t"
+			"j\t3b\n\t"
 			".previous\n\t"
 			".section\t__ex_table,\"a\"\n\t"
 			STR(PTR)"\t1b, 4b\n\t"
---
Atsushi Nemoto
