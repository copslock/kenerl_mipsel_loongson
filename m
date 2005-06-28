Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 12:26:03 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:61702 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226038AbVF1LZo>; Tue, 28 Jun 2005 12:25:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4F30EE1C91; Tue, 28 Jun 2005 13:25:13 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12945-09; Tue, 28 Jun 2005 13:25:13 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 0DA6AE1C6B; Tue, 28 Jun 2005 13:25:13 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5SBPFPl024380;
	Tue, 28 Jun 2005 13:25:16 +0200
Date:	Tue, 28 Jun 2005 12:25:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Markus Dahms <mad@automagically.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
In-Reply-To: <20050628102013.GA10442@gaspode.automagically.de>
Message-ID: <Pine.LNX.4.61L.0506281204190.13758@blysk.ds.pg.gda.pl>
References: <20050627100757.GA27679@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
 <20050627141842.GA28236@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl>
 <20050628062107.GA8665@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl>
 <20050628102013.GA10442@gaspode.automagically.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/959/Tue Jun 28 01:00:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello Markus,

> [R4000 in 64-bit mode]
> 
> I propably won't find the time to build a patched toolchain for R4000,
> so my 64-bit experiments will concentrate on the R4600.

 Well, you can still use my readily available binaries. :-)  This should 
be quite straightforward for the Linux kernel itself and you can keep 
running o32 userland for the time being.  You may need to find a way to 
pass "-meb" to GCC (and perhaps "-EB" to ld and gas as they may be invoked 
explicitly for some reason) to ask it for big-endian code though.  Or you 
may ask someone to build a patched toolchain. ;-)  There is no change in 
code generation for non-affected configurations as a result of these 
patches, so the resulting toolchain is not crippled in any way.

 This won't solve the lack of necessary support in Linux 2.6, though... 

> The R4000 now successfully boots to prompt using a 32-bit kernel. I'll
> try to enable "Support for 64-bit physical address space" in the next
> kernel build ;).

 I guess nobody will bother if it turns out non-working. ;-)

> [R4600 tlbex.c patch]
> 
> This doesn't seem to be enough. The patch applies almost cleanly on
> current CVS (offset -1 line), but the resulting kernel (I tried 64
> and 32-bit) still stops after "INIT: ...".

 Well, there can be something else.  But to be sure I haven't missed 
anything in these TLB handlers, could you please generate the dumps I 
mentioned yesterday and send them to me?  You need to uncomment the 
definition of DEBUG_TLB at the top of arch/mips/mm/tlbex.c for that.

  Maciej
