Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 12:02:59 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:47531 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20040275AbYGPLCz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 12:02:55 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id CD921C8101;
	Wed, 16 Jul 2008 14:02:49 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id nHUptE8CUJVm; Wed, 16 Jul 2008 14:02:49 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id A46CAC80FE;
	Wed, 16 Jul 2008 14:02:49 +0300 (EEST)
Message-ID: <487DD559.3020802@movial.fi>
Date:	Wed, 16 Jul 2008 14:02:49 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: MIPS toolchain
References: <487DA40C.6010405@movial.fi> <20080716104533.GA7198@linux-mips.org>
In-Reply-To: <20080716104533.GA7198@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Jul 16, 2008 at 10:32:28AM +0300, Dmitri Vorobiev wrote:
> 
>> The linux-mips.org Web site recommends gcc 3.4.4 to build the MIPS kernel. However:
>>
>> <<<<<<<<<<<<<<<<<<
>>
>> [dmitri.vorobiev@amber linux-2.6]$ mips-unknown-linux-gnu-gcc -v
>> Reading specs from /home/dmitri.vorobiev/Projects/misc/zoo/lib/gcc/mips-unknown-linux-gnu/3.4.4/specs
>> Configured with: ../src/gcc-3.4.4/configure --prefix=/home/dmitri.vorobiev/Projects/misc/zoo --target=mips-unknown-linux-gnu --disable-nls --without-headers --with-gnu-ld --with-gnu-as --disable-shared --disable-threads
>> Thread model: single
>> gcc version 3.4.4
>> [dmitri.vorobiev@amber linux-2.6]$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu-
>>   CHK     include/linux/version.h
>>   CHK     include/linux/utsrelease.h
>>   CALL    scripts/checksyscalls.sh
>>   CC      init/main.o
>> include/asm/bitops.h: In function `start_kernel':
>> include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
>> include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
>> include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
>> include/asm/bitops.h:76: error: impossible constraint in `asm'
>> include/asm/bitops.h:76: error: impossible constraint in `asm'
>> include/asm/bitops.h:76: error: impossible constraint in `asm'
>> make[1]: *** [init/main.o] Error 1
>> make: *** [init] Error 2
>> [dmitri.vorobiev@amber linux-2.6]$
>>
>> <<<<<<<<<<<<<<<<<<
>>
>> Kernel build goes smoothly for me with this gcc version:
>>
>> <<<<<<<<<<<<<<<<<<
>>
>> [dmitri.vorobiev@amber linux-2.6]$ mips-unknown-linux-gnu-gcc -v
>> Using built-in specs.
>> Target: mips-unknown-linux-gnu
>> Configured with: ../gcc-4.3.0/configure --target=mips-unknown-linux-gnu --disable-nls --disable-threads --disable-shared --disable-multilib --disable-libmudflap --disable-libssp --prefix=/home/dmitri.vorobiev/Projects/misc/zoo/4.3-toolchain --with-gmp=/home/dmitri.vorobiev/Projects/misc/zoo/ --with-mfpr=/home/dmitri.vorobiev/Projects/misc/zoo --without-headers --with-gnu-as=/tmp/cross/ --with-gnu-ld=/tmp/cross/ --disable-libgcc --enable-languages=c --disable-libgomp
>> Thread model: single
>> gcc version 4.3.0 (GCC)
>> [dmitri.vorobiev@amber linux-2.6]$
>>
>> <<<<<<<<<<<<<<<<<<
>>
>> What I would like to know is which gcc/binutils versions are currently the blessed ones. Thanks.
> 
> Anything from gcc 3.2 to 4.3 is supposed to work for 32-bit kernels; 3.3
> to 4.3 are the blessed ones for 64-bit kernels.
> 
> I'll look into that build problem ...   hmm...  First thing I'm hitting
> with 3.4.6 and binutils 2.18 is:
> 
> [ralf@denk linux-mips]$ make malta_defconfig
> [ralf@denk linux-mips]$ nice -19 make
> cc1: error: unrecognized command line option "-fno-stack-protector"
> scripts/kconfig/conf -s arch/mips/Kconfig
> cc1: error: unrecognized command line option "-fno-stack-protector"
> 
> With the offending line in the main Makefile commented out I get the same
> error messages as you.  Initial fix below.

With this fix applied on top of the current Linus git tree I was able to build and boot the kernel using my 4Kc. Thanks a lot!

Regards,
Dmitri

> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
> index 9a7274b..49df8c4 100644
> --- a/include/asm-mips/bitops.h
> +++ b/include/asm-mips/bitops.h
> @@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
>  		"2:	b	1b					\n"
>  		"	.previous					\n"
>  		: "=&r" (temp), "=m" (*m)
> -		: "i" (bit), "m" (*m), "r" (~0));
> +		: "ir" (bit), "m" (*m), "r" (~0));
>  #endif /* CONFIG_CPU_MIPSR2 */
>  	} else if (cpu_has_llsc) {
>  		__asm__ __volatile__(
> @@ -147,7 +147,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
>  		"2:	b	1b					\n"
>  		"	.previous					\n"
>  		: "=&r" (temp), "=m" (*m)
> -		: "i" (bit), "m" (*m));
> +		: "ir" (bit), "m" (*m));
>  #endif /* CONFIG_CPU_MIPSR2 */
>  	} else if (cpu_has_llsc) {
>  		__asm__ __volatile__(
> @@ -428,7 +428,7 @@ static inline int test_and_clear_bit(unsigned long nr,
>  		"2:	b	1b					\n"
>  		"	.previous					\n"
>  		: "=&r" (temp), "=m" (*m), "=&r" (res)
> -		: "i" (bit), "m" (*m)
> +		: "ir" (bit), "m" (*m)
>  		: "memory");
>  #endif
>  	} else if (cpu_has_llsc) {
