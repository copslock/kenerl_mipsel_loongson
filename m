Received:  by oss.sgi.com id <S305165AbQBDLy6>;
	Fri, 4 Feb 2000 03:54:58 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:42621 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305160AbQBDLyi>;
	Fri, 4 Feb 2000 03:54:38 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA16289; Wed, 2 Feb 2000 19:45:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA86294
	for linux-list;
	Wed, 2 Feb 2000 19:35:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA85676
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Feb 2000 19:35:04 -0800 (PST)
	mail_from (kenwills@mailbag.com)
Received: from glacier.binc.net (glacier.binc.net [205.173.176.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA05973
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Feb 2000 19:35:03 -0800 (PST)
	mail_from (kenwills@mailbag.com)
Received: from spanky.yaberk.int (msn-1-136.x2.binc.net [198.70.31.136])
	by glacier.binc.net (8.8.8/8.8.6) with ESMTP id VAA14011;
	Wed, 2 Feb 2000 21:35:01 -0600
Received: (from kenwills@localhost)
	by spanky.yaberk.int (8.9.3/8.9.3) id VAA01338;
	Wed, 2 Feb 2000 21:35:54 -0600 (CST)
	(envelope-from kenwills@mailbag.com)
Date:   Wed, 2 Feb 2000 21:35:54 -0600
From:   Ken Wills <kenwills@mailbag.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Indy crashes
Message-ID: <20000202213554.C1242@spanky.yaberk.int>
References: <20000203021018.A25786@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre1i
In-Reply-To: <20000203021018.A25786@uni-koblenz.de>
X-Mailer: Mutt http://www.mutt.org/
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This is from an Indy running 2.3.21. I've had no stability problems, but the machine
isn't doing much yet.

[root@boger /proc]# cat cpuinfo
cpu                     : MIPS
cpu model               : R4600 V2.0
system type             : SGI Indy
BogoMIPS                : 133.12
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : yes
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available
[root@boger /proc]#

[root@boger /proc]# uname -a
Linux boger.yaberk.int 2.3.21 #2 Sun Jan 16 02:02:46 CST 2000 mips
unknown


* Ralf Baechle (ralf@oss.sgi.com) [000202 21:22]:
> Today I exchanged the R5000 CPU module in my Indy against a R4600 module
> and found that on R4600SC the kernel runs reliable while it crashs pretty
> soon after booting on a R5000SC module.  This is consistent with the
> reports that I've looked at.
> 
> I'd appreciate some more reports from people who did upgrade from a
> kernel older than 2.3.11 to 2.3.11 or newer.  Do you experience crashes
> with the newer kernel?  What type of CPU are you using?
> 
> Thanks,
> 
>   Ralf

-- 

Ken

Ken Wills
kenwills@mailbag.com
