Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2005 18:42:00 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:12808 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225282AbVBKSlo>; Fri, 11 Feb 2005 18:41:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5627CE1C69; Fri, 11 Feb 2005 19:41:37 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10390-10; Fri, 11 Feb 2005 19:41:37 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 01CC4E1C67; Fri, 11 Feb 2005 19:41:37 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1BIffVI024628;
	Fri, 11 Feb 2005 19:41:41 +0100
Date:	Fri, 11 Feb 2005 18:41:50 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>,
	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
In-Reply-To: <420CF611.5030705@gentoo.org>
Message-ID: <Pine.LNX.4.61L.0502111825300.30117@blysk.ds.pg.gda.pl>
References: <420CEE7F.3080201@astek.fr> <420CF611.5030705@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 11 Feb 2005, Stephen P. Becker wrote:

> > First, there's something wrong with "make ip32_defconfig" which generate
> > config file with "Kernel code model = 64-bit kernel" (MIPS64=y) but
> > doesn't preselect  "Use 64-bit ELF format for building" (BUILD_ELF64=n)
> > doing so, "make" quickly generates an error:
> 
> O2 doesn't use 64-bit ELF format.  You have to use o64.  See the

 O64 isn't a supported ABI for Linux.  It's a crazy ad-hoc hack that 
shouldn't be used at all.  Code to handle it somehow may still exist in 
binutils, but it's abandoned -- nobody bothers checking if it still works.  
With the upcoming explicit reloc support for non-PIC code in GCC 4.0 it 
won't work at all anymore.

> arch/mips/Makefile portion of http://dev.gentoo.org/~geoman/cvs.diff for the
> proper changes.  I'm willing to bet a lot of your problems will go away if you
> stop using ELF64.  Such a kernel will boot, but it never quite works right.

 If you have a problem with n64 binaries, then either you have broken 
tools or there is a bug in the platform-dependent code somewhere -- 
probably some inline asm forgetting about the %higher and %highest 
relocations.  Check your tools (I'd recommend GCC 3.4.3 and binutils 2.15) 
and if they're fine, then file a bug report.  N64 binaries work for 
several platforms (I've tested three myself; I'm sure others did that 
for others as well).

 Regardless of the format used for building, the final executable is 
converted to ELF32 or ELF64 if necessary to suit the bootloader used, as 
controlled by the CONFIG_BOOT_ELF32 and CONFIG_BOOT_ELF64 options.

  Maciej
