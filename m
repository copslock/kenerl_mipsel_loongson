Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g38H788d031068
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Apr 2002 10:07:08 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g38H78Cs031067
	for linux-mips-outgoing; Mon, 8 Apr 2002 10:07:08 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g38H6s8d031049
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 10:07:01 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA08632;
	Mon, 8 Apr 2002 19:04:13 +0200 (MET DST)
Date: Mon, 8 Apr 2002 19:04:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: New style IRQs for DECstation
Message-ID: <Pine.GSO.3.96.1020408184203.26107I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is code that implements new style IRQ handlers for DECstation. 
Beside obvious things, like mask/unmask, etc. functions it adds IRQ
routing tables for individual systems (including somewhat more complete
basic support for the 5100) so that device drivers for onboard devices do
not have to code IRQ guesswork based on model types.  I tried to make
hardware documentation more complete as well as its external sources are
scarce to say at least, so it might be best to keep bits described within
the code that deals with them. 

 Also included there are a few updates to generic code:

1. A few clean-ups to arch/mips/kernel/irq_cpu.c.  Just a five minute
approach to fix obvious things.  A deeper action is needed, in particular
locking is missing altogether.

2. A new mips_cpu option to denote the dedicated FPU exception is present
as there is currently no sane way to conclude whether it's available or
not.

3. A few missing header inclusions.

 Actually the code is nothing new, but since I'm resubmitting it and a few
people confirmed their interest in the DECstation port since the previous
submission, I'm making the patch available to the public.  I'm running the
code since mid January successfully with only a few minor fixes since
then.

 Due to a relatively large size the patch is available here:
'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/patch-mips-2.4.18-20020402-irq-48.gz'.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
