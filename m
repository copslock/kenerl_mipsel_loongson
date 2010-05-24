Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 16:32:05 +0200 (CEST)
Received: from mail1.adax.com ([208.201.231.104]:16565 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491928Ab0EXOcB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 May 2010 16:32:01 +0200
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id 5BDDE2130E;
        Mon, 24 May 2010 07:31:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 88AC020868;
        Mon, 24 May 2010 10:31:58 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at
        static-151-204-189-187.pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JH3GeAvdP94Y; Mon, 24 May 2010 10:31:53 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTPS id AABEC200C0;
        Mon, 24 May 2010 10:31:53 -0400 (EDT)
Message-ID: <4BFA8DEC.3070808@adax.com>
Date:   Mon, 24 May 2010 10:32:12 -0400
From:   Jan Rovins <janr@adax.com>
Organization: Adax Inc.
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     octane indice <octane@alinto.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
References: <1274711094.4bfa8c3675983@www.inmano.com>
In-Reply-To: <1274711094.4bfa8c3675983@www.inmano.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <janr@adax.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips

octane indice wrote:
> Hello
>
> I have an octeon board. I'm trying to use a custom kernel from kernel.org
> instead of the Cavium one.
>
> Under x86, I installed the CrossTools from kegel:
> http://www.kegel.com/crosstool/
>
> I tried to cross compile:
> octane@darkstar:/opt/linux-2.6.34$ make ARCH=mips
> CROSS_COMPILE=/opt/crosstool/gcc-3.4.5-glibc-2.3.6/mips-unknown-linux-gnu/bin/mips-unknown-linux-gnu-
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   Checking missing-syscalls for N32
>   CALL    scripts/checksyscalls.sh
>   Checking missing-syscalls for O32
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/checksyscalls.sh
>   CC      scripts/mod/empty.o
> Assembler messages:
> Error: Bad value (octeon) for -march
> make[2]: *** [scripts/mod/empty.o] Error 1
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2
>
> So, I'm obviously missing a thing, but what?
>
> Here is other information:
> octane@darkstar:/opt$ cat world.c 
> #include <stdio.h>
> int main()
> {
>     printf("Hello world!\n");
>     return 0;
> }
> octane@darkstar:/opt$
> /opt/crosstool/gcc-3.4.5-glibc-2.3.6/mips-unknown-linux-gnu/bin/mips-unknown-linux-gnu-gcc
> -march=octeon -o hello world.c 
> world.c:1: error: bad value (octeon) for -march
> octane@darkstar:/opt$
>
> octane@darkstar:/opt$ ls
> /opt/crosstool/gcc-3.4.5-glibc-2.3.6/mips-unknown-linux-gnu/bin/
> fix-embedded-paths*                mips-unknown-linux-gnu-gcov*
> mips-unknown-linux-gnu-addr2line*  mips-unknown-linux-gnu-gprof*
> mips-unknown-linux-gnu-ar*         mips-unknown-linux-gnu-ld*
> mips-unknown-linux-gnu-as*         mips-unknown-linux-gnu-nm*
> mips-unknown-linux-gnu-c++*        mips-unknown-linux-gnu-objcopy*
> mips-unknown-linux-gnu-c++filt*    mips-unknown-linux-gnu-objdump*
> mips-unknown-linux-gnu-cpp*        mips-unknown-linux-gnu-ranlib*
> mips-unknown-linux-gnu-g++*        mips-unknown-linux-gnu-readelf*
> mips-unknown-linux-gnu-gcc*        mips-unknown-linux-gnu-size*
> mips-unknown-linux-gnu-gcc-3.4.5*  mips-unknown-linux-gnu-strings*
> mips-unknown-linux-gnu-gccbug*     mips-unknown-linux-gnu-strip*
>
> So, is it a problem with octeon arch and gcc, or a mips problem?
>
> Thanks
>
>
>
>
>
>
>
>
> ------------------------------------------------------------------------------------------
>
>
> Envoyé avec Inmano, ma messagerie renversante et gratuite : http://www.inmano.com
>
>
>
>   

gcc-3.4.5-glibc-2.3.6


The recognition of "octeon" as an option does not show up in GCC until mainstream version 4.4.
looks like your gcc is too old 
gcc-3.4.5-glibc-2.3.6


Jan
