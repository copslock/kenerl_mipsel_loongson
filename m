Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VAQHA06822
	for linux-mips-outgoing; Wed, 31 Oct 2001 02:26:17 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VAQ9006816;
	Wed, 31 Oct 2001 02:26:10 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 31 Oct 2001 10:26:09 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id CA37BB471; Wed, 31 Oct 2001 19:26:07 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id TAA40015; Wed, 31 Oct 2001 19:26:07 +0900 (JST)
Date: Wed, 31 Oct 2001 19:30:55 +0900 (JST)
Message-Id: <20011031.193055.18309028.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: fix typo in fault.c
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

bust_spinlock() does not exist.

Also, this code does NOT cause link error.  It seems the codes after
die() are discarded at compile time because die() has "noreturn"
attribute.


--- /work3/sgi/linux-sgi-cvs/arch/mips/mm/fault.c	Mon Oct 29 15:26:57 2001
+++ arch/mips/mm/fault.c	Wed Oct 31 13:44:16 2001
@@ -202,7 +202,7 @@
 	       "address %08lx, epc == %08lx, ra == %08lx\n",
 	       address, regs->cp0_epc, regs->regs[31]);
 	die("Oops", regs);
-	bust_spinlock(0);
+	bust_spinlocks(0);
 	do_exit(SIGKILL);
 
 /*
---
Atsushi Nemoto
