Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA341897; Thu, 21 Aug 1997 19:45:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA09709 for linux-list; Thu, 21 Aug 1997 19:43:38 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA09699 for <linux@cthulhu.engr.sgi.com>; Thu, 21 Aug 1997 19:43:36 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA25439
	for <linux@relay.engr.sgi.com>; Thu, 21 Aug 1997 19:43:32 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id WAA08505 for <linux@relay.engr.sgi.com>; Thu, 21 Aug 1997 22:43:00 -0400
Date: Thu, 21 Aug 1997 22:43:00 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: Kernel compile errors...
Message-ID: <Pine.LNX.3.95.970821222908.6393A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I just checked out the latest kernel, and I get the following errors when
I try to compile. Uh, what am I doing wrong?  I'm afraid MIPS assembler is
above me.

make[1]: Entering directory `/usr/src/adevries/linux/arch/mips/kernel'
mips-linux-gcc -D__KERNEL__ -I/usr/src/adevries/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -D__GOGOGO__ -G 0
-mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe -c entry.S -o entry.o
entry.S: Assembler messages:
entry.S:208: Error: .previous without corresponding .section; ignored
entry.S:208: Error: .previous without corresponding .section; ignored
entry.S:209: Error: .previous without corresponding .section; ignored
entry.S:209: Error: .previous without corresponding .section; ignored
entry.S:216: Error: .previous without corresponding .section; ignored
entry.S:216: Error: .previous without corresponding .section; ignored
entry.S:218: Error: .previous without corresponding .section; ignored
entry.S:218: Error: .previous without corresponding .section; ignored
entry.S:219: Error: .previous without corresponding .section; ignored
entry.S:219: Error: .previous without corresponding .section; ignored
entry.S:220: Error: .previous without corresponding .section; ignored
entry.S:220: Error: .previous without corresponding .section; ignored
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory `/usr/src/adevries/linux/arch/mips/kernel'
make: *** [linuxsubdirs] Error 2

- Alex

      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
