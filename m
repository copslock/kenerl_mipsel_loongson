Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2002 14:07:02 +0200 (CEST)
Received: from r-bu.iij4u.or.jp ([210.130.0.89]:11466 "EHLO r-bu.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1123396AbSJGMHB>;
	Mon, 7 Oct 2002 14:07:01 +0200
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id g97C6mq05247;
	Mon, 7 Oct 2002 21:06:49 +0900 (JST)
Date: Mon, 7 Oct 2002 21:04:16 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: control reaches end of non-void function
Message-Id: <20021007210416.5cbf7f20.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__7_Oct_2002_21:04:16_+0900_084fb308"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__7_Oct_2002_21:04:16_+0900_084fb308
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

When "mask" doesn't match in the switch conditions,
msg2str in arch/mips/lib/dump_tlb.c doesn't return value.

Please apply this patch.


Yoichi
--Multipart_Mon__7_Oct_2002_21:04:16_+0900_084fb308
Content-Type: text/plain;
 name="msg2str.patch"
Content-Disposition: attachment;
 filename="msg2str.patch"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/lib/dump_tlb.c linux/arch/mips/lib/dump_tlb.c
--- linux.orig/arch/mips/lib/dump_tlb.c	Sat Feb 23 10:41:28 2002
+++ linux/arch/mips/lib/dump_tlb.c	Mon Oct  7 19:54:18 2002
@@ -32,6 +32,8 @@
 	case PM_256M:	return "256Mb";
 #endif
 	}
+
+	return "unknown";
 }
 
 void dump_tlb(int first, int last)

--Multipart_Mon__7_Oct_2002_21:04:16_+0900_084fb308--
