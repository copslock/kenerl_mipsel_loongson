Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Dec 2002 20:20:29 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:38648 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225195AbSLBTU3>;
	Mon, 2 Dec 2002 20:20:29 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gB2JKKq04708;
	Mon, 2 Dec 2002 11:20:20 -0800
Date: Mon, 2 Dec 2002 11:20:20 -0800
From: Jun Sun <jsun@mvista.com>
To: henaldohzh@hotmail.com
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Problem about porting mips kernel
Message-ID: <20021202112020.I4363@mvista.com>
References: <F116EbjkyqU7a0xtAEH00000946@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <F116EbjkyqU7a0xtAEH00000946@hotmail.com>; from henaldohzh@hotmail.com on Thu, Nov 28, 2002 at 02:42:22AM +0000
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I have vr4131 board running just fine here for quite a while now.

A couple of basic things you may to check with:

. Make sure you have CONFIG_CPU_VR41XX set (obviously).
. Use your own init program that poke some devices other
  than console.  Just to make sure it is *not* the SIU
  console driver problem.

Other things you want to check is the CPU revision.  Make sure
it is 0x0c82, which is v2.2.  Otherwise there are some nasty
cache problems you need to work around.

What is your kernel base?  The latest linux-mips.org CVS tree?

Jun

On Thu, Nov 28, 2002 at 02:42:22AM +0000, henaldohzh@hotmail.com wrote:
>  I carefully check the codes of TLB, but no any problem found.
>  And I debug my kernel, I found that before init task jump into 
> application, it means after do_execve, sp is 0. it is for 
> __strnlen_user_asm function return invalid result. And I done a little 
> change(only for test), the system stop after ret_from_syscall. In normal, 
> it should jump to user space to execute user task.
> before ret_from_syscall, the start_thread arguments 
> is:"elf_entry:0x2aaa8a00,user_sp is:0x7fff7f40,cp0_status is:0x200cc13".I 
> determine that the arguments are correct. But why my application cann't run 
> at all?
> > >   these days, I am busy with porting mips kernel to a board with vr4131
> > > core. This board has only SIU serial port, and some hw have been 
> modified.
> > > Now, I have ported the kernel to it, and modified hw run well. But so
> > > puzzling me, the execution file cann't run at all. If some one can help 
> me
> > > or give some advices. I have been crazy for the problem. Off hat for 
> your
> > > help. Thanks a lot.
> > >  btw, I use the ramdisk with busybox.
> >
> >In general this kind of problem means the tlb or cache code for a 
> particular
> >platform is faulty or the kernel not configured properly.
> >
> >   Ralf
> 
> 
> _________________________________________________________________
> 与联机的朋友进行交流，请使用 MSN Messenger: http://messenger.msn.com/cn 
> 
> 
