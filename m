Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id HAA19115
	for <pstadt@stud.fh-heilbronn.de>; Thu, 26 Aug 1999 07:02:40 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA02498; Wed, 25 Aug 1999 21:52:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA62395
	for linux-list;
	Wed, 25 Aug 1999 21:46:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA42995
	for <linux@engr.sgi.com>;
	Wed, 25 Aug 1999 21:45:58 -0700 (PDT)
	mail_from (simba@secns.sec.samsung.co.kr)
Received: from network.sec.samsung.co.kr (secns.sec.samsung.co.kr [168.219.201.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA00148
	for <linux@engr.sgi.com>; Wed, 25 Aug 1999 21:45:53 -0700 (PDT)
	mail_from (simba@secns.sec.samsung.co.kr)
Received: from simba.samsung.co.kr ([168.219.244.175])
	by network.sec.samsung.co.kr (8.8.8H1/8.8.8) with SMTP id NAA19915;
	Thu, 26 Aug 1999 13:54:44 +0900 (KST)
Received: by simba.samsung.co.kr with Microsoft Mail
	id <01BEEFC9.E02A8320@simba.samsung.co.kr>; Thu, 26 Aug 1999 13:49:54 +0900
Message-ID: <01BEEFC9.E02A8320@simba.samsung.co.kr>
From: simba <simba@secns.sec.samsung.co.kr>
To: "'linux-mips@fnet.fr'" <linux-mips@fnet.fr>,
        "'linux@engr.sgi.com'"
	 <linux@cthulhu.engr.sgi.com>
Subject: About the error of building egcs cross-compiler for mips
Date: Thu, 26 Aug 1999 13:49:48 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 8bit

Hello!

Now I have some fatal error in building cross-compiler for MIPS using egcs-  
1.1.2.

My host linux is the redhat 5.0 running on the i586 machine.
I used egcs-1.1.2 from cygnus ftp and configure instruction is
$ ./configure --prefix=/usr/local/mips --with-newlib --target=mips-linux
$ make ALL_TARGET_MODULES= LANGUAGES=c.


The message of the error is following
---------------------------------------------------
rm -f tmplibgcc2.a
for name in _muldi3 _divdi3 _moddi3 _udivdi3 _umoddi3 _negdi2 _lshrdi3 
_ashldi3 _ashrdi3 _ffsdi2 _udiv_w_sdiv _udivmoddi4 _cmpdi2 _ucmpdi2 
_floatdidf _floatdisf _fixunsdfsi _fixunssfsi _fixunsdfdi _fixdfdi 
_fixunssfdi _fixsfdi _fixxfdi _fixunsxfdi _floatdixf _fixunsxfsi _fixtfdi 
_fixunstfdi _floatditf __gcc_bcmp _varargs __dummy _eprintf _bb _shtab 
_clear_cache _trampoline __main _exit _ctors _pure; \
do \
  echo ${name}; \
  /usr/src/mipsbuild/egcs-1.1.2/gcc/xgcc -B/usr/src/mipsbuild/egcs-  
1.1.2/gcc/ -O2 -I/usr/include -DCROSS_COMPILE -DIN_GCC    -g -O2 -  
I./include   -g1  -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc  -I. 
-I. -I./config -c -DL${name} \
      ./libgcc2.c -o ${name}.o; \
  if [ $? -eq 0 ] ; then true; else exit 1; fi; \
  mips-linux-ar rc tmplibgcc2.a ${name}.o; \
  rm -f ${name}.o; \
done
_muldi3
xgcc: installation problem, cannot exec `mips-tfile': No such file or 
directory
make[1]: *** [libgcc2.a] Error 1
make[1]: Leaving directory `/usr/src/mipsbuild/egcs-1.1.2/gcc'
make: *** [all-gcc] Error 2
[simba@elinux egcs-1.1.2]$
[simba@elinux egcs-1.1.2]$
----------------------------------------

What's mips-tfile?
I'm waiting your help!
