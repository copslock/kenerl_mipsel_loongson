Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 14:51:56 +0100 (BST)
Received: from mx5.kent.ac.uk ([IPv6:::ffff:129.12.21.36]:2488 "EHLO
	mx5.kent.ac.uk") by linux-mips.org with ESMTP id <S8225373AbVHaNv3>;
	Wed, 31 Aug 2005 14:51:29 +0100
Received: from apophis.ukc.ac.uk ([129.12.4.11])
	by mx5.kent.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EAT5s-0006b2-6B
	for linux-mips@linux-mips.org; Wed, 31 Aug 2005 14:57:36 +0100
Received: from myrtle.ukc.ac.uk ([129.12.3.176] ident=exim)
	by apophis.ukc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.50)
	id 1EAT5s-0006lc-2Q
	for linux-mips@linux-mips.org; Wed, 31 Aug 2005 14:57:36 +0100
Received: from fingerpoken.ukc.ac.uk ([129.12.16.14])
	by myrtle.ukc.ac.uk with esmtp (Exim 4.50)
	id 1EAT5r-0000Fp-Tu
	for linux-mips@linux-mips.org; Wed, 31 Aug 2005 14:57:35 +0100
From:	Damian Dimmich <djd20@kent.ac.uk>
To:	linux-mips@linux-mips.org
Subject: compiling kernel 2.6.13
Date:	Wed, 31 Aug 2005 14:59:46 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TfbFDyhkIifKgj5"
Message-Id: <200508311459.47273.djd20@kent.ac.uk>
X-UKC-Mail-System: No virus detected
X-UKC-SpamCheck: 
X-UKC-MailScanner-From:	djd20@kent.ac.uk
Return-Path: <djd20@kent.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djd20@kent.ac.uk
Precedence: bulk
X-list: linux-mips

--Boundary-00=_TfbFDyhkIifKgj5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I had some trouble compiling 2.6.13 for the mips architecture.  I encountered 
two errors:

1)

In the file include/asm-mips/thread_info.h TIF_32BIT was undefined.

I added the following two lines which showed up in parisc and ppc64 's 
thread-info's.  Don't know if these values are correct or if this actually 
works.  It just gets it to compile...
#define TIF_32BIT               5       /* 32 bit binary */
#define _TIF_32BIT              (1<<TIF_32BIT)

The error was in drivers/input/evdev.c which includes 
include/asm-mips/thread_info.h

The error was:
 CC [M]  drivers/input/evdev.o
drivers/input/evdev.c: In function `evdev_write':
drivers/input/evdev.c:193: error: `TIF_32BIT' undeclared (first use in this 
function)
drivers/input/evdev.c:193: error: (Each undeclared identifier is reported only 
once
drivers/input/evdev.c:193: error: for each function it appears in.)
drivers/input/evdev.c: In function `evdev_read':
drivers/input/evdev.c:254: error: `TIF_32BIT' undeclared (first use in this 
function)


2)

When linking .tmp_vmlinux1, KSEG1ADDR and KSEG1 where reported as undefined 
and linking failed. 
 LD      .tmp_vmlinux1
arch/mips/sgi-ip22/built-in.o(.text+0x2854): In function `ip22_eisa_intr':
: undefined reference to `KSEG1ADDR'
arch/mips/sgi-ip22/built-in.o(.text+0x2864): In function `ip22_eisa_intr':
: undefined reference to `KSEG1ADDR'
arch/mips/sgi-ip22/built-in.o(.text+0x2870): In function `ip22_eisa_intr':
: undefined reference to `KSEG1ADDR'
arch/mips/sgi-ip22/built-in.o(.text+0x28ac): In function `ip22_eisa_intr':
: undefined reference to `KSEG1ADDR'
arch/mips/sgi-ip22/built-in.o(.text+0x28c0): In function `ip22_eisa_intr':
: undefined reference to `KSEG1ADDR'
arch/mips/sgi-ip22/built-in.o(.text+0x293c): more undefined references to 
`KSEG1ADDR' follow
make: *** [.tmp_vmlinux1] Error 1


I fixed this by adding the lines:
#define KSEG1ADDR(a)  (CPHYSADDR(a) | KSEG1)
#define KSEG1     0xa0000000
at the top of the file arch/mips/sgi-ip22/ip22-eisa.c
These are copied from include/asm/addrspace.h

I found it quite strange that it only failed when linking the kernel and not 
earlier.  The file asm/addrspace.h is included in ip22-eisa.c

eisa support is enabled and i'm compiling a 64 bit kernel.
gcc is: 
Reading specs from /usr/mips/lib/gcc-lib/mips-linux/3.3.3/specs
Configured with: ../configure --prefix=/usr/mips --exec-prefix=/usr/mips 
--target=mips-linux --enable-shared --disable-nls --disable-multilib 
--enable-languages=c,c++,ada,f77,objc
Thread model: posix
gcc version 3.3.3 (Debian)


Cheers,
Damian

--Boundary-00=_TfbFDyhkIifKgj5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ip22-eisa.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ip22-eisa.c.patch"

34c34,35
< #include <asm/addrspace.h>
---
> //#include <asm/addrspace.h>
> #include <asm-mips/addrspace.h>
39a41,45
> //Force redefine.. seems to fail to find it when linking kernel itself.
> //This is probably no good..
> #define KSEG1ADDR(a)	(CPHYSADDR(a) | KSEG1)
> #define KSEG1     0xa0000000
> 

--Boundary-00=_TfbFDyhkIifKgj5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="asm-mips.thread_info.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asm-mips.thread_info.h.patch"

38a39,45
> /*Copied these from parisc and ppc64 - don't know any better.  TIF_32BIT was 
>  * undefined when compiling for mips in drivers/input/evdev.c I do not 
>  * understand this code.  Just guessing...*/
> #define TIF_32BIT               5       /* 32 bit binary */
> #define _TIF_32BIT              (1<<TIF_32BIT)
> 
> 

--Boundary-00=_TfbFDyhkIifKgj5--
