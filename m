Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA09397; Tue, 23 Apr 1996 09:35:43 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id JAA07561; Tue, 23 Apr 1996 09:35:37 -0700
Received: from ares.esd.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	 id JAA07555; Tue, 23 Apr 1996 09:35:36 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id JAA15628; Tue, 23 Apr 1996 09:35:35 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id JAA13693; Tue, 23 Apr 1996 09:35:24 -0700
Date: Tue, 23 Apr 1996 09:35:24 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199604231635.JAA13693@fir.esd.sgi.com>
To: "David S. Miller" <davem@caip.rutgers.edu>
Cc: ariel@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: David Miller is on the list
In-Reply-To: <199604230140.VAA03615@huahaga.rutgers.edu>
References: <199604230116.SAA28514@yon.engr.sgi.com>
	<199604230140.VAA03615@huahaga.rutgers.edu>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
 >    From: ariel@yon.engr.sgi.com (Ariel Faigon)
 >    Date: Mon, 22 Apr 1996 18:16:30 -0700 (PDT)
...
 > 	1) MIPS 4[40]00 manual is some online format (not postscript,
 > 	   something I can cut and paste out of an emacs buffer etc.
 > 	   so maybe info or pure ascii text would be fine, I could
 > 	   care less about the formatting, I just want the words
 > 	   there)

     The manuals are online, generally at www,mips.com.  For example,

	http://www.mips.com/r4400/UMan/R4400_UM_cv.html

is the latest R4400 manual.

     Our newer processors for low-end systems are the R4600 and now the
R5000.  Most Indy systems now ship with R5000 processors, and the Indy should
be the target for the initial port, since it is in current production and
widely available.

     The R4600 and R5000 are generally similar, except that the R4600
has 16 KB primary caches and is MIPS III, whereas the R5000 has 32 KB
primary caches and is MIPS IV.  Both are fairly similar to the R4000PC
and R4400PC, in the sense that they do not have a secondary cache
which enforces primary cache virtual index coherency.  (Many Indy
R4600 and R5000 systems do have secondary caches, but they do not
supply virtual coherency exceptions.)  The R4600 and R5000 are good
targets for an initial port, because they have the fewest errata, and
hence require the fewest kernel workarounds.  The R4000 workarounds,
in particular, are pretty messy.

     The R4600 and R5000 data sheets may be found via

	http://www.idt.com/risc/Welcome.html

(under the 64-bit RISC microprocessors category).  The manuals are not online
on public servers, but I can track down copies.  There is some more 
R4600 and R5000 information under

	http://www.qedinc.com/

There is a comparison of the R4400 and the R4600 at

	http://www.mips.com/r4400/Des_Com/Des_Com_cv.html

The MIPS IV architecture document is

	http://www.mips.com/arch/MIPS4_cv.html

This is of relatively minor importance for a basic port, but can be used
to good effect to improve graphics and application performance.  There are
a few minor kernel support issues.

     Once the basic port is done, extending it to the other common processors,
such as the R3000, R4000, R4400, and R10000, will be fairly simple.  The R6000
(not common and obsolete for some years now) and the R8000 would be somewhat
more work to support, since they differ more from the other processors in 
the kernel interface.  

 > 	2) Docs on the ethernet/scsi interfaces and I/O bus
 > 	   architecture for the first machine I will be getting
 > 	   this to work on, again text/info format would be nice.
 > 	   Of course I will probably just stuff in the ready
 > 	   drivers you might be getting to me into Linux but I want
 > 	   to write my own from scratch in the near future after
 > 	   that.

      I have the documents for the memory controller for Indy, and I think
I can locate most of the others.  They are only on paper, however, but I can
get copies.

 > 	3) I know as much as a bum on the street about SGI machines
 > 	   and the various lines, a nice "roadmap to sgi workstations
 > 	   and servers, plus the hardware gook thats inside" type
 > 	   thing would be very useful to me.

     There are tables of the systems under

	http://ssales.corp.sgi.com/products/html/periodic_table.html

Unfortunately, these are inside the firewall.

 > 	I will feel more comfortable if:
 > 	1) I became very familiar with who the heavy low level MIPS
 > 	   assembly level hackers are who I will be dealing with while
 > 	   I am there.  Please tell me who they are, introduce, make
 > 	   us say hello to each other, you get the idea.

     I am probably the best initial contact for Indy issues, and I can
introduce you to people familiar with the various drivers and so on.

...
 > I've thought it over and to me the best plan for things this summer to
 > me is:
 > 	a) R4400 32-bit "proof of concept, yeah we can pull it off"
 > 	   port happens first, side effect is that I become intimate
 > 	   enough with the chip that I can do things more efficiently.

     As I mentioned above, the R4600 and R5000 processors are a simpler
initial target, and the Indy R4600 is the most common configuration.

 > 	b) From here we look into the 64-bit stuff and whether that is
 > 	   is even desirable on 64-bit.  (this would be my first
 > 	   64-bit port outside of my initial UltraSparc hacks)

     This is mainly interesting on the larger systems.  64-bit kernels
do take more space and time (due to extra cache misses, if nothing else),
and most applications don't need more than 32-bit addresses.  The 32-bit
kernel should, however, support using 64-bit arithmetic (MIPS III and IV)
even in 32-bit programs, since there are substantial performance gains
available for certain applications.  The kernel itself can use 64-bit
arithmetic to good effect as well.  (This is how IRIX works.)

 > 	c) Also think about the work needed to turn that code into
 > 	   r3000 friendly code.  Should not be too much as I've done
 > 	   the "write it on recent architecture design then backport
 > 	   it to older design which had some limitations" already and
 > 	   this didn't end up being so bad.

     The R3000 is not drastically different from the R4600.  The main
differences are somewhat different TLB and cache control routines, and, of
course, the MIPS I instruction set.
