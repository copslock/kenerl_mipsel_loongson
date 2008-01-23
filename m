Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2008 21:09:52 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:15045 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28593101AbYAWVJn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jan 2008 21:09:43 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6F9A34023F;
	Wed, 23 Jan 2008 22:09:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id oWTlCQf2WagM; Wed, 23 Jan 2008 22:09:35 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 4F0C441481;
	Wed, 23 Jan 2008 18:53:18 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id m0NHrNCG025246;
	Wed, 23 Jan 2008 18:53:23 +0100
Date:	Wed, 23 Jan 2008 17:53:11 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:	gigo@poczta.ibb.waw.pl, linux-mips@linux-mips.org
Subject: Re: Old Indy, 64-bit setup
In-Reply-To: <20080122223332.GA11444@alpha.franken.de>
Message-ID: <Pine.LNX.4.64N.0801231052581.6944@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64.0801222106460.31014@poczta.ibb.waw.pl>
 <20080122223332.GA11444@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.92/5531/Wed Jan 23 11:32:09 2008 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jan 2008, Thomas Bogendoerfer wrote:

> > Just a silly question. Is there any working 64-bit kernel configuration 
> > for my r4k 100MHz Indy? From time to time i compile another new kernel for 
> > 64-bit... and see the thing dying. Recently it looked pretty well like 
> 
> your CPU needs a special gcc to avoid triggering 64bit CPU bugs. There
> are also some kernel workarounds missing, which are scheduled for 2.6.25.
> No idea about the gcc part.

 I have made suitable GCC packages available at:

ftp://ftp3.ds.pg.gda.pl/people/macro/RPMS/

I have just updated the archive and you need at least revision 5 of GCC 
4.1.2 packages available there.  You also need at least revision 2 of 
binutils 2.18 packages to complement your setup.  Pick whichever 
architecture suits you (there are native packages for MIPS configurations 
as well as cross-tools from i386 there) or alternatively grab the 
corresponding source packages from:

ftp://ftp3.ds.pg.gda.pl/people/macro/SRPMS/

and build binaries yourself (that may require some trickery, but you can 
also apply patches manually and use your usual procedure).

 Please note that the relevant kernel changes have only been tested with a 
DECstation, which in particular means little endianness only.  You will 
also have to add this fragment:

select CPU_DADDI_WORKAROUNDS if 64BIT
select CPU_R4000_WORKAROUNDS if 64BIT
select CPU_R4400_WORKAROUNDS if 64BIT

to the right part of the Kconfig file relevant for your machine.  See the 
MACH_DECSTATION section in arch/mips/Kconfig for a reference.  Finally, 
running the kernel from the XPHYS segment is not supported with these 
workarounds enabled, which may worth noting for some platforms, though may 
not necessarily be relevant for yours.

 I plan to update GCC and the associated patches to version 4.2 at some 
point in the future, but I have not decided yet when it is going to happen 
as I am going to stick with 4.1 for a while due to some other work.

 I'll be pleased to get some feedback and good luck!

  Maciej
