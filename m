Received:  by oss.sgi.com id <S305187AbQDWRuC>;
	Sun, 23 Apr 2000 10:50:02 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:25892 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305185AbQDWRto>;
	Sun, 23 Apr 2000 10:49:44 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA19604; Sun, 23 Apr 2000 10:44:59 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA11825
	for linux-list;
	Sun, 23 Apr 2000 10:35:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA81603
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 23 Apr 2000 10:35:35 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06981
	for <linux@cthulhu.engr.sgi.com>; Sun, 23 Apr 2000 10:35:34 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 22CEA81E; Sun, 23 Apr 2000 19:35:34 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0FC4F8FFD; Sun, 23 Apr 2000 19:27:35 +0200 (CEST)
Date:   Sun, 23 Apr 2000 19:27:35 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: /usr/include/asm/io.h:308: undefined reference to `mips_io_port_base'
Message-ID: <20000423192734.A3630@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i am trying to build "pileup" which is a "SoundBlaster" morse trainer.
As it directly accesses hardware it seems to include some files which
aehm - dont seem to work for userspace :)

Does someone have an idea what goes wrong here ?

[...]
make CFLAGS="-O2 -g -Wall -D_REENTRANT"
make[1]: Entering directory `/home/builder/build/pileup-1.1'
gcc -O2 -g -Wall -D_REENTRANT -c  AdLib.c
gcc -O2 -g -Wall -D_REENTRANT -c pileup.c
gcc -O2 -g -Wall -D_REENTRANT -o pileup pileup.o AdLib.o -lm -lpthread 
pileup.o: In function `stop_thread':
/home/builder/build/pileup-1.1/pileup.c:229: undefined reference to `ioperm'
/home/builder/build/pileup-1.1/pileup.c:230: undefined reference to `ioperm'
pileup.o: In function `start_thread':
/home/builder/build/pileup-1.1/pileup.c:289: undefined reference to `ioperm'
/home/builder/build/pileup-1.1/pileup.c:290: undefined reference to `ioperm'
pileup.o: In function `main':
/home/builder/build/pileup-1.1/pileup.c:625: undefined reference to `ioperm'
pileup.o:/home/builder/build/pileup-1.1/pileup.c:626: more undefined references to `ioperm' follow
AdLib.o: In function `wr_register':
/usr/include/asm/io.h:308: undefined reference to `mips_io_port_base'
/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
AdLib.o: In function `AdLib_found':
/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
AdLib.o: In function `ºm\*ºm\und':
/usr/include/asm/io.h:304: undefined reference to `mips_io_port_base'
make[1]: *** [pileup] Error 1
make[1]: Leaving directory `/home/builder/build/pileup-1.1'
make: *** [build] Error 2
[...]

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
