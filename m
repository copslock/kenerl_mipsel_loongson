Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 00:08:19 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17655 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225199AbTBUAIS>;
	Fri, 21 Feb 2003 00:08:18 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1L08AY32606;
	Thu, 20 Feb 2003 16:08:10 -0800
Date: Thu, 20 Feb 2003 16:08:10 -0800
From: Jun Sun <jsun@mvista.com>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH] allow CROSS_COMPILE override
Message-ID: <20030220160810.J7466@mvista.com>
References: <20030220124703.H7466@mvista.com> <3E55455A.8080403@murphy.dk> <20030220132300.I7466@mvista.com> <3E5550BA.4050107@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E5550BA.4050107@murphy.dk>; from brian@murphy.dk on Thu, Feb 20, 2003 at 11:03:38PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 11:03:38PM +0100, Brian Murphy wrote:
> Jun Sun wrote:
> 
> >Is this allowed?  Can't find any such usage in kernel other
> >than the worrisome comment below:
> >
> >arch/arm/Makefile:# Grr, ?= doesn't work as all the other assignment operators do.  Make bug?
> >
> >
> >  
> >
> The arm code does this:
> 
> # Only set INCDIR if its not already defined above
> # Grr, ?= doesn't work as all the other assignment operators do.  Make bug?
> ifeq ($(origin INCDIR), undefined)
> INCDIR          := $(MACHINE)
> endif
> 
> where the make docs say:
> 
> INCDIR ?= $(MACHINE)
> 
> is the same as
> 
> ifeq ($(origin INCDIR), undefined)
> INCDIR          = $(MACHINE)
> endif
> 
> which means INCDIR will reflect changes to MACHINE.
> The := form sets INCDIR once and for all. What do you want?

':=' is fine, as long as "?=" is deemed appropriate for kernel and hackers.

Jun
