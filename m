Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA08972 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 07:40:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA04891
	for linux-list;
	Thu, 16 Jul 1998 07:40:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA11160
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 07:40:00 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA10459
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 07:39:58 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id QAA02620;
	Thu, 16 Jul 1998 16:39:54 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id QAA12103;
	Thu, 16 Jul 1998 16:39:51 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id QAA10960;
	Thu, 16 Jul 1998 16:39:53 +0200 (MET DST)
Message-Id: <199807161439.QAA10960@aisa.fi.muni.cz>
Subject: Re: The pre-release of Hard Hat Linux for SGI...
In-Reply-To: <Pine.LNX.3.95.980716101110.6127A-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 16, 98 10:12:06 am"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 16 Jul 1998 16:39:53 +0200 (MET DST)
Cc: adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> Okay, this queston is simple:
> 
> are you 100% sure that you're not installing with old packages, and that
> the huge .tar.gz has the same md5sum ?

I might be doing some stupid mistake somewhere but I just checked the
checksum and it's the same, the installer says Hard Hat, it installs
kernel 2.1.100 and there are 458 packages in the mipseb/RedHat/RPMS
directory that came from the tar. And my nfsroot argument to
$installinux point to tftpboot and from there the link goes to this
mipseb subdirectory (you can actually check the unpacked tar at our
mirror ftp://ftp.fi.muni.cz/pub/linux/sgi/redhat/mipseb, I install
from that machine). So I'm like at 98 % that it's not the old
version ;-)

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
