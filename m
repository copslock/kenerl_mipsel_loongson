Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 17:33:35 +0000 (GMT)
Received: from emma.patton.com ([IPv6:::ffff:209.49.110.2]:25101 "EHLO
	emma.patton.com") by linux-mips.org with ESMTP id <S8225338AbSLRRde>;
	Wed, 18 Dec 2002 17:33:34 +0000
Received: from barrett ([209.49.110.172])
	by emma.patton.com (8.9.0/8.9.0) with SMTP id MAA08533;
	Wed, 18 Dec 2002 12:33:49 -0500 (EST)
From: "Brad Barrett" <brad@patton.com>
To: "Chien-Lung Wu" <cwu@deltartp.com>, <linux-mips@linux-mips.org>
Subject: RE: Help in cross-compiler
Date: Wed, 18 Dec 2002 12:33:30 -0500
Message-ID: <BBEBJGNKIDPPHNAJKDFHGEKLCFAA.brad@patton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <A4E787A2467EF849B00585F14C9005590689B4@dprn03.deltartp.com>
Return-Path: <brad@patton.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@patton.com
Precedence: bulk
X-list: linux-mips

On Wednesday 18 December 2002 10:57 am, you wrote:

> I am working on the embedded linux system on bug endian mips (mips-linux).
> As I understand, I need to get the cross-compiler work on my linux-i686
> host (redhat 7.2).
> Following the Bradly's "Building a modern MIPS cross-toolchain for linux",
>  I download following packages:
>
> 	binutils-2.11
> 	gcc-2.95
> 	glibc-2.2.5
> 	glibc-linuxthreads-2.2.5
>
> And following the procedue:
...
> However, I got the error_message:
...
> /usr/toolchain1-mips/lib/gcc-lib/mips-linux/2.95/../../../../mips-linux/sys
>- include/bits/mathinline.h:426:
>       unknown register name `st(1)' in `asm'
...
> Does any have any idea to fix this error?

It sounds like you used the standard binutils.  You should probably use H.J.
Lu's binutils (they have some MIPS patches applied), and also his gcc (same
story).  They're available at:

http://ftp.kernel.org/pub/linux/devel/binutils/
ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/test/

> When I build the C cross-compiler, I use the "dubious hack"
> --with-headers=/usr/include copy the "MIPS host header files". Are there
> any other ways to copy the MIPS-host headers?

I never understood why anyone would use this method.  If you're building a
mips-linux cross-compiler, you should have a copy of the Linux kernel source
from linux-mips.org lying around somewhere (or are you using a pre-compiled
kernel image?).  Just copy the include directory from this source to a
convenient location, symbolically link asm to asm-mips and point the gcc
configure to it.


I've included below my personal build notes from a mipsel (little-endian)
cross-toolchain I built a couple months ago.  Hopefully these will be helpful.
Note that I chose /opt/toolchains/mips for the installed path, rather than
/usr/local.  My build system was SuSE 7.2 (gcc version 2.95.3 20010315 (SuSE)
and binutils version 2.10.91).

Also, you don't mention applying the glibc-2.2.5-mips-build-gmon.diff patch that
Brad LaRonde recommends.  If you didn't apply this patch, you might also want to
do that.

Brad

----------------Build Notes------------------------------------

I relied primarily on Steven J. Hill's build script [SJH], but with several
adjustments.

H.J. Lu says only his binutils will work:
http://ftp.kernel.org/pub/linux/devel/binutils/
I got the latest version.

H.J. Lu also says to use his gcc 3.2.  This is available only in source rpm
format, at:
ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/test/

