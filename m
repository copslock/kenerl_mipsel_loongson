Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA56313 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Jan 1998 13:34:27 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA23071 for linux-list; Mon, 12 Jan 1998 13:30:15 -0800
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA23059 for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 13:30:14 -0800
Received: (from ariel@localhost) by oz.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) id NAA79891 for linux@engr.sgi.com; Mon, 12 Jan 1998 13:30:12 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199801122130.NAA79891@oz.engr.sgi.com>
Subject: The perennial bus error IRQ :-)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Mon, 12 Jan 1998 13:30:12 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi List,

Going over the linux archives I see over 5 emails
from people hitting this problem.  It was upposedly already
fixed in the sources.  Looks like a lot of time and grief
would be saved just by deleting the bad precompiled kernel
from linux and putting one that should work on any Indy
(R4400, R4600, R5000, with/without Scache) instead...

Anyone voluteering to put a precompiled stable current
kernel on linus ?

-- 
Peace, Ariel

Enclosing what I found about this in the archive (trimmed down):
----------------------------------------------------------------


Date: Thu, 24 Jul 1997 23:15:26 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>

- While doing a lot of NFS stuff, I got a the following panic:

Got a bus error IRQ, shouldn't happen yet
...
Cause: 00004000
Spinning

and then the whole thing locks.  I'm using Mike Shaver's 2.1.43.  Should
anyone have a brand new 2.1.47, I'd love to try it.




Date: Fri, 5 Sep 1997 17:30:59 -0500
Message-Id: <199709052230.RAA21201@speedy.rd.qms.com>
From: Mark Salter <marks@sun470.sun470.rd.qms.com>

Mike Shaver said:
> because heavy ethernet traffic occasionally generates bus errors that
> lock up the box.  I'm going to take a look at what causes those
> tomorrow, hopefully.

These finally annoyed me to the point I started looking at it today. I
was able to hack the buserr irq handler to set up a gdb frame so that
gdb gets control at the instruction that was interrupted. The problem
appears to be in sgiseeq.c which is no great surprise since it occurs
during times of heavy network traffic. The bus error irqs always occur
when interrupts are reenabled in the ret_from_sys_call after a sgiseeq
irq. The hpc_ethregs tx_ctrl value is 0x1 indicating that transmit was
inactive, but there was an underflow. The tx_ndptr value is 0xffffffff.
The latter I think leads to the bus error. Look at kick_tx() being
called from sgiseeq_tx() during the handling of the interrupt. With
that value of tx_ndptr, kick_tx would end up writing to 0xbffffff0
which is not we want to do. I don't have the HPC docs, so I'm probably
not going to be able to come up with a proper fix...

--Mark


Date: Tue, 23 Sep 1997 13:37:28 -0500
Message-Id: <199709231837.NAA20145@speedy.rd.qms.com>
From: Mark Salter <marks@sun470.sun470.rd.qms.com>
To: miguel@nuclecu.unam.mx

>> [5] Verify that the latest source tree on Llinus compiles and boots
>> (maybe automate this with a daily build that gets tested)

> I checked this yesterday when I commited my code to linus.

Yes, but I bet you didn't check it on an Indy with no scache :-)
I have one of those beasts and the latest code in the cvs tree
crashes early in the boot process.

The code in arch/mips/mm/r4xx0.c which sets up the cache flush
procs now selects r4k_flush_page_to_ram_d32i32_r4600 where
earlier versions of r4xx0.c selected r4k_flush_page_to_ram_d32i32.
I think the current choice is correct in that my Indy has the
R4600 cache bug mentioned in IDT's errata. But the *_r4600 version
also has some inline assembler under an ifdef CONFIG_SGI which
appears to do something to the SGI scache. But since I have
no scache, I get a bus error irq instead.

It seems a bit strange that r4k_flush_page_to_ram_d32i32_r4600
has this bit of SGI specific code, but r4k_flush_page_to_ram_d32i32
does not. ???

--Mark


Date: Tue, 23 Sep 1997 15:40:35 -0700
Message-Id: <199709232240.PAA09768@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Mark Salter <marks@sun470.sun470.rd.qms.com>
Cc: miguel@nuclecu.unam.mx, ariel@cthulhu.engr.sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: Task list --preliminary list

 > It seems a bit strange that r4k_flush_page_to_ram_d32i32_r4600
 > has this bit of SGI specific code, but r4k_flush_page_to_ram_d32i32
 > does not. ???

     I have not looked at the source, but the problem is probably that
