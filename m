Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 10:58:07 +0200 (CEST)
Received: from [220.76.242.187] ([220.76.242.187]:4816 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133477AbWEZI57 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 10:57:59 +0200
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k4Q8xhEE002635
	for <linux-mips@linux-mips.org>; Fri, 26 May 2006 17:59:46 +0900
Message-ID: <003601c680a2$7946d3e0$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	<linux-mips@linux-mips.org>
Subject: compiling C++ app for RM9150 board
Date:	Fri, 26 May 2006 17:57:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello!

So, I succefully booted with PMC-sierra board RM9150. Now I need to compile 
and test some C++ application on it. I use toolchain provided by PMC-sierra 
and use the following compilation flags:

Creating .depend
mips64-linux-gnu-g++  -Wall -mips1 -mabi=32 -M main.cpp cmd.cpp ../ep.c > 
.depend
Compiling main.cpp
mips64-linux-gnu-g++ -c  -Wall -mips1 -mabi=32 main.cpp -o main.o
Compiling cmd.cpp
mips64-linux-gnu-g++ -c -Wall -mips1 -mabi=32 cmd.cpp -o cmd.o
Linking linkd
mips64-linux-gnu-g++ main.o cmd.o ../ep.c ../lib/api.a  -o linkd -m 
elf32btsmip

At linking stage I get whole bunch of errors:

/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld: 
main.o: ABI is incompatible with that of the selected emulation
File format not recognized: failed to merge target specific data of file 
main.o
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld: 
cmdProc.o: ABI is incompatible with that of the selected emulation
File format not recognized: failed to merge target specific data of file 
cmdProc.o
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld: 
../lib/clnkapi.a(clnkethapilnx.o): ABI is incompatible with that of the 
selected emulation
File format not recognized: failed to merge target specific data of file 
../lib/clnkapi.a(clnkethapilnx.o)
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld: 
BFD 2.13-mips64linux-031001 20020920 assertion fail 
/es/build/mips64linux/devo/bfd/elfxx-mips.c:1775
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld: 
BFD 2.13-mips64linux-031001 20020920 assertion fail 
/es/build/mips64linux/devo/bfd/elfxx-mips.c:1778
main.o: In function `main':
main.o(.text+0x28): relocation truncated to fit: R_MIPS_GOT16 card
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld: 
BFD 2.13-mips64linux-031001 20020920 assertion fail 
/es/build/mips64linux/devo/bfd/elfxx-mips.c:1775
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld: 
BFD 2.13-mips64linux-031001 20020920 assertion fail 
/es/build/mips64linux/devo/bfd/elfxx-mips.c:1778
main.o(.text+0x48): relocation truncated to fit: R_MIPS_CALL16 
getopt@@GLIBC_2.0

.... and so on

Seems I have some mismatch with formats?

I appreciate any hints. Thanks in advance!

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
