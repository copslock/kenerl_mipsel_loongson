Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 20:11:59 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:5641 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225003AbUJJTLy>; Sun, 10 Oct 2004 20:11:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7B63EE1CBE; Sun, 10 Oct 2004 21:11:47 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08174-03; Sun, 10 Oct 2004 21:11:47 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 17812E1CA1; Sun, 10 Oct 2004 21:11:47 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9AJBxxI020473;
	Sun, 10 Oct 2004 21:11:59 +0200
Date: Sun, 10 Oct 2004 20:11:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pete Popov <ppopov@embeddedalley.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
In-Reply-To: <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58L.0410102004190.4217@blysk.ds.pg.gda.pl>
References: <1097428659.4627.10.camel@localhost.localdomain>
 <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 10 Oct 2004, Geert Uytterhoeven wrote:

> > Ralf, or anyone else, any suggestions on how to get a patch like the one
> > below accepted in 2.6? It's needed due to the 36 bit address of the
> > pcmcia controller on the Au1x CPUs.
> 
> Perhaps you can ask the PPC people? Book E PPC has 36-bit I/O as well.

 Using 36-bit pointers for PCMCIA seems questionable to me -- does the bus
support such wide addresses?  If not, why not use a data type that covers
valid offsets only when passing addresses to bus access functions?  In
particular, the range of offsets (the data type used) shouldn't depend on
the processor type, should it?

  Maciej
