Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8J2vBH14713
	for linux-mips-outgoing; Tue, 18 Sep 2001 19:57:11 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8J2uxe14698
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 19:56:59 -0700
Received: from nevyn.them.org (NEVYN.RES.CMU.EDU [128.2.145.6]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA00133
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 19:56:46 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15jXNU-0005qP-00; Tue, 18 Sep 2001 22:46:20 -0400
Date: Tue, 18 Sep 2001 22:46:20 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Shaolin Zhang <zhangshaolin@huawei.com>
Cc: linux-mips@oss.sgi.com, Ernest Jih <ernest.jih@idt.com>,
   recc stone <renwei@huawei.com>
Subject: Re: kgdb with linux-mips problem
Message-ID: <20010918224620.A22455@nevyn.them.org>
References: <00fe01c140b4$ad3f9200$cd22690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <00fe01c140b4$ad3f9200$cd22690a@huawei.com>; from zhangshaolin@huawei.com on Wed, Sep 19, 2001 at 10:42:08AM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

What version of GDB are you using?  I recommend you get the current CVS
snapshot and try again.

On Wed, Sep 19, 2001 at 10:42:08AM +0800, Shaolin Zhang wrote:
> Hello ,
> 
>   Now we have some problems in using kgdb to debug the Linux-mips kernel on IDT 79s334A board.
> 
> 1.I enabled the kernel startup option kgdb=on to debug the kernel setup.
>   At first, the gdb on host pc connected to the target boards correctly.
>   Then I use a few "n"(Next) command to debug the kernel, but the kernel
> seems
>  to run out of my hands, as if I had executed some "c" command.
>   I use "set debug remote 1"  command to see the packets gdb send&receive:
>   and find :
>    the gdb send a "c" packet to the stub at the end of packet sequence.
> 
>   I guess that the gdb on the host pc send some wrong command , or it can't
> get right info
>   to debug?
> 
> 
> 2.I want to debug some init_module function in module , like this :
> 
> int init_module(void)
> {
>     breakpoint(); // use the breakpoint function in kernel to get a break.
>     my_functions();
> }
> 
> When I insmod this module, it through exception 9 (breakpoint), then I run
> "bt"
> command in gdb, but this time gdb report "can't find the start of function
> 0x....".
> Is this a gdb problem or gdb stub problem? BTW, when I first bootup the
> kernel
> and connect the gdb&stub ,the sample problem happened.
> 
> 

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