there needs to be two cases, one with and one without Indy R4600 scache.
This is determined by reading out the EEPROM on the CPU board, and looking
at the appropriate bits for "scache present" and "scache size".  The 
processor will get a bus error trying to reference the control registers
of the scache controller (via uncached memory references) if the secondary
cache is not present.


From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709232334.BAA03833@informatik.uni-koblenz.de>
Received: by erbse (SMI-8.6/KO-2.0)
        id BAA04268; Wed, 24 Sep 1997 01:34:50 +0200
Subject: Re: Task list --preliminary list
To: marks@sun470.sun470.rd.qms.com (Mark Salter)
Date: Wed, 24 Sep 1997 01:34:50 +0200 (MET DST)

> 
> It seems a bit strange that r4k_flush_page_to_ram_d32i32_r4600
> has this bit of SGI specific code, but r4k_flush_page_to_ram_d32i32
> does not. ???

The R4400 versions of the Indy have the "real" second level cache and
use a SC CPU version.  Opposed to that the  L2 cache of the R4600 and
R5000 Indies is controlled by external circuitry which needs special code.

Actually since we have the same problem on a couple of other machines,
SNI RM family one of them,  what should be done is to break out all the
#ifugly'ed SGI bits and provide some hooks for them.  You L2 less
machine would simply plug an empty function into these hooks.

Using r4k_flush_page_to_ram_d32i32 was definately wrong, the R4600
cache is two way set associative and flush_page_to_ram needs to take
care of that for all the R4600 and R5000 relatives.

  Ralf


From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199711272254.OAA27112@oz.engr.sgi.com>
Subject: Re: Problems with booting SGI/Linux
To: kron@informatics.muni.cz (David Kostal)
Date: Thu, 27 Nov 1997 14:54:20 -0800 (PST)

:
:Hallo,
:I've tried to run sgi/linux on our INDY/R4600PC 100MHz, but I was
:unable to boot the kernel. I used kernel from
:test/vmlinux-970916-efs.gz . The booting process stoped after while. 
:I use this kernel, because I wasn't able to cross-compile my own
:kernel.
:I send you the messages (handly) rewriten from the console. Can you,
:please, lat me know, where was problem? If you wil need more info or
:more tests on my Indy, I will do it.
:
:thanks a lot
:
:david kostal (kron@fi.muni.cz)
:----+
:
:
:
:PROMLIB: SGI ARCS firmware Version1 Revision 10
:PROMLIB: Total free ram 31502336 bytes (...)
:ARCH: SGI-IP22
:CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
:Loading R4000 MNV routines
:CPU revision is: 00002020
:Primary ICACHE 16K (linesize 32 bytes)
:Primary DCACHE 16K (linesize 32 bytes)
:R4600/R5000 SCACHE size 0 Kb linesize 32 bytes
:MC: SGI memory controller Revision 3
:calculating r4koff ... 0007eedc(519900)
:GFX INIT: SHMIQ setup
:usenamedone misc device registred (minor: 151)
:umesa device registred (major 86)
:video screen size is 00004c88a18833e948
:console: 16 point font, 992 scans
:console: color NEWPORT 158x62, 1 virtual console (max 63)
:Calibrating delay loop ... ok - 103.83 BogoMIPS
:Memory: 28616/163836 available (1020k kernel code, 2352k data)
:Swansea University Computer Society NET3.035 for Linux 2.0
:NET3: Unix domain sockets 0.13 for Linux NET3.035.
:Swansea University Computer Society TCP/IP for NET3.034
:IP Protocols: IGMP, ICMP, UDP, TCP
:Checking 'wait' instruction... available.
:Linux version 2.1.55 (slaue@neor.ingenia.ca) (gcc version 2.7.2) #122 9.16. 16:30:52
:Posix counfornance testing by UNIFIX
:Starting kswapd v 1.2.3
:SGI Zilog 8530 serial driver version 1.08 tty00 at 0xbbbd9838 (irq = 21) is a Zilog 8530
:SGI Zilog 8530 serial driver version 1.08 tty01 at 0xbbbd9830 (irq = 21) is a Zilog 8530
:Got a bus error IRQ, shouldn't happen yet
:$0 :0000 0000 1000 bc01 8811 0000 0000 0000
:$4 :8813 418c 8819 9630 89ff 5cf0 0000 0001
:$8 :1000 fc03 0000 0201 0000 9fe1 8811 99d8
:$12:0000 0001 0000 0001 0000 0001 ffff fffc
:$16:0000 c000 89fe 1000 0000 0000 0000 0000
:$20:987b fc20 a874 6d10 9fc5 5664 0000 0000
:$24:1000 bc01 0000 000f 0000 0000 0000 0000
:$28:0000 0000 89ff 5c90 0000 0001 8800 b0c8
:epc: 88033258
:slots: 1000fc03
:Cause: 0000 4000
:Spinning.....


