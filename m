Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA16516 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Nov 1998 16:20:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA20594
	for linux-list;
	Wed, 4 Nov 1998 16:21:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA20611
	for <linux@engr.sgi.com>;
	Wed, 4 Nov 1998 16:21:06 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09090
	for <linux@engr.sgi.com>; Wed, 4 Nov 1998 16:20:56 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA11656
	for <linux@engr.sgi.com>; Thu, 5 Nov 1998 01:20:54 +0100 (MET)
Message-ID: <19981104175235.A16320@uni-koblenz.de>
Date: Wed, 4 Nov 1998 17:52:35 +0100
From: ralf@uni-koblenz.de
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: RM200 and more
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

Something is very fishy with the RM200 (E)ISA interrupt handler code.

Sympthom was that some time we loose (E)ISA interrupts which essentially is
almost equivalent to a crash since without timer interrupt there isn't very
much left to loose ...  What I observed was that the 8259 PICs stop signaling
interrupts to the processor however if I poll them for interrupts they tell
me there'd be an interrupt.  In some cases not all interrupts are dead an
another interrupt may resurrect the dead ones.  For a user this bug was
visible as strange hangs from which the machine may recover by for example
hitting a key or telneting to the machine.  This bug affects all RM200C
kernels since at least 2.1.73, probably even longer.  No idea what's the
cause for this.

I've done a major overhaul of the keyboard stuff.  Essentially my current
2.1.126 based kernel has the MIPS keyboard stuff redone completly.  For
the first time without CONFIG_STUPID system and flexible enough to
add about any new port with non-standard keyboard controller interface like
the Algorithmics P4032 board.  During that I found the probably oldest
Linux/MIPS bug, __delay has a wrong operand to multu resulting usually in
way to short delay loops which on some machines may result in funny
keyboard messages or even the keyboard not being detected.  Another effect
is that now the PS/2 mouse of the RM200 works.

I've hacked the NCR 53C8xx driver back into usability.  It works on my two
NCR based systems but I'd never call that thing reliable because I know how
horribly hacked my source is.  Anyway since it seems to be usable I'll
commit it.

I just found that I accidently never commited the uaccess.h file with my
module fixes to CVS, so modules built from the CVS source can in most cases
not be loaded due to relocation overflows.

Modutils have bug which prevents them from building on little endian machines.
I've fixed that one just like two other modutil bugs.

  Ralf
