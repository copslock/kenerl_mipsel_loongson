Received:  by oss.sgi.com id <S554072AbQKJKeO>;
	Fri, 10 Nov 2000 02:34:14 -0800
Received: from router.isratech.ro ([193.226.114.69]:7185 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S554067AbQKJKeA>;
	Fri, 10 Nov 2000 02:34:00 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eAAAXMf30348;
	Fri, 10 Nov 2000 12:33:25 +0200
Message-ID: <3A0C3DAB.7481EECE@isratech.ro>
Date:   Fri, 10 Nov 2000 13:25:48 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com, carstenl@mips.com
Subject: Atlas support.
Content-Type: multipart/mixed;
 boundary="------------AA990F358F198CF551CEF681"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------AA990F358F198CF551CEF681
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Carsten,

I so in the linux 2.2.12 on the Atlas board that you added support for
this board in this kernel. What I need now is kernel2.2.14 for ATLAS
boards. What should I do in order to have such a thing ?
I did  the following :
1. I modified the Config.in from /linux2.2.14/arch/mips with the lines
from 2.2.12 regarding ATLAS board. The same I did with the Makefile from
the same directory.
2. copied the atlas directory from 2.2.12 into arch/mips/atlas on the
2.2.14 kernel and also the linux/include/asm/atlas/ from 2.2.12 into
2.2.14 directory .
And now I did the following : make menuconfig and  appeared the Mips
Atlaas Board
make dep ( I dod not know if this is correct ) and make
CROSS_COMPILE=mips-linux-.But I got the following errors:
 In file included from /usr/mips-linux/include/linux/sched.h:15,
                 from setup.c:30:
/usr/mips-linux/include/linux/timex.h:159: field `time' has incomplete
type
In file included from /usr/mips-linux/include/linux/sched.h:18,
                 from setup.c:30:
/usr/mips-linux/include/asm/semaphore.h:30: parse error before
`wait_queue_head_
t'
/usr/mips-linux/include/asm/semaphore.h:30: warning: no semicolon at end
of stru
ct or union
/usr/mips-linux/include/asm/semaphore.h:34: warning: empty declaration
/usr/mips-linux/include/asm/semaphore.h: In function `sema_init':
/usr/mips-linux/include/asm/semaphore.h:64: dereferencing pointer to
incompletetype
/usr/mips-linux/include/asm/semaphore.h:65: dereferencing pointer to
incompletetype
/usr/mips-linux/include/asm/semaphore.h:66: dereferencing pointer to
incompletetype
/usr/mips-linux/include/asm/semaphore.h: In function `down':
/usr/mips-linux/include/asm/semaphore.h:92: dereferencing pointer to
incompletetype
/usr/mips-linux/include/asm/semaphore.h: In function
`down_interruptible':
/usr/mips-linux/include/asm/semaphore.h:103: dereferencing pointer to
incomplete
 type
/usr/mips-linux/include/asm/semaphore.h: In function `down_trylock':
/usr/mips-linux/include/asm/semaphore.h:113: dereferencing pointer to
incomplete
 type
/usr/mips-linux/include/asm/semaphore.h: In function `up':
/usr/mips-linux/include/asm/semaphore.h:188: dereferencing pointer to
incomplete
 type
/usr/mips-linux/include/asm/semaphore.h: At top level:
/usr/mips-linux/include/asm/semaphore.h:219: parse error before
`wait_queue_head
_t'
/usr/mips-linux/include/asm/semaphore.h:219: warning: no semicolon at
end of str
uct or union
/usr/mips-linux/include/asm/semaphore.h:220: warning: data definition
has no typ
e or storage class
/usr/mips-linux/include/asm/semaphore.h: In function `init_rwsem':
/usr/mips-linux/include/asm/semaphore.h:252: dereferencing pointer to
incomplete
 type
/usr/mips-linux/include/asm/semaphore.h:253: dereferencing pointer to
incomplete
 type
/usr/mips-linux/include/asm/semaphore.h:254: dereferencing pointer to
incomplete
 type
/usr/mips-linux/include/asm/semaphore.h:255: dereferencing pointer to
incomplete
 type
/usr/mips-linux/include/asm/semaphore.h: In function `down_read':
In file included from /usr/mips-linux/include/linux/sched.h:76,
                 from setup.c:30:
/usr/mips-linux/include/linux/timer.h:21: field `list' has incomplete
type
setup.c:59: storage class specified for parameter `atlas_irq_setup'
setup.c:75: redefinition of `__initfunc'
setup.c:60: `__initfunc' previously defined here
setup.c: In function `__initfunc':
setup.c:86: `atlas_irq_setup' undeclared (first use this function)
setup.c:86: (Each undeclared identifier is reported only once
setup.c:86: for each function it appears in.)
setup.c:135: `mips_cpu' undeclared (first use this function)
setup.c:135: `MIPS_CPU_FPU' undeclared (first use this function)
setup.c:137: `pci_ops' undeclared (first use this function)
[WIFEXITED(s) && WEXITSTATUS(s) == 33], 0, NULL) = 5696
--- SIGCHLD (Child exited) ---
stat("/tmp/cc2u8Czo.s", {st_mode=S_IFREG|0644, st_size=1823, ...}) = 0
unlink("/tmp/cc2u8Czo.s")               = 0
stat("/tmp/cc2u8Czo.i", {st_mode=S_IFREG|0644, st_size=61912, ...}) = 0
unlink("/tmp/cc2u8Czo.i")               = 0
_exit(1)                                = ?
[root@ares kernel]#

this is an output from a strace make CROSS_COMPILE=mips-linux-

Maybe there is a patch for what I need , maybe some will help me .
Thanks in advance
Regards,
Nicu


--------------AA990F358F198CF551CEF681
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------AA990F358F198CF551CEF681--
