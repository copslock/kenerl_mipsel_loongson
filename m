Received:  by oss.sgi.com id <S305187AbQDWTRL>;
	Sun, 23 Apr 2000 12:17:11 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53034 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305185AbQDWTQv>;
	Sun, 23 Apr 2000 12:16:51 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA23159; Sun, 23 Apr 2000 12:12:01 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA25624; Sun, 23 Apr 2000 12:15:01 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA51028
	for linux-list;
	Sun, 23 Apr 2000 12:00:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA93200
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 23 Apr 2000 12:00:32 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08258
	for <linux@cthulhu.engr.sgi.com>; Sun, 23 Apr 2000 12:00:32 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA17635;
	Sun, 23 Apr 2000 12:00:33 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA16016;
	Sun, 23 Apr 2000 12:00:29 -0700 (PDT)
Message-ID: <000d01bfad56$7541c320$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: /usr/include/asm/io.h:308: undefined reference to `mips_io_port_base'
Date:   Sun, 23 Apr 2000 21:02:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>Hi,
>i am trying to build "pileup" which is a "SoundBlaster" morse trainer.
>As it directly accesses hardware it seems to include some files which
>aehm - dont seem to work for userspace :)
>
>Does someone have an idea what goes wrong here ?

Sure.  The "IN" and "OUT" macros used to simulate x86
I/O instructions operating on ISA I/O space use
mips_io_port_base as the base address for the
memory-mapped I/O access to "non memory-mapped I/O"
(in the PC sense) addresses.  Since MIPS platforms don't
always have the same address space layout as a standard PC,
mips_io_port_base is not a constant, but a variable declared
in arch/mips/kernel/setup.c and initialized (if a non-zero value
is required) in the platform setup code.

So arguably, what you need to do to make those macros
work in user mode, is to have some kind of library module
that you can link into the application that contains a declaration
of mips_io_port_base, initialized to the correct value for
your platform.

>[...]
>make CFLAGS="-O2 -g -Wall -D_REENTRANT"
>make[1]: Entering directory `/home/builder/build/pileup-1.1'
>gcc -O2 -g -Wall -D_REENTRANT -c  AdLib.c
>gcc -O2 -g -Wall -D_REENTRANT -c pileup.c
>gcc -O2 -g -Wall -D_REENTRANT -o pileup pileup.o AdLib.o -lm -lpthread
>pileup.o: In function `stop_thread':
>/home/builder/build/pileup-1.1/pileup.c:229: undefined reference to `ioperm'
>/home/builder/build/pileup-1.1/pileup.c:230: undefined reference to `ioperm'
>pileup.o: In function `start_thread':
>/home/builder/build/pileup-1.1/pileup.c:289: undefined reference to `ioperm'
>/home/builder/build/pileup-1.1/pileup.c:290: undefined reference to `ioperm'
>pileup.o: In function `main':
>/home/builder/build/pileup-1.1/pileup.c:625: undefined reference to `ioperm'
>pileup.o:/home/builder/build/pileup-1.1/pileup.c:626: more undefined references
to `ioperm' follow
>AdLib.o: In function `wr_register':
>/usr/include/asm/io.h:308: undefined reference to `mips_io_port_base'
>/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
>/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
>AdLib.o: In function `AdLib_found':
>/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
>AdLib.o: In function `ºm\*ºm\und':
>/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
>make[1]: *** [pileup] Error 1
>make[1]: Leaving directory `/home/builder/build/pileup-1.1'
>make: *** [build] Error 2
>[...]
>
>Flo
>--
>Florian Lohoff flo@rfc822.org       +49-subject-2-change
>"Technology is a constant battle between manufacturers producing bigger and
>more idiot-proof systems and nature producing bigger and better idiots."
>
