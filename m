Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 20:10:56 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:25216 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225777AbUERTKz>; Tue, 18 May 2004 20:10:55 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BQ9yl-0002tZ-00; Tue, 18 May 2004 20:10:19 +0100
Date: Tue, 18 May 2004 20:10:19 +0100
To: Jun Sun <jsun@mvista.com>
Cc: Bob Breuer <bbreuer@righthandtech.com>, linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518191019.GA11007@skeleton-jack>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com> <20040518114519.C5390@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518114519.C5390@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 11:45:19AM -0700, Jun Sun wrote:
> 
> Like others suggested, this is not the right fix.  flush_page_to_ram()
> is correctly nullified.  Its job should be done somewhere else
> by other routines.
> 
> Here are a couple of random ideas for finding the true root cause:
> 

We know what the true root cause is :-)

IDE PIO fills the D-cache with the read data (write allocate) as it
copies it to the page cache.

The kernel maps the page cache page into user space ... BANG! possible
D-cache alias.

The kernel doesn't bother flushing the page cache page from the D-cache
as it's never accessed at it's page cache address.

The current fix in the Cobalt patches (2.4 & 2.6) just flushes the read
data out of the D-cache after every IDE insw()/insl(). This is the least
intrusive fix.

Some Sparc machines also see this problem.

P.
