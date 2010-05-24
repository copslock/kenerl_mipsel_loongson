Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 16:25:05 +0200 (CEST)
Received: from mx1-v2.alinto.net ([83.145.109.31]:50660 "EHLO
        mx1-v2.alinto.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491928Ab0EXOZC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 May 2010 16:25:02 +0200
Received: from http1alinto.alinto.net (http1alinto.alinto.net [83.145.109.61])
        by mx1-v2.alinto.net (Postfix) with ESMTP id AA4E2580516
        for <linux-mips@linux-mips.org>; Mon, 24 May 2010 16:24:54 +0200 (CEST)
Received: by http1alinto.alinto.net (Postfix, from userid 48)
        id 95E3ED1EF1; Mon, 24 May 2010 16:24:54 +0200 (CEST)
Received: from unknown (octane/alinto.com@82.228.201.195); 24 May 2010 16:24:54 -0000
Message-ID: <1274711094.4bfa8c3675983@www.inmano.com>
Date:   Mon, 24 May 2010 16:24:54 +0200
To:     linux-mips@linux-mips.org
From:   octane indice <octane@alinto.com>
Subject: Cross compiling MIPS kernel under x86
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <octane@alinto.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: octane@alinto.com
Precedence: bulk
X-list: linux-mips


Hello

I have an octeon board. I'm trying to use a custom kernel from kernel.org
instead of the Cavium one.

Under x86, I installed the CrossTools from kegel:
http://www.kegel.com/crosstool/

I tried to cross compile:
octane@darkstar:/opt/linux-2.6.34$ make ARCH=mips
CROSS_COMPILE=/opt/crosstool/gcc-3.4.5-glibc-2.3.6/mips-unknown-linux-gnu/bin/mips-unknown-linux-gnu-
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  Checking missing-syscalls for N32
  CALL    scripts/checksyscalls.sh
  Checking missing-syscalls for O32
  CALL    scripts/checksyscalls.sh
  CALL    scripts/checksyscalls.sh
  CC      scripts/mod/empty.o
Assembler messages:
Error: Bad value (octeon) for -march
make[2]: *** [scripts/mod/empty.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2

So, I'm obviously missing a thing, but what?

Here is other information:
octane@darkstar:/opt$ cat world.c 
#include <stdio.h>
int main()
{
    printf("Hello world!\n");
    return 0;
}
octane@darkstar:/opt$
/opt/crosstool/gcc-3.4.5-glibc-2.3.6/mips-unknown-linux-gnu/bin/mips-unknown-linux-gnu-gcc
-march=octeon -o hello world.c 
world.c:1: error: bad value (octeon) for -march
octane@darkstar:/opt$

octane@darkstar:/opt$ ls
/opt/crosstool/gcc-3.4.5-glibc-2.3.6/mips-unknown-linux-gnu/bin/
fix-embedded-paths*                mips-unknown-linux-gnu-gcov*
mips-unknown-linux-gnu-addr2line*  mips-unknown-linux-gnu-gprof*
mips-unknown-linux-gnu-ar*         mips-unknown-linux-gnu-ld*
mips-unknown-linux-gnu-as*         mips-unknown-linux-gnu-nm*
mips-unknown-linux-gnu-c++*        mips-unknown-linux-gnu-objcopy*
mips-unknown-linux-gnu-c++filt*    mips-unknown-linux-gnu-objdump*
mips-unknown-linux-gnu-cpp*        mips-unknown-linux-gnu-ranlib*
mips-unknown-linux-gnu-g++*        mips-unknown-linux-gnu-readelf*
mips-unknown-linux-gnu-gcc*        mips-unknown-linux-gnu-size*
mips-unknown-linux-gnu-gcc-3.4.5*  mips-unknown-linux-gnu-strings*
mips-unknown-linux-gnu-gccbug*     mips-unknown-linux-gnu-strip*

So, is it a problem with octeon arch and gcc, or a mips problem?

Thanks








------------------------------------------------------------------------------------------


Envoyé avec Inmano, ma messagerie renversante et gratuite : http://www.inmano.com
