Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 20:32:14 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:3821 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8226101AbVF3Tbz>; Thu, 30 Jun 2005 20:31:55 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc12) with SMTP
          id <2005063019313601200h96rie>; Thu, 30 Jun 2005 19:31:37 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Stephen P. Becker'" <geoman@gentoo.org>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: Seg fault when compiled with -mabi=64 and -lpthread
Date:	Thu, 30 Jun 2005 15:31:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-index: AcV9pz+aRx+9hWzVTzilb9rL9PauPgAAlkvQ
In-Reply-To: <42C44336.1080401@gentoo.org>
Message-Id: <20050630193155Z8226101-3678+745@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Steve,

I don't see a kernel oops.  I checked /var/log/messages, and a few others.
I have verified that klogd and syslogd are running.

Bryan

-----Original Message-----
From: Stephen P. Becker [mailto:geoman@gentoo.org] 
Sent: Thursday, June 30, 2005 3:09 PM
To: Bryan Althouse
Cc: 'Linux/MIPS Development'
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread

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
>
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/bin/mips64-linux-g
nu-gcc
> -mabi=64 empty.c -o empty -lpthread
> 
> The executable will seg fault.  If I remove the -lpthread, it is fine. 
> Also, if I change the 64 to 32, it is fine.
> 
>  
> 
> Maybe I have a bad libpthread in /lib64?  If I type "file
> /lib64/libpthread-0.10.so" I get: "ELF 64-bit MSB shared object, mips-3
> MIPS R3000_BE, version 1, not stripped".  Looks fine to me.  Should I
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
