Received:  by oss.sgi.com id <S305170AbQDSRDe>;
	Wed, 19 Apr 2000 10:03:34 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:25462 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQDSRDN>;
	Wed, 19 Apr 2000 10:03:13 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA06639; Wed, 19 Apr 2000 09:58:28 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA85189
	for linux-list;
	Wed, 19 Apr 2000 09:53:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA75467
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Apr 2000 09:53:09 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02614
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Apr 2000 09:53:05 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 32FE07F3; Wed, 19 Apr 2000 18:53:00 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 838958FC4; Wed, 19 Apr 2000 18:48:13 +0200 (CEST)
Date:   Wed, 19 Apr 2000 18:48:13 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, debian-mips@lists.debian.org
Subject: 2.3.99pre5 on Decstation 5000/150 Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000419184812.I7793@paradigm.rfc822.org>
References: <20000419135535Z305163-391+262@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000419135535Z305163-391+262@oss.sgi.com>; from Ralf Baechle on Wed, Apr 19, 2000 at 06:55:33AM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Apr 19, 2000 at 06:55:33AM -0700, Ralf Baechle wrote:
> CVSROOT:	/home/pub/cvs
> Module name:	linux
> Changes by:	ralf@oss.sgi.com	00/04/19 06:55:33
[...]
> Log message:
> 	Merge with Linux 2.3.99-pre5.

Ok - Boots on Decstation 5000/150 which pre4 didnt do.

[flo@repeat flo]$ uname -a
Linux repeat 2.3.99-pre5 #1 Wed Apr 19 18:34:20 CEST 2000 mips unknown
[flo@repeat flo]$ cat /proc/cpuinfo 
cpu                     : MIPS
cpu model               : R4000SC V3.0
system type             : Digital DECstation 5000/1xx
BogoMIPS                : 49.81
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 6694
VCEI exceptions         : 40559

Pause syscall does what it should, top started to work - Many thanks.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
