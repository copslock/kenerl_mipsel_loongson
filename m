Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f838VJe20110
	for linux-mips-outgoing; Mon, 3 Sep 2001 01:31:19 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f838VEd20107
	for <linux-mips@oss.sgi.com>; Mon, 3 Sep 2001 01:31:15 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 3 Sep 2001 08:31:14 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP id 101A454C0E
	for <linux-mips@oss.sgi.com>; Mon,  3 Sep 2001 17:31:13 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id RAA54936; Mon, 3 Sep 2001 17:31:10 +0900 (JST)
Date: Mon, 03 Sep 2001 17:35:50 +0900 (JST)
Message-Id: <20010903.173550.11594280.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Subject: Re: segfaults with 2.4.8
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010903100155.A5219@gandalf.physik.uni-konstanz.de>
References: <3B91089E.5050900@csh.rit.edu>
	<20010902202810.A14288@paradigm.rfc822.org>
	<20010903100155.A5219@gandalf.physik.uni-konstanz.de>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Mon, 3 Sep 2001 10:01:56 +0200, Guido Guenther <guido.guenther@gmx.net> said:
flo> That is definitly a cache issue - The 2nd level Boardcache of the
flo> R5000 indy is still unfixed.
guenther> Not 100% sure about that. 2.4.5 handles this stuff fine
guenther> while 2.4.8 segfaults(it might be that we just trigger this
guenther> caching issues occasionaly though).

This might be the problem of recent entry.S I reported on 8/31.

I saw a strange SEGFAULT too and a following patch fixed the problem
(at least for me).


diff -ur linux.sgi/arch/mips/kernel/entry.S linux/arch/mips/kernel/entry.S
--- linux.sgi/arch/mips/kernel/entry.S	Sun Aug 26 22:32:47 2001
+++ linux/arch/mips/kernel/entry.S	Mon Sep  3 17:15:51 2001
@@ -44,17 +44,15 @@
 tracesys_exit:	jal	syscall_trace
 		b	ret_from_sys_call
 
-EXPORT(ret_from_irq)
-EXPORT(ret_from_exception)
-		lw	t0, PT_STATUS(sp)	# returning to kernel mode?
-		andi	t0, t0, KU_USER
-		bnez	t0, ret_from_sys_call
-		j	restore_all
-
 reschedule:	jal	schedule 
 
+EXPORT(ret_from_irq)
+EXPORT(ret_from_exception)
 EXPORT(ret_from_sys_call)
 		.type	ret_from_irq,@function
+		lw	t0, PT_STATUS(sp)	# returning to kernel mode?
+		andi	t0, t0, KU_USER
+		beqz	t0, restore_all
 
 		mfc0	t0, CP0_STATUS	# need_resched and signals atomic test
 		ori	t0, t0, 1
---
Atsushi Nemoto
