Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78NeWO06518
	for linux-mips-outgoing; Wed, 8 Aug 2001 16:40:32 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78NeTV06509
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 16:40:29 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP id 2C0F1590AC
	for <linux-mips@oss.sgi.com>; Wed,  8 Aug 2001 19:37:47 -0400 (EDT)
Message-ID: <02a401c12063$cde1e830$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <linux-mips@oss.sgi.com>
Subject: gcc 3.0 / glibc 2.2.3 cross-toolchain
Date: Wed, 8 Aug 2001 19:42:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have spent quite a bit of time trying to get a gcc 3.0 / glibc 2.2.3
cross-toolchain working.  I am not a Toolchain Builder, but I really wanted
to try this combo and I don't see any way around building it myself.

I've had some success.  Everything seems to build fine.  However, when I try
to run a simple "hello world" dynamically linked with glibc, I get this:

    <myprogram>: error while loading shared libraries: failed to map
    segment from shared object: cannot load shared object file: Invalid
argument

I think it is trying to load libc.so.6, which is in my root in /lib/,
symlinked to libc-2.2.3.so, and so is ld.so.1, symlinked to ld-2.2.3.so.

I feel like I am pretty close, but I am starting to get discouraged and
could really use some help.  I really am clueless about what
should/shouldn't work.  I'm trying to do this based on bits and pieces of
information that I've collected from countless sources.  I have heard that
gcc 3.0 isn't really "working", but I still want to try.

Here is what I've used:

   * binutils-2.11.90.0.25.tar.gz (extracted from H. J. Lu's
     srpm on oss.sgi.com; I've tried others also)
   * gcc-3.0.tar.gz (released version - no patches)
   * glibc-linuxthreads-2.2.3.tar.gz (released version - no
     patches; glibc didn't want to configure without this)
   * glibc-2.2.3.tar.gz (released version)

plus a tiny patch to glibc that looks like:

--- libc-04052001/sysdeps/mips/mipsel/rtld-parms Sat Jul 12 18:26:15 1997
+++ libc-04052001-patched/sysdeps/mips/mipsel/rtld-parms Fri Apr  6 09:23:27
2001
@@ -1,3 +1,3 @@
 ifndef rtld-oformat
-rtld-oformat = elf32-littlemips
+rtld-oformat = elf32-tradlittlemips
 endif

I built everything on my i386 Debian 2.2 box as follows:

Build the mipsel cross-binutils

  tar -xzf binutils-2.11.90.0.25.tar.gz
  mkdir mipsel-binutils
  cd mipsel-binutils

  ../binutils-2.11.2/configure --target=mipsel-linux \
    --libdir='${exec_prefix}'/mipsel-linux/i386-linux/lib

  make
  make install
  cd ..

Build the mipsel cross-gcc:

  tar -xzf gcc-3.0.tar.gz
  mkdir mipsel-gcc
  cd mipsel-gcc

  ../gcc-3.0/configure --target=mipsel-linux \
     --enable-languages=c --disable-shared

  make
  make install
  cd ..

Install the kernel headers

  mkdir /usr/local/mipsel-linux/include
  cp -r $LINUX_SRC/include/linux /usr/local/mipsel-linux/include
  cp -r $LINUX_SRC/include/asm-mips /usr/local/mipsel-linux/include/asm

Build glibc:

  tar -xzf glibc-2.2.3
  cd glibc-2.2.3
  patch -p1 -i../elf32-tradlittlemips.diff
  tar -xzf ../glibc-linuxthreads-2.2.3.tar.gz
  cd ..
  mkdir mipsel-glibc
  cd mipsel-glibc

  ../glibc-2.2.3/configure --build=i686-linux --host=mipsel-linux \
    --enable-add-ons --prefix=/usr/local/mipsel-linux

  make
  make install
  cd ..

Thanks.

Regards,
Brad
