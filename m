Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 15:44:00 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:19724 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226150AbVGAOno>; Fri, 1 Jul 2005 15:43:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B3230F5985; Fri,  1 Jul 2005 16:43:32 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30374-01; Fri,  1 Jul 2005 16:43:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 739DFF5983; Fri,  1 Jul 2005 16:43:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j61EhXIB006017;
	Fri, 1 Jul 2005 16:43:33 +0200
Date:	Fri, 1 Jul 2005 15:43:41 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: RFH:  What are the semantics of writeb() and friends?
In-Reply-To: <1120224708.12446.26.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0507011513320.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
  <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl> 
 <1120218385.12446.16.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0507011303190.30138@blysk.ds.pg.gda.pl>
 <1120224708.12446.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/963/Fri Jul  1 15:27:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Alan Cox wrote:

> >  Is that non-reordering specified anywhere for the API or does it just 
> > happen to be satisfied by most implementations?  Ours (for MIPS, that is) 
> > for example does nothing to ensure that.
> 
> It is defined by the device I/O document as follows:
> 
> 
>         The read and write functions are defined to be ordered. That is
> the
>         compiler is not permitted to reorder the I/O sequence. When the
>         ordering can be compiler optimised, you can use <function>
>         __readb</function> and friends to indicate the relaxed ordering.
> Use
>         this with care.

 Oh, wonderful! -- another set of three functions per each operation, for 
direct, CPU-endian and memory-endian accesses.  Sigh...

> Note order - not synchronicity. On that it says

 But that mentions compiler only, not CPU ordering!  I understand the BIU 
of the issuing CPU and any external hardware is still permitted to 
merge/reorder these accesses unless separated by wmb()/rmb()/mb() as 
appropriate.  Note that there are MIPS-based systems that e.g. retrieve 
data pending in the write-back buffer (which is logically external to the 
CPU; sometimes even physically) for reads, e.g. with:

	writel(COMMAND, dev->csr);
	status = readl(dev->csr);

you'll likely get COMMAND in status, rather than any actual value of 
dev->csr and no read cycle ever reaches that device at all!  You need an 
mb() in between so that COMMAND leaves the CPU domain before issuing a 
read for this code to work as expected.  And of course an arbitrary number 
of read cycles to dev->irq_status placed after readl() above may bypass 
the write as well.

 We have that iob() macro/call as well, so that you can push cycles out of 
the CPU domain immediately as well, which is equivalent to:

	mb(); 
	make_host_complete_writes();

>        While the basic functions are defined to be synchronous with
> respect
>         to each other and ordered with respect to each other the busses
> the
>         devices sit on may themselves have asynchronicity. In particular
> many
>         authors are burned by the fact that PCI bus writes are posted
>         asynchronously. A driver author must issue a read from the same
>         device to ensure that writes have occurred in the specific cases
> the
>         author cares. This kind of property cannot be hidden from driver
>         writers in the API.  In some cases, the read used to flush the
> device
>         may be expected to fail (if the card is resetting, for
> example).  In
>         that case, the read should be done from config space, which is
>         guaranteed to soft-fail if the card doesn't respond.

 True and obvious once cycles actually reach your I/O bus of choice -- 
rules for that bus apply from then on.

> >  What if the host I/O bus is not PCI?  For this kind of stuff I tend to 
> > think in the terms of TURBOchannel systems, just to be sure not to get 
> > influenced by the most common hardware. ;-)
> 
> The bus behaviour is bus defined.

 Certainly -- does it apply to host buses as well from the Linux point of 
view?  I don't think drivers should be made aware of them -- they should 
be abstracted by the means of these barriers.

> >  Again, the I/O bus your host is attached to need not be PCI and you may 
> > need a bridge specific operation to make your write be completed, possibly 
> > combined with your quoted sequence (if there is actually PCI somewhere in 
> > the system; think AlphaServer 8400).
> 
> We don't currently have cross bridge "io_write_and_be_synchronous()"
> type functions. So far drivers have always known what to do. Your
> example might break that of course.

 So far I've been able to get away with that iob() function, but if the 
bus and buffering hierarchy gets even more complicated, there may be more 
barriers like this needed.

  Maciej
