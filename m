Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 05:34:45 +0000 (GMT)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:54914 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225230AbUARFep>; Sun, 18 Jan 2004 05:34:45 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc13) with SMTP
          id <2004011805343801600gc6t9e>
          (Authid: kumba12345);
          Sun, 18 Jan 2004 05:34:38 +0000
Message-ID: <400A1B5F.6010307@gentoo.org>
Date: Sun, 18 Jan 2004 00:36:31 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
References: <200401171711.34964@korath> <200401181119.15234@korath> <1074399252.3602.8.camel@dzur.sfbay.redhat.com> <200401181510.35686@korath>
In-Reply-To: <200401181510.35686@korath>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Adam Nielsen wrote:

> I was just following the linux-mips.org FAQ for building a cross compiler.  
> The errors were something to do with missing headers (pthread.h among others) 
> so I tried configuring gcc with --disable-threads as suggested in a post 
> Google found, and so far that seems to be working...except just as I wrote 
> that it came up with this:
> 
> /usr/mips-linux/bin/ld: cannot open crti.o: No such file or directory
> 
> Now I see why it says on the FAQ that building a cross compiler has always 
> been the hardest step - it's certainly a lot harder than you'd expect (at 
> least for a cross-compiler newbie like me ;-))  I was thinking it would be a 
> simple matter of compiling a few programs in a certain order and that'd be 
> it, but it seems that there are huge differences between versions - the 
> instructions use ecgs-1.1.2 and binutils-2.13.2.1, but to compile linux-2.6.0 
> you need newer than ecgs-1.1.2, but using gcc-3.x means upgrading to 
> binutils-2.14, but then when you've done that gcc-3.x won't compile so you 
> try gcc-2.95.3 instead, but that means you have to go back to 
> binutils-2.13.2.1 but then gcc-2.95.3 is still too old to compile the kernel, 
> so you *need* gcc-3.x but that won't compile...grrr!!! ;-)

I can't guarantee the below will work for you, but it has produced a 
cross-compiler on my sparc64 machine (I now use an i686->mips 
cross-compiler), but the instructions should be easily adaptable.

The commands assume you are building in a separate build directory in 
the source tree (i.e. glibc-x.y.z/buildhere/).

I'd recommend the following:
binutils-2.14.90.0.7 (or you can try the latest .8 release, it has some 
more mips fixes in it)
glibc-2.3.2 (or 2.3.1)
gcc-3.3.2

CVS snaps of latest gcc/glibc/binutils may also work as well.


-------------------

# ${myARCH}: Target Architecture
# ${myHOST}: Build Architecture
# ${myDEST}: Install location
# ${myXTRA}: Arch-specific flags to build glibc with


export myARCH=mips-unknown-linux-gnu
export myHOST=sparc-unknown-linux-gnu
export myDEST=/home/crossdev/mips
export myXTRA="-mips3 -mabi=32"

--- binutils ---
../configure \
	--target=${myARCH} --host=${myHOST} \
	--prefix=${myDEST} --enable-shared \
	--enable-64-bit-bfd \
&& make && make install


--- kernel headers ---
cd ${myDEST}
cp -r /usr/include/* ${myDEST}/include/
rm -Rf ${myDEST}/include/linux
rm -Rf ${myDEST}/include/asm*
cp -r /usr/src/linux/include/linux ${myDEST}/include
cp -r /usr/src/linux/include/asm-$(echo ${myARCH} | cut -d- -f1) 
${myDEST}/include
cp -r /usr/src/linux/include/asm-generic ${myDEST}/include
ln -s ${myDEST}/include/asm-$(echo ${myARCH} | cut -d- -f1) 
${myDEST}/include/asm


--- gcc-bootstrap ---
../configure \
	--prefix=${myDEST} --host=${myHOST} \
	--target=${myARCH} --with-newlib \
	--disable-shared --disable-threads \
	--enable-languages=c --disable-multilib \
	--without-headers \
&& make && make install


--- glibc ---
CC="${myARCH}-gcc" CFLAGS="-O2 ${myXTRA}" \
	../configure \
		--prefix=${myDEST} --host=${myARCH} \
		--build=${myHOST} --without-tls \
		--without-__thread \
		--enable-add-ons=linuxthreads \
		--enable-kernel=2.4.0 --with-gd=no \
		--without-cvs --disable-profile \
		--with-headers="${myDEST}/include" \
	&& make && make install


--- gcc-full ---
../configure \
	--prefix=${myDEST} --target=${myARCH} \
	--host=${myHOST} --disable-multilib \
	--enable-shared --enable-languages="c,c++,ada,f77,objc" \
	--enable-nls --without-included-gettext \
	--with-system-zlib --enable-threads=posix \
	--enable-long-long --disable-checking \
	--enable-cstdio=stdio \
	--enable-clocale=generic \
	--enable-__cxa_atexit \
	--enable-version-specific-runtime-libs \
	--with-local-prefix=${prefix}/local \
	--with-libs="${myDEST}/lib" \
	--with-headers="${myDEST}/${myARCH}/include" \
&& make && make install



--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
