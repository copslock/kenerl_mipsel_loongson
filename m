Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 May 2004 06:48:11 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22259 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225263AbUEIFsJ> convert rfc822-to-8bit;
	Sun, 9 May 2004 06:48:09 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i495m7x6024794;
	Sat, 8 May 2004 22:48:07 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i495m6IF024792;
	Sat, 8 May 2004 22:48:06 -0700
Date: Sat, 8 May 2004 22:48:06 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: semaphore woes in 2.6, 32bit
Message-ID: <20040508224806.A24682@mvista.com>
References: <20040507181031.F9702@mvista.com> <20040508071822.GA29554@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040508071822.GA29554@linux-mips.org>; from ralf@linux-mips.org on Sat, May 08, 2004 at 09:18:22AM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sat, May 08, 2004 at 09:18:22AM +0200, Ralf Baechle wrote:
> On Fri, May 07, 2004 at 06:10:31PM -0700, Jun Sun wrote:
> 
> > I got a bunch of segfaults which are due to HAS_LLSCD cpu operating
> > on a semaphore which is aligned along 4-byte boundary instead of the
> > desired 8-byte boundary.
> 
> Dare to give a complete version number?  I've dumped 2.4 on all my systems
> months ago and never have seen this problem except with slab debugging
> enabled - but that side effect of slab debugging is known since years.
> 

Kernel is yesterday's CVS. gcc is 3.3.1.  config is ddb5477.  No 
additional patch.  See below.

In any case if you look at the uart code you should see there
is a problem already.  'state' is allocated through kmalloc() which only
gives 4-byte alignement.  The only puzzling thing is that why this
did not show up before.  Maybe kmalloc() was giving 8-byte aligned block?

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 6
EXTRAVERSION =-rc3
NAME=Zonked Quokka

[jsun@orion linux]$ mipsel-linux-gcc -v
Reading specs from /opt/mvl-installs/pe040201/montavista/pro/devkit/mips/fp_le/bin/../lib/gcc-lib/mipsel-hardhat-linux/3.3.1/specs
Configured with: ../configure --host=i686-pc-linux-gnu --target=mipsel-hardhat-linux --prefix=/opt/montavista/devkit/mips/fp_le --exec-prefix=/opt/montavista/devkit/mips/fp_le --bindir=/opt/montavista/devkit/mips/fp_le/bin --sbindir=/opt/montavista/devkit/mips/fp_le/sbin --sysconfdir=/opt/montavista/devkit/mips/fp_le/etc --datadir=/opt/montavista/devkit/mips/fp_le/share --includedir=/opt/montavista/devkit/mips/fp_le/include --libdir=/opt/montavista/devkit/mips/fp_le/lib --libexecdir=/opt/montavista/devkit/mips/fp_le/libexec --localstatedir=/opt/montavista/devkit/mips/fp_le/var --sharedstatedir=/opt/montavista/devkit/mips/fp_le/share --mandir=/opt/montavista/devkit/mips/fp_le/man --infodir=/opt/montavista/devkit/mips/fp_le/info --program-transform-name=s,^,mips_fp_le-, --enable-cross --with-sysroot=/opt/montavista/devkit/mips/fp_le/target --enable-shared --enable-languages=c,c++ --enable-__cxa_atexit --enable-threads=posix --disable-multilib --with-gxx-include-dir='$'{gcc_tooldir}/../target/usr/include/c++/3.3.1
Thread model: posix
gcc version 3.3.1 (MontaVista 3.3.1-3.0.10.0300532 2003-12-24)
 
Jun
