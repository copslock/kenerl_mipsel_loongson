Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2U7s6h08503
	for linux-mips-outgoing; Fri, 29 Mar 2002 23:54:06 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g2U7s0v08499
	for <linux-mips@oss.sgi.com>; Fri, 29 Mar 2002 23:54:00 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2U7rL431434;
	Fri, 29 Mar 2002 23:53:21 -0800
Date: Fri, 29 Mar 2002 23:53:21 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Muthukumar Ratty <muthur@paul.rutgers.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: Lost when execve-ing the init.
Message-ID: <20020329235321.C31160@dea.linux-mips.net>
References: <Pine.SOL.4.10.10203212243150.12256-100000@paul.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.10.10203212243150.12256-100000@paul.rutgers.edu>; from muthur@paul.rutgers.edu on Fri, Mar 22, 2002 at 11:48:18PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 22, 2002 at 11:48:18PM -0500, Muthukumar Ratty wrote:

(Mail answering day ...)

> I was trying a kernel I made and found that I got lost after it goes to
> execve("/sbin/init") in init/main.c. I can ping the board which means the
> board is alive.

This almost sounds like you don't get any output from the console?
If so, check you configured your /dev/console right.  It should be a char
device, major device id 5, minor 1.

 I tried to trace it down but got stuck with the following
> code in "include/asm-mips/unistd.h" [ I believe it implements 
> the execve function since in the same file I have .....
> static inline _syscall3(int,execve,const char *,file,char **,argv,char
> **,envp)] 

Not really.  The execve macro there does a syscall just like a user
process would do it.

> I guess...
> After setting up the arguments its referencing (#defined ???) syscall. I
> couldnt find the definition for "syscall". Could someone point me to the 
> right place (and help me get some sleep please ;). Also any idea about how
> to debug this. (Can I set breakpoint in syscall3??). (Any idea why its not
> going.. error in my irq setup??...)

> PS : what does this funny thing mean???
> 
>    : "=r" (__res), "=r" (__err) \
>                   : "i" (__NR_##name),"r" ((long)(a)), \
>                                       "r" ((long)(b)), \
>                                       "r" ((long)(c)) \
>                   : "$2","$4","$5","$6","$7","$8","$9","$10","$11","$12",
> \
>                     "$13","$14","$15","$24"); \
> if (__err == 0) \

Don't ask :-)  Since your did anyway - it means that this piece of
inline assembler receives a integer constant argument as (__NR_#name)
and three variables casted into longs (a, b, c) as arguments.  The
results will be returned into the variables __res and __err.  Finally
the "$2" etc. are the registers that will be destroyed by the inline
code.

That was just the quick version.  The basic stuff about inline assembler
is documented in the gcc info pages.  All the nasty details are hidden
somewhere in a a few million lines of gcc code ...

  Ralf
