Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2003 10:39:30 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:56556 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225348AbTIJJi5>;
	Wed, 10 Sep 2003 10:38:57 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id SAA05578;
	Wed, 10 Sep 2003 18:38:54 +0900 (JST)
Received: 4UMDO00 id h8A9cs729393; Wed, 10 Sep 2003 18:38:54 +0900 (JST)
Received: 4UMRO00 id h8A9cqa14352; Wed, 10 Sep 2003 18:38:53 +0900 (JST)
	from pudding.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Wed, 10 Sep 2003 18:38:52 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] simulate_llsc in v2.4
Message-Id: <20030910183852.2e8248d5.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__10_Sep_2003_18:38:52_+0900_0ab12bc8"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Wed__10_Sep_2003_18:38:52_+0900_0ab12bc8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I found a differece between v2.4 and v2.6 in simulate_llsc().

Please apply this patch to v2.4 tree.

Yoichi

--Multipart_Wed__10_Sep_2003_18:38:52_+0900_0ab12bc8
Content-Type: text/plain;
 name="simulate_llsc.diff"
Content-Disposition: attachment;
 filename="simulate_llsc.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Fri Jul 18 23:16:06 2003
+++ linux/arch/mips/kernel/traps.c	Wed Sep 10 18:34:40 2003
@@ -523,6 +523,8 @@
 		simulate_sc(regs, opcode);
 		return 0;
 	}
+
+	return -EFAULT;			/* Strange things going on ... */
 }
 
 asmlinkage void do_ov(struct pt_regs *regs)

--Multipart_Wed__10_Sep_2003_18:38:52_+0900_0ab12bc8--
