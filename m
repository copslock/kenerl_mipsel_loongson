Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA59286 for <linux-archive@neteng.engr.sgi.com>; Fri, 19 Jun 1998 18:59:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA69479
	for linux-list;
	Fri, 19 Jun 1998 18:58:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from piecomputer.engr.sgi.com (piecomputer.engr.sgi.com [150.166.105.8])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA21583;
	Fri, 19 Jun 1998 18:58:31 -0700 (PDT)
	mail_from (mende@piecomputer.engr.sgi.com)
Received: (from mende@localhost) by piecomputer.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id SAA29080; Fri, 19 Jun 1998 18:58:31 -0700 (PDT)
Date: Fri, 19 Jun 1998 18:58:31 -0700 (PDT)
Message-Id: <199806200158.SAA29080@piecomputer.engr.sgi.com>
From: Bob Mende Pie <mende@piecomputer.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com, dmk@cthulhu.engr.sgi.com
Subject: more changes on linus.linux.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  The system linus.linux.sgi.com now has a new disk configuration for /src.
It is now a pair of high speed 4g drives mirrored (via xlv).   The old disk
array is offline, but will not be recycled for at least a week.  Please let
me know if you see any problems or data discrepencies.   

   The system is now a 150Mhz R4400 running on a Challenge/S.   Before we
consider upgrading linus to run linux, we should have support for the
Challenge/S.  I have a IO+ card free, but the backplate of the indy does
not allow for it to fit into a box.  I am seeing if I can get a Challenge/S
for loan for a few months so we can get it someone who can do the HW port
for it.   It should be close to a no brainer since it is just a few more WD
scsi chains and another ethernet (just like the internal one).

                    /Bob...                    mailto:mende@sgi.com
              http://reality.sgi.com/mende            KF6EID
