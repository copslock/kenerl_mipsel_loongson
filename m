Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 09:52:50 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:55961 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8224841AbUIXIwq>; Fri, 24 Sep 2004 09:52:46 +0100
Received: by the-doors.enix.org (Postfix, from userid 1105)
	id 3D1291EFB0; Fri, 24 Sep 2004 10:52:40 +0200 (CEST)
Date: Fri, 24 Sep 2004 10:52:40 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: linux-mips@linux-mips.org
Cc: mentre@tcl.ite.mee.com
Subject: "Can't analyze prologue code ..." at boot time
Message-ID: <20040924085240.GP24730@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <thomas@the-doors.enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

Hello,

In arch/mips/kernel/process.c, the function frame_info_init() called
at boot time, calls the get_frame_info() to a analyze the prologue of
a few functions (I don't know why, does anyone know ?).

At boot time, I have the following message on the console :

Can't analyze prologue code at 80315308

At 80315308 is the beginning of the schedule_timeout() function which
is one of the functions analyzed by the frame_info_init().

The get_frame_info() seems to search a sw or sd instruction, but here
is the beginning of the schedule_timeout() function :

80315308 <schedule_timeout>:
80315308:       3c027fff        lui     v0,0x7fff
8031530c:       27bdffc0        addiu   sp,sp,-64
80315310:       3442ffff        ori     v0,v0,0xffff
80315314:       afb10034        sw      s1,52(sp)
80315318:       afbf003c        sw      ra,60(sp)
8031531c:       afb20038        sw      s2,56(sp)
80315320:       afb00030        sw      s0,48(sp)
80315324:       1082002c        beq     a0,v0,803153d8 <schedule_timeout+0xd0>
80315328:       00808821        move    s1,a0

This error isn't fatal, the kernel perfectly boots, and I can use my
shell perfectly. I just wanted to know why it is reporting a problem,
why the kernel needs to analyze the prologues of a couple of
functions, and maybe report a possible problem ?

I'm using a quite outdated linux-mips CVS (from the beginning of the
month, a 2.6.9-rc1). I compiled using gcc 3.3.4, for an RM9000
processor.

Don't hesitate to ask for details,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org 
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
