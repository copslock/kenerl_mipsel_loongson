Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2003 19:57:12 +0000 (GMT)
Received: from main.analog.ro ([IPv6:::ffff:81.196.32.141]:5580 "EHLO
	main.analog.ro") by linux-mips.org with ESMTP id <S8225198AbTL1T5M>;
	Sun, 28 Dec 2003 19:57:12 +0000
Received: from contabili (deltha@networkadministrator.analog.ro [192.168.6.2])
	by main.analog.ro (8.12.10/8.12.9) with ESMTP id hBSJvdgr027526
	for <linux-mips@linux-mips.org>; Sun, 28 Dec 2003 21:57:39 +0200
Date: Sun, 28 Dec 2003 21:57:17 +0200
From: none <deltha@analog.ro>
X-Mailer: The Bat! (v1.62i) Personal
Reply-To: none <deltha@analog.ro>
Organization: S.C. Analog S.A.
X-Priority: 3 (Normal)
Message-ID: <59201944070.20031228215717@analog.ro>
To: linux-mips@linux-mips.org
Subject: philips nino 300 - 4mb ram
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <deltha@analog.ro>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deltha@analog.ro
Precedence: bulk
X-list: linux-mips

Hello,
   I tried to boot the precompiled kernel :
   ftp://ftp.realitydiluted.com/Nino/kernel/precompiled/vmlinux-2.4.17.gz
   using pbsdboot but
   all I can see is the display scrambled,
   and not a bootup sequence, nothing at hyperterminal set as 115200 8-N-1
   How to get it working? (booting)
Manually:
I tried to crosscompile a kernel from sources
  ftp://ftp.realitydiluted.com/Nino/kernel/
  on a x86 machine but I encountered some errors when making dep

# make dep
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep scripts/mkdep.c
scripts/mkdep.c: In function `add_path':
scripts/mkdep.c:221: `PATH_MAX' undeclared (first use in this function)
scripts/mkdep.c:221: (Each undeclared identifier is reported only once
scripts/mkdep.c:221: for each function it appears in.)
scripts/mkdep.c:221: warning: unused variable `resolved_path'
make: *** [scripts/mkdep] Error 1
# gcc -v
Reading specs from /opt/toolchains/mips/lib/gcc-lib/mipsel-linux/3.1/specs
Configured with: ../gcc-3.1/configure --prefix=/opt/toolchains/mips --target=mipsel-linux i686-pc-linux-gnu --includedir=/opt/toolchains/mips/mipsel-linux/include --with-gxx-include-dir=/opt/toolchains/mips/mipsel-linux/include --mandir=/opt/toolchains/mips/man --infodir=/opt/toolchains/mips/info --enable-languages=c,c++ --enable-threads --enable-shared --disable-checking
Thread model: posix
gcc version 3.1
[root@crosscompiling linux]# echo $PATH
/opt/toolchains/mips/bin:/opt/toolchains/mips/mipsel-linux:/opt/toolchains/mips/mipsel-linux/bin:/usr/bin:/usr/sbin:/bin


So after modifying value PATH_MAX with 4095 in the mkdep.c I got

 # make dep
 gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep scripts/mkdep.c
 if [ ! -f /usr/src/linux/include/asm-mips/offset.h ]; then \
  touch /usr/src/linux/include/asm-mips/offset.h; \
 fi;
 make[1]: Entering directory `/usr/src/linux/arch/mips/boot'
 make[1]: Nothing to be done for `dep'.
 make[1]: Leaving directory `/usr/src/linux/arch/mips/boot'
 scripts/mkdep -- init/*.c > .depend
 /bin/sh: scripts/mkdep: cannot execute binary file
 make: *** [dep-files] Error 126

]# cat .config |grep "CONFIG_CROSS"
 CONFIG_CROSSCOMPILE=y
 
 #file scripts/mkdep
 scripts/mkdep: ELF 32-bit LSB mips-1 executable, MIPS R3000_LE [bfd bug], version 1, dynamically linked (uses shared libs), not stripped
-- 
Thanx in advance,
 Rujinski Remus Nikolai                          mailto:deltha@analog.ro
