Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 12:21:34 +0100 (BST)
Received: from nx5.HRZ.Uni-Dortmund.DE ([IPv6:::ffff:129.217.131.21]:44151
	"EHLO nx5.hrz.uni-dortmund.de") by linux-mips.org with ESMTP
	id <S8225278AbTEJLVb>; Sat, 10 May 2003 12:21:31 +0100
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP id 245314AA2B9
	for <linux-mips@linux-mips.org>; Sat, 10 May 2003 13:21:29 +0200 (MET DST)
Received: from linuxpc1 (p508EFB9C.dip.t-dialin.net [80.142.251.156])
	(authenticated (0 bits))
	by unimail.uni-dortmund.de (8.12.9+Sun/8.11.6) with ESMTP id h4ABLMtC014169
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified NOT)
	for <linux-mips@linux-mips.org>; Sat, 10 May 2003 13:21:23 +0200 (MEST)
From: Benjamin =?iso-8859-1?q?Menk=FCc?= <benmen@gmx.de>
Reply-To: menkuec@auto-intern.com
To: linux-mips@linux-mips.org
Subject: Re: compiling glibc
Date: Sat, 10 May 2003 13:21:21 +0200
User-Agent: KMail/1.5.1
References: <200305092145.43690.benmen@gmx.de> <20030510042535.GA2336@nevyn.them.org> <200305101156.08254.benmen@gmx.de>
In-Reply-To: <200305101156.08254.benmen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305101321.21232.benmen@gmx.de>
X-MailScanner-Information: UniDo-UniMail
X-MailScanner: Found to be clean
Return-Path: <benmen@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benmen@gmx.de
Precedence: bulk
X-list: linux-mips

Okay, I fixed this problem by adding --disable-profile:

[benmen@linuxpc1 mipsel-glibc] LD_LIBRARY_PATH="" CFLAGS="-O2 -g 
-finline-limit=10000" CC="mipsel-linux-gcc" AS="mipsel-linux-as" 
../glibc-2.3.2/configure --build=i686-linux --host=mipsel-linux 
--enable-add-ons --prefix=/home/benmen/mipsel 
--with-headers=/home/benmen/mips/kernel/mips-2.4.20/include --disable-profile

...

Now I can compile until this comes:

[benmen@linuxpc1 mipsel-glibc] BUILD_CC=gcc CC=mipsel-linux-gcc ma

...

make[3]: Leaving directory `/home/benmen/mips/glibc-2.3.2/elf'
mipsel-linux-gcc   -nostdlib -nostartfiles -r -o 
/home/benmen/mips/mipsel-glibc/elf/librtld.os '-Wl,-(' 
/home/benmen/mips/mipsel-glibc/elf/dl-allobjs.os 
/home/benmen/mips/mipsel-glibc/elf/rtld-libc.a -lgcc '-Wl,-)'
mipsel-linux-gcc   -nostdlib -nostartfiles -shared                      \
   -Wl,-z,defs -Wl,--verbose 2>&1 |     \
          sed -e '/^=========/,/^=========/!d;/^=========/d'    \
              -e 's/\. = 0 + SIZEOF_HEADERS;/& _begin = . - SIZEOF_HEADERS;/' 
\
          > /home/benmen/mips/mipsel-glibc/elf/ld.so.lds
mipsel-linux-gcc   -nostdlib -nostartfiles -shared -o 
/home/benmen/mips/mipsel-glibc/elf/ld.so                  \
           -Wl,-z,defs                          \
          /home/benmen/mips/mipsel-glibc/elf/librtld.os 
-Wl,--version-script=/home/benmen/mips/mipsel-glibc/ld.map    \
          -Wl,-soname=ld.so.1 -T /home/benmen/mips/mipsel-glibc/elf/ld.so.lds
/home/benmen/mips/mipsel-glibc/elf/librtld.os: In function 
`_dl_resolve_conflicts':
/home/benmen/mips/glibc-2.3.2/elf/dl-conflict.c:65: undefined reference to 
`elf_machine_rela.7'
collect2: ld returned 1 exit status
make[2]: *** [/home/benmen/mips/mipsel-glibc/elf/ld.so] Fehler 1
make[2]: Leaving directory `/home/benmen/mips/glibc-2.3.2/elf'
make[1]: *** [elf/subdir_lib] Fehler 2
make[1]: Leaving directory `/home/benmen/mips/glibc-2.3.2'
make: *** [all] Fehler 2
Verzeichnis: ~/mips/mipsel-glibc
[benmen@linuxpc1 mipsel-glibc]

regards,

Ben