Date: Sun, 30 Nov 1997 20:41:40 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: More news...

The good news [deleted]

The bad news:

Still more libc problems, but I'll quit whining about that since Ralf
kindly told me to cross cross my own.  I'm looking at my cross-compiler
problems now.

Next problem:
I was running a ./configure for the nfs-server package, and I got a few
segfaults, followed by many copies of this on the console:

release_dev: pty1: read/write wait queue active!

and finally:
Got a bus error IRQ, shouldn't happen yet
and a freeze.


Date: Thu, 11 Dec 1997 23:03:50 +0100
From: Benjamin Pannier <NOSPAMkaro@artcom.net>
Reply-To: karo@artcom.net


ralf@uni-koblenz.de wrote:
> 
> On Tue, Dec 09, 1997 at 07:34:21PM -0500, Michael Hill wrote:
> 
> > Thanks for the kernel binary.  Unfortunately it quits in the same spot as the
> > previous kernel I tried (the R4600 V2.0 problem).  You said you had a stable
> > kernel on the SNI RM200.  This time I used the Indy kernel; should I try the
> > rm200 kernel?
> 
> If your have a RM200 ...
> 
> Is it still that bus error message you get?  If so, could you please mail
> me the register dump displayed on the screen.

vmlinux-indy-2.1.67:

ARCH: SGI-IP22 
CPU: MIPS-4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
Loading R4000 MMU routines
CPU revision is: 00002020
...
Stating kswapd v1.23
SGI Zilog8530 serialdriver V1.00
tty00 at 0xbfbd9838 (irq = 21) is Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is Zilog8530
loop: registered device at major 7
Got a bus error IRQ, shouldn't ...
$0 : 00000000 1000fc01 88130000 00000000
$4 : 88174274 8812cb10 8fff1cd8 00000001
$8 : 1000fc03 00000201 0000ffe5 8813de68
$12: 00000001 00000001 00000001 fffffffc
$16: 0000c000 8ffe5000 00000000 00000000
$20: a8747330 9fc47a40 00000000 9fc47a40
$24: 1000fc01 0000000f
$2:  00000000 8fff1cb8 9fc47bac 8800b0e8
epc: 880359f8
status: 1000fc03
cause: 00004000
Spinning...

-karo


From: ralf@uni-koblenz.de
Date: Fri, 12 Dec 1997 03:34:48 +0100
To: linux@cthulhu.engr.sgi.com
Subject: Indy crash during bootup

On Thu, Dec 11, 1997 at 06:12:24AM -0500, Michael Hill wrote:

> Got a bus error IRQ, shouldn't happen yet
> $0 : 00000000 00000000 0007c000 8007d000
> $4 : 00000080 89f7d000 1000fc01 8007cfe0
> $8 : 80000000 00000000 00009f7c 8813de68
> $12: 00000001 00000001 00000001 fffffffc
> $16: 09f7c000 89f7c000 00000000 00000000
> $20: a87ffc20 a8746d60 9fc556d4 00000000
> $24: 1000fc01 0000000f
> $28: eb3b6f7f 89f81d90 00000001 880f2890
> epc   : 88026918
> Status: 1000fc03
> Cause : 00004000
> Spinning...

Ok, I did some further analysis.  Dissassembling shows that Benjamin's
report doesn't really contain useful data.  His machine took the
bus error interrupt while processing some other exception.  Michael's
machine took the bus error at the end of r4k_flush_page_to_ram_d32i32_r4600()
which is being called during sgiwd33.c:sgiwd93_detect().c.

Since the R4600 v2.0 is running rocksolid - my RM200 is up for over two
weeks - the problem seems to be in the SGI specific code in the function
that handles the Indy style l2 caches.

Hmm...  I just noticed in Benjamin's startup messages that his machine
doesn't print a message (``Enabling R4600 SCACHE'') about activating the
second level cache.  I bet both your and Benjamin's machines don't have
second level caches.  Could you check the hinv output, please?

William: would an attempt to manipulate the R4600 second level cache on
a Indy without such a cache result in a bus error interrupt?

  Ralf


[and later]
On Thu, Dec 11, 1997 at 11:03:50PM +0100, Benjamin Pannier wrote:

