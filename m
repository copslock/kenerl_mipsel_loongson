Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 12:06:38 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:51728 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225348AbVITLGQ>; Tue, 20 Sep 2005 12:06:16 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8KB69uQ005289;
	Tue, 20 Sep 2005 12:06:09 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8KB69Z3005288;
	Tue, 20 Sep 2005 12:06:09 +0100
Date:	Tue, 20 Sep 2005 12:06:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
Message-ID: <20050920110609.GB3159@linux-mips.org>
References: <20050920032818.GA7199@nevyn.them.org> <Pine.LNX.4.61L.0509201140160.23494@blysk.ds.pg.gda.pl> <1127214005.2149.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127214005.2149.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 20, 2005 at 01:00:04PM +0200, Matej Kupljen wrote:

> > > This caused incorrect checksums in some UDP packets for NFS root.  The
> > > problem was mild when using a 10.0.1.x IP address, but severe when
> > > using 192.168.1.x.
> > 
> >  Ah!  So *that* is the reason for the absolutely abysmal NFS performance 
> > of the SWARM with 2.6!  I have had no time to track it down -- thanks a 
> > lot!
> 
> Is this for MIPS64 only?
> Because, on dbau1200 we also have poor NFS performance :-(

It's for 64-bit kernels only.  Note the difference, I didn't say MIPS64.

Also, since this bug did result in an operation that has undefined
behaviour it likely may will only have impacted some 64-bit processors -
such as the SB1 - but others may have been unaffected.

  Ralf
