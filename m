Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 08:32:38 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:33190 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20040110AbYGPHce (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 08:32:34 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 8D1A0C80EA
	for <linux-mips@linux-mips.org>; Wed, 16 Jul 2008 10:32:28 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id nZUwVVyyYDTB for <linux-mips@linux-mips.org>;
	Wed, 16 Jul 2008 10:32:28 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 6E223C8084
	for <linux-mips@linux-mips.org>; Wed, 16 Jul 2008 10:32:28 +0300 (EEST)
Message-ID: <487DA40C.6010405@movial.fi>
Date:	Wed, 16 Jul 2008 10:32:28 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: MIPS toolchain
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Hi,

The linux-mips.org Web site recommends gcc 3.4.4 to build the MIPS kernel. However:

<<<<<<<<<<<<<<<<<<

[dmitri.vorobiev@amber linux-2.6]$ mips-unknown-linux-gnu-gcc -v
Reading specs from /home/dmitri.vorobiev/Projects/misc/zoo/lib/gcc/mips-unknown-linux-gnu/3.4.4/specs
Configured with: ../src/gcc-3.4.4/configure --prefix=/home/dmitri.vorobiev/Projects/misc/zoo --target=mips-unknown-linux-gnu --disable-nls --without-headers --with-gnu-ld --with-gnu-as --disable-shared --disable-threads
Thread model: single
gcc version 3.4.4
[dmitri.vorobiev@amber linux-2.6]$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu-
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC      init/main.o
include/asm/bitops.h: In function `start_kernel':
include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
include/asm/bitops.h:76: error: impossible constraint in `asm'
include/asm/bitops.h:76: error: impossible constraint in `asm'
include/asm/bitops.h:76: error: impossible constraint in `asm'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
[dmitri.vorobiev@amber linux-2.6]$

<<<<<<<<<<<<<<<<<<

Kernel build goes smoothly for me with this gcc version:

<<<<<<<<<<<<<<<<<<

[dmitri.vorobiev@amber linux-2.6]$ mips-unknown-linux-gnu-gcc -v
Using built-in specs.
Target: mips-unknown-linux-gnu
Configured with: ../gcc-4.3.0/configure --target=mips-unknown-linux-gnu --disable-nls --disable-threads --disable-shared --disable-multilib --disable-libmudflap --disable-libssp --prefix=/home/dmitri.vorobiev/Projects/misc/zoo/4.3-toolchain --with-gmp=/home/dmitri.vorobiev/Projects/misc/zoo/ --with-mfpr=/home/dmitri.vorobiev/Projects/misc/zoo --without-headers --with-gnu-as=/tmp/cross/ --with-gnu-ld=/tmp/cross/ --disable-libgcc --enable-languages=c --disable-libgomp
Thread model: single
gcc version 4.3.0 (GCC)
[dmitri.vorobiev@amber linux-2.6]$

<<<<<<<<<<<<<<<<<<

What I would like to know is which gcc/binutils versions are currently the blessed ones. Thanks.

Regards,
Dmitri
