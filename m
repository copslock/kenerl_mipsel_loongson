Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:24:25 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:24005 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20026235AbXJDPYR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:24:17 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DB80E400A8;
	Thu,  4 Oct 2007 17:23:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Q3wR2IbOty0X; Thu,  4 Oct 2007 17:23:43 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9283740095;
	Thu,  4 Oct 2007 17:23:43 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l94FNlN8031779;
	Thu, 4 Oct 2007 17:23:47 +0200
Date:	Thu, 4 Oct 2007 16:23:42 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <4705004C.5000705@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4471/Thu Oct  4 15:22:27 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Oct 2007, Franck Bui-Huu wrote:

> It's just a bit sad to see my TLB handler generated at each boot and
> to embed the whole tlbex generator inside the kernel which is quite
> big:
> 
>    $ mipsel-linux-size arch/mips/mm/tlbex.o
>       text    data     bss     dec     hex filename
>      10116    3904    1568   15588    3ce4 arch/mips/mm/tlbex.o
> 
> specially if my cpu doesn't have any bugs.

 Well, most systems are there to work and not to be rebooted repeatedly 
all the time. ;-)  All of tlbex.o is discarded after bootstrap.

> Maybe having, 2 default implementations in tlbex-r3k.S, tlbex-r4k.S
> for good cpus (the ones which needn't any fixups at all) and otherwise
> the tlbex.c is used. And with luck the majority of the cpus are
> good...

 Well, most of the differences are not due to CPU bugs, but different cp0 
hazards.  The MIPS32r2 and MIPS64r2 architecture specs introduce the "ehb" 
and "jr.hb" instructions to sort them out, but most of the processors we 
support predate them.

 The existence of the definitions in <asm/war.h> is there so that 
workarounds for CPU bugs are optimised away at the kernel build time if 
not activated.

 I agree the inclusion both R3k and R4k handlers at the same time even 
though any configuration predetermines which of the two is only going to 
be needed is a bit suboptimal indeed.

  Maciej
