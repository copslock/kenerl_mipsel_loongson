Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:53:59 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49903 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTBTVx7>;
	Thu, 20 Feb 2003 21:53:59 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA07395;
	Thu, 20 Feb 2003 13:53:14 -0800
Subject: Re: [PATCH] allow CROSS_COMPILE override
From: Pete Popov <ppopov@mvista.com>
To: Brian Murphy <brian@murphy.dk>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
In-Reply-To: <3E554A1F.7080307@murphy.dk>
References: <20030220124703.H7466@mvista.com> <3E55455A.8080403@murphy.dk>
	 <20030220132300.I7466@mvista.com>  <3E554A1F.7080307@murphy.dk>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1045778225.16540.322.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 13:57:05 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-02-20 at 13:35, Brian Murphy wrote:
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
> It worked for me when I tested the patch, at least for this simple case.
> Might have something to do with the make version, when was the comment
> written?
> 
> brm@brian:~$ make -v
> GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.

I know for a fact that this syntax works for me on RH7.3 because we use
it heavily in a bunch of tools makefiles.

Pete
