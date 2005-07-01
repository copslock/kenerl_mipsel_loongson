Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 14:34:55 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:1415
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226142AbVGANei>; Fri, 1 Jul 2005 14:34:38 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j61DVpF2015066;
	Fri, 1 Jul 2005 14:31:51 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j61DVpf2015065;
	Fri, 1 Jul 2005 14:31:51 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: RFH:  What are the semantics of writeb() and friends?
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0507011303190.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
	 <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl>
	 <1120218385.12446.16.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507011303190.30138@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120224708.12446.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Fri, 01 Jul 2005 14:31:49 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-07-01 at 13:54, Maciej W. Rozycki wrote:
> > writeb/writel may be merged in some cases (but not re-ordered) for I/O
> 
>  Is that non-reordering specified anywhere for the API or does it just 
> happen to be satisfied by most implementations?  Ours (for MIPS, that is) 
> for example does nothing to ensure that.

It is defined by the device I/O document as follows:


        The read and write functions are defined to be ordered. That is
the
        compiler is not permitted to reorder the I/O sequence. When the
        ordering can be compiler optimised, you can use <function>
        __readb</function> and friends to indicate the relaxed ordering.
Use
        this with care.

Note order - not synchronicity. On that it says

       While the basic functions are defined to be synchronous with
respect
        to each other and ordered with respect to each other the busses
the
        devices sit on may themselves have asynchronicity. In particular
many
        authors are burned by the fact that PCI bus writes are posted
        asynchronously. A driver author must issue a read from the same
        device to ensure that writes have occurred in the specific cases
the
        author cares. This kind of property cannot be hidden from driver
        writers in the API.  In some cases, the read used to flush the
device
        may be expected to fail (if the card is resetting, for
example).  In
        that case, the read should be done from config space, which is
        guaranteed to soft-fail if the card doesn't respond.

>  What if the host I/O bus is not PCI?  For this kind of stuff I tend to 
> think in the terms of TURBOchannel systems, just to be sure not to get 
> influenced by the most common hardware. ;-)

The bus behaviour is bus defined.

>  Again, the I/O bus your host is attached to need not be PCI and you may 
> need a bridge specific operation to make your write be completed, possibly 
> combined with your quoted sequence (if there is actually PCI somewhere in 
> the system; think AlphaServer 8400).

We don't currently have cross bridge "io_write_and_be_synchronous()"
type functions. So far drivers have always known what to do. Your
example might break that of course.

Alan
--
        "In flight refueling scares me. It's like two elephants
                        mating at mach one"
                                -- Arjan van de Ven
