Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 11:45:45 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:38344
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28576377AbYGPKpn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 11:45:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6GAjeAP017538;
	Wed, 16 Jul 2008 11:45:40 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6GAjX53017470;
	Wed, 16 Jul 2008 11:45:33 +0100
Date:	Wed, 16 Jul 2008 11:45:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS toolchain
Message-ID: <20080716104533.GA7198@linux-mips.org>
References: <487DA40C.6010405@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487DA40C.6010405@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 10:32:28AM +0300, Dmitri Vorobiev wrote:

> The linux-mips.org Web site recommends gcc 3.4.4 to build the MIPS kernel. However:
> 
> <<<<<<<<<<<<<<<<<<
> 
> [dmitri.vorobiev@amber linux-2.6]$ mips-unknown-linux-gnu-gcc -v
> Reading specs from /home/dmitri.vorobiev/Projects/misc/zoo/lib/gcc/mips-unknown-linux-gnu/3.4.4/specs
> Configured with: ../src/gcc-3.4.4/configure --prefix=/home/dmitri.vorobiev/Projects/misc/zoo --target=mips-unknown-linux-gnu --disable-nls --without-headers --with-gnu-ld --with-gnu-as --disable-shared --disable-threads
> Thread model: single
> gcc version 3.4.4
> [dmitri.vorobiev@amber linux-2.6]$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu-
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CC      init/main.o
> include/asm/bitops.h: In function `start_kernel':
> include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
> include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
> include/asm/bitops.h:76: warning: asm operand 2 probably doesn't match constraints
> include/asm/bitops.h:76: error: impossible constraint in `asm'
> include/asm/bitops.h:76: error: impossible constraint in `asm'
> include/asm/bitops.h:76: error: impossible constraint in `asm'
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> [dmitri.vorobiev@amber linux-2.6]$
> 
> <<<<<<<<<<<<<<<<<<
> 
> Kernel build goes smoothly for me with this gcc version:
> 
> <<<<<<<<<<<<<<<<<<
> 
> [dmitri.vorobiev@amber linux-2.6]$ mips-unknown-linux-gnu-gcc -v
> Using built-in specs.
> Target: mips-unknown-linux-gnu
> Configured with: ../gcc-4.3.0/configure --target=mips-unknown-linux-gnu --disable-nls --disable-threads --disable-shared --disable-multilib --disable-libmudflap --disable-libssp --prefix=/home/dmitri.vorobiev/Projects/misc/zoo/4.3-toolchain --with-gmp=/home/dmitri.vorobiev/Projects/misc/zoo/ --with-mfpr=/home/dmitri.vorobiev/Projects/misc/zoo --without-headers --with-gnu-as=/tmp/cross/ --with-gnu-ld=/tmp/cross/ --disable-libgcc --enable-languages=c --disable-libgomp
> Thread model: single
> gcc version 4.3.0 (GCC)
> [dmitri.vorobiev@amber linux-2.6]$
> 
> <<<<<<<<<<<<<<<<<<
> 
> What I would like to know is which gcc/binutils versions are currently the blessed ones. Thanks.

Anything from gcc 3.2 to 4.3 is supposed to work for 32-bit kernels; 3.3
to 4.3 are the blessed ones for 64-bit kernels.

I'll look into that build problem ...   hmm...  First thing I'm hitting
with 3.4.6 and binutils 2.18 is:

[ralf@denk linux-mips]$ make malta_defconfig
[ralf@denk linux-mips]$ nice -19 make
cc1: error: unrecognized command line option "-fno-stack-protector"
scripts/kconfig/conf -s arch/mips/Kconfig
cc1: error: unrecognized command line option "-fno-stack-protector"

With the offending line in the main Makefile commented out I get the same
error messages as you.  Initial fix below.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index 9a7274b..49df8c4 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		"2:	b	1b					\n"
 		"	.previous					\n"
 		: "=&r" (temp), "=m" (*m)
-		: "i" (bit), "m" (*m), "r" (~0));
+		: "ir" (bit), "m" (*m), "r" (~0));
 #endif /* CONFIG_CPU_MIPSR2 */
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
@@ -147,7 +147,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		"2:	b	1b					\n"
 		"	.previous					\n"
 		: "=&r" (temp), "=m" (*m)
-		: "i" (bit), "m" (*m));
+		: "ir" (bit), "m" (*m));
 #endif /* CONFIG_CPU_MIPSR2 */
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__(
@@ -428,7 +428,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		"2:	b	1b					\n"
 		"	.previous					\n"
 		: "=&r" (temp), "=m" (*m), "=&r" (res)
-		: "i" (bit), "m" (*m)
+		: "ir" (bit), "m" (*m)
 		: "memory");
 #endif
 	} else if (cpu_has_llsc) {
