Received:  by oss.sgi.com id <S305222AbQD0PmV>;
	Thu, 27 Apr 2000 08:42:21 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:4963 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305187AbQD0PmN>;
	Thu, 27 Apr 2000 08:42:13 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA20799; Thu, 27 Apr 2000 08:37:27 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA10182
	for linux-list;
	Thu, 27 Apr 2000 08:10:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA13368
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Apr 2000 08:10:04 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA07249
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Apr 2000 08:09:30 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 776B97F6; Thu, 27 Apr 2000 17:09:30 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1B36C8FFD; Thu, 27 Apr 2000 16:58:03 +0200 (CEST)
Date:   Thu, 27 Apr 2000 16:58:03 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: VC exceptions
Message-ID: <20000427165803.H272@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i had a conversation with Harald concerning a "strong" time drift
on my R4000 Decstation. He than was astonished on the large
number of VCE.

I than searched all my Mips books for an definition of those
exceptions. But i dont think i currently understand the 
cause of those exceptions.

BTW:

[flo@resume flo]$ uptime && cat /proc/cpuinfo 
  2:55pm  up 13 days, 20 min,  3 users,  load average: 1.15, 1.09, 1.01
  cpu                     : MIPS
  cpu model               : R4000SC V6.0
  system type             : SGI Indy
  BogoMIPS                : 124.93
  byteorder               : big endian
  unaligned accesses      : 90
  wait instruction        : no
  microsecond timers      : no
  extra interrupt vector  : no
  hardware watchpoint     : yes
  VCED exceptions         : 130546469
  VCEI exceptions         : 36073607

On a medium loaded machine i see 40-50 VCEDs per second.

Now i read in the "Mips R4000 Users`s Manual" page 133

------
Cause: A Virtual Coherency exception occurs when one of the
       following conditions is true:

       - a primary cache miss hits in the secondary cache
       - bits 14:12 of the virtual address were not equal to
         the corresponding bits of the PIdx field of the secondary 
	 cache tag.
       - the cache algorithm for the page specifies that the page is cached.
------

The "Mips Risc Architecture" says that ALL conditions are to be met which
i trust more :)

As a resume - The exception is taken when the index of the 1st and
the 2nd level cache are not identical - Right ?
So - why is there a mismatch ? Might it be due to some invalidation
of the 1st (and not the 2nd) level cache ?

As the exception is taken quiet often and the "Mips Risc Architecture" states
"Software can avoid the cost of this trap by using constistent virtual
primary cache indexes to access the same physical data".

Currently i dont think whats the exact cause of this exception and
a probably optimization which brings this down.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
