Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 04:57:48 +0000 (GMT)
Received: from crack.them.org ([IPv6:::ffff:65.125.64.184]:10977 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225200AbSLSE5r>;
	Thu, 19 Dec 2002 04:57:47 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18Oud2-0001KW-00; Thu, 19 Dec 2002 00:57:56 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18Osla-0002Zv-00; Wed, 18 Dec 2002 23:58:38 -0500
Date: Wed, 18 Dec 2002 23:58:38 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Chien-Lung Wu <cwu@deltartp.com>
Cc: 'Brad Barrett' <brad@patton.com>, linux-mips@linux-mips.org
Subject: Re: Help in cross-compiler--gcc3.2-7.1 error
Message-ID: <20021219045838.GA9861@nevyn.them.org>
References: <A4E787A2467EF849B00585F14C9005590689B5@dprn03.deltartp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4E787A2467EF849B00585F14C9005590689B5@dprn03.deltartp.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 05:21:39PM -0500, Chien-Lung Wu wrote:
> Hi, Brad:
> 
> Thanks for your information.
> I download:
> 	binutils			v2.13.90.0.10 (H.J. Lu)
> 	GCC				v3.2-7.1 (H.J. Lu)
> 	glibc				v2.2.5
> 	glibc-linuxthreads	v2.2.5
> 
> and follow your build note to build a big-endian mips cross-compiler.
> 
> As I build the binutil-2.13.90.10, it is o.k.
> 
> However, as I build the gcc (1st), I get the error message:
> 
> make[1]: Leaving directory `/home/lineo/xcompiler/mips-gcc-3.2.7/libiberty'
> make[1]: Entering directory `/home/lineo/xcompiler/mips-gcc-3.2.7/gcc'
> gcc -DIN_GCC -DCROSS_COMPILE   -g -O2 -W -Wall -Wwrite-strings
> -Wstrict-prototypes -Wmissing-prototypes -Wtraditional -pedantic
> -Wno-long-long
> -DHAVE_CONFIG_H -DGENERATOR_FILE  -o gengenrtl \
>  gengenrtl.o ../libiberty/libiberty.a
>  ../libiberty/libiberty.a: could not read symbols: Archive has no index; run
>  ranlib to add one
>  collect2: ld returned 1 exit status
>  make[1]: *** [gengenrtl] Error 1
>  make[1]: Leaving directory `/home/lineo/xcompiler/mips-gcc-3.2.7/gcc'
>  make: *** [all-gcc] Error 2
> 
> 
> Do I miss something?
> Since I download the gcc3.2-7.1.src.rpm (only srpm format), I use 
> 
> 	rpm --rebuild gcc3.2-7.1.src.rpm
> 
> then I got gcc-3.2-20020903.tar.bz2 and many patch files.
> 
> I umcompress the gcc-3.2-20020903.tar.bz2 using the command
> 	tar -xvIf gcc-3.2-20020903.tar.bz2 
> ==>I get the gcc-3.2-20020903.
> 
> Questions:
> 	Do I need to patch all the patch files? If so, how can I patch all
> of them?
> 	or is the tarball pached?
> 
> Regarding to the error message, is it caused by missing some patch files?
> How can I fix this problem?

I don't know anything about HJ's RPM setup, but that error means it ran
host ranlib on a MIPS library instead of running MIPS ranlib.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
