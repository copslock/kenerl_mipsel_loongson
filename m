Received:  by oss.sgi.com id <S305180AbQDRJLF>;
	Tue, 18 Apr 2000 02:11:05 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53873 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQDRJKw>;
	Tue, 18 Apr 2000 02:10:52 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA08326; Tue, 18 Apr 2000 02:06:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA02690
	for linux-list;
	Tue, 18 Apr 2000 01:57:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA91506
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 01:57:46 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA06395
	for <linux@cthulhu.engr.sgi.com>; Tue, 18 Apr 2000 01:57:45 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8A60F848; Tue, 18 Apr 2000 10:57:46 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id AB62C8FC4; Tue, 18 Apr 2000 10:53:48 +0200 (CEST)
Date:   Tue, 18 Apr 2000 10:53:48 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     Mike Klar <mfklar@ponymail.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Unaligned address handling, and the cause of that login prob
Message-ID: <20000418105348.A1247@paradigm.rfc822.org>
References: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com> <XFMail.000417183334.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <XFMail.000417183334.Harald.Koerfgen@home.ivm.de>; from Harald Koerfgen on Mon, Apr 17, 2000 at 06:33:34PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 17, 2000 at 06:33:34PM +0200, Harald Koerfgen wrote:
> Good spotted. This is perfectly in line with my observation that telnet/ssh
> worked perfectly well if you built a kernel without CONFIG_CPU_HAS_LLSC.
> 
> The attached patch seems to fix this, and another bug in
> waking_non_zero_interruptible() as well.
> 
> Telnet is working again :)

Many thanks - It works :)

(root@193)~# cat /proc/cpuinfo 
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
VCED exceptions         : 13636
VCEI exceptions         : 113050

(root@193)~# uname -a
Linux repeat.rfc822.org 2.3.99-pre3 #3 Tue Apr 18 10:31:47 CEST 2000 mips unknown

But the (kernel) fix from Ralph concerning the sleep? syscalls seems
to be incorrect or buggy - When calling top the display refreshes
multiple times a second without a sleep and on the console i get
an.

Setting flush to zero for top.
schedule_timeout: wrong timeout value fffbd0b2 from 800942b8 

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