> tty01 at 0xbfbd9830 (irq = 21) is Zilog8530
> loop: registered device at major 7
> Got a bus error IRQ, shouldn't ...

Bad, the two register dumps you and Mike mailed don't make very much
sense; the epc register is pointer to completly different routines.
What both reports have in common is that the kernel dies after the
initialisation of the loop device.  The loop driver is actually
``harmless'' as it has no SGI specific code.  The next driver to
be initialized would be the SCSI driver, so the problem is there.
This and the useless epc values might indicate a problem with the
hpc dma.

I wonder if the DMA engine in the HPC might still be active?

I'm going to try to solve the problem by starring at the source.  If
this doesn't help, could you guys please run a special debug kernel
that I'll make for you?

  Ralf

From: Joachim Schmitz <jojo@unixpc.dus.Tandem.COM>
Message-Id: <199712161036.LAA07650@unixpc.germany.tandem.com>
Subject: bus error IRQ
To: linux@cthulhu.engr.sgi.com
Date: Tue, 16 Dec 1997 11:36:08 +0100 (CET)
Organization: Tandem Computers GmbH

Hi list

I'm new to this list and currently trying to setup my Indy for Linux.
For a start I tried just to boot vmlinux-970916-efs and vmlinux-2.1.67
... without success. Both boots ends up with:

boot vmlinux-2.1.67
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 64376832 bytes (62868k,61MB)
ARCH: SGI-IP22
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
Loading R4000 MMU routines.
CPU revision is: 00002020
Primary ICACHE 16k (linesize 32 bytes)
Primary DCACHE 16k (linesize 32 bytes)
R4600/R5000 SCACHE size 0K linesize 32 bytes
MC: SGI memory controller Revision 3
calculating r4coff... 000a8fe8(692200)
GFX INIT: SHMIQ setup
usemaclone misc device registered (minor: 151)
Video screen size is 00004c88 at 883e5d48
Console: 16 point font, 992 scans
Console: color NEWPORT 158x62, 1 virtual console (max 63)
Calibrating delay loop.. ok - 138.04 BogoMIPS
Memory: 60304k/196196k available (1164k kernel code, 2880k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: IGMP, ICMP, UDP, TCP
Checking for 'wait' instruction... available.
Linux version 2.1.67 (ralf@indy) (gcc version 2.7.2) #1 Sat Dec 6 12:48:52 PST 1997
POSIX conformance testing by UNIFIX
Starting kswapd v 1.23
SGI Zilog8530  serial driver version 1.00
tty00 at 0xbfdb9838 (irq=21) is a Zilog8530
tty01 at 0xbfdb9830 (irq=21) is a Zilog8530
loop: registered device at major 7
Got a bus error IRQ, shouldn't happen yet
$0 : 00000000 1000fc01 88130000 00000000
$4 : 88174274 8812cb10 883fdcb8 00000001
$8 : 1000fc03 00000201 0000bf81 8813de68
$12: 00000001 00000001 00000001 fffffffc
$16: 0000c000 8bf81000 00000000 00000000
$20: a87ffc20 a8746d10 9fc55064 00000000
$24: 1000fc01 0000000f
$28: 881da370 883fdcb8 00000001 8800b0e8
epc   : 880359f8
Status: 1000fc03
Cause : 00004000
Spinning...


Date: Tue, 16 Dec 1997 13:24:07 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Joachim Schmitz <jojo@unixpc.dus.Tandem.COM>
Cc: linux@cthulhu.engr.sgi.com


On Tue, Dec 16, 1997 at 11:36:08AM +0100, Joachim Schmitz wrote:

> I'm new to this list and currently trying to setup my Indy for Linux.
> For a start I tried just to boot vmlinux-970916-efs and vmlinux-2.1.67
> ... without success. Both boots ends up with:
> 
> boot vmlinux-2.1.67
> PROMLIB: SGI ARCS firmware Version 1 Revision 10
> PROMLIB: Total free ram 64376832 bytes (62868k,61MB)
> ARCH: SGI-IP22
> CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
> Loading R4000 MMU routines.
> CPU revision is: 00002020
> Primary ICACHE 16k (linesize 32 bytes)
> Primary DCACHE 16k (linesize 32 bytes)
> R4600/R5000 SCACHE size 0K linesize 32 bytes
                          ^^
That's the problem, there is a kernel bug which prevents Linux from
working on R4600/R5000 Indys without second level cache.  My next
kernel release will fix that.


  Ralf
