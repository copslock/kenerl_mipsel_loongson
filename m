Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94AN4N07149
	for linux-mips-outgoing; Thu, 4 Oct 2001 03:23:04 -0700
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94AMwD07145
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 03:22:58 -0700
Received: from [192.168.1.233] (192.168.1.233 [192.168.1.233]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id QMJCNP89; Thu, 4 Oct 2001 06:22:52 -0400
Subject: Re: mipsel-linux cross compiler issue while installing
From: Marc Karasek <marc_karasek@ivivity.com>
To: balaji.ramalingam@philips.com
Cc: linux-mips@oss.sgi.com
In-Reply-To: <OF5B78E837.1C0B89F9-ON88256ADA.007E2E97@diamond.philips.com>
References: <OF5B78E837.1C0B89F9-ON88256ADA.007E2E97@diamond.philips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.22.08.08 (Preview Release)
Date: 04 Oct 2001 06:23:08 -0400
Message-Id: <1002190997.1402.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

As long as you just want to do LE, I would recommend the package from
Monta Vista.  It is there journeyman distrobution.  It has both a
cross-compiler for LE along with there released 2.4.2 kernel.  They went
thru a long process to validate this kernel, and have incorporated/fixed
many bugs that were outstanding.  This delayed the release of this port
by about 3 months.  Just my 2 cents......

On Wed, 2001-10-03 at 19:08, balaji.ramalingam@philips.com wrote:
> 
> Hello Support,
> 
> I 'm working in Philips Semiconductors, Sunnyvale, CA in the MIPS core group.
> I'm planning to boot the linux kernel on our latest 4kc mips32 core.
> I thought of installing the compiler source available for mips2 ISA and and later edit
> them for mips32 ISA.
> 
> I tried downloading the compiler source for linux mips from the following link.
> 
> ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev
> 
> I edited the make-cross.sh to change the base path and target and when I ran the script
> I got the following errors while installing the glibc.
> 
> Can you please help me in fixing this error?
> Is there a patch or something which I'm missing here?
> 
> 
> regards,
> Balaji Ramalingam
> 408 991 2941 work phone
> -----------------------------------------------------------------------------------------------------
> 
> make[2]: Entering directory `/home/ramaling/crossdev-build/src/glibc-2.2.3-20010
> 421/setjmp'
> mipsel-linux-gcc ../sysdeps/mips/setjmp.S -c  -I../include -I. -I/home/ramaling/
> crossdev-build/mipsel-linux/glibc-2.2.3-20010421-obj/setjmp -I.. -I../libio  -I/
> home/ramaling/crossdev-build/mipsel-linux/glibc-2.2.3-20010421-obj -I../sysdeps/
> mips/elf -I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pth
> read -I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix -I../lin
> uxthreads/sysdeps/mips -I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/
> linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysd
> eps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips -I../sysdeps/unix -I
> ../sysdeps/posix -I../sysdeps/mips/mipsel -I../sysdeps/mips/fpu -I../sysdeps/mip
> s -I../sysdeps/wordsize-32 -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-
> 64 -I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic  -nostdinc
>  -isystem /usr/gnu-kalra/pc-linux/lib/gcc-lib/mipsel-linux/2.95.1/include -isyst
> em /home/ramaling/crossdev/mipsel-linux/mipsel-linux/include -D_LIBC_REENTRANT -
> include ../include/libc-symbols.h     -DASSEMBLER   -o /home/ramaling/crossdev-b
> uild/mipsel-linux/glibc-2.2.3-20010421-obj/setjmp/setjmp.o
> ../sysdeps/mips/setjmp.S: Assembler messages:
> ../sysdeps/mips/setjmp.S:43: Error: Can not represent BFD_RELOC_16_PCREL_S2 relo
> cation in this object file format
> make[2]: *** [/home/ramaling/crossdev-build/mipsel-linux/glibc-2.2.3-20010421-ob
> j/setjmp/setjmp.o] Error 1
> make[2]: Leaving directory `/home/ramaling/crossdev-build/src/glibc-2.2.3-200104
> 21/setjmp'
> make[1]: *** [setjmp/subdir_lib] Error 2
> make[1]: Leaving directory `/home/ramaling/crossdev-build/src/glibc-2.2.3-200104
> 21'
> make: *** [all] Error 2
> [ramaling@svlhp106 crossdev-build]$
> 
> -----------------------------------------------------------------------------------------------------
> 
> 
-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
