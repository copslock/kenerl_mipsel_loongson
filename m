Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 00:45:44 +0100 (BST)
Received: from [IPv6:::ffff:66.29.16.26] ([IPv6:::ffff:66.29.16.26]:54028 "EHLO
	junsun.net") by linux-mips.org with ESMTP id <S8225479AbVHYXp0>;
	Fri, 26 Aug 2005 00:45:26 +0100
Received: from gw.junsun.net (adsl-69-227-52-159.dsl.pltn13.pacbell.net [69.227.52.159])
	by junsun.net (8.13.1/8.13.1) with ESMTP id j7PNmfLm028550;
	Thu, 25 Aug 2005 16:48:41 -0700
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id j7PNomWj010560;
	Thu, 25 Aug 2005 16:50:48 -0700
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id j7PNolwH010557;
	Thu, 25 Aug 2005 16:50:47 -0700
Date:	Thu, 25 Aug 2005 16:50:47 -0700
From:	Jun Sun <jsun@junsun.net>
To:	Kishore K <hellokishore@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Preemption patch for 2.4.26 - mips
Message-ID: <20050825235047.GC10406@gw.junsun.net>
References: <f07e6e050825065756c3ac27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07e6e050825065756c3ac27@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips


You might be interested in an earlier patch I made for 2.4.21 against
MIPS CVS tree.

http://linux.junsun.net/patches/oss.sgi.com/experimental/030304-b.preempt-mips.patch

Jun

On Thu, Aug 25, 2005 at 07:57:48PM +0600, Kishore K wrote:
> When I try to compile 2.4.26 kernel with the pre-emption patch from
> (http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/)
> for malta board based on MIPS 4kc, compilation fails with the
> following error.
> 
> [kishorek@blrn0092 linux-2.4.26]$ make vmlinux.srec
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include scripts/split-include.c
> scripts/split-include include/linux/autoconf.h include/config
> mips-linux-gcc -D__KERNEL__ -I/home/kishorek/linux-2.4.26/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -fomit-frame-pointer -I
> /home/kishorek/linux-2.4.26/include/asm/gcc -G 0 -mno-abicalls
> -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=mips32 -mips32
> -Wa,-32 -Wa,-march=mips32 -Wa,-mips32 -Wa,--trap  
> -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> In file included from /home/kishorek/linux-2.4.26/include/linux/fs.h:200,
>                  from
> /home/kishorek/linux-2.4.26/include/linux/capability.h:17,            
>     from /home/kishorek/linux-2.4.26/include/linux/binfmts.h:5,
>                  from /home/kishorek/linux-2.4.26/include/linux/sched.h:9,
>                  from /home/kishorek/linux-2.4.26/include/linux/mm.h:4,
>                  from /home/kishorek/linux-2.4.26/include/linux/slab.h:14,
>                  from /home/kishorek/linux-2.4.26/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /home/kishorek/linux-2.4.26/include/asm/semaphore.h: In function
> `down_trylock':/home/kishorek/linux-2.4.26/include/asm/semaphore.h:230:
> error: `current' undeclared (first use in this function)
> /home/kishorek/linux-2.4.26/include/asm/semaphore.h:230: error: (Each
> undeclared identifier is reported only once
> /home/kishorek/linux-2.4.26/include/asm/semaphore.h:230: error: for
> each function it appears in.)
> /home/kishorek/linux-2.4.26/include/asm/semaphore.h:243: warning:
> implicit declaration of function `preempt_schedule'
> /home/kishorek/linux-2.4.26/include/asm/semaphore.h: In function `up':
> /home/kishorek/linux-2.4.26/include/asm/semaphore.h:266: error:
> `current' undeclared (first use in this function)
> In file included from /home/kishorek/linux-2.4.26/include/linux/mm.h:4,
>                  from /home/kishorek/linux-2.4.26/include/linux/slab.h:14,
>                  from /home/kishorek/linux-2.4.26/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /home/kishorek/linux-2.4.26/include/linux/sched.h: At top level:
> /home/kishorek/linux-2.4.26/include/linux/sched.h:152: warning: type
> mismatch with previous implicit declaration
> /home/kishorek/linux-2.4.26/include/asm/semaphore.h:273: warning:
> previous implicit declaration of `preempt_schedule'
> /home/kishorek/linux-2.4.26/include/linux/sched.h:152: warning:
> `preempt_schedule' was previously implicitly declared to return `int'
> In file included from /home/kishorek/linux-2.4.26/include/linux/sched.h:586,
>                  from /home/kishorek/linux-2.4.26/include/linux/mm.h:4,
>                  from /home/kishorek/linux-2.4.26/include/linux/slab.h:14,
>                  from /home/kishorek/linux-2.4.26/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /home/kishorek/linux-2.4.26/include/asm/current.h:15: error: `current'
> used prior to declaration
> make: *** [init/main.o] Error 1
> 
> May I know, if any of you tried the pre-emption patch for 2.4.26 on
> mips platform. If so, please let me know the changes to be done or any
> other patch needs to be applied.
> 
> Here are the details of my toolchain
> gcc 3.3.6, binutils: 2.14.90.0.8, uclibc-0.9.27
> Kernel configuration file is enclosed along with this mail. 
> 
> TIA,
> --kishore
