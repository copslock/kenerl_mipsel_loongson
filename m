Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA34508 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 May 1998 20:14:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA37094
	for linux-list;
	Tue, 26 May 1998 20:12:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA05686
	for <linux@engr.sgi.com>;
	Tue, 26 May 1998 20:12:38 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id UAA06782
	for <linux@engr.sgi.com>; Tue, 26 May 1998 20:12:36 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA16949
	for <linux@engr.sgi.com>; Wed, 27 May 1998 05:12:34 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA01439;
	Wed, 27 May 1998 04:26:29 +0200
Message-ID: <19980527042629.62884@uni-koblenz.de>
Date: Wed, 27 May 1998 04:26:29 +0200
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Cc: hjl@lucon.org
Subject: Assembler bug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I ran into an assembler bug which affects at least MIPS GAS 2.7 and 2.8.1.
An example which triggers the bug:

[ralf@lappi ralf]$ cat s.s 
        .globl  label1
label1:

        .org    0x1000

        .align  13		# align on 8kb boundary
[ralf@lappi /tmp]$ mips-linux-as -O3 -o s.o s.s
[ralf@lappi /tmp]$ mips-linux-objdump --syms s.o | grep label1
0000000000002000 g     O .text  0000000000000000 label1
[ralf@lappi /tmp]$ 

=> Label label1 get's the wrong value 0x2000, not 0x0 as it should,
assigned.  Inserting a label definition after the .org pseudo op generates
correct code again.  I haven't tried this on non-MIPS GAS.

  Ralf
