Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA1140317 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 16:37:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA22463 for linux-list; Thu, 11 Dec 1997 16:35:04 -0800
Received: from meteor.nsg.sgi.com (meteor.nsg.sgi.com [134.14.162.53]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA22438 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 16:34:57 -0800
Received: (from hakamada@localhost) by meteor.nsg.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA05477; Fri, 12 Dec 1997 09:30:15 +0900
Message-Id: <199712120030.JAA05477@meteor.nsg.sgi.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Mount ext2 filesystem.
In-Reply-To: Your message of "Wed, 10 Dec 1997 22:43:26 +0000 (GMT)"
References: <m0xfuql-0005FsC@lightning.swansea.linux.org.uk>
X-Mailer: Mew version 1.70 on XEmacs 20.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Dec 1997 09:30:15 +0900
From: Takeshi Hakamada <hakamada@meteor.nsg.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > However, when I try to invoke rpm which is made by Alan(libc/ld workaround
> > version), I get efs read error as follows:
> > 
> > efs: read error in indirect extents
> > attempt to access beyond end of device
> > 08:01 rw=0, want=1207011792, limit=1965937
> 
> The efs driver is still very limited and cant handle many file layouts.

Okay.

> > Anyway, why root-be-0.00.cpio.gz doesn't contain rpm binary?
> > I think rpm binary should be in root-be-0.00.cpio.gz.
> 
> Personally I'd like to see a lot less in a final root-be-0.00. Really it
> needs some minimal disk handling tools and rpm. The root-be is a good
> start for an NFS root right now.
> 
> I used the installer stuff I did to get rpm on the disk by doing
> 
> on Linux x86
> 
> rpm2cpio rpm-2.3.11.mips.rpm >rpm.cpio

Thank you. I've converted rpm to cpio and I could have installed rpm binary.
But, I can't boot from local disk yet. If I can boot from local disk, I'd
like to update faq on the www.linux.sgi.com. How do you think about it?

> ftping it to Irix and using the install cpio option. Ive been poking at
> better installing and talked to a few people about Arc firmware after Ralf
> prodded me. Given the horror stories told I think the better option is
> to finish producing a tool that takes a compressed ramdisk image (the initrd
> image) that is used by setups like the redhat installer and merges it with
> the kernel image so the existing bootup stuff can load it
> 
> The X86 has memory space problems (install in 8Mb), on the indy blowing
> 4Mbytes on the install ramdisk is almost an irrelevance.

Yes, when I installed RedHat4.2 on my poor note PC(8MBytes), it bothered me.

Cheers,
--
Takeshi Hakamada                  
Nihon Silicon Graphics Cray
E-mail: hakamada@nsg.sgi.com, URL: http://reality.sgi.com/hakamada_nsg/
Voice mail: (internal)822-1300, (external)+81-3-5488-1863-1300
