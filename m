Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 15:52:27 +0000 (GMT)
Received: from p508B4EE8.dip.t-dialin.net ([IPv6:::ffff:80.139.78.232]:707
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225234AbTBDPw0>; Tue, 4 Feb 2003 15:52:26 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h14FqMq00560;
	Tue, 4 Feb 2003 16:52:22 +0100
Date: Tue, 4 Feb 2003 16:52:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jason Ormes <jormes@wideopenwest.com>
Cc: linux-mips@linux-mips.org
Subject: Re: ip27-init.c problem
Message-ID: <20030204165222.A30704@linux-mips.org>
References: <001801c2cc62$b319a9a0$4437e183@fermi.win.fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001801c2cc62$b319a9a0$4437e183@fermi.win.fnal.gov>; from jormes@wideopenwest.com on Tue, Feb 04, 2003 at 09:33:00AM -0600
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 04, 2003 at 09:33:00AM -0600, Jason Ormes wrote:

> 	I downloaded the linux_2_4 branch from the cvs repository and am
> trying to build a kernel for an origin 200.  I'm using
> binutils-mips64-linux-2.13.1-1 and egcs-mips64-linux-1.1.2-4 on a redhat
> 8.0 system.  I am getting these errors in ip27-init.c when trying to
> build the kernel.
> 
> mips64-linux-gcc -D__KERNEL__ -I/home/jason/mips/linux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -I /home/jason/mips/linux/include/asm/gcc -mabi=64
> -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r8000 -mips4 -Wa,-32
> -Wa,-mgp64   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ip27_init
> -c -o ip27-init.o ip27-init.c
> ip27-init.c:48: parse error before `boot_cpumask'
> ip27-init.c:48: warning: type defaults to `int' in declaration of
> `boot_cpumask'
[...]

You're trying to build a uniprocessor kernel.  That's currently not supported.
Just enable CONFIG_SMP.  Do you actually have a uniprocessor Origin?

  Ralf
