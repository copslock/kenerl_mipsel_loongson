Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2004 00:29:42 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:10113 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225790AbUERX3k>; Wed, 19 May 2004 00:29:40 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BQE1R-0003UQ-00; Wed, 19 May 2004 00:29:21 +0100
Date: Wed, 19 May 2004 00:29:21 +0100
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518232921.GA13365@skeleton-jack>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com> <20040518114519.C5390@mvista.com> <20040518191019.GA11007@skeleton-jack> <20040518152539.D5390@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518152539.D5390@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 03:25:39PM -0700, Jun Sun wrote:
> > 
> > IDE PIO fills the D-cache with the read data (write allocate) as it
> > copies it to the page cache.
> > 
> > The kernel maps the page cache page into user space ... BANG! possible
> > D-cache alias.
> > 
> > The kernel doesn't bother flushing the page cache page from the D-cache
> > as it's never accessed at it's page cache address.
> > 
> 
> The kernel (or driver) should flush the page if it is mapped to user space 
> and the content is modified.
> 

We just need a hook so that we can flush a page from the D-cache once
it's read from a block device into the page cache.

> > The current fix in the Cobalt patches (2.4 & 2.6) just flushes the read
> > data out of the D-cache after every IDE insw()/insl(). This is the least
> > intrusive fix.
> > 
> 
> It should be fixed at a higher layer before we return back to userland.
> 
> If you can illustrate the call stack, I can probably take a look and
> give my opinion.
> 

No call stack, sorry. It was months ago that I debugged this.

IIRC I picked up the aliases with memcmp() in do_no_page() in
mm/memory.c.

P.
