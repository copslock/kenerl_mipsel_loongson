Received:  by oss.sgi.com id <S553775AbQKBHEj>;
	Wed, 1 Nov 2000 23:04:39 -0800
Received: from router.isratech.ro ([193.226.114.69]:57102 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553724AbQKBHEL>;
	Wed, 1 Nov 2000 23:04:11 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eA273oA20841
	for <linux-mips@oss.sgi.com>; Thu, 2 Nov 2000 09:03:51 +0200
Message-ID: <3A018098.ECB9E20C@isratech.ro>
Date:   Thu, 02 Nov 2000 09:56:24 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Soon I will give up on MIPS kernel!
Content-Type: multipart/mixed;
 boundary="------------A15BF52BE68D9C32267A9CB0"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------A15BF52BE68D9C32267A9CB0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

As you know by now I don't succeeded to crosscompile a mips linux
kernel. I was at oss.sgi.com repository and I took the linux_2_2 tag but
when I try to compile I have this kind of errors.

 make CROSS_COMPILE=mips-linux-
cc -O2 -o scripts/split-include scripts/split-include.c
In file included from /usr/include/errno.h:36,
                 from scripts/split-include.c:26:
/usr/include/bits/errno.h:32: warning: `ECANCELED' redefined
/usr/include/asm/errno.h:139: warning: this is the location of the
previous d
efinition
scripts/split-include include/linux/autoconf.h include/config
mips-linux-gcc -D__KERNEL__ -I/usr/src/linux_2_2_CVS/include -Wall
-Wstrict-p
rototypes -O2 -fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic
-mcpu=r3000 -
mips1 -pipe  -c -o init/main.o init/main.c
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function `atomic_add':
In file included from /usr/src/linux_2_2_CVS/include/linux/fs.h:22,
                 from /usr/src/linux_2_2_CVS/include/linux/mm.h:4,
                 from /usr/src/linux_2_2_CVS/include/linux/slab.h:14,
                 from /usr/src/linux_2_2_CVS/include/linux/malloc.h:4,
                 from /usr/src/linux_2_2_CVS/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux_2_2_CVS/include/asm/atomic.h:46: invalid operands to
binary +
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function `atomic_sub':
/usr/src/linux_2_2_CVS/include/asm/atomic.h:55: invalid operands to
binary -
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function `atomic_or':
/usr/src/linux_2_2_CVS/include/asm/atomic.h:64: invalid operands to
binary |
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function `atomic_and':
/usr/src/linux_2_2_CVS/include/asm/atomic.h:73: invalid operands to
binary &
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function
`atomic_add_return':/usr/src/linux_2_2_CVS/include/asm/atomic.h:82:
incompatible types in assignment
/usr/src/linux_2_2_CVS/include/asm/atomic.h:84: incompatible types in
assignment
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function
`atomic_sub_return':/usr/src/linux_2_2_CVS/include/asm/atomic.h:95:
incompatible types in assignment
/usr/src/linux_2_2_CVS/include/asm/atomic.h:97: incompatible types in
assignment
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function
`atomic_or_return':
/usr/src/linux_2_2_CVS/include/asm/atomic.h:107: incompatible types in
assignment
/usr/src/linux_2_2_CVS/include/asm/atomic.h:109: incompatible types in
assignment
/usr/src/linux_2_2_CVS/include/asm/atomic.h: In function
`atomic_and_return':/usr/src/linux_2_2_CVS/include/asm/atomic.h:120:
incompatible types in assignment
/usr/src/linux_2_2_CVS/include/asm/atomic.h:122: incompatible types in
assignment
make: *** [init/main.o] Error 1

The steps that I did are :
1. made a linux symlink to linux_2_2_CVS
2. make menuconfig while I am in /usr/src/linux directory
3. make dep CROSS_COMPILE=mips-linux-
4. make CROSS_COMPILE=mips-linux-

I want to manage to crosscompile this kernel on a i686 machine for a
mips machine. So I saw there that it says something  about
/usr/include/asm  which is for my i686 machine. I guess that the errors
come from here. Can you tell me what I have to do. I have to mention
that I can crosscompile user application and then I can run tha result
on mips and it works.

Thanks,

Nicu

--------------A15BF52BE68D9C32267A9CB0
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

--------------A15BF52BE68D9C32267A9CB0--
