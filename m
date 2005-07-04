Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2005 14:08:49 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:42766 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226154AbVGDNIe>; Mon, 4 Jul 2005 14:08:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 0A8ABE1CA7; Mon,  4 Jul 2005 15:08:40 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27549-05; Mon,  4 Jul 2005 15:08:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id AB786E1CA1; Mon,  4 Jul 2005 15:08:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j64D8g7R027568;
	Mon, 4 Jul 2005 15:08:43 +0200
Date:	Mon, 4 Jul 2005 14:08:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: RFH:  What are the semantics of writeb() and friends?
In-Reply-To: <1120247593.12462.38.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0507041326380.32001@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
  <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl> 
 <1120218385.12446.16.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0507011303190.30138@blysk.ds.pg.gda.pl> 
 <1120224708.12446.26.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0507011513320.30138@blysk.ds.pg.gda.pl>
 <1120247593.12462.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/965/Sun Jul  3 21:23:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Alan Cox wrote:

> >  But that mentions compiler only, not CPU ordering!  I understand the BIU 
> > of the issuing CPU and any external hardware is still permitted to 
> > merge/reorder these accesses unless separated by wmb()/rmb()/mb() as 
> 
> I think the practical situation is that this implies ordering to the bus
> interface. It might be interesting to ask the powerpc people their
> experience but looking at most PCI drivers they assume this and it would
> be expensive not to do so on x86.

 Hmm, doing this OTOH would be expensive on platforms actually requiring 
explicit barriers for this to be the case.  The problem is only drivers 
know what they expect, e.g. you may need as much as:

	writel();
	mb();
	readl();

but only:

	readl();
	rmb();
	readl();

With barriers coded explicitly in drivers, you may control this, with ones 
inside these mmio functions/macros you need to use mb() everywhere as you 
don't know what the surrounding operations are going to be.  And mb() may 
be significantly more expensive than rmb().

 Of course to facilitate such explicit barriers for platforms where 
inter-processor ordering rules are different to ones for mmio a different 
set of operations would have to be defined -- actually we've already got 
one, mmiowb(), as a starting point.

> >  We have that iob() macro/call as well, so that you can push cycles out of 
> > the CPU domain immediately as well, which is equivalent to:
> 
> > 	mb(); 
> > 	make_host_complete_writes();
> 
> My feeling is the default readb etc are __readb + mb + make_hos...

 Hmm, barriers are normally expected to happen *before* affected 
operations, which is natural and often much faster as in the case of 
traditional MIPS write-back buffers, where there is no "flush" operation 
and mb() is just a tight loop spinning on the WB condition non-empty, 
e.g.: "0: bc0f 0b" till the buffer empties itself.  So I'd rather make 
readb() being mb() + make_host_complete_writes() + __readb().  But it 
would be more painful performance-wise than necessary for many cases, 
questioning the whole idea as any sane driver writer would prefer to use 
these double-underscore calls and schedule barriers as necessary manually 
anyway.

 But if it's indeed what's intended I'd prefer it to be documented 
somewhere in a reasonable place as there are people outside the Intel 
world which may not necessarily know which interfaces imply Intel 
semantics and which do not. ;-)

  Maciej
