Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA981619 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Dec 1997 14:40:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA10564 for linux-list; Wed, 10 Dec 1997 14:38:59 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA10558 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 14:38:56 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA14005
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Dec 1997 14:37:57 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-village.bc.nu [163.164.160.21]) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id WAA09694; Wed, 10 Dec 1997 22:36:50 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xfuql-0005FsC; Wed, 10 Dec 97 22:43 GMT
Message-Id: <m0xfuql-0005FsC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Mount ext2 filesystem.
To: hakamada@meteor.nsg.sgi.com (Takeshi Hakamada)
Date: Wed, 10 Dec 1997 22:43:26 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199712101335.WAA09888@meteor.nsg.sgi.com> from "Takeshi Hakamada" at Dec 10, 97 10:35:39 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> However, when I try to invoke rpm which is made by Alan(libc/ld workaround
> version), I get efs read error as follows:
> 
> efs: read error in indirect extents
> attempt to access beyond end of device
> 08:01 rw=0, want=1207011792, limit=1965937

The efs driver is still very limited and cant handle many file layouts.

> Anyway, why root-be-0.00.cpio.gz doesn't contain rpm binary?
> I think rpm binary should be in root-be-0.00.cpio.gz.

Personally I'd like to see a lot less in a final root-be-0.00. Really it
needs some minimal disk handling tools and rpm. The root-be is a good
start for an NFS root right now.

I used the installer stuff I did to get rpm on the disk by doing

on Linux x86

rpm2cpio rpm-2.3.11.mips.rpm >rpm.cpio

ftping it to Irix and using the install cpio option. Ive been poking at
better installing and talked to a few people about Arc firmware after Ralf
prodded me. Given the horror stories told I think the better option is
to finish producing a tool that takes a compressed ramdisk image (the initrd
image) that is used by setups like the redhat installer and merges it with
the kernel image so the existing bootup stuff can load it

The X86 has memory space problems (install in 8Mb), on the indy blowing
4Mbytes on the install ramdisk is almost an irrelevance.

Alan
