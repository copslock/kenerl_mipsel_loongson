Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBU4VDJ04054
	for linux-mips-outgoing; Sat, 29 Dec 2001 20:31:13 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBU4V1g04051
	for <linux-mips@oss.sgi.com>; Sat, 29 Dec 2001 20:31:02 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBU3UqW03624;
	Sun, 30 Dec 2001 01:30:52 -0200
Date: Sun, 30 Dec 2001 01:30:52 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: fake@bingo-ev.de
Cc: linux-mips@oss.sgi.com
Subject: Re: Introduction, errors in devfs and ARC, success: 2.4.16 on R4K I2, oops with 2.5.1
Message-ID: <20011230013052.A2980@dea.linux-mips.net>
References: <20011230031658.A28756@apollo.bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011230031658.A28756@apollo.bingo-ev.de>; from fake@bingo-ev.de on Sun, Dec 30, 2001 at 03:16:58AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Dec 30, 2001 at 03:16:58AM +0100, fake@bingo-ev.de wrote:

> as this is my first post, i'd like to introduce myself, although it 
> may be a bit off-topic ;-) My pseudonym is FAKE, i'm from germany 

People here tend to have the courage of using their real name ;-)

> and proud owner of an Indigo2 R4k. I just found enough time 
> (thanks, santa) to fire up linux on it. My System is:
> 
> Indigo2, ~160MB RAM, GR3-XZ Gfx Board, R4400 proc.
> 
> this is my /dev/cpuinfo:
> system type             : SGI Indigo2
> processor               : 0
> cpu model               : R4000SC V5.0  FPU V0.0

Interesting.  Thanks for reporting.

> BogoMIPS                : 74.75
> byteorder               : big endian
> wait instruction        : no
> microsecond timers      : yes
> extra interrupt vector  : no
> hardware watchpoint     : yes
> VCED exceptions         : 23868
> VCEI exceptions         : 32852

> (the PROM hinv says i have a R4400 and a FPU ... is cpuinfo right?)

Yes and no.  R4000 and R4400 are basically the same thing aside of the R4400
having less (that is different ;-) bugs, the version number and the R4400
having twice as much cache.  In other words the marketing droids were in
need of a new CPU type back in time, I guess ;-)

> Anyways, i want to contribute, and so i got the 2.5.1 kernel from 
> oss.sgi.com via cvs and compiled it. it boots, but exactly when the
> scsi-driver is about to add the disk it oopses and i get the message 
> 
> <1>Unable to handle kernel paging request at virtual address 00000000, epc == 880db32c, ra == 880
> db270
> Oops in fault.c:do_page_fault, line 204:
> .... ( insert useless stack trace here, becuz of non-saved system map *dough*)

That's almost as expected, unfortunately.  2.5.1 changes blockdevice I/O 
entirely and our SCSI drivers don't yet reflect that.

> sorry for not saving the System.map >_< i'll check in more deeply if i get
> oopses in future.

An unstripped vmlinux ELF binary has all the information of System.map in
it.

> then i compiled 2.4.14, it worked, but somehow debian didn't like it, but
> that's not the kernel's fault. Anyways, now i compiled the 2.4.16 and
> everything just works fine - except devfs and the ARC
> console. Devfsd says:
> 
> Error getting protocol revision Inappropriate ioctl for device

Which ioctl / device?

Most people on MIPS seem to try to get away without devfs so it's
heavily untested.  This one should be easy to fix though as devfs doesn't
have alot of portability problems.

> and the ARC console (one thing i especially want to get to work) behaves
> strange: As the kernel starts writing output the PROM console adds black
> lines to the screen, whilest the data from before the kernel started
> output (boot linux console=ttyS0... etc) nicely scrolls UP........ what
> to do? i tried to find information about the PROM on oss.sgi.com and
> toolbox.sgi.com, but both seem _DAMN_ outdated (the newest "news" are from
> 2000 or something) so i'm stuck....

The firmware is not exactly well documented.  The closest document is a
MS Word document which used to available from (surprise) at
http://www.microsoft.com/hwdev/download/respec/riscspec.zip seems it's no
longer available.  The document is (C) by MIPS, so I hope it's still
available somewhere on the net.  Anyway, SGI's ARCS implementation
violates the ARC specification quite badly so this is just a rough
guideline.

Yes, we're not the kings of documentation :-)

> i would enjoy helping, but i'm still learning, as i am very new to the
> mips platform...

Welcome to hell.  We'll do everything to make this a warm place during
your stay  ;-)

  Ralf
