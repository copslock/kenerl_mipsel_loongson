Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6IhVQ26111
	for linux-mips-outgoing; Thu, 6 Dec 2001 10:43:31 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB6IhNo26104
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 10:43:24 -0800
Received: from defiant.informatik.uni-bremen.de (defiant.informatik.uni-bremen.de [134.102.204.163]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09299
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 09:43:19 -0800 (PST)
	mail_from (cbusse@defiant.informatik.uni-bremen.de)
Received: (from cbusse@localhost)
	by defiant.informatik.uni-bremen.de (8.11.6/8.11.6/SuSE Linux 0.5) id fB6HQK216786
	for linux-mips@oss.sgi.com; Thu, 6 Dec 2001 18:26:20 +0100
Date: Thu, 6 Dec 2001 18:26:20 +0100
From: carsten busse -- hladmin <cbusse@defiant.informatik.uni-bremen.de>
To: linux-mips@oss.sgi.com
Subject: Linux on Indy, kernel compile (2.4.14) and xfree ...
Message-ID: <20011206182620.A16589@defiant.informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello all,

I'm relatively new to the SGI Indy Hardware, and it was quite a funny thing how I got involved using it ...

Nevertheless I do have 4 indy's here in my project room, and one of these just for getting linux to run on it. 
what i've done already:

i've installed the root-filesystem from oss.sgi.com/pub/linux/mips/redhat/test-7.0 and other packages from this directory (I've tried the 5.1-version before, but the tools were too old for me).
The kernel 2.4.1 is running quite ok, but i couldn't get the XFree-rpm running

XFree complains about some missing module information in libbitmap.a!? i will try and compile a new XFree 4.1.0, but first i'd like to use a newer kernel
(i am trying 2.4.14 know, but the same is going for 2.4.16, which i've tried before
 i am using gcc 2.95.3, native mips
 The gfx hardware from what the kernel told me is:
 NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9 revision A, cmap revision D, bt445 revision D
 NG1: Screensize 1280x1024
 is this maybe unsupported? i do not know how to decide if its ex or zx or whatsoever ... :(
 the virtual console is running with the newport driver from the kernel 
 )

Now i found out, that there are some weird inconsistencies in the kernel source code, while compiling on mips-arch (a longer text, but all my steps are written down):

include/asm/keyboard.h
include/linux/vt_kern.h

do define pckbd_rate in two different ways ((int *) and (int) as return-type)
i've decided to use (int) return type for this function in include/linux/vt_kern.h
in asm-i386 its not used , so i think its a not so necessary function

drivers/char/pc_keyb.c, line 909 needed a small change, too (kbd_rate is the same as pckbd_rate through '#define kbd_rate pckbd_rate', so i inserted a new int-variable)
                        line 800 i removed the static


next:
include/asm/softirq.h  
include/linux/interrupt.h    -- overwrites __cpu_raise_softirq from asm/softirq.h, i removed this line in favor for the definition from asm-mips


next:
drivers/scsi/scsi_merge.c: In function '__init_io':
drivers/scsi/scsi_merge.c:946 structure has no member named 'page'

this is quite natural, the mips-definition in asm/scatterlist.h does not contain this var (but the one in asm-i386)
so i've commented this one out, too,
someone needs to put in an #ifdef statement, to determine if we want to compile on mips -> discard the line 


next:
drivers/scsi/sgiwd93.c:
in line 59,60 and 61 i inserted a cast to (unsigned long), otherwise the operation was invalid
in line 102 and 174, the member of the struct is not called "regp" but "regs", and its not (wd33c93_regs *) but (wd33c93_regs)
in line 293 and 327, the second parameter from wd33c93_init is not from type wd33c93_regs * but wd33c93_regs, so some hacking required

next:
drivers/scsi/st.c: 3236, 3268, 3342 same as with drivers/scsi/scsi_merge.c 
drivers/scsi/sg.c: 1547, 1634, 1792 dito
 
next:
drivers/sgi/char/rrm.c:74 and 75  the export from the .o-version does only function, when it is inserted in export-objs in Makefile

------ 
my question is, are these steps ok? or did i miss something, did something wrong? i thought these kernels should compile without problems ;)?

ok, i will try the kernel (not before tomorrow, its already late enough), if it runs, it should be ok, or not? :)
i do not know if these are all steps needed, because i want to finish for today. if theres something missing, i will update tomorrow

thanks for any help, you may can give,

wbr
carsten

flame me, if there is a doc/faq i've missed where all my answers are
