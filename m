Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 12:14:09 +0000 (GMT)
Received: from mailout11.sul.t-online.com ([IPv6:::ffff:194.25.134.85]:9864
	"EHLO mailout11.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225587AbSLWMOI> convert rfc822-to-8bit; Mon, 23 Dec 2002 12:14:08 +0000
Received: from fwd04.sul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 18QRTA-0005yN-07; Mon, 23 Dec 2002 13:14:04 +0100
Received: from juli.scheel-home.de (320039238345-0001@[217.81.86.204]) by fmrl04.sul.t-online.com
	with esmtp id 18QRT1-2BAdY8C; Mon, 23 Dec 2002 13:13:55 +0100
From: Julian Scheel <jscheel@activevb.de>
To: linux-mips <linux-mips@linux-mips.org>
Subject: Problems compiling MIPS64 kernel
Date: Mon, 23 Dec 2002 13:13:54 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200212231313.54593.jscheel@activevb.de>
X-Sender: 320039238345-0001@t-dialin.net
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi all,

after I got the mips-patched 2.4.20 kernel-sources now, I made a new try to 
compile my mips64-kernel.
As compiler I am using the SDE-GCC (www.algor.co.uk). make menuconfig works 
well, but when I do "make vmlinux" I get following errors:

------------
sde-gcc -D__KERNEL__ 
-I/home/jscheel/Programmieren/cmms/mips-kernel/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -mips64     -I 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/gcc -mabi=64 
-G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -Wa,-32 -Wa,-mgp64   
-DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/system.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/processor.h:36,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/prefetch.h:13,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/list.h:6,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/wait.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/fs.h:12,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/capability.h:17,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/binfmts.h:5,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/sched.h:9,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:4,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/slab.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/sgidefs.h:18:39: 
#error Use a Linux compiler or give up.
In file included from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/fs.h:26,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/capability.h:17,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/binfmts.h:5,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/sched.h:9,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:4,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/slab.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/bitops.h: In 
function `find_next_zero_bit':
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/bitops.h:340: 
`SZLONG_LOG' undeclared (first use in this function)
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/bitops.h:340: 
(Each undeclared identifier is reported only once
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/bitops.h:340: 
for each function it appears in.)
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/bitops.h:341: 
`SZLONG_MASK' undeclared (first use in this function)
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/bitops.h:350: 
`_MIPS_SZLONG' undeclared (first use in this function)
In file included from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda_fs_i.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/fs.h:308,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/capability.h:17,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/binfmts.h:5,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/sched.h:9,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:4,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/slab.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h: At 
top level:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:259: 
parse error before `u_quad_t'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:259: 
warning: no semicolon at end of struct or union
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:267: 
parse error before `va_bytes'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:267: 
warning: type defaults to `int' in declaration of `va_bytes'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:267: 
warning: data definition has no type or storage class
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:268: 
parse error before `va_filerev'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:268: 
warning: type defaults to `int' in declaration of `va_filerev'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:268: 
warning: data definition has no type or storage class
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:435: 
field `attr' has incomplete type
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:443: 
field `attr' has incomplete type
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:485: 
field `attr' has incomplete type
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:494: 
field `attr' has incomplete type
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:539: 
field `attr' has incomplete type
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:546: 
field `attr' has incomplete type
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/coda.h:566: 
field `attr' has incomplete type
In file included from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termios.h:12,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/termios.h:5,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/tty.h:22,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/sched.h:24,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:4,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/slab.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:31: 
parse error before `tcflag_t'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:31: 
warning: no semicolon at end of struct or union
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:32: 
warning: type defaults to `int' in declaration of `c_oflag'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:32: 
warning: data definition has no type or storage class
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:33: 
parse error before `c_cflag'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:33: 
warning: type defaults to `int' in declaration of `c_cflag'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:33: 
warning: data definition has no type or storage class
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:34: 
parse error before `c_lflag'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:34: 
warning: type defaults to `int' in declaration of `c_lflag'
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:34: 
warning: data definition has no type or storage class
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/asm/termbits.h:37: 
parse error before `}'
In file included from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/tty.h:24,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/sched.h:24,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:4,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/slab.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/tty_driver.h:130: 
field `init_termios' has incomplete type
In file included from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:4,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/slab.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/sched.h:187: 
`_MIPS_SZLONG' undeclared here (not in a function)
In file included from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/slab.h:14,
                 from 
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h: In 
function `page_zone':
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:330: 
`_MIPS_SZLONG' undeclared (first use in this function)
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:331: 
warning: control reaches end of non-void function
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h: In 
function `set_page_zone':
/home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:335: 
`_MIPS_SZLONG' undeclared (first use in this function)
make: *** [init/main.o] Error 1
-----------

especially the line "#error Use a Linux compiler or give up" surprised me?!
Can someone help me a bit?

-- 
Grüße,
Julian
