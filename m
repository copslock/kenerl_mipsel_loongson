Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA86gNw24299
	for linux-mips-outgoing; Wed, 7 Nov 2001 22:42:23 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA86gG024294;
	Wed, 7 Nov 2001 22:42:17 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 8 Nov 2001 06:42:16 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 56F45B46B; Thu,  8 Nov 2001 15:42:15 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id PAA63589; Thu, 8 Nov 2001 15:42:14 +0900 (JST)
Date: Thu, 08 Nov 2001 15:47:02 +0900 (JST)
Message-Id: <20011108.154702.74756496.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: i8259.c in big endian
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

arch/mips/kernel/i8259.c seems not working in big endian.

Here is a patch to fix this.

--- linux-sgi-cvs/arch/mips/kernel/i8259.c	Mon Sep 10 02:43:01 2001
+++ linux.new/arch/mips/kernel/i8259.c	Thu Nov  8 15:40:03 2001
@@ -70,8 +70,13 @@
 static unsigned int cached_irq_mask = 0xffff;
 
 #define __byte(x,y) 	(((unsigned char *)&(y))[x])
+#ifdef __BIG_ENDIAN
+#define cached_21	(__byte(1,cached_irq_mask))
+#define cached_A1	(__byte(0,cached_irq_mask))
+#else
 #define cached_21	(__byte(0,cached_irq_mask))
 #define cached_A1	(__byte(1,cached_irq_mask))
+#endif
 
 void disable_8259A_irq(unsigned int irq)
 {
---
Atsushi Nemoto
