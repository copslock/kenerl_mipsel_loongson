Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2003 14:52:42 +0000 (GMT)
Received: from p508B66FD.dip.t-dialin.net ([IPv6:::ffff:80.139.102.253]:28392
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225195AbTBFOwm>; Thu, 6 Feb 2003 14:52:42 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h16EqU821641;
	Thu, 6 Feb 2003 15:52:30 +0100
Date: Thu, 6 Feb 2003 15:52:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Indukumar Ilangovan <iilangov@cisco.com>
Cc: linux-mips@linux-mips.org
Subject: Re: manipulating e_machine value in the elf Header
Message-ID: <20030206155230.A21248@linux-mips.org>
References: <005201c2cde8$b145e5d0$a78b4d0a@apac.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <005201c2cde8$b145e5d0$a78b4d0a@apac.cisco.com>; from iilangov@cisco.com on Thu, Feb 06, 2003 at 07:34:40PM +0530
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 06, 2003 at 07:34:40PM +0530, Indukumar Ilangovan wrote:

> I'm trying to port linux kernel to a mips board with a R4700 processor. It
> has a rom monitor program which can be used to load the image. (has support
> for tftp boot, xmodem....) . This bootloader has a hardcoded cpu_type which
> is cross checked with the e_machine value in the elf header. When I try to
> load the linux kernel this check (cpu_type == e_machine) fails & hence the
> boot loader aborts the loading of image.
> 
> I tried to change the e_machine type value by changing the EM_MIPS value in
> include/linux/elf.h, still e_machine type is "8" in the image even after
> completely rebuilding the image. I even changed the EM_MIPS value in
> /usr/include/elf.h & couple of other locations (sde headers.....) still no
> luck....though hand editing the elf header is an option.. I don't want to do
> that !

I guess you're hunting the problem at the wrong place.  All MIPS ELF systems
are using EM_MIPS (8) for the e_machine.  A few ancient systems have been
using EM_MIPS_RS3_LE (10) but I've yet to see a system using that value.
So probably the bootloader is expecting the wrong value?

Your attempt at changing that value didn't work because the value is
hardcoded in binutils.  However if you change that value you'd break
binary compatibility with each and every Linux/MIPS binary.

  Ralf
