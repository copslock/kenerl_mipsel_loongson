Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2004 01:26:05 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:10997 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225489AbUAPB0F>;
	Fri, 16 Jan 2004 01:26:05 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0G1Q2h30472;
	Thu, 15 Jan 2004 17:26:02 -0800
Date: Thu, 15 Jan 2004 17:26:02 -0800
From: Jun Sun <jsun@mvista.com>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
Message-ID: <20040115172602.H18368@mvista.com>
References: <20040115141427.GA28546@icm.edu.pl> <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net> <20040115231735.GA6619@icm.edu.pl> <4007386F.80207@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4007386F.80207@gentoo.org>; from kumba@gentoo.org on Thu, Jan 15, 2004 at 08:03:43PM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 15, 2004 at 08:03:43PM -0500, Kumba wrote:
> Dominik 'Rathann' Mierzejewski wrote:
> > Well, it appears something has been broken during the last 2 months.
> > Good to know I'm not alone in this.
> 
> I have a 2.4.23 kernel I used from a 20031128 CVS snapshot that works 
> fine, but a 2.4.23 20031214 snapshot didn't work (on an R4400@250MHz 
> I2), so likely the problem was introduced sometime between those dates. 
>   Might help for tracking down the issue.
> 

If you like to know what changes had been made during that period,
you may find my tracking tool useful.  Just select the 2.4 branch
and enter the date range, it will give you all the changes in 
patch format.  So you can also find out who is the lamer! :)

http://linux.junsun.net/xcvs/xcvs_linux_mips

Please be gentle to my little poor server.  This really should be
hosted on linux-mips.org or some other real servers.  Any volunteers?

Jun
