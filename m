Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id CAA31465; Wed, 6 Aug 1997 02:27:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA12529 for linux-list; Wed, 6 Aug 1997 02:26:43 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA12518 for <linux@cthulhu.engr.sgi.com>; Wed, 6 Aug 1997 02:26:39 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id CAA23516
	for <linux@cthulhu.engr.sgi.com>; Wed, 6 Aug 1997 02:26:28 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id LAA11554; Wed, 6 Aug 1997 11:25:58 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708060925.LAA11554@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id LAA07231; Wed, 6 Aug 1997 11:25:55 +0200
Subject: Re: indyIRQ.S
To: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Wed, 6 Aug 1997 11:25:54 +0200 (MET DST)
Cc: shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
In-Reply-To: <199708052111.XAA01741@alpha.franken.de> from "Thomas Bogendoerfer" at Aug 5, 97 11:11:49 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > mips-linux-gcc -D__KERNEL__ -I/export/sgi-linux/kernel/linux/include -D__GOGOGO__ -c indyIRQ.S -o indyIRQ.o
> > indyIRQ.S: Assembler messages:
> > indyIRQ.S:72: Warning: No .cprestore pseudo-op used in PIC code
> > [...] 
> > Any ideas?
> 
> yes, add a -fno-pic to your CFLAGS. The default for the current mips-linux-gcc
> is to produce PIC code and most of the .S files aren't prepared to be compiled
> this way.

None will compile not will the linker accept mixtures of PIC and non-PIC
object files.  I suppose the cause is didling with the makefiles since
-G 0 -mno-abicalls -fno-pic is default for MIPS.

  Ralf
