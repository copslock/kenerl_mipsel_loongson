Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA57370 for <linux-archive@neteng.engr.sgi.com>; Wed, 16 Jun 1999 08:21:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA53730
	for linux-list;
	Wed, 16 Jun 1999 08:17:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from eurohub.neu.sgi.com (gate2-eurohub.neu.sgi.com [144.253.133.139])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA94530
	for <linux@engr.sgi.com>;
	Wed, 16 Jun 1999 08:17:37 -0700 (PDT)
	mail_from (youssef@neu.sgi.com)
Received: from magic.neu.sgi.com (magic.neu.sgi.com [144.253.142.146]) by eurohub.neu.sgi.com (980427.SGI.8.8.8/19990607.SGI.cwilson.europe.hoststrip) via ESMTP id RAA68943 for <@eurohub.neu.sgi.com:linux@engr.sgi.com>; Wed, 16 Jun 1999 17:17:36 +0200 (MDT)
Received: (from youssef@localhost) by magic.neu.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id RAA15372 for linux@engr.sgi.com; Wed, 16 Jun 1999 17:17:23 +0200 (MDT)
Date: Wed, 16 Jun 1999 17:17:23 +0200 (MDT)
From: youssef@neu.sgi.com (Youssef Benyahia)
Message-Id: <9906161717.ZM55097@magic.neu.sgi.com>
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: glibc & phreads
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi there,

I'm trying to compile a threaded program on my LindyX and I ran in the
following known bug :

30-[diags](~/test) > cc -o thread thread.c -D_REENTRANT -lpthread
/usr/lib/libpthread.so: undefined reference to `__libc_accept'
/usr/lib/libpthread.so: undefined reference to `__libc_send'
/usr/lib/libpthread.so: undefined reference to `__libc_recvfrom'
/usr/lib/libpthread.so: undefined reference to `__libc_recvmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_sendmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_recv'
/usr/lib/libpthread.so: undefined reference to `__libc_sendto'
/usr/lib/libpthread.so: undefined reference to `__libc_connect'

Looks like the answer would be to have "more recent libc versions as you have
installed." [Ralf, 10 Feb 1999]. But no way to get a hand on the desired
rpm/binary/source  on ftp.linux.sgi.com.

Is there a sgi-linux thread-ok glibc somewhere ?

What would be the sgi-linux thread-ok glibc version ?

Thanks in advance,

Y.

PS: Great porting job ! Cool to see an Indy running something else than Irix.


cpu                     : MIPS
cpu model               : R4600 V1.0
system type             : SGI Indy
BogoMIPS                : 99.94
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : yes
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available

-- 
-------------------------------------------------------------------
Youssef Benyahia         		eMail : youssef@neu.sgi.com 
EMC ME Engineer 			Tel   : (++41 32) 843 37 59
SGI					vMail : 476-3759
-------------------------------------------------------------------
