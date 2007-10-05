Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 12:54:16 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:50609 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20027229AbXJELyG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 12:54:06 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 28C53400CD;
	Fri,  5 Oct 2007 13:54:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id J0zcmgbW69np; Fri,  5 Oct 2007 13:53:58 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0AF6E40095;
	Fri,  5 Oct 2007 13:53:58 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l95Bs0Sl002637;
	Fri, 5 Oct 2007 13:54:00 +0200
Date:	Fri, 5 Oct 2007 12:53:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
In-Reply-To: <20071005073349.4a95ac75.giuseppe@eppesuigoccas.homedns.org>
Message-ID: <Pine.LNX.4.64N.0710051223330.17849@blysk.ds.pg.gda.pl>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
 <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl>
 <20071004130318.GC28928@linux-mips.org> <1191508413.10050.26.camel@scarafaggio>
 <20071004151951.GD6897@linux-mips.org> <Pine.LNX.4.64N.0710041624450.10573@blysk.ds.pg.gda.pl>
 <20071004153217.GF6897@linux-mips.org> <20071005073349.4a95ac75.giuseppe@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4475/Fri Oct  5 10:56:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 5 Oct 2007, Giuseppe Sacco wrote:

> After removing the chkslot() call, I get these errors when booting:
> [...]
> SCSI subsystem initialized
> MACEPCI: Master abort at 0x00000000 (C)
> MACEPCI: Master abort at 0x00008000 (C)
> MACEPCI: Master abort at 0x00010000 (C)
[...]

 Well, these are not errors in this context even though they seem to be 
reported as such -- these Master Aborts are expected to happen for non 
occupied slots (device numbers).  And reporting them to the user in this 
context seems silly (unless debugging).

 I can see the are coming from the MACE error interrupt handler -- either 
the Master-Abort interrupt should be masked for the duration of the 
configuration space access or, if impossible or the way to do so is 
unknown, the handler should recognise the context and silently ack the 
interrupt and pass the error up somehow.  It is up to code handling the 
host bridge in question to get it right -- see 
arch/mips/pci/ops-bonito64.c for an example.

> PCI: Bridge: 0000:00:03.0
>   IO window: 1000-1fff
>   MEM window: 80000000-800fffff
>   PREFETCH window: 80100000-801fffff
> PCI: Enabling device 0000:00:03.0 (0000 -> 0003)
> [...]
> 
> It seems all probes to devfn=0 fails. There is even a call on bus=2, 
> that I really don't understand. the current lspci output is:

 Well, perhaps the initial setup of the PCI-to-PCI bridge reports the 
subordinate bus to be 2 or something.  If you post the whole PCI probe 
log, someone may be able to provide an explanation.

 And devfn=0 failing probably means the host bridge does not want to 
report itself in the PCI configuration space; that is a valid approach 
(seen with the Alphas too, for example), although personally I do not like 
it very much.

> So probably, the test was correct.  Should I restore the same check or 
> only check for devfn==0?

 The handling of Master Aborts should be fixed instead.  It looks like 
MACEPCI_CONTROL_MAR_INT might be the right mask bit -- do we have a spec 
for the chip anywhere or is <asm-mips/ip32/mace.h> the only source?

  Maciej
