Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6I9STRw020874
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 02:28:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6I9STWn020873
	for linux-mips-outgoing; Thu, 18 Jul 2002 02:28:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6I9SMRw020860
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 02:28:22 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06469
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 02:28:53 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA10305;
	Thu, 18 Jul 2002 11:26:00 +0200 (MET DST)
Date: Thu, 18 Jul 2002 11:26:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Current CVS (2.4.19-rc1) broken on DECstations
In-Reply-To: <20020717212503.A4332@excalibur.cologne.de>
Message-ID: <Pine.GSO.3.96.1020718111752.9765B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 17 Jul 2002, Karsten Merker wrote:

> it looks like the current oss.sgi.com 2.4 cvs (currently 2.4.19-rc1) is 
> broken on DECstations. The kernel boots on a DS 5000/150, but using
> the onboard LANCE does not work. Using ifconfig gives a "SIOCSIFLAGS:
> Resource temporarily not available and the kernel tells "lance: Can't get
> DMA IRQ 24".

 Thanks for the report.  It's a stupid bug in the KN02BA IRQ routing
table.  I'm committing the following fix to the CVS.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020717-lance-merr-0
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020717.macro/arch/mips/dec/setup.c linux-mips-2.4.19-rc1-20020717/arch/mips/dec/setup.c
--- linux-mips-2.4.19-rc1-20020717.macro/arch/mips/dec/setup.c	2002-06-27 02:57:18.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020717/arch/mips/dec/setup.c	2002-07-18 09:21:42.000000000 +0000
@@ -426,7 +426,7 @@ static int kn02ba_interrupt[DEC_NR_INTS]
 	[DEC_IRQ_TC2]		= DEC_CPU_IRQ_NR(KN02BA_CPU_INR_TC2),
 	[DEC_IRQ_TIMER]		= -1,
 	[DEC_IRQ_VIDEO]		= -1,
-	[DEC_IRQ_ASC_MERR]	= IO_IRQ_NR(IO_INR_LANCE_MERR),
+	[DEC_IRQ_ASC_MERR]	= IO_IRQ_NR(IO_INR_ASC_MERR),
 	[DEC_IRQ_ASC_ERR]	= IO_IRQ_NR(IO_INR_ASC_ERR),
 	[DEC_IRQ_ASC_DMA]	= IO_IRQ_NR(IO_INR_ASC_DMA),
 	[DEC_IRQ_FLOPPY_ERR]	= -1,
