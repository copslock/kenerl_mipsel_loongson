Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA02898; Mon, 13 May 1996 18:24:17 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA11019 for linux-list; Tue, 14 May 1996 01:22:53 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA11014 for <linux@cthulhu.engr.sgi.com>; Mon, 13 May 1996 18:22:52 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id SAA02367 for <lmlinux>; Mon, 13 May 1996 18:22:51 -0700
Message-Id: <199605140122.SAA02367@neteng.engr.sgi.com>
To: lmlinux@neteng.engr.sgi.com
Subject: Uselinux and the Linux/SPARC port (forwarded)
Date: Mon, 13 May 1996 18:22:51 -0700
From: Larry McVoy <lm@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


------- Forwarded Message

Date:    Sat, 11 May 1996 10:52:53 -0500
From:    Miguel de Icaza <miguel@roxanne.nuclecu.unam.mx>
To:      sparclinux-cvs@caipfs.rutgers.edu
cc:      davem@caip.rutgers.edu, tridge@cs.anu.edu.au
Subject: Uselinux and the Linux/SPARC port


Hello guys, 

   On Jannuary the Uselinux conference will be help together with the
Usenix technical conference (http://www.usenix.org).  David and I had
plans to make a technical presentation on the Linux/SPARC port.  I
think Linux/SPARC is not just another port, but a port that has some
unique features not found on other ports.

   The idea is to co-author this paper with those of you wanting to
help/contribute to the article.

   I have assembled a list of things I think are interesting on
Linux/SPARC, I guess that before we can make a presentation on why we
find Linux/SPARC to be a unique port we will have to massage this
quite a bit.  I have already mailed this one to Michael Johnson (He is
the technical session chair I think), if you want to co-author this
with David and I please, contact me (and CC the sparclinux-cvs list.
David will be very busy before leaving to SGI, so I'm doing the
coordination for this).

Best wishes,
Miguel.

* MMU/cache

   Sparc have 3 types of MMU -- this is easy to plug into Linux.
   
   Sparc have Virtual Addressed Caches (VAC) and Physical caches --
   these require changes to Linux kernel.  With the VACs, one must be
   careful to not complete flush the caches as it was being done
   initially, because they damage performace quite a bit.
   
   As an extra challenge, some MMU are buggy, MMUs are accessed in
   different ways.

   Linux/SPARC uses pointer functions for most MMU/cache manipulation 

* SunOS compatibility.

   We use the model that Linus used to get OSF/1 compatibility.
   (we use same constants, and same structures for the kernel, 
   thus no need to translate anything).

   This model lets us have a userland ready early during the port and
   the code is written when something fails to run properly.
   
   Compare this to NetBSD, 4114 lines of code for Sparc code plus 2753
   lines of generic emulation "libraries"; compare this to Linux: 1140
   lines.  We think this is the right way to future ports.  

   Linux emulation code is mostly related to features not found
   usually in Linux (like assumption from SunOS applications on the
   OS), while NetBSD's emulation code is spent on doing conversions
   in/from each OS constants and data structures, so Linux does not
   have a runtime performance penalty for running SunOS applications.

   Sparc drivers have to support the Linux interface and the SunOS
   interface to make some programs happy (X-Window), the mouse driver,
   keyboard driver and frame buffer drivers provide SunOS interfaces.
   The mouse and keyboard driver provide the same interface to Linux
   applications as it is found on original i386 port.

* Drivers for undocumented hardware.

   Getting information out of Sun is not very easy.  Documentation for
   some hardware came from the vendor that makes the chips (scsi and
   lance drivers), sources for the NetBSD, Sprite and the Xinu
   operating system were used as references at the beginning of the
   port to understand the architecture.  

   bwtwo, cg3 and cg6 drivers were based on existing NetBSD drivers
   and a generic frame buffer interface for Linux/SPARC was coded.  A
   driver for the cg14 has been written using only Solaris include
   file for the video card and some poking at the rom letting us
   emulate a lowend graphics card on it.

* Stability and performance.

   During the port the use of crashme has been constantly used to avoid
   the same mistakes on Sun operating system.  

   lmbench has been used to test the performance of the operating
   system.  It was not just used as a benchmarking tool, but also to
   pinpoint weaknesses in the port.  After a couple of weeks tunning
   the port, Linux/SPARC was able to keep up against SunOS and Solaris
   on the same hardware and in some cases outperforming them.

   The lmbench results are more interesting than they may appear at
   first sight: They do not only reflect that Linux is a great
   operating system, but most sadly it reflects the fact that
   corporate operating systems are sometimes bloated and slow.  The
   reason for bloated operating systemd may come from different
   sources, as documented in the 4.3BSD book, there were 13 memory
   allocators on the BSD kernel in 1986, at that point they were aware
   of the problem: code is being rewritten over and over.  This in my
   opinion means that most kernel programmers lack a deep knowledge on
   the operating system and may be writting thing that are not
   completely clean   

   (anecdote: over the past two weeks I made one remark and one
   suggestion to the kernel to Linus, and even when they looked fine
   to me and many people agree they are Linus quickly pointed me out
   where the design flaws were in; it was related rfork, btw).

* SMP

   Problems encountered when porting Linux to the Sparc.  Not all SMP
   machines are born the same, there are some hacks required to get
   SMP working on the Sparc.  

   [Ufinished section I will complete this section later]

* Portability and the AP+

   The Linux/SPARC port is itself a relatively easy to port to non Sun
   hardware.  Andrew Tridgell and his hackers team in Canberra have
   ported Linux/SPARC to the AP+ multiprocessor.

   [ This section is still  not finished ]

* Bootstraping the SPARC.

   Booting the SPARC required: a) cleaning up the ext2fs to make it
   aware of the endianess of the SPARC;  b) the merging into the
   kernel of the nfsroot allowed one of the developers to work without
   a hard disk, and let people test drive Linux kernel without needing
   to reformat their disks.

   Jay Eastabrook's Alpha console code split was used as the second
   attempt at the Linux console code.  Once we had this one, we got
   the same functionality of Linux/i386 on the sparc.

