Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 06:52:17 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:15259
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225195AbVAGGwL>; Fri, 7 Jan 2005 06:52:11 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <ZYJ972J0>; Fri, 7 Jan 2005 11:42:30 +0500
Message-ID: <1B701004057AF74FAFF851560087B16106469E@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: 'Thiemo Seufer' <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: mipes-linux-ld: final link failed: Bad value
Date: Fri, 7 Jan 2005 11:42:29 +0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

>does it miss the '-c' somehow?
I don't think -c is being missed because I changed the mm/Makefile from 

mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o
\
			   vmalloc.o

to

mmu-$(CONFIG_MMU)	:= highmem.o madvise.o memory.o mincore.o \
			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o
\
			   vmalloc.o fremap.o

All the other files are compiled and I persume linked successfully. The
problem only comes in fremap.o

Mudeem

-----Original Message-----
From: Thiemo Seufer [mailto:ica2_ts@csv.ica.uni-stuttgart.de]
Sent: Thursday, January 06, 2005 7:51 PM
To: Mudeem Iqbal
Cc: 'linux-mips@linux-mips.org'
Subject: Re: mipes-linux-ld: final link failed: Bad value


Mudeem Iqbal wrote:
> hi,
> 
> I have built a toolchain using the following combination
> 
> binutils-2.15
> gcc-3.4.3
> glibc-2.3.3
> linux-2.6.9	(from linux-mips.org)
> 
> I am cross compiling linux kernel for mips. I think the toolchain has been
> successfully built. But when cross compiling the kernel I get the
following
> error
> 
>   CC      mm/fremap.o
> mipsel-linux-ld: final link failed: Bad value
> make[1]: *** [mm/fremap.o] Error 1

A _final_ link for mm/fremap.o sounds like a broken cc invocation
in mm/Makefile (does it miss the '-c' somehow?).


Thiemo
