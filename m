Received:  by oss.sgi.com id <S305156AbQEIXeC>;
	Tue, 9 May 2000 23:34:02 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:52274 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEIXdo>;
	Tue, 9 May 2000 23:33:44 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA05520; Tue, 9 May 2000 16:28:54 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA06839
	for linux-list;
	Tue, 9 May 2000 16:24:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA95606
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 9 May 2000 16:24:20 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
From:   nick@ns.snowman.net
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA02036
	for <linux@cthulhu.engr.sgi.com>; Tue, 9 May 2000 16:24:19 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.1a/8.9.0) with ESMTP id TAA15067;
	Tue, 9 May 2000 19:26:00 -0400
Date:   Tue, 9 May 2000 19:26:00 -0400 (EDT)
To:     Florian Lohoff <flo@rfc822.org>
cc:     Klaus Naumann <spock@mgnet.de>,
        Debian MIPS <debian-mips@lists.debian.org>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Problems with cvs kernel on Indigo2
In-Reply-To: <20000506131018.C606@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.05.10005091925300.14753-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

If you are looking for an Indy there are some floating around cheap (~250$
after shipping) in the us.
	Nick

On Sat, 6 May 2000, Florian Lohoff wrote:

> On Sat, May 06, 2000 at 01:06:15PM +0200, Klaus Naumann wrote:
> 
> > 1. The network driver is completely broken. The output of ifconfig
> > shows the eth0 device about 8 times and network isn't working at all.
> > ifconfig up & down didn't change anything.
> 
> I am not seeing this on my indigo2.
> 
> > 2. There are messages in my kernel log like:
> > Bug in get_wchan
> > Due to my still very limited knowledge about the kernel I don't know
> > what's the problem, I only know that this error is generated in the 
> > get_wchan function in arch/mips/kernel/process.c
> 
> I already had a go in the source.
> 
> The problem is that with some "ps" output you want to see the kernel
> "function" the process got stuck in when it was scheduled. Now - There
> are a couple of possible functions which might be used to schedule
> namely all the ones in kernel/sched.c between
> 
> void scheduling_functions_start_here(void) { }
> 
> and
> 
> void scheduling_functions_end_here(void) { }
> 
> As the calling convention for mips just says the return address (Which
> is the interesting thing to return in get_wchan() ) is passed in
> the "ra" register. Somewhere in the functions between the two markers
> above (e.h. asmlinkage void schedule(void)) the "ra" gets pushed on
> the stack. Now - get_wchan has to find out WHICH function did
> the schedule and depending on the function retrieve the return
> address for the specific process from the stack. On some architectures
> this is simple or you even can search the stackpage which mips/mipsel
> cant do. Where the return address is stored on the stack
> for the specific functions can be seen in the gdb.
> 
> (gdb) disass schedule
> Dump of assembler code for function schedule:
> 0x8802565c <schedule>:  addiu   $sp,$sp,-48
> 0x88025660 <schedule+4>:        sw      $ra,40($sp)
> 0x88025664 <schedule+8>:        sw      $s8,36($sp)
> 0x88025668 <schedule+12>:       sw      $s4,32($sp)
> 0x8802566c <schedule+16>:       sw      $s3,28($sp)
> 0x88025670 <schedule+20>:       sw      $s2,24($sp)
> 0x88025674 <schedule+24>:       sw      $s1,20($sp)
> 0x88025678 <schedule+28>:       sw      $s0,16($sp)
> 0x8802567c <schedule+32>:       lw      $s0,48($gp)
> 0x88025680 <schedule+36>:       bnez    $s0,0x880256a4 <schedule+72>
> 0x88025684 <schedule+40>:       move    $s8,$sp
> 0x88025688 <schedule+44>:       lui     $a0,0x8812
> 0x8802568c <schedule+48>:       addiu   $a0,$a0,18536
> 0x88025690 <schedule+52>:       lui     $a1,0x8812
> 0x88025694 <schedule+56>:       addiu   $a1,$a1,18780
> 
> As you can see "ra" gets pushed on the stack at sp + 0x40 
> 
> In "get_wchan" you see the following
> 
>     204         pc = thread_saved_pc(&p->thread);
> 
> Get the programm counter - Means - You can find out which
> function did the schedule.
> 
>     212                 schedule_frame = ((unsigned long *)p->thread.reg30)[9];
> 
> Get the stack pointer.
> 
>     213                 return ((unsigned long *)schedule_frame)[16];
> 
> And return the 16ths long of the stack -> 16 * 4 -> 64 ...
> 
> Now we found the "real" programm counter where the thread scheduled.
> 
> Now we try if this is inbetween the scheduling functions which could
> mean we havent found the return address on the stack.
> 
>     215         if (pc >= first_sched && pc < last_sched) {
>     216                 printk(KERN_DEBUG "Bug in %s\n", __FUNCTION__);
>     217         }
> 
> And there is your "Bug in get_wchan()"
> 
> > Is there anyone out there who has solutions for the named problems ?
> 
> The "Bug in get_wchan()" is quiet obvious to fix - The day i 
> get my Indy ill be able to do a bit more kernel things.
> 
> The "Ethernet" is a bit mysterious to me. 
> 
> Flo
> -- 
> Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
> "Technology is a constant battle between manufacturers producing bigger and
> more idiot-proof systems and nature producing bigger and better idiots."
> 