* SILO.
 
   SILO is unique in one aspect:  It is the first Linux boot loader
   that uses the ext2fs library from the ext2fs tool suite by Remy
   Card and Ted Tso.  This is a good thing because it let us write the
   boot loader in a very short time frame.  

   The SILO bootloader fully understands the ext2fs and thus does not
   require a special boot loader installer for each kernel image that
   is made available.  There is still work in progress on LILO to make
   it work with iso9660 cdroms and boot loading.

* The port

   David Miller setup an account for the developers on vger to have
   access to his CVS tree so that we could make changes directly to
   the source tree without taking time from him.  Simple rules were
   set: test before you commit your code.

   Another idea that was pushed since the beginning was to keep track
   of current kernel developement.  Even if this would imply that we
   had to spend some time merging and fixing sparc stuff on our
   kernels, it helped us to merge our tree faster and easier than the
   other ports.  Letting versions slip proved to be not a very good
   idea, and the MkLinux people will suffer with it as did the m68k
   guys some months ago. 

* Userland

   The first attempt at a Libc port was done by porting Linux's a.out
   Libc4 to the SPARC.  Later a GNU libc port was attempted, but
   because of the adapting nature of the kernel to the host OS for
   binary compatibility, the GNU libc port was found to not be
   possible at the time, we may try again as soon as some issues are
   hashed out on glibc.  

   Currently the Linux Libc 5 is in use and ELF loading has been fixed
   into the kernel.  Eric Youngdale is making the elf loader less
   i386-centric, and thus our patches will go in easier.

   The libc5 supports shared executables and Eric's ld.so linker has
   been ported to the SPARC, as well as adapting it to Linux
   (originally it was written and tested on Solaris).  What is amazing
   is that this linker is quite portable nowadays.

   RedHat and Debian are both working on Linux distributions for the
   SPARC.  The goal is to have the same interface on all different
   architectures and in the future encourage commercial software
   companies to compile with a cross compiler versions of their
   software for all the available platforms of Linux.

   

------- End of Forwarded Message
