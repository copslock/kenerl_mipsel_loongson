Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2003 04:09:19 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:62965 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224939AbTLJEJR>;
	Wed, 10 Dec 2003 04:09:17 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id NAA15844
	for <linux-mips@linux-mips.org>; Wed, 10 Dec 2003 13:09:12 +0900 (JST)
Received: 4UMDO01 id hBA49Cc25712; Wed, 10 Dec 2003 13:09:12 +0900 (JST)
Received: 4UMRO00 id hBA49BK06363; Wed, 10 Dec 2003 13:09:11 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131])
	for <linux-mips@linux-mips.org>; (authenticated)
Date: Wed, 10 Dec 2003 13:09:16 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: linux-mips@linux-mips.org
Subject: compile error in __cmpxchg_u32
Message-Id: <20031210130916.555732f4.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__10_Dec_2003_13_09_16_+0900_0vnanPSD5ZWOAY.a"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart=_Wed__10_Dec_2003_13_09_16_+0900_0vnanPSD5ZWOAY.a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I found following error in 2.6, when I compiled.

include/asm/system.h: In function `__cmpxchg_u32':
include/asm/system.h:407: error: `val' undeclared (first use in this function)
include/asm/system.h:407: error: (Each undeclared identifier is reported only once
include/asm/system.h:407: error: for each function it appears in.)

I made patch. Is this patch right?

Yoichi


--Multipart=_Wed__10_Dec_2003_13_09_16_+0900_0vnanPSD5ZWOAY.a
Content-Type: text/plain;
 name="cmpxchg-v26.diff"
Content-Disposition: attachment;
 filename="cmpxchg-v26.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/system.h linux/include/asm-mips/system.h
--- linux.orig/include/asm-mips/system.h	2003-12-03 11:30:36.000000000 +0900
+++ linux/include/asm-mips/system.h	2003-12-09 11:21:08.000000000 +0900
@@ -404,7 +404,8 @@
 
 	local_irq_save(flags);
 	retval = *m;
-	*m = val;
+	if (retval == old)
+		*m = new;
 	local_irq_restore(flags);	/* implies memory barrier  */
 #endif
 
@@ -440,7 +441,8 @@
 
 	local_irq_save(flags);
 	retval = *m;
-	*m = val;
+	if (retval == old)
+		*m = new;
 	local_irq_restore(flags);	/* implies memory barrier  */
 #endif
 

--Multipart=_Wed__10_Dec_2003_13_09_16_+0900_0vnanPSD5ZWOAY.a--
