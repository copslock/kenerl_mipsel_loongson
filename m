Received:  by oss.sgi.com id <S554074AbQKJL5O>;
	Fri, 10 Nov 2000 03:57:14 -0800
Received: from mx.mips.com ([206.31.31.226]:42653 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554071AbQKJL4y>;
	Fri, 10 Nov 2000 03:56:54 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA17136;
	Fri, 10 Nov 2000 03:56:19 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA02515;
	Fri, 10 Nov 2000 03:56:38 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id MAA28191;
	Fri, 10 Nov 2000 12:56:31 +0100 (MET)
Message-ID: <3A0BE26E.77137E0E@mips.com>
Date:   Fri, 10 Nov 2000 12:56:30 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: Atlas support.
References: <3A0C3DAB.7481EECE@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

If you don't know what you are doing it is not that simple to get Atlas
support in the 2.2.14 kernel.
It will probably take me a couple of days, but I'm afraid I don't have the
time.
Right now I'm in the progress of integrating our 2.2.12 work into the 2.4.0
kernel.
I have already sent Ralf a patch, so one can run the 2.4.0 kernel on the
Atlas board with a QED, but I don't think he had committed it yet.

I hope to have a new patch with FP emulator integrated for the 2.4.0 kernel
ready in next week, if time permits it.

/Carsten

Nicu Popovici wrote:

> Hello Carsten,
>
> I so in the linux 2.2.12 on the Atlas board that you added support for
> this board in this kernel. What I need now is kernel2.2.14 for ATLAS
> boards. What should I do in order to have such a thing ?
> I did  the following :
> 1. I modified the Config.in from /linux2.2.14/arch/mips with the lines
> from 2.2.12 regarding ATLAS board. The same I did with the Makefile from
> the same directory.
> 2. copied the atlas directory from 2.2.12 into arch/mips/atlas on the
> 2.2.14 kernel and also the linux/include/asm/atlas/ from 2.2.12 into
> 2.2.14 directory .
> And now I did the following : make menuconfig and  appeared the Mips
> Atlaas Board
> make dep ( I dod not know if this is correct ) and make
> CROSS_COMPILE=mips-linux-.But I got the following errors:
>  In file included from /usr/mips-linux/include/linux/sched.h:15,
>                  from setup.c:30:
> /usr/mips-linux/include/linux/timex.h:159: field `time' has incomplete
> type
> In file included from /usr/mips-linux/include/linux/sched.h:18,
>                  from setup.c:30:
> /usr/mips-linux/include/asm/semaphore.h:30: parse error before
> `wait_queue_head_
> t'
> /usr/mips-linux/include/asm/semaphore.h:30: warning: no semicolon at end
> of stru
> ct or union
> /usr/mips-linux/include/asm/semaphore.h:34: warning: empty declaration
> /usr/mips-linux/include/asm/semaphore.h: In function `sema_init':
> /usr/mips-linux/include/asm/semaphore.h:64: dereferencing pointer to
> incompletetype
> /usr/mips-linux/include/asm/semaphore.h:65: dereferencing pointer to
> incompletetype
> /usr/mips-linux/include/asm/semaphore.h:66: dereferencing pointer to
> incompletetype
> /usr/mips-linux/include/asm/semaphore.h: In function `down':
> /usr/mips-linux/include/asm/semaphore.h:92: dereferencing pointer to
> incompletetype
> /usr/mips-linux/include/asm/semaphore.h: In function
> `down_interruptible':
> /usr/mips-linux/include/asm/semaphore.h:103: dereferencing pointer to
> incomplete
>  type
> /usr/mips-linux/include/asm/semaphore.h: In function `down_trylock':
> /usr/mips-linux/include/asm/semaphore.h:113: dereferencing pointer to
> incomplete
>  type
> /usr/mips-linux/include/asm/semaphore.h: In function `up':
> /usr/mips-linux/include/asm/semaphore.h:188: dereferencing pointer to
> incomplete
>  type
> /usr/mips-linux/include/asm/semaphore.h: At top level:
> /usr/mips-linux/include/asm/semaphore.h:219: parse error before
> `wait_queue_head
> _t'
> /usr/mips-linux/include/asm/semaphore.h:219: warning: no semicolon at
> end of str
> uct or union
> /usr/mips-linux/include/asm/semaphore.h:220: warning: data definition
> has no typ
> e or storage class
> /usr/mips-linux/include/asm/semaphore.h: In function `init_rwsem':
> /usr/mips-linux/include/asm/semaphore.h:252: dereferencing pointer to
> incomplete
>  type
> /usr/mips-linux/include/asm/semaphore.h:253: dereferencing pointer to
> incomplete
>  type
> /usr/mips-linux/include/asm/semaphore.h:254: dereferencing pointer to
> incomplete
>  type
> /usr/mips-linux/include/asm/semaphore.h:255: dereferencing pointer to
> incomplete
>  type
> /usr/mips-linux/include/asm/semaphore.h: In function `down_read':
> In file included from /usr/mips-linux/include/linux/sched.h:76,
>                  from setup.c:30:
> /usr/mips-linux/include/linux/timer.h:21: field `list' has incomplete
> type
> setup.c:59: storage class specified for parameter `atlas_irq_setup'
> setup.c:75: redefinition of `__initfunc'
> setup.c:60: `__initfunc' previously defined here
> setup.c: In function `__initfunc':
> setup.c:86: `atlas_irq_setup' undeclared (first use this function)
> setup.c:86: (Each undeclared identifier is reported only once
> setup.c:86: for each function it appears in.)
> setup.c:135: `mips_cpu' undeclared (first use this function)
> setup.c:135: `MIPS_CPU_FPU' undeclared (first use this function)
> setup.c:137: `pci_ops' undeclared (first use this function)
> [WIFEXITED(s) && WEXITSTATUS(s) == 33], 0, NULL) = 5696
> --- SIGCHLD (Child exited) ---
> stat("/tmp/cc2u8Czo.s", {st_mode=S_IFREG|0644, st_size=1823, ...}) = 0
> unlink("/tmp/cc2u8Czo.s")               = 0
> stat("/tmp/cc2u8Czo.i", {st_mode=S_IFREG|0644, st_size=61912, ...}) = 0
> unlink("/tmp/cc2u8Czo.i")               = 0
> _exit(1)                                = ?
> [root@ares kernel]#
>
> this is an output from a strace make CROSS_COMPILE=mips-linux-
>
> Maybe there is a patch for what I need , maybe some will help me .
> Thanks in advance
> Regards,
> Nicu

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
