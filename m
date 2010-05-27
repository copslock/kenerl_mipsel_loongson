Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 18:30:01 +0200 (CEST)
Received: from mx3-v2.alinto.net ([83.145.109.33]:42372 "EHLO
        mx3-v2.alinto.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492358Ab0E0Q34 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 18:29:56 +0200
X-Virus-Scanned: amavisd-new at alinto.net
Received: from http3alinto.alinto.net (http3alinto.alinto.net [83.145.109.63])
        by mx3-v2.alinto.net (Postfix) with ESMTP id A28F97423E;
        Thu, 27 May 2010 18:29:48 +0200 (CEST)
Received: by http3alinto.alinto.net (Postfix, from userid 48)
        id 95EC757740; Thu, 27 May 2010 18:29:48 +0200 (CEST)
Received: from unknown (octane/alinto.com@82.228.201.195); 27 May 2010 18:29:48 -0000
Message-ID: <1274977788.4bfe9dfc7680f@www.inmano.com>
Date:   Thu, 27 May 2010 18:29:48 +0200
To:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
From:   octane indice <octane@alinto.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
In-Reply-To: <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com>
References: <1274711094.4bfa8c3675983@www.inmano.com>  <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>  <20100525131341.GA26500@linux-mips.org>  <1274795905.4bfbd781a17fa@www.inmano.com>  <20100525144400.GA30900@linux-mips.org>  <1274879482.4bfd1dfa91e70@www.inmano.com>
 <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <octane@alinto.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: octane@alinto.com
Precedence: bulk
X-list: linux-mips

Response to Dmitri Vorobiev <dmitri.vorobiev@gmail.com> :
> Just checked that the following steps result in a successful
> build of a vanilla 2.6.34 vmlinux:
> 
Thanks for taking the time to do it.

> http://ftp.gnu.org/gnu/gcc/gcc-4.4.4/gcc-core-4.4.4.tar.bz2
> tar jxf gcc-core-4.4.4.tar.bz2
> cd ../build
> ../src/gcc-4.4.4/configure --target=mips64-unknown-linux-gnu
> --prefix=/work/tmp/zoo --disable-threads --disable-shared
> --disable-multilib --disable-libgcc --disable-libmudflap
> --disable-libssp --disable-libgomp
> make

It fails here with something related to stdc++. With adding a
--enable-language=c it works. So the configure line I used is:
../gcc-4.4.4/configure --target=mips64-unknown-linux-gnu
--prefix=/var/samba/mips --disable-threads --disable-shared
--disable-multilib --disable-libgcc --disable-libmudflap --disable-libssp
--disable-libgomp --enable-languages=c

> make ARCH=mips cavium-octeon_defconfig
> make ARCH=mips
> CROSS_COMPILE=/work/tmp/zoo/bin/mips64-unknown-linux-gnu- vmlinux
> 
> Hope that helps.
> 
It helped me a lot, thank you. The kernel compiles fine. 
The kernel is very huge: 39MBytes (!).
After a mips64-unknown-linux-gnu-strip, it downsized to 3.3MBytes.
But that kernel doesn't boot.

The system in the board I have uses in U-boot:
ext2load ide 0 4000000 vmlinux
bootoctlinux 4000000 (other args..)

But when I replace the vmlinux file with mine called 'mips', it says:
RSEC-K1# ext2load ide 0 4000000 mips

3362840 bytes read
WARNING: Data loaded outside of the reserved load area, memory corruption
may occur.
WARNING: Please refer to the bootloader memory map documentation for more
information.
RSEC-K1# bootoctlinux 4000000
ELF file is 64 bit
Attempting to allocate memory for ELF segment: addr: 0xffffffff81100000
(adjusted to: 0x0000000001100000), size 0x355c00
Allocated memory for ELF segment: addr: 0xffffffff81100000, size 0x355c00
Attempting to allocate memory for ELF segment: addr: 0xffffffff81343da0
(adjusted to: 0x0000000001343da0), size 0x24
Error allocating memory for elf image!
## ERROR loading File!
RSEC-K1#

I tried a lot of different numbers like 2000000 or greater, depending of
what I find in mailing lists, but I don't find the right value. Is there a
way to compute it, or it's kernel I made that is not right?

Thanks

> -------------------  ---------------------




Envoyé avec Inmano, ma messagerie renversante et gratuite : http://www.inmano.com
