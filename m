Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Mar 2003 13:59:57 +0000 (GMT)
Received: from p508B4B98.dip.t-dialin.net ([IPv6:::ffff:80.139.75.152]:49884
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225213AbTCIN74>; Sun, 9 Mar 2003 13:59:56 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h29DxjH28095;
	Sun, 9 Mar 2003 14:59:45 +0100
Date: Sun, 9 Mar 2003 14:59:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: HG <henri@broadbandnetdevices.com>, linux-mips@linux-mips.org
Subject: Re: mips-linux-ld related question
Message-ID: <20030309145945.B27651@linux-mips.org>
References: <000f01c2e4c6$65818600$0400a8c0@amdk62400> <20030307181720.GA5795@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030307181720.GA5795@nevyn.them.org>; from dan@debian.org on Fri, Mar 07, 2003 at 01:17:20PM -0500
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 07, 2003 at 01:17:20PM -0500, Daniel Jacobowitz wrote:

> > I installed the binutils-mips-linux-2.13.1.i386.rpm and
> > egcs-mips-linux-1.1.2-4.i386.rpm from the linux-mips ftp site on a caldera
> > distribution 3.11 linux box to crosscompile a 2.4 kernel.
> > no error message while compiling , i get the following error while linking :
> >  mips-linux-ld: target elf32-bigmips not found
> > 
> > is there some env variable or path that I missed that needs to be set ????
> 
> Fix the kernel; if it references elf32-bigmips your source is too old. 
> It should be tradbigmips with those tools.

True - almost.  We still have two systems, the Baget and the EV64120
explicitly referencing elf32-bigmips, so I guess he was using one of these
two systems.  I just fixed that in CVS - IRIX ELF really should be dead
since years.

  Ralf
