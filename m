Received:  by oss.sgi.com id <S42267AbQFKKw2>;
	Sun, 11 Jun 2000 03:52:28 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:59184 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42199AbQFKKwD>;
	Sun, 11 Jun 2000 03:52:03 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA12747
	for <linux-mips@oss.sgi.com>; Sun, 11 Jun 2000 03:46:37 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA60883 for <linux-mips@oss.sgi.com>; Sun, 11 Jun 2000 03:49:46 -0700 (PDT)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA06076;
	Sun, 11 Jun 2000 03:48:06 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id 1E0B7A7875; Sun, 11 Jun 2000 03:46:22 -0700 (PDT)
Date:   Sun, 11 Jun 2000 03:46:22 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     Jiri Kasi Kastner <indy.j@worldonline.cz>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: i'm not able compile new kernel
In-Reply-To: <00061112164900.01364@pingu>
Message-ID: <Pine.LNX.4.21.0006110341490.30891-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> /usr/src/linux/include/linux/sched.h: In function `on_sig_stack':
> In file included from /usr/src/linux/include/linux/mm.h:4,
>                  from /usr/src/linux/include/linux/slab.h:14,
>                  from /usr/src/linux/include/linux/malloc.h:4,
>                  from /usr/src/linux/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /usr/src/linux/include/linux/sched.h:566: `current' undeclared (first use this function)
> /usr/src/linux/include/linux/sched.h:566: (Each undeclared identifier is reported only once
> /usr/src/linux/include/linux/sched.h:566: for each function it appears in.)
> /usr/src/linux/include/linux/sched.h:567: warning: control reaches end of non-void function
> /usr/src/linux/include/linux/sched.h: In function `sas_ss_flags':
> /usr/src/linux/include/linux/sched.h:571: `current' undeclared (first use this function)
> /usr/src/linux/include/linux/sched.h:573: warning: control reaches end of non-void function
> /usr/src/linux/include/linux/sched.h: In function `suser':
> /usr/src/linux/include/linux/sched.h:596: `current' undeclared (first use this function)
> /usr/src/linux/include/linux/sched.h: In function `fsuser':
> /usr/src/linux/include/linux/sched.h:605: `current' undeclared (first use this function)
> /usr/src/linux/include/linux/sched.h: In function `capable':
> /usr/src/linux/include/linux/sched.h:621: `current' undeclared (first use this function)
> /usr/src/linux/include/linux/mm.h: In function `expand_stack':
> In file included from /usr/src/linux/include/linux/slab.h:14,
>                  from /usr/src/linux/include/linux/malloc.h:4,
>                  from /usr/src/linux/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /usr/src/linux/include/linux/mm.h:406: `current' undeclared (first use this function)
> init/main.c: In function `start_kernel':
> init/main.c:536: `current' undeclared (first use this function)
> init/main.c: In function `do_basic_setup':
> init/main.c:597: `current' undeclared (first use this function)
> make: *** [init/main.o] Error 1

You have to use egcs when you compile the kernel.

Ulf
