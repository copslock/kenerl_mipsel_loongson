Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA217707 for <linux-archive@neteng.engr.sgi.com>; Fri, 23 Jan 1998 09:45:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA12818 for linux-list; Fri, 23 Jan 1998 09:43:44 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA12742; Fri, 23 Jan 1998 09:43:33 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA13324; Fri, 23 Jan 1998 09:43:11 -0800
Date: Fri, 23 Jan 1998 09:43:11 -0800
Message-Id: <199801231743.JAA13324@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Oliver Frommel <oliver@aec.at>, Mike Shaver <shaver@netscape.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
In-Reply-To: <19980123045725.54480@uni-koblenz.de>
References: <34C6E304.680D7541@netscape.com>
	<Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at>
	<19980123045725.54480@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Thu, Jan 22, 1998 at 01:04:30PM +0100, Oliver Frommel wrote:
 > 
 > > > Could we not modify sash to know about ext2?
 > > > I thought I read somewhere that we could get sash sources/info, which
 > > > would help a lot.
 > > > 
 > > 
 > > sash is located in the volumen header afaik(?)
 > > wouldn't it be possible to replace sash by another (possibly free) bootloader?
 > 
 > Basically we could Milo for the Indy also.  Milo even has the required
 > features to be built as ECOFF executable thus supporting old machines
 > where the ARC proms can't load ELF.
 > 
 > Q: What filesystem types are supported directly by the ARC firmware in the
 > ROMs?

      In general, just bootp over Ethernet, tape files, and the volume header.
Some machines support floppy (DOS?) and CDROM (iso9660).  
