Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 10:00:13 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.116]:60285 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225202AbTDOJAM>; Tue, 15 Apr 2003 10:00:12 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout08.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0HDD00IB5NO5JE@mtaout08.icomcast.net> for
 linux-mips@linux-mips.org; Tue, 15 Apr 2003 05:00:06 -0400 (EDT)
Date: Tue, 15 Apr 2003 05:02:08 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
In-reply-to: <20030415095034.A29593@ftp.linux-mips.org>
To: linux-mips@linux-mips.org
Reply-to: kumba@gentoo.org
Message-id: <3E9BCA90.8080607@gentoo.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek>
 <3E9BC44B.8080708@gentoo.org> <20030415095034.A29593@ftp.linux-mips.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ladislav Michl wrote:
> On Tue, Apr 15, 2003 at 04:35:23AM -0400, Kumba wrote:
> 
> silly question: you specified -r linux_2_4 when checkouting kernel, didn't
> you? otherwise you are trying to boot 2.5.47, which has broken serial console
> support.

Yes, I know I'm definitely working with 2.4 sources.  2.5's menuconfig 
still confuses me somewhat due to it's more organized layout.

> anyway, toolchains i'm using to build 32-bit kernel:
> $ mips-linux-gcc -v
> Reading specs from /home/ladis/mips-tools/lib/gcc-lib/mips-linux/3.2/specs
> Configured with: ../gcc-3.2/configure --prefix=/home/ladis/mips-tools --disable-shared --with-gnu-as --enable-languages=c --disable-nls --with-newlib --enable-checking=no --disable-threads --with-headers=/home/ladis/src/linux/include --target=mips-linux
> Thread model: single
> gcc version 3.2
> $ mips-linux-ld -v
> GNU ld version 2.13
> 
> 64-bit kernel (egcs is patched with egcs-1.1.2.diff.gz from linux-mips.org ftp):
> $ mips64-linux-gcc -v
> Reading specs from /home/ladis/mips-tools/lib/gcc-lib/mips64-linux/egcs-2.91.66/specs
> gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)
> $ mips64-linux-ld -v
> GNU ld version 2.13

# mips-unknown-linux-gnu-gcc -v
Reading specs from 
/home/crossdev/mips/lib/gcc-lib/mips-unknown-linux-gnu/3.2.2/specs
Configured with: ../configure --prefix=/home/crossdev/mips 
--target=mips-unknown-linux-gnu --host=sparc-unknown-linux-gnu 
--disable-multilib --enable-shared --enable-languages=c,c++,ada,f77,objc 
--enable-nls --without-included-gettext --with-system-zlib 
--enable-threads=posix --enable-long-long --disable-checking 
--enable-cstdio=stdio --enable-clocale=generic --enable-__cxa_atexit 
--enable-version-specific-runtime-libs --with-local-prefix=/local 
--with-libs=/home/crossdev/mips/lib 
--with-headers=/home/crossdev/mips/mips-unknown-linux-gnu/include
Thread model: posix
gcc version 3.2.2

# mips-unknown-linux-gnu-ld -v
GNU ld version 2.13.90.0.16 20021126

It's a cross compiler, specifically a sparc -> mips one, as my sparc 
machine is the fastest machine (Blade 100) running linux on my network 
atm.  I stuck to the .16 binutils initially because I didn't know how to 
address the -mcpu curiosity that appears in .18 and .20.  I originally 
thought that binutils was broken on mips, but after thinking about it, I 
partially suspect -mcpu has been gutted from the usable options.

I'm wondering if there are some strange oddities a slightly older 
binutils such as .16 may have in relation to the CVS kernels.  In all 
likely, it's probably something else I'm overseeing, but I'm trying to 
eliminate possible causes and get to the root of this problem.

--Kumba
