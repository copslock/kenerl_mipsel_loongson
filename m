Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 22:39:20 +0000 (GMT)
Received: from smtp-102.noc.nerim.net ([IPv6:::ffff:62.4.17.102]:3596 "EHLO
	mallaury.noc.nerim.net") by linux-mips.org with ESMTP
	id <S8225241AbTBDWjT>; Tue, 4 Feb 2003 22:39:19 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id 2B46C62E5E; Tue,  4 Feb 2003 23:39:16 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18gBkD-0000b8-00; Tue, 04 Feb 2003 23:40:45 +0100
Date: Tue, 4 Feb 2003 23:40:45 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.5] daily r4k_switch fixes (fwd)
Message-ID: <Pine.LNX.4.21.0302042339150.31806-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

forgotten Cc:

---------- Forwarded message ----------
Date: Tue, 4 Feb 2003 22:09:08 +0100 (CET)
From: Vivien Chappelier <glaurung@vivienc.net1.nerim.net>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2.5] daily r4k_switch fixes

Hi,

	TIF_USEDFPU and _TIF_USEDFPU are not the same thing at all,
not surprisingly introducing bugs and confusion in r4k_switch.S
(mips64) and r2300_switch.S (mips) :)

On Tue, 4 Feb 2003, Ralf Baechle wrote:
> Ok.  You missed r2300_switch.S though :)

Not this time :)

Vivien.

Index: arch/mips/kernel/r2300_switch.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/r2300_switch.S,v
retrieving revision 1.28
diff -u -r1.28 r2300_switch.S
--- arch/mips/kernel/r2300_switch.S	4 Feb 2003 12:53:57 -0000	1.28
+++ arch/mips/kernel/r2300_switch.S	4 Feb 2003 20:59:01 -0000
@@ -61,7 +61,7 @@
 	 */
 	lw	t3, TASK_THREAD_INFO(a0)
 	lw	t0, TI_FLAGS(t3)
-	li	t1, TIF_USEDFPU
+	li	t1, _TIF_USEDFPU
 	and	t2, t0, t1
 	beqz	t2, 1f
 	nor	t1, zero, t1
Index: arch/mips64/kernel/r4k_switch.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/r4k_switch.S,v
retrieving revision 1.23
diff -u -r1.23 r4k_switch.S
--- arch/mips64/kernel/r4k_switch.S	4 Feb 2003 12:53:57 -0000	1.23
+++ arch/mips64/kernel/r4k_switch.S	4 Feb 2003 20:59:09 -0000
@@ -56,7 +56,7 @@
 	 */
 	ld	t3, TASK_THREAD_INFO(a0)
 	ld	t0, TI_FLAGS(t3)
-	li	t1, TIF_USEDFPU
+	li	t1, _TIF_USEDFPU
 	and	t2, t0, t1
 	beqz	t2, 1f
 	nor	t1, zero, t1
