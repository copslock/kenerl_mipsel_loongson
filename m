Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBU3GMZ03511
	for linux-mips-outgoing; Sat, 29 Dec 2001 19:16:22 -0800
Received: from apollo.bingo-ev.de (mail@apollo.bingo-ev.de [213.70.214.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBU3GFg03508
	for <linux-mips@oss.sgi.com>; Sat, 29 Dec 2001 19:16:15 -0800
Received: from fake by apollo.bingo-ev.de with local (Exim 3.32 #1 (Debian))
	id 16KVX1-0007aM-00
	for <linux-mips@oss.sgi.com>; Sun, 30 Dec 2001 03:16:59 +0100
Date: Sun, 30 Dec 2001 03:16:58 +0100
From: fake@bingo-ev.de
To: linux-mips@oss.sgi.com
Subject: Introduction, errors in devfs and ARC, success: 2.4.16 on R4K I2, oops with 2.5.1
Message-ID: <20011230031658.A28756@apollo.bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi there,

as this is my first post, i'd like to introduce myself, although it 
may be a bit off-topic ;-) My pseudonym is FAKE, i'm from germany 
and proud owner of an Indigo2 R4k. I just found enough time 
(thanks, santa) to fire up linux on it. My System is:

Indigo2, ~160MB RAM, GR3-XZ Gfx Board, R4400 proc.

this is my /dev/cpuinfo:
system type             : SGI Indigo2
processor               : 0
cpu model               : R4000SC V5.0  FPU V0.0
BogoMIPS                : 74.75
byteorder               : big endian
wait instruction        : no
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 23868
VCEI exceptions         : 32852

(the PROM hinv says i have a R4400 and a FPU ... is cpuinfo right?)

Anyways, i want to contribute, and so i got the 2.5.1 kernel from 
oss.sgi.com via cvs and compiled it. it boots, but exactly when the
scsi-driver is about to add the disk it oopses and i get the message 

<1>Unable to handle kernel paging request at virtual address 00000000, epc == 880db32c, ra == 880
db270
Oops in fault.c:do_page_fault, line 204:
.... ( insert useless stack trace here, becuz of non-saved system map *dough*)

sorry for not saving the System.map >_< i'll check in more deeply if i get oopses in future.

then i compiled 2.4.14, it worked, but somehow debian didn't like it, but that's not the kernel's
fault. Anyways, now i compiled the 2.4.16 and everything just works fine - except devfs and the ARC
console. Devfsd says:

Error getting protocol revision Inappropriate ioctl for device

and the ARC console (one thing i especially want to get to work) behaves strange:
As the kernel starts writing output the PROM console adds black lines to the screen,
whilest the data from before the kernel started output (boot linux console=ttyS0... etc)
nicely scrolls UP........ what to do? i tried to find information about the PROM on
oss.sgi.com and toolbox.sgi.com, but both seem _DAMN_ outdated (the newest "news" are from
2000 or something) so i'm stuck....

i would enjoy helping, but i'm still learning, as i am very new to the mips platform...
i have some experiences with linux/the kernel in general on the intel32 platform.

well, plz reply, so i can start coding ^-^

greetz & thanx in advance

FAKE
