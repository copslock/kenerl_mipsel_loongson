Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA06083
	for <pstadt@stud.fh-heilbronn.de>; Thu, 23 Sep 1999 01:24:04 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA12988; Wed, 22 Sep 1999 16:20:37 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA03622
	for linux-list;
	Wed, 22 Sep 1999 16:16:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [150.166.40.92])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA98592;
	Wed, 22 Sep 1999 16:16:43 -0700 (PDT)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id QAA17900;
	Wed, 22 Sep 1999 16:16:42 -0700
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From: "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14313.25434.334444.31793@liveoak.engr.sgi.com>
Date: Wed, 22 Sep 1999 16:16:42 -0700 (PDT)
To: Rory Hunter <roryh@dcs.ed.ac.uk>
Cc: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: oddness
In-Reply-To: <37E95D52.AC2CE967@dcs.ed.ac.uk>
References: <37E95D52.AC2CE967@dcs.ed.ac.uk>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Rory Hunter writes:
 > hi,
 > 
 > I noticed yesteday that it appears that a partition has been set aside
 > by the previous owners of my O2 for /proc... assuming that 'df' isn't
 > lying to me, can anyone think of a reason why an 800Mb partition would
 > be set aside for /proc?

     As on Linux, /proc is not a real file system.  On IRIX, the size
of /proc is roughly the maximum amount of virtual space available (including
swap space), and the space used is the amount of virtual space in use.