Glibc came from the standard location:
ftp://ftp.gnu.org/gnu/glibc/
*Except*...patched with "glibc-2.2.5-mips-build-gmon.diff" from [BDL2.4].
This source also recommends the "-finline-limit=10000" CFLAG value (claims
ld.so won't work without it, and this seems to be true).

Tool versions:
Binutils             v2.13.90.0.10 (H.J. Lu)
GCC                  v3.2 (H.J. Lu)
Glibc                v2.2.5
Glibc-linuxthreads   v2.2.5

Patch:
glibc-2.2.5-mips-build-gmon.diff
  (http://www.ltc.com/~brad/mips/glibc-2.2.5-mips-build-gmon.diff)

-------------------------
Build Log
-------------------------
[Implied "su" to root prior to each "make install" below.]

1. Downloaded tarballs/rpms and unpacked to:
               ~/mipsel-cross/binutils-2.13
               ~/mipsel-cross/gcc-3.2
               ~/mipsel-cross/glibc-2.2.5
               (linuxthreads is unpacked into the glibc-2.2.5 directory)

2. Binutils:
  cd ~/mipsel-cross/binutils-2.13/mips
  chmod 744 README
  cd ..
  ./mips/README  (apply HJ Lu's patches)
  mkdir ~/mipsel-cross/mipsel-binutils
  cd ~/mipsel-cross/mipsel-binutils
  ../binutils-2.13/configure --prefix=/opt/toolchains/mips \
      --enable-targets=mips64el-linux,mipsel-linux --target=mipsel-linux \
      --enable-shared
  make
  make install

3. Gcc (1st time)
  cp -R ~/linux-2.4/include/asm-mips /opt/toolchains/mips/mipsel-linux/include
  cp -R ~/linux-2.4/include/linux    /opt/toolchains/mips/mipsel-linux/include
  cd /opt/toolchains/mips/mipsel-linux/include
  ln -s asm-mips asm
  mkdir ~/mipsel-cross/mipsel-gcc
  cd ~/mipsel-cross/mipsel-gcc
  AR=mipsel-linux-ar  RANLIB=mipsel-linux-ranlib  ../gcc-3.2/configure  \
      --prefix=/opt/toolchains/mips  --with-newlib  --enable-languages=c  \
      --target=mipsel-linux  --disable-shared  --disable-threads
  make
  make install

4. Glibc
  cd ~/mipsel-cross/glibc-2.2.5
  patch -p1 -i ../glibc-2.2.5-mips-build-gmon.diff
    (patch asked for name of each file to patch...had to type them in)
  mkdir ~/mipsel-cross/mipsel-glibc
  cd ~/mipsel-cross/mipsel-glibc
  CFLAGS="-O2 -g -finline-limit=10000"  LD_LIBRARY_PATH=  \
  BUILD_CC=gcc  CC=mipsel-linux-gcc  AR=mipsel-linux-ar  AS=mipsel-linux-as  \
      RANLIB=mipsel-linux-ranlib  ../glibc-2.2.5/configure  \
      --prefix=/opt/toolchains/mips/mipsel-linux  --host=mipsel-linux  \
      --build=i686-pc-linux-gnu  --enable-add-ons  --with-elf  \
      --disable-profile  \
      --with-headers=/opt/toolchains/mips/mipsel-linux/include  \
      --mandir=/opt/toolchains/mips/man  --infodir=/opt/toolchains/mips/info  \
      --enable-kernel=2.4.0
  make
  make install

5. Gcc (2nd time - with full glibc support)
  mkdir ~/mipsel-cross/mipsel-gccfull
  cd ~/mipsel-cross/mipsel-gccfull
  AR=mipsel-linux-ar  RANLIB=mipsel-linux-ranlib  ../gcc-3.2/configure  \
      --prefix=/opt/toolchains/mips  --enable-languages=c,c++  \
      --target=mipsel-linux  --enable-shared  --enable-threads  \
      --includedir=/opt/toolchains/mips/mipsel-linux/include  \
      --with-gxx-include-dir=/opt/toolchains/mips/mipsel-linux/include  \
      --mandir=/opt/toolchains/mips/man  --infodir=/opt/toolchains/mips/info  \
      --disable-checking
  make
  make install




Sources:
--------
[BDL2.4]   LaRonde, Bradley D., "Building a Modern MIPS Cross-Toolchain for
           Linux", v2.4, 2002-09-25,
           http://www.ltc.com/~brad/mips/mips-cross-toolchain.html

[SJH]
ftp://ftp.cotw.com/Linux/MIPS/toolchain/stable/sources/mipsel-linux-toolchain-bu
ild.sh

----------------End Build Notes--------------------------------


--
Brad Barrett
Staff Engineer, Patton Electronics
brad@patton.com
