Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f93N8EQ27496
	for linux-mips-outgoing; Wed, 3 Oct 2001 16:08:14 -0700
Received: from gw-nl4.philips.com (gw-nl4.philips.com [212.153.190.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f93N88D27490
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 16:08:09 -0700
Received: from smtpscan-nl2.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl4.philips.com with ESMTP id BAA11531
          for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 01:08:06 +0200 (MEST)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-nl2.philips.com(130.139.36.22) by gw-nl4.philips.com via mwrap (4.0a)
	id xma011529; Thu, 4 Oct 01 01:08:06 +0200
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-nl2.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id BAA19405
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 01:08:05 +0200 (MET DST)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id SAA16708
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 18:08:04 -0500 (CDT)
Subject: mipsel-linux cross compiler issue while installing
To: linux-mips@oss.sgi.com
Date: Wed, 3 Oct 2001 16:08:35 -0700
Message-ID: <OF5B78E837.1C0B89F9-ON88256ADA.007E2E97@diamond.philips.com>
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 03/10/2001 18:11:51
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello Support,

I 'm working in Philips Semiconductors, Sunnyvale, CA in the MIPS core group.
I'm planning to boot the linux kernel on our latest 4kc mips32 core.
I thought of installing the compiler source available for mips2 ISA and and later edit
them for mips32 ISA.

I tried downloading the compiler source for linux mips from the following link.

ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev

I edited the make-cross.sh to change the base path and target and when I ran the script
I got the following errors while installing the glibc.

Can you please help me in fixing this error?
Is there a patch or something which I'm missing here?


regards,
Balaji Ramalingam
408 991 2941 work phone
-----------------------------------------------------------------------------------------------------

make[2]: Entering directory `/home/ramaling/crossdev-build/src/glibc-2.2.3-20010
421/setjmp'
mipsel-linux-gcc ../sysdeps/mips/setjmp.S -c  -I../include -I. -I/home/ramaling/
crossdev-build/mipsel-linux/glibc-2.2.3-20010421-obj/setjmp -I.. -I../libio  -I/
home/ramaling/crossdev-build/mipsel-linux/glibc-2.2.3-20010421-obj -I../sysdeps/
mips/elf -I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pth
read -I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix -I../lin
uxthreads/sysdeps/mips -I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/
linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysd
eps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips -I../sysdeps/unix -I
../sysdeps/posix -I../sysdeps/mips/mipsel -I../sysdeps/mips/fpu -I../sysdeps/mip
s -I../sysdeps/wordsize-32 -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-
64 -I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic  -nostdinc
 -isystem /usr/gnu-kalra/pc-linux/lib/gcc-lib/mipsel-linux/2.95.1/include -isyst
em /home/ramaling/crossdev/mipsel-linux/mipsel-linux/include -D_LIBC_REENTRANT -
include ../include/libc-symbols.h     -DASSEMBLER   -o /home/ramaling/crossdev-b
uild/mipsel-linux/glibc-2.2.3-20010421-obj/setjmp/setjmp.o
../sysdeps/mips/setjmp.S: Assembler messages:
../sysdeps/mips/setjmp.S:43: Error: Can not represent BFD_RELOC_16_PCREL_S2 relo
cation in this object file format
make[2]: *** [/home/ramaling/crossdev-build/mipsel-linux/glibc-2.2.3-20010421-ob
j/setjmp/setjmp.o] Error 1
make[2]: Leaving directory `/home/ramaling/crossdev-build/src/glibc-2.2.3-200104
21/setjmp'
make[1]: *** [setjmp/subdir_lib] Error 2
make[1]: Leaving directory `/home/ramaling/crossdev-build/src/glibc-2.2.3-200104
21'
make: *** [all] Error 2
[ramaling@svlhp106 crossdev-build]$

-----------------------------------------------------------------------------------------------------
