Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA18391; Wed, 5 Jun 1996 17:28:25 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA23246 for linux-list; Thu, 6 Jun 1996 00:27:19 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA23223 for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jun 1996 17:27:14 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id RAA03914; Wed, 5 Jun 1996 17:27:05 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id RAA12455; Wed, 5 Jun 1996 17:26:22 -0700
Date: Wed, 5 Jun 1996 17:26:22 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606060026.RAA12455@fir.esd.sgi.com>
To: Mike McDonald <mikemac@titian.engr.sgi.com>
Cc: "David S. Miller" <dm@neteng.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: netbooting 
In-Reply-To: <199606052356.QAA12520@titian>
References: <199606052338.QAA09961@neteng.engr.sgi.com>
	<199606052356.QAA12520@titian>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike McDonald writes:
 > 
 > >Date: Wed, 5 Jun 1996 16:38:09 -0700
 > >From: "David S. Miller" <dm@neteng>
 > >To: wje@fir.esd.sgi.com
 > >Subject: Re: netbooting
 > >
 > >   Date: Wed, 5 Jun 1996 11:35:26 -0700
 > >   From: wje@fir.esd.sgi.com (William J. Earl)
 > >
 > >	On an Indy, the booted kernel (or other program) must be
 > >   in MIPS ECOFF format.
 > >
 > >Know whats strange, I can netboot big endian elf kernels from the ARCS
 > >command line monitor with zero problems on my target INDY. ;-)
 > >
 > >Later,
 > >David S. Miller
 > >dm@engr.sgi.com
 > 
 >   My understanding was that sash had to be COFF due to the proms but
 > that the newer versions of sash understood both COFF and ELF kernels.
 > Something like that anyway.

     Yes, that is correct.  If David is leaving off the "-f", it is possible
that the PROM is booting sash first, and letting sash boot the kernel.
On the other hand, David's Indy does have the latest Indy PROM, so it is
possible that the PROM developer dropped in ELF support.  We can't assume
it is available on an Indy, so we let sash do the work.

     I checked on the PROM source, and the recent PROMs, such as what David
has, do indeed boot ELF binaries directly.  That is, both ELF and ECOFF are
turned on in the recent Indy PROMs.
