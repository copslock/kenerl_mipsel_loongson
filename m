Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA91525 for <linux-archive@neteng.engr.sgi.com>; Tue, 19 Jan 1999 18:06:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA45417
	for linux-list;
	Tue, 19 Jan 1999 18:05:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA58473
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 19 Jan 1999 18:05:02 -0800 (PST)
	mail_from (job@piquin.uchicago.edu)
Received: from piquin.uchicago.edu (piquin.uchicago.edu [128.135.132.47]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04197
	for <linux@cthulhu.engr.sgi.com>; Tue, 19 Jan 1999 18:05:01 -0800 (PST)
	mail_from (job@piquin.uchicago.edu)
Received: from piquin.uchicago.edu (localhost [127.0.0.1]) by piquin.uchicago.edu (8.9.1b+Sun/8.8.3) with ESMTP id UAA14601; Tue, 19 Jan 1999 20:04:56 -0600 (CST)
Message-Id: <199901200204.UAA14601@piquin.uchicago.edu>
To: Chad Carlin <chad@sgi.com>
cc: linux@cthulhu.engr.sgi.com, nldesai@dsmserver.uchicago.edu,
        ellidz@eridu.uchicago.edu
Subject: Re: [Fwd: linus.linux.sgi.com] 
In-Reply-To: Message from Chad Carlin <chad@sgi.com> 
   of "Tue, 19 Jan 1999 19:29:16 CST." <Pine.SGI.3.94.990119192805.7049B-110000@roctane.dallas.sgi.com> 
Date: Tue, 19 Jan 1999 20:04:55 -0600
From: job bogan <job@piquin.uchicago.edu>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Your message dated: Tue, 19 Jan 1999 19:29:16 CST

>The current mainstream memory offering is 70n/s and we are at 50n/s.  The memo
>ry is not proprietary - any manufacturer could buy it if their system could dr
>ive it fast enough! 

pardon me but...
Cut the SGI - "We Are Better Than God, Bow Before Our I/O" crap.  

Lots of PCs use 10ns SDRAM and 6ns SDRAM all of the time.  And there is
plenty of memory saturation happening on those systems.  Trust me.  We
do it all the time w/ scientific matrix code.

Humm, a look at the glossies for the 320 and 540 make it look like all
of SGI is working off a typo.  It lists:
   * 100 MHz (50 ns) ECC synchronous dynamic RAM (SDRAM)
that should read 5ns.  and beyond that, lots of people sell 100Mhz
capable SDRAM.  (eg http://www.memoryx.com/generic.htm)  

Anyhow, the only things that seem different from the std garage built PC
are:
Video expandable to 1/2gb of ram (though this looks like it's running
      off the system ram, not dedicated ram.  not a bad thing, but it
      kills the system bus. and it's a bit misleading)
2 64-bit PCI busses
540 uses a WTX tower case.  (320 uses ATX)
540 has SCA scsi disk bays.  I wonder if i'll need $700 drive sleds...
Video Capture card (S-Video, RCA.  in/out)
USB Keyboard & Mouse (this currently limits linux support - USB is
      alpha'ish)
video connector for the SGI LCD Display
2 firewire ports.  not hard to do, just pointless for the next 6months.

I might buy some if they are competitive w/ plain old white Linux boxes.
Esp. if they have good OpenGL performance under Linux.  They would be
more interesting if they had a craylink type high speed connector that
could be used ala myrinet for making Beowulf clusters.

job

ps - 540 has 4 DIMM slots, the 320 2 slots.

--
John Bogan
Director of Computing					773-702-2588
James Franck Institute				5640 South Ellis Ave
University of Chicago				   Chicago, Il 60637
