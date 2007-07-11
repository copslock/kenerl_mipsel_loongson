Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 17:05:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3345 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021649AbXGKQF3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 17:05:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3324CE1D03;
	Wed, 11 Jul 2007 18:05:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 76E11tNp0PXn; Wed, 11 Jul 2007 18:05:23 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C8F9BE1C67;
	Wed, 11 Jul 2007 18:05:23 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6BG5TYH019483;
	Wed, 11 Jul 2007 18:05:29 +0200
Date:	Wed, 11 Jul 2007 17:05:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Songmao Tian <tiansm@lemote.com>,
	LinuxBIOS Mailing List <linuxbios@linuxbios.org>,
	marc.jones@amd.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: about cs5536 interrupt ack
In-Reply-To: <4694FA7B.6030409@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0707111653130.26459@blysk.ds.pg.gda.pl>
References: <4694A495.1050006@lemote.com> <Pine.LNX.4.64N.0707111347360.26459@blysk.ds.pg.gda.pl>
 <4694FA7B.6030409@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3635/Wed Jul 11 13:30:51 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi,

> > does it return if you write 0xc to the address 0x20 in the I/O port space
> > and then read back from that location?  You should complain to the
> > manufacturer -- they may be able to fix the problem in a later revision.
> 
>    Haha, here's an excerpt form CS5535 spec. update:
> 
> 96. PIC does not support Polling mode
> 
> [...]
> 
> Implications: This mode is not normally used in x86 systems.
> Resolution: None.

 Yes, of course:

$ grep OCW3 arch/i386/kernel/*.c
arch/i386/kernel/time.c:		outb(0x0c, PIC_MASTER_OCW3);

not at all, indeed!

> > You can still dispatch interrupts manually by examining the IRR register,
> > but having a way to ask the 8259A's prioritiser would be nice.  Although
> > given such a lethal erratum you report I would not count on the prioritiser
> > to provide any useful flexibility...
> 
>    Why not? AMD just decided not to implement poll mode, that's all.

 If they have decided to skip such an "unimportant" bit of logic, they 
could have skipped more, only providing support for the basic FNM 
INT/INTA/EOI scheme -- the only one "architecturally" supported from the 
original IBM PC on.  And indeed, a brief look at the datasheed reveals 
they claim to have removed the SFNM too (which IMO provides a more 
reasonable nesting resolution and should be the default for setups where 
nesting is used, such as the environment as set up at the bootstrap by the 
PC BIOS).

  Maciej
