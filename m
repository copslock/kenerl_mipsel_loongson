Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 17:17:26 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:13794
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225256AbVAMRRS>;
	Thu, 13 Jan 2005 17:17:18 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 13 Jan 2005 09:17:13 -0800
Message-ID: <41E6AD15.7030104@avtrex.com>
Date: Thu, 13 Jan 2005 09:17:09 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philippe De Swert <philippedeswert@scarlet.be>
CC: linux-mips <linux-mips@linux-mips.org>
Subject: Re: unresolved (soft)float symbols
References: <IA9DY0$DCC07516FD959EE0729448D36856A324@scarlet.be>
In-Reply-To: <IA9DY0$DCC07516FD959EE0729448D36856A324@scarlet.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jan 2005 17:17:13.0451 (UTC) FILETIME=[B91E83B0:01C4F993]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Philippe De Swert wrote:
> Hello people,
> 
> I have a custom build module with some float operations in it. I build a
> 2.4.17 kernel for a mips32 core (BCM6348 chip). It boots up fine, busybox
> works nicely, also some other apps like dropbear and thttpd do what they are
> expected to do.
> 
> I build everything with soft-floats using a uclibc toolchain (kernel +
> filesystem). This is the configuration of my toolchain.
> 
> ~#mips-linux-gcc -v
> Reading specs from
> /vobs/linux/tools/3pp-build/gcc/../../mips/gcc/lib/gcc-lib/mips-linux-uclibc/3.3.4/specs
> Configured with:
> /vobs/linux/tools/3pp-build/gcc/toolchain_build_mips_nofpu/gcc-3.3.4/configure
> --prefix=/vobs/linux/tools/3pp-build/gcc/../../mips/gcc
> --build=i386-pc-linux-gnu --host=i386-pc-linux-gnu --target=mips-linux-uclibc
> --enable-languages=c,c++ --enable-shared --disable-__cxa_atexit
> --enable-target-optspace --with-gnu-ld --disable-nls --enable-multilib
> --without-float --enable-sjlj-exceptions
> Thread model: posix
> gcc driver version 3.3.4 executing gcc version 3.3.3
> 
> The module builds fine also, but when insmodding I get the following error.
> 
> insmod: unresolved symbol __fixdfsi
> insmod: unresolved symbol __floatsidf
> insmod: unresolved symbol __muldf3
> insmod: unresolved symbol __adddf3
> 
> As these are all float operations I am wondering about the following things:
> 
> 1.why they are in there? I have a soft-float toolchain....
> 2.Is there float support in the kernel? While googling for it I found a few
> things talking about FP point in the kernel. Does it have something to do with
> the Algorithmics/MIPS FPU emulator. (Although it does not work emulator or
> not. Which I expected because it should only be used by apps which emit FPU
> calls, and this should not happen because I use a softfloat toolchain). So I
> expect it does not really have something to do with this.
> 3.I took care of using the same compiler options as the kernel compilation
> uses. I guess this is the correct way, and the problems are thus not related
> to this.
> 
> Any pointers to a solution would be helpful. I am trying woth a hard-float
> toolchain now (it only takes a while to compile everything). I could also not
> dig up anything similar in the archives.
> 

These symbols are defined in libgcc.a, however libgcc.a is normally
compiled with options that make it incompatible with kernel modules.

There is a trick I have played to work around this. If you do a normal gcc
build and then remove gcc/libgcc.a and the gcc/libgcc directory. You can
build a kernel compatible version by doing:

export LIBGCC2_DEBUG_CFLAGS='-g -G0 -mno-abicalls -fno-pic'
make

The resulting libgcc.a will be compatible with the kernel.  Rename it to
something like libgcckernel.a.

Now you can link the kernel module adding -lgcckernel and you should be
ready to go.

David Daney.
