Received:  by oss.sgi.com id <S305237AbQD0S2c>;
	Thu, 27 Apr 2000 11:28:32 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:12569 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQD0S2Q>;
	Thu, 27 Apr 2000 11:28:16 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA13573; Thu, 27 Apr 2000 11:23:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA72890
	for linux-list;
	Thu, 27 Apr 2000 11:10:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA76364
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Apr 2000 11:10:17 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA04025
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Apr 2000 11:10:15 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA22675;
	Thu, 27 Apr 2000 11:10:07 -0700 (PDT)
Received: from Ulysses (fra-tgn-oyh-vty9.as.wcom.net [212.211.87.9])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA01406;
	Thu, 27 Apr 2000 11:09:58 -0700 (PDT)
Message-ID: <001001bfb074$22311480$0957d3d4@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: VC exceptions
Date:   Thu, 27 Apr 2000 20:12:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

It's a thing that can happen whenever caches are
virtually indexed (for speed) but physically tagged
(for correctness), and caches get large enough for
the algorithm to be wrong once in a while.  They can
be avoided with a little thought and overhead in the
assignment of physical pages to virtual addresses.
Gimme a day or so to look at the code, and I'll propose
a fix for Linux...

            Kevin K.

-----Original Message-----
From: Florian Lohoff <flo@rfc822.org>
To: linux@cthulhu.engr.sgi.com <linux@cthulhu.engr.sgi.com>
Date: Thursday, April 27, 2000 5:39 PM
Subject: VC exceptions


>
>Hi,
>i had a conversation with Harald concerning a "strong" time drift
>on my R4000 Decstation. He than was astonished on the large
>number of VCE.
>
>I than searched all my Mips books for an definition of those
>exceptions. But i dont think i currently understand the
>cause of those exceptions.
>
>BTW:
>
>[flo@resume flo]$ uptime && cat /proc/cpuinfo
>  2:55pm  up 13 days, 20 min,  3 users,  load average: 1.15, 1.09, 1.01
>  cpu                     : MIPS
>  cpu model               : R4000SC V6.0
>  system type             : SGI Indy
>  BogoMIPS                : 124.93
>  byteorder               : big endian
>  unaligned accesses      : 90
>  wait instruction        : no
>  microsecond timers      : no
>  extra interrupt vector  : no
>  hardware watchpoint     : yes
>  VCED exceptions         : 130546469
>  VCEI exceptions         : 36073607
>
>On a medium loaded machine i see 40-50 VCEDs per second.
>
>Now i read in the "Mips R4000 Users`s Manual" page 133
>
>------
>Cause: A Virtual Coherency exception occurs when one of the
>       following conditions is true:
>
>       - a primary cache miss hits in the secondary cache
>       - bits 14:12 of the virtual address were not equal to
>         the corresponding bits of the PIdx field of the secondary
> cache tag.
>       - the cache algorithm for the page specifies that the page is
cached.
>------
>
>The "Mips Risc Architecture" says that ALL conditions are to be met which
>i trust more :)
>
>As a resume - The exception is taken when the index of the 1st and
>the 2nd level cache are not identical - Right ?
>So - why is there a mismatch ? Might it be due to some invalidation
>of the 1st (and not the 2nd) level cache ?
>
>As the exception is taken quiet often and the "Mips Risc Architecture"
states
>"Software can avoid the cost of this trap by using constistent virtual
>primary cache indexes to access the same physical data".
>
>Currently i dont think whats the exact cause of this exception and
>a probably optimization which brings this down.
>
>Flo
>--
>Florian Lohoff flo@rfc822.org       +49-subject-2-change
>"Technology is a constant battle between manufacturers producing bigger and
>more idiot-proof systems and nature producing bigger and better idiots."
>
