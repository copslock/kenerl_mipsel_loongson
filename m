Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 22:21:59 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:48768 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225800AbUERVV6>; Tue, 18 May 2004 22:21:58 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BQC25-00034i-00; Tue, 18 May 2004 22:21:53 +0100
Date: Tue, 18 May 2004 22:21:53 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Horton <pdh@colonel-panic.org>, Jun Sun <jsun@mvista.com>,
	Bob Breuer <bbreuer@righthandtech.com>,
	linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518212153.GA11783@skeleton-jack>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com> <20040518114519.C5390@mvista.com> <20040518191019.GA11007@skeleton-jack> <20040518195055.GB2454@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518195055.GB2454@linux-mips.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 09:50:55PM +0200, Ralf Baechle wrote:
> On Tue, May 18, 2004 at 08:10:19PM +0100, Peter Horton wrote:
> 
> > The kernel maps the page cache page into user space ... BANG! possible
> > D-cache alias.
> > 
> > The kernel doesn't bother flushing the page cache page from the D-cache
> > as it's never accessed at it's page cache address.
> 
> It is - after all the driver is copying the data to there.  The same
> problem also exists in the ramdisk driver and there it has been fixed
> properly, it seems.
> 

I had a dig around but couldn't decide where the proper fix should go.

> > The current fix in the Cobalt patches (2.4 & 2.6) just flushes the read
> > data out of the D-cache after every IDE insw()/insl(). This is the least
> > intrusive fix.
> > 
> > Some Sparc machines also see this problem.
> 
> Carelessly written PIO drivers on any architecture would suffer from this
> kind of problem.
> 

Are you saying it's a driver problem ? :-)

P.
