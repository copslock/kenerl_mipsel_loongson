Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA20001; Fri, 10 May 1996 04:21:09 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA12246 for linux-list; Fri, 10 May 1996 11:19:43 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA12234 for <linux@cthulhu.engr.sgi.com>; Fri, 10 May 1996 04:19:40 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA19918 for <lmlinux@neteng.engr.sgi.com>; Fri, 10 May 1996 04:19:39 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA12225 for <lmlinux@neteng.engr.sgi.com>; Fri, 10 May 1996 04:19:38 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id EAA23217; Fri, 10 May 1996 04:19:37 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id HAA08456; Fri, 10 May 1996 07:19:33 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id HAA00626; Fri, 10 May 1996 07:19:33 -0400
Date: Fri, 10 May 1996 07:19:33 -0400
Message-Id: <199605101119.HAA00626@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lnz@dandelion.com
CC: sparclinux@vger.rutgers.edu, lmlinux@neteng.engr.sgi.com
Subject: check this out...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


(Leonard, I thought you'd get a kick out of this...)

I stress tested my new Sparc SCSI driver with the following bus
configuration:

	ID 3: SCSI2 Seagate disk
	ID 4: pre-CCS SCSI1 disk of unknown vendor type ;-)
	ID 5: FAST SCSI2 Conner drive

I ran three instances of a program which just did random seeks
forever, one on each drive. (thank god for lmbench programs which have
dual role as stress/stability testers ;-)

I was getting bus lockups now and then, and happily my abort/reset
code completely recovered the bus back into a working state and things
proceeded.  After about 30 minutes of analyzing state dumps from my
driver when this would happen I figure out what was going on.  My
driver now fixes this problem and does not reset anymore no matter how
hard I smash all the drives on this chain.

Anyways, to get to the point, for your edification Leonard, here is
the comment above my fix for the problem. Enjoy ;-)

		/* A fix for broken SCSI1 targets, when they disconnect
		 * they lock up the bus and confuse ESP.  So disallow
		 * disconnects for SCSI1 targets for now until we
		 * find a better fix.
		 *
		 * Addendum: This is funny, I figured out what was going
		 *           on.  The blotzed SCSI1 target would disconnect,
		 *           one of the other SCSI2 targets or both would be
		 *           disconnected as well.  The SCSI1 target would
		 *           stay disconnected long enough that we start
		 *           up a command on one of the SCSI2 targets.  As
		 *           the ESP is arbitrating for the bus the SCSI1
		 *           target begins to arbitrate as well to reselect
		 *           the ESP.  The SCSI1 target refuses to drop it's
		 *           ID bit on the data bus even though the ESP is
		 *           at ID 7 and is the obvious winner for any
		 *           arbitration.  The ESP is a poor sport and refuses
		 *           to lose arbitration, it will continue indefinately
		 *           trying to arbitrate for the bus and can only be
		 *           stopped via a chip reset or SCSI bus reset.
		 *           Therefore _no_ disconnects for SCSI1 targets
		 *           thank you very much. ;-)
		 */

Later,
David S. Miller
davem@caip.rutgers.edu
