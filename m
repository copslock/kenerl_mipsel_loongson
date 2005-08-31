Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 16:06:31 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:49349 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225548AbVHaPGN>;
	Wed, 31 Aug 2005 16:06:13 +0100
Received: from port-195-158-167-225.dynamic.qsc.de ([195.158.167.225] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EAUGE-0005jr-00; Wed, 31 Aug 2005 17:12:22 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EAUGF-0005J9-Dq; Wed, 31 Aug 2005 17:12:23 +0200
Date:	Wed, 31 Aug 2005 17:12:23 +0200
To:	Damian Dimmich <djd20@kent.ac.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050831151223.GV21717@hattusa.textio>
References: <200508311459.47273.djd20@kent.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508311459.47273.djd20@kent.ac.uk>
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Damian Dimmich wrote:
[snip]
> When linking .tmp_vmlinux1, KSEG1ADDR and KSEG1 where reported as undefined 
> and linking failed. 
>  LD      .tmp_vmlinux1
> arch/mips/sgi-ip22/built-in.o(.text+0x2854): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x2864): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x2870): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x28ac): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x28c0): In function `ip22_eisa_intr':
> : undefined reference to `KSEG1ADDR'
> arch/mips/sgi-ip22/built-in.o(.text+0x293c): more undefined references to 
> `KSEG1ADDR' follow
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> I fixed this by adding the lines:
> #define KSEG1ADDR(a)  (CPHYSADDR(a) | KSEG1)
> #define KSEG1     0xa0000000
> at the top of the file arch/mips/sgi-ip22/ip22-eisa.c
> These are copied from include/asm/addrspace.h
> 
> I found it quite strange that it only failed when linking the kernel and not 
> earlier.  The file asm/addrspace.h is included in ip22-eisa.c
> 
> eisa support is enabled and i'm compiling a 64 bit kernel.

You could try the patch in http://people.debian.org/~ths/foo/ip22-eisa.diff
which fixes that problem. I don't have the hardware to test it, and so far
nobody else cared to tell me if works.


Thiemo
