Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 22:57:42 +0000 (GMT)
Received: from smtp-102.noc.nerim.net ([IPv6:::ffff:62.4.17.102]:46860 "EHLO
	mallaury.noc.nerim.net") by linux-mips.org with ESMTP
	id <S8225240AbTBDW5l>; Tue, 4 Feb 2003 22:57:41 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id 7DE6662E41; Tue,  4 Feb 2003 23:57:38 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18gC20-0000cv-00; Tue, 04 Feb 2003 23:59:08 +0100
Date: Tue, 4 Feb 2003 23:59:07 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.5] disable interrupts in entry.S
Message-ID: <Pine.LNX.4.21.0302042355280.31806-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	A mtc0 is missing in entry.S to disable interrupts while doing
ret_from_irq, ret_from_exception and resume_userspace.

Vivien.

Index: arch/mips64/kernel/entry.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/entry.S,v
retrieving revision 1.23
diff -u -r1.23 entry.S
--- arch/mips64/kernel/entry.S	9 Jan 2003 19:25:15 -0000	1.23
+++ arch/mips64/kernel/entry.S	4 Feb 2003 20:59:33 -0000
@@ -29,6 +29,7 @@
 		mfc0	t0, CP0_STATUS		# make sure need_resched and
 		ori	t0, t0, 1		# signals dont change between
 		xori	t0, t0, 1		# sampling and return
+		mtc0	t0, CP0_STATUS
 		SSNOP; SSNOP; SSNOP
 
 		LONG_L	a2, TI_FLAGS($28)
