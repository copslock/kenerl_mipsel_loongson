Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA71860 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Jun 1998 13:25:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA85344
	for linux-list;
	Tue, 16 Jun 1998 13:25:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA68101
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Jun 1998 13:25:12 -0700 (PDT)
	mail_from (tomilepp@ousrvr2.oulu.fi)
Received: from ousrvr2.oulu.fi (ousrvr2.oulu.fi [130.231.240.7]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id NAA28970
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Jun 1998 13:25:10 -0700 (PDT)
	mail_from (tomilepp@ousrvr2.oulu.fi)
Received: (from tomilepp@localhost)
	by ousrvr2.oulu.fi (8.8.5/8.8.5) id XAA28706
	for linux@cthulhu.engr.sgi.com; Tue, 16 Jun 1998 23:25:08 +0300 (EET DST)
From: Tomi Leppikangas <tomilepp@ousrvr2.oulu.fi>
Message-Id: <199806162025.XAA28706@ousrvr2.oulu.fi>
Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
To: linux@cthulhu.engr.sgi.com
Date: Tue, 16 Jun 1998 23:25:08 +0300 (EET DST)
In-Reply-To: <Pine.LNX.3.95.980614004054.27426A-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jun 14, 98 00:44:23 am"
Reply-To: Tomi.Leppikangas@oulu.fi
X-Mailer: ELM [version 2.4ME+ PL15 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I tryed to install that new 5.1 redhad tonight, but installation
stops when selecting partitions, i cant make swap partition,
and installation wont continue without any swap.

I partitioned second disk in irix, and in boot linux finds it,
but both partitions are 'linux native', i cant change them to
'linux swap' becouse fdisk segfaults in installation. Should that
fdisk work? Could that segfault be becouse i have two disks, one 
id=0 and second id=3.

Any way to install it without swap? Or how to force sdb2
to be swap partition?

In that announcment posting there was 'copy all files from...',
i just copied "installfs.tgz" and untar it, is all files in that?



-- 
##        Tomi.Leppikangas@oulu.fi         ##
##  http://www.student.oulu.fi/~tomilepp/  ##
