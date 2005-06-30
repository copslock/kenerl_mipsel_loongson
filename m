Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 20:10:14 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:49354 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8226101AbVF3TJ4>; Thu, 30 Jun 2005 20:09:56 +0100
Received: from dagger.cc.vt.edu (IDENT:mirapoint@[10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j5UJ8qS5023139;
	Thu, 30 Jun 2005 15:09:02 -0400
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by dagger.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DOQ23270;
	Thu, 30 Jun 2005 15:08:45 -0400 (EDT)
Message-ID: <42C44336.1080401@gentoo.org>
Date:	Thu, 30 Jun 2005 15:08:38 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050624)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
CC:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
References: <20050630173409Z8226102-3678+735@linux-mips.org>
In-Reply-To: <20050630173409Z8226102-3678+735@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Bryan Althouse wrote:
> I have a problem when linking a 64 bit application with libpthread.  I
> appears to link fine, but it will seg fault when I execute it.  I wrote
> an empty C program called empty.c:
> 
>  
> 
> int main (void)
> 
> { 
> 
>     return 0;
> 
> }
> 
>  
> 
> I cross compile it with:
> 
> /opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/bin/mips64-linux-gnu-gcc
> –mabi=64 empty.c –o empty –lpthread
> 
> The executable will seg fault.  If I remove the –lpthread, it is fine. 
> Also, if I change the 64 to 32, it is fine.
> 
>  
> 
> Maybe I have a bad libpthread in /lib64?  If I type “file
> /lib64/libpthread-0.10.so” I get: “ELF 64-bit MSB shared object, mips-3
> MIPS R3000_BE, version 1, not stripped”.  Looks fine to me.  Should I
> cross compile and replace libpthread?  If so, where can I find the source?
> 

Wow, so I'm not just smoking crack.  I ran into essentially the same
exact problem with my n32 userland while trying to build glib (not
glibc).  The configure script kept dying while trying to determine if
libpthread was available.  Looking at the config.log, I noticed that the
conftest code was causing a segfault.  Furthermore, this causes a kernel
oops (you should check your kernel logs for an oops).

I isolated the conftest code, and it is available at:
http://beerandrocks.net:8080/~spbecker/oops/

In that directory is also a statically linked big endian n32 executable,
as well as dumps of oops messages that I was able to reproduce 100% of
the time on both ip32 and ip22 systems.  If anyone is in an
experimenting mood, try to run that executable on a mips64 box (with n32
binary support enabled obviously) and see what happens.  The interesting
thing about this problem is that it only happens with recent kernels.  I
can't speak for 2.6.11 since I haven't tested it yet, but the oops only
occurred while running 2.6.12 from cvs HEAD.  When running my 2.6.10
build that has been on my indy for some time, the conftest code runs
fine without any segfault, and there is no kernel oops.

-Steve
