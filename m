Received:  by oss.sgi.com id <S553786AbRAAFb1>;
	Sun, 31 Dec 2000 21:31:27 -0800
Received: from cvsftp.cotw.com ([208.242.241.39]:4617 "EHLO cvsftp.cotw.com")
	by oss.sgi.com with ESMTP id <S553724AbRAAFbK>;
	Sun, 31 Dec 2000 21:31:10 -0800
Received: from cotw.com (dsl19.cedar-rapids.net [208.242.241.211])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id XAA28763
	for <linux-mips@oss.sgi.com>; Sun, 31 Dec 2000 23:26:36 -0600
Message-ID: <3A5018A0.6B43960B@cotw.com>
Date:   Sun, 31 Dec 2000 23:41:52 -0600
From:   "Steven J. Hill" <sjhill@cotw.com>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Simple problem with second stage MIPS GCC compiler...
References: <3A2FB3CB.3566F805@mips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Well, I almost have a complete toolchain. I succesfully got binutils,
first stage GCC-2.95.2 and GLIBC-2.2 installed just fine. I am having
problems with rebuilding GCC. Below is the configuration and make
directives that I am currently using along with the output. I have
verified that the header files are in /usr/local/mips/mipsel-linux-include.
Any help or thoughts are need and appreciated. Yes, I read the mailing
list archives. TIA.

-Steve

*************************************************************
AR=mipsel-linux-ar RANLIB=mipsel-linux-ranlib ../gcc-2.95.2/configure
--prefix=/usr/local/mips --target=mipsel-linux i686-pc-linux-gnu --enable-shared
--enable-threads --enable-languages=c

make LANGUAGES=c ALL_TARGET_MODULES= CONFIGURE_TARGET_MODULES=
INSTALL_TARGET_MODULES= SUBDIRS="libiberty gcc"

*************************************************************
make[2]: Leaving directory `/data/mips-stuff/build-gcc2/gcc/intl'
rm -f tmplibgcc2.a
for name in _muldi3 _divdi3 _moddi3 _udivdi3 _umoddi3 _negdi2 _lshrdi3 _ashldi3
_ashrdi3 _ffsdi2 _udiv_w_sdiv _udivmoddi4 _cmpdi2 _ucmpdi2 _floatdidf _floatdisf
_fixunsdfsi _fixunssfsi _fixunsdfdi _fixdfdi _fixunssfdi _fixsfdi _fixxfdi
_fixunsxfdi _floatdixf _fixunsxfsi _fixtfdi _fixunstfdi _floatditf __gcc_bcmp
_varargs __dummy _eprintf _bb _shtab _clear_cache _trampoline __main _exit
_ctors _pure; \
do \
  echo ${name}; \
  /data/mips-stuff/build-gcc2/gcc/xgcc -B/data/mips-stuff/build-gcc2/gcc/
-B/usr/local/mips/mipsel-linux/bin/ -I/usr/local/mips/mipsel-linux/include -O2 
-DCROSS_COMPILE -DIN_GCC     -g -O2 -I./include  -fPIC -g1 -DHAVE_GTHR_DEFAULT
-DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED   -I. -I../../gcc-2.95.2/gcc
-I../../gcc-2.95.2/gcc/config -I../../gcc-2.95.2/gcc/../include -c -DL${name} \
       ../../gcc-2.95.2/gcc/libgcc2.c -o ${name}.o; \
  if [ $? -eq 0 ] ; then true; else exit 1; fi; \
  mipsel-linux-ar rc tmplibgcc2.a ${name}.o; \
  rm -f ${name}.o; \
done
_muldi3
../../gcc-2.95.2/gcc/libgcc2.c:41: stdlib.h: No such file or directory
../../gcc-2.95.2/gcc/libgcc2.c:42: unistd.h: No such file or directory
make[1]: *** [libgcc2.a] Error 1
make[1]: Leaving directory `/data/mips-stuff/build-gcc2/gcc'
make: *** [all-gcc] Error 2

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'finger sjhill@mail.cotw.com'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
