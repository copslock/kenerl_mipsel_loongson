Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7R198Q10601
	for linux-mips-outgoing; Sun, 26 Aug 2001 18:09:08 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7R196d10597
	for <linux-mips@oss.sgi.com>; Sun, 26 Aug 2001 18:09:06 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 27 Aug 2001 01:09:06 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id EDBE354C12; Mon, 27 Aug 2001 10:09:03 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id KAA99094; Mon, 27 Aug 2001 10:09:02 +0900 (JST)
Date: Mon, 27 Aug 2001 10:13:40 +0900 (JST)
Message-Id: <20010827.101340.74756473.nemoto@toshiba-tops.co.jp>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: scall_o32.S in 2.4.6 (or later)
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

After merging with 2.4.6, it seems that syscall destroy static
registers.  Isnt't this needed?

diff -ur linux.sgi/arch/mips/kernel/scall_o32.S linux/arch/mips/kernel/scall_o32.S
--- linux.sgi/arch/mips/kernel/scall_o32.S	Mon Aug 27 10:03:56 2001
+++ linux/arch/mips/kernel/scall_o32.S	Mon Aug 27 10:04:21 2001
@@ -88,6 +88,7 @@
 
 	move	a0, zero
 	move	a1, sp
+ 	SAVE_STATIC
 	jal	do_signal
 	b	restore_all
 
---
Atsushi Nemoto
