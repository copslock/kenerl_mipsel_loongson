Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 15:39:26 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:8819
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8224821AbTFEOjX>; Thu, 5 Jun 2003 15:39:23 +0100
Received: from pluto.mmc.atmel.com (pluto.mmc.atmel.com [10.127.240.51])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA28154
	for <linux-mips@linux-mips.org>; Thu, 5 Jun 2003 10:39:16 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by pluto.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id KAA26604
	for <linux-mips@linux-mips.org>; Thu, 5 Jun 2003 10:39:15 -0400 (EDT)
X-Authentication-Warning: pluto.mmc.atmel.com: dkesselr owned process doing -bs
Date: Thu, 5 Jun 2003 10:39:15 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: linux-mips@linux-mips.org
Subject: 64bit gcc
Message-ID: <Pine.GSO.4.44.0306051033370.26007-100000@pluto.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I'm trying to build gcc from "Marco's" gcc source and patches for 2.9xxxx.
I have also changed t-elf and elf64.h based on notes from
www.cse.unsw.edu.au/~s2174381/notes/gcc.html. But during the make I get
the following error. It looks like it's building 16bit code that I don't
need. Any comments are appreciated.
BTW, my target is a Mips 5kf core, little endian.

///////////////////////////////////////
rm -f tmplibgcc1.a libgcc1.S
cp ./config/mips/mips16.S libgcc1.S
for name in _m16addsf3 _m16subsf3 _m16mulsf3 _m16divsf3 _m16eqsf2
_m16nesf2 _m16gtsf2 _m16gesf2 _m16lesf2 _m16ltsf2 _m16fltsisf _m16fixsfsi
_m16adddf3 _m16subdf3 _m16muldf3 _m16divdf3 _m16extsfdf2 _m16trdfsf2
_m16eqdf2 _m16nedf2 _m16gtdf2 _m16gedf2 _m16ledf2 _m16ltdf2 _m16fltsidf
_m16fixdfsi _m16retsf _m16retdf _m16stub1 _m16stub2 _m16stub5 _m16stub6
_m16stub9 _m16stub10 _m16stubsf0 _m16stubsf1 _m16stubsf2 _m16stubsf5
_m16stubsf6 _m16stubsf9 _m16stubsf10 _m16stubdf0 _m16stubdf1 _m16stubdf2
_m16stubdf5 _m16stubdf6 _m16stubdf9 _m16stubdf10; \
do \
  echo ${name}; \
  /usr/src/redhat/SOURCES/gcc/gcc/xgcc -B/usr/src/redhat/SOURCES/gcc/gcc/
-B/usr/local/mips64el/bin/ -I/usr/local/mips64el/include -O2
-DCROSS_COMPILE -DIN_GCC    -g -O2   -I./include  -G 0 -g1  -DIN_LIBGCC2
-D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc  -I. -I. -I./config -I./../include
-c -DL${name} libgcc1.S;
\
  if [ $? -eq 0 ] ; then true; else exit 1; fi; \
  mv libgcc1.o ${name}.o; \
  mips64el-ar rc tmplibgcc1.a ${name}.o; \
  rm -f ${name}.o; \
done
_m16addsf3
as: unrecognized option `-EL'
make[1]: *** [libgcc1-asm.a] Error 1
make[1]: Leaving directory `/usr/src/redhat/SOURCES/gcc/gcc'
make: *** [all-gcc] Error 2
////////////////////////////////////////////////

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
