Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 10:42:29 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.177]:21228
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224925AbVBUKmM>; Mon, 21 Feb 2005 10:42:12 +0000
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1D3B10-00084u-00
	for linux-mips@linux-mips.org; Mon, 21 Feb 2005 11:42:10 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1D3B10-0001Jx-00
	for linux-mips@linux-mips.org; Mon, 21 Feb 2005 11:42:10 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Fixes to MTD flash driver on AMD Alchemy db1100 board
Date:	Mon, 21 Feb 2005 11:44:58 +0100
User-Agent: KMail/1.7.1
References: <1108962105.6611.24.camel@SillyPuddy.localdomain>
In-Reply-To: <1108962105.6611.24.camel@SillyPuddy.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502211144.58470.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Josh Green wrote:
> Hello, I found a couple compile problems with the
> drivers/mtd/maps/db1x00-flash.c MTD driver.  I'm using linux-mips CVS
> from a few weeks back, corresponding to 2.6.11rc2.  I noticed some
> recent CVS traffic in regards to this driver, but I didn't see them in
> cvsweb on the linux-mips site.  My apologies if this is something that
> has already been reported.  

Even if reported, it hasn't been fixed - I have similar problems.

> - Cast return value of ioremap to (void __iomem *) to get rid of warning
> concerning conversion of integer to pointer

This one needs further inspection, I'd say. Grepping through the sources, I 
see that some platforms define ioremap to return 'void*' and some use 'void 
__iomem*'. The same class inconsistencies exist for iounmap(), I think the 
right thing is 'iounmap( void __iomem*)'.

I found a comment that the value returned from ioremap() is not to be used as 
a virtual address, so it can't be used directly anyway, so a  qualifier like 
volatile is not even necessary. The qualifier becomes necessary inside the 
functions that perform the actual IO like readb(), but everything outside 
should not even attempt to look at this pointer.
Yes, on MIPS it can be used as virtual address AFAICT, some (broken?) code 
might even do so. If that code then relies on the volatile qualifier it will 
break...

I went ahead and changed the functions in asm-mips/io.h, and my Au1100 board 
still seems to work as before. Several other architectures need these fixes, 
too, and several cases where the returnvalue of ioremap() or the parameter to 
iounmap() is cast falsely/unnecessarily are also present. 

Hacking on above stuff, I came across another thing that escapes me: inside 
functions like writes*() and reads*(), the the buffer to write to or read is 
taken as 'void*', then to be cast to 'volatile void*'. In the case of 
writes*(), IMHO the pointer should be const. In neither cases does it make 
sense to me to add the volatile to the pointer. What is the reason for this?

Disclaimer: I'm far from being a kernel expert, so if I'm talking crap 
somebody please enlighten me. I just looked at the code and saw what to me 
looked inconsistent.

> - Setup DB1X00_BOTH_BANKS, DB1X00_BOOT_ONLY, and DB1X00_USER_ONLY
> defines in db1x00.h (used pb1550.h as an example) 

I copied over the code from the db1x00.h of Linux 2.4 to achieve the same. 
However, I didn't put this in any header because its use is limited to just 
one file, AFAICT.
 Hmm, I just looked a bit further, and now I wonder why there are so many 
drivers for Au1xx0 based boards. pb1550-flash.c and db1550-flash.c are almost 
similar, including the comment about the file they are based on (look at it, 
seems like search&replace gone amok).
 I haven't looked too far into it, but I really wonder if not at least 
db1x00-flash.c and db1550-flash.c could be merged with pb1xxx-flash.c and 
pb1550-flash.c, if not even all four could be merged into a single driver. 
Point is that the main difference seem to be the memory layout of the flash, 
all the rest seems generic enough.

> I can see the partitions in /dev/mtd now, but I have not thoroughly
> tested it yet to see if there are any other problems.

Can you tell me how you created /dev/mtd? My version (Debian/x86) of MAKEDEV 
doesn't know these. Also, could you tell me how you configured your kernel? I 
have never seen an MTD working, so I don't even know if what I'm doing is 
supposed to work. :(

Uli
