Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA355101 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Sep 1997 16:47:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA28519 for linux-list; Tue, 2 Sep 1997 16:46:24 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA28300 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 16:45:39 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA23561
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 16:45:37 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id TAA11131; Tue, 2 Sep 1997 19:45:59 -0400
Date: Tue, 2 Sep 1997 19:45:59 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
Reply-To: Alex deVries <adevries@engsoc.carleton.ca>
To: Mark Salter <marks@sun470.sun470.rd.qms.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Booting off of sdb1...
In-Reply-To: <199709022201.RAA26782@speedy.rd.qms.com>
Message-ID: <Pine.LNX.3.95.970902180957.5212B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 2 Sep 1997, Mark Salter wrote:
> > The kernel starts, and it finishes off with:
> > Partition check:
> >  sda: sad1 sda2 sda3 sda4
> >  sdb: sdb1 sdb2 sdb3
> > VFS: Mounted root (ext2 filesystem) readonly.
> > : Can't open
> 
> Try this patch to linux/arch/mips/sgi/prom/cmdline.c:

<snip>

Well, I would try that patch, but I am unable to compile kernels because I
_always_ get this:

make[1]: Entering directory `/usr/src/sgi/linux/arch/mips/kernel'
mips-linux-gcc -D__KERNEL__ -I/usr/src/sgi/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-D__GOGOGO__ -mcpu=r4600 -mips2 -pipe -c entry.S -o entry.o
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
make[1]: Leaving directory `/usr/src/sgi/linux/arch/mips/kernel'
make: *** [linuxsubdirs] Error 2

I'm using the gcc that's up on ftp.linux.sgi.com, and I'm using binutils
2.8.1, which is the latest I believe.

_PLEASE_ can someone who is able to succesfully cross compile kernels post
here what versions they are using, and where I can get them from. Not
sorting this out brings my development efforts to a complete stop. 

- Alex
