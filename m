Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 19:55:55 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:12017 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225205AbTDJSzy>;
	Thu, 10 Apr 2003 19:55:54 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3AItqk09820;
	Thu, 10 Apr 2003 11:55:52 -0700
Date: Thu, 10 Apr 2003 11:55:52 -0700
From: Jun Sun <jsun@mvista.com>
To: Mike Uhler <uhler@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: way selection bit for multi-way cache
Message-ID: <20030410115552.F9002@mvista.com>
References: <20030410110527.E9002@mvista.com> <200304101850.h3AIorK11089@uhler-linux.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200304101850.h3AIorK11089@uhler-linux.mips.com>; from uhler@mips.com on Thu, Apr 10, 2003 at 11:50:53AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Apr 10, 2003 at 11:50:53AM -0700, Mike Uhler wrote:
> > 
> > If a cache is multi-way set associative cache, one must
> > select the way for indexed cache operations.
> > 
> > The most common way selection is to use MSBs in the addressing
> > range of the whole cache size.  In other word, a two-way
> > cache of size d would use bit (log(d)-1) to select the way.
> > 
> > Some other CPUs often the LSB(s) in the address to select
> > ways.  Examples include R5432, R5500, TX49, TX39.  Does
> > anybody know other such CPUs?
> > 
> > And I think I have seen a third kind way selection, but I
> > can't remember which CPU it is.  Does anybody know any
> > other way selection schemes?
> > 
> > Thanks.
> > 
> > Jun
> > 
> 
> I can't comment on anything but MIPS32 and MIPS64 CPUs, but the
> MIPS32 and MIPS64 standard is to use the bits above the index field
> to specify the way.  

Yes.  This is same as the "most common case" as I said above.
Maybe this is a better way to phrase it.  :)

Jun
