Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA2317473 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Apr 1998 22:02:45 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id WAA15447085
	for linux-list;
	Wed, 22 Apr 1998 22:01:31 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA15279823
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Apr 1998 22:01:29 -0700 (PDT)
Received: from MajorD.xtra.co.nz (terminator.xtra.co.nz [202.27.184.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id WAA08993
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 22:01:26 -0700 (PDT)
	mail_from (ratfink@xtra.co.nz)
Received: from xtra.co.nz (xtra185187.xtra.co.nz [202.27.185.187])
	by MajorD.xtra.co.nz (8.8.8/8.8.6) with ESMTP id RAA13739
	for <linux@cthulhu.engr.sgi.com>; Thu, 23 Apr 1998 17:01:25 +1200 (NZST)
Message-ID: <353ECB23.2AA34FBF@xtra.co.nz>
Date: Thu, 23 Apr 1998 17:01:23 +1200
From: Brendan Black <ratfink@xtra.co.nz>
Organization: Acess Denied...
X-Mailer: Mozilla 4.05 [en] (X11; U; Linux 2.0.33 i586)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: VCE exceptions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ok I am unashamedly bringing up an old thread again...:-)

I read back over the mailing list & found that Ralf wanted people to test this,
so I am hereby volunteering to test anything, as the indy I have is showing this
lovely trait:

booting with the latest kernel from zero.aec.at comes up with

Got vced at 8801a2a4.
Kernel panic: Caught VCE exception - should not happen

it does this when either mounting root from a local disk (/dev/sda3) or mounting
root via nfs

I now have a console cable wired up & running to my laptop, which works for
irix, and requires tweaking to get working in linux I beleive (any ideas on this
would be great too...)

I am happy to provide more info on my system setup

cheers

brendan
