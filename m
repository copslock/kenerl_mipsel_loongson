Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA112405 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 10:23:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA13439 for linux-list; Thu, 22 Jan 1998 10:19:03 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA13379; Thu, 22 Jan 1998 10:18:57 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA23753; Thu, 22 Jan 1998 10:18:56 -0800
Date: Thu, 22 Jan 1998 10:18:56 -0800
Message-Id: <199801221818.KAA23753@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Oliver Frommel <oliver@aec.at>
Cc: Mike Shaver <shaver@netscape.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
In-Reply-To: <Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at>
References: <34C6E304.680D7541@netscape.com>
	<Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Oliver Frommel writes:
 > > 
 > > Could we not modify sash to know about ext2?
 > > I thought I read somewhere that we could get sash sources/info, which
 > > would help a lot.
 > > 
 > 
 > sash is located in the volumen header afaik(?)
 > wouldn't it be possible to replace sash by another (possibly free) bootloader?

     Yes, you can easily replace sash, and the replacement need not even
be called sash, since you can 

	setenv -p OSLoader xyz

to change the name the PROM will use for the boot loader to "xyz".  The
IRIX tool for updating the volume header is dvhtool.
