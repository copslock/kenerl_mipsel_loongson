Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 07:48:51 +0200 (CEST)
Received: from dalsmrelay2.nai.com ([205.227.136.216]:13103 "EHLO
        dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490967Ab0JVFsq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 07:48:46 +0200
Received: from (unknown [10.64.5.51]) by dalsmrelay2.nai.com with smtp
        (TLS: TLSv1/SSLv3,128bits,AES128-SHA)
         id 1c8a_118a_4898ff52_dd9f_11df_a6d2_00219b929abd;
        Fri, 22 Oct 2010 05:43:35 +0000
Received: from dalexbr1.corp.nai.org (161.69.111.81) by DALEXHT1.corp.nai.org
 (10.64.5.51) with Microsoft SMTP Server id 8.2.254.0; Fri, 22 Oct 2010
 00:43:22 -0500
Received: from [172.22.196.222] ([172.22.196.222]) by dalexbr1.corp.nai.org
 with Microsoft SMTPSVC(6.0.3790.4675);  Fri, 22 Oct 2010 00:43:20 -0500
Message-ID: <4CC123E7.1000409@snapgear.com>
Date:   Fri, 22 Oct 2010 15:40:55 +1000
From:   Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.14) Gecko/20101006 Thunderbird/3.0.9
MIME-Version: 1.0
To:     Akinobu Mita <akinobu.mita@gmail.com>
CC:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@uclinux.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Hirokazu Takata <takata@linux-m32r.org>,
        linux-m32r@ml.linux-m32r.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH v2 22/22] bitops: remove minix bitops from asm/bitops.h
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com> <1287672077-5797-23-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1287672077-5797-23-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2010 05:43:20.0782 (UTC) FILETIME=[08E65EE0:01CB71AC]
Return-Path: <Greg_Ungerer@McAfee.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@snapgear.com
Precedence: bulk
X-list: linux-mips

On 22/10/10 00:41, Akinobu Mita wrote:
> minix bit operations are only used by minix filesystem and useless
> by other modules. Because byte order of inode and block bitmaps is
> defferent on each architecture like below:
>
> m68k:
> 	big-endian 16bit indexed bitmaps
>
> h8300, microblaze, s390, sparc, m68knommu:
> 	big-endian 32 or 64bit indexed bitmaps
>
> m32r, mips, sh, xtensa:
> 	big-endian 32 or 64bit indexed bitmaps for big-endian mode
> 	little-endian bitmaps for little-endian mode
>
> Others:
> 	little-endian bitmaps
>
> In order to move minix bit operations from asm/bitops.h to
> architecture independent code in minix file system, this provides two
> config options.
>
> CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED is only selected by m68k.
> CONFIG_MINIX_FS_NATIVE_ENDIAN is selected by the architectures which
> use native byte order bitmaps (h8300, microblaze, s390, sparc,
> m68knommu, m32r, mips, sh, xtensa).
> The architectures which always use little-endian bitmaps do not select
> these options.
>
> Finally, we can remove minix bit operations from asm/bitops.h for
> all architectures.
>
> Signed-off-by: Akinobu Mita<akinobu.mita@gmail.com>
> Cc: Greg Ungerer<gerg@uclinux.org>

I have no problems with the m68k part.

Acked-by: Greg Ungerer <gerg@uclinux.org>


> Cc: Geert Uytterhoeven<geert@linux-m68k.org>
> Cc: Roman Zippel<zippel@linux-m68k.org>
> Cc: Andreas Schwab<schwab@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Martin Schwidefsky<schwidefsky@de.ibm.com>
> Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> Cc: Yoshinori Sato<ysato@users.sourceforge.jp>
> Cc: Michal Simek<monstr@monstr.eu>
> Cc: microblaze-uclinux@itee.uq.edu.au
> Cc: "David S. Miller"<davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Hirokazu Takata<takata@linux-m32r.org>
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Paul Mundt<lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org
> Cc: Chris Zankel<chris@zankel.net>
> ---
> Mostly rewritten since previous submission
>
>   arch/alpha/include/asm/bitops.h       |    2 -
>   arch/arm/include/asm/bitops.h         |   14 ------
>   arch/avr32/include/asm/bitops.h       |    1 -
>   arch/blackfin/include/asm/bitops.h    |    1 -
>   arch/cris/include/asm/bitops.h        |    1 -
>   arch/frv/include/asm/bitops.h         |    2 -
>   arch/h8300/include/asm/bitops.h       |    1 -
>   arch/ia64/include/asm/bitops.h        |    1 -
>   arch/m32r/include/asm/bitops.h        |    1 -
>   arch/m68k/include/asm/bitops_mm.h     |   30 ------------
>   arch/mips/include/asm/bitops.h        |    1 -
>   arch/mn10300/include/asm/bitops.h     |    1 -
>   arch/parisc/include/asm/bitops.h      |    2 -
>   arch/powerpc/include/asm/bitops.h     |   14 ------
>   arch/s390/include/asm/bitops.h        |    1 -
>   arch/sh/include/asm/bitops.h          |    1 -
>   arch/sparc/include/asm/bitops_32.h    |    1 -
>   arch/sparc/include/asm/bitops_64.h    |    2 -
>   arch/tile/include/asm/bitops.h        |    1 -
>   arch/x86/include/asm/bitops.h         |    2 -
>   arch/xtensa/include/asm/bitops.h      |    1 -
>   fs/minix/Kconfig                      |    8 +++
>   fs/minix/minix.h                      |   79 +++++++++++++++++++++++++++++++++
>   include/asm-generic/bitops.h          |    1 -
>   include/asm-generic/bitops/minix-le.h |   15 ------
>   include/asm-generic/bitops/minix.h    |   15 ------
>   26 files changed, 87 insertions(+), 112 deletions(-)
>   delete mode 100644 include/asm-generic/bitops/minix-le.h
>   delete mode 100644 include/asm-generic/bitops/minix.h
>
> diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
> index 822433a..85b8152 100644
> --- a/arch/alpha/include/asm/bitops.h
> +++ b/arch/alpha/include/asm/bitops.h
> @@ -459,8 +459,6 @@ sched_find_first_bit(const unsigned long b[2])
>   #define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
>   #define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
>
> -#include<asm-generic/bitops/minix.h>
> -
>   #endif /* __KERNEL__ */
>
>   #endif /* _ALPHA_BITOPS_H */
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index ac2edb4..59a2a2b 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -332,20 +332,6 @@ static inline int fls(int x)
>   #define ext2_clear_bit_atomic(lock,nr,p)        \
>   		test_and_clear_le_bit(nr, (unsigned long *)(p))
>
> -/*
> - * Minix is defined to use little-endian byte ordering.
> - * These do not need to be atomic.
> - */
> -#define minix_set_bit(nr,p)			\
> -		__set_le_bit(nr, (unsigned long *)(p))
> -#define minix_test_bit(nr,p)			\
> -		test_le_bit(nr, (unsigned long *)(p))
> -#define minix_test_and_set_bit(nr,p)		\
> -		__test_and_set_le_bit(nr, (unsigned long *)(p))
> -#define minix_test_and_clear_bit(nr,p)		\
> -		__test_and_clear_le_bit(nr, (unsigned long *)(p))
> -#define minix_find_first_zero_bit(p,sz)		\
> -		find_first_zero_le_bit((unsigned long *)(p), sz)
>
>   #endif /* __KERNEL__ */
>
> diff --git a/arch/avr32/include/asm/bitops.h b/arch/avr32/include/asm/bitops.h
> index 73a163a..72444d9 100644
> --- a/arch/avr32/include/asm/bitops.h
> +++ b/arch/avr32/include/asm/bitops.h
> @@ -301,6 +301,5 @@ static inline int ffs(unsigned long word)
>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix-le.h>
>
>   #endif /* __ASM_AVR32_BITOPS_H */
> diff --git a/arch/blackfin/include/asm/bitops.h b/arch/blackfin/include/asm/bitops.h
> index 2c549f7..68843fa 100644
> --- a/arch/blackfin/include/asm/bitops.h
> +++ b/arch/blackfin/include/asm/bitops.h
> @@ -27,7 +27,6 @@
>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #ifndef CONFIG_SMP
>   #include<linux/irqflags.h>
> diff --git a/arch/cris/include/asm/bitops.h b/arch/cris/include/asm/bitops.h
> index 71bea40..310e0de 100644
> --- a/arch/cris/include/asm/bitops.h
> +++ b/arch/cris/include/asm/bitops.h
> @@ -159,7 +159,6 @@ static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
>   #define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
>   #define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
>
> -#include<asm-generic/bitops/minix.h>
>   #include<asm-generic/bitops/sched.h>
>
>   #endif /* __KERNEL__ */
> diff --git a/arch/frv/include/asm/bitops.h b/arch/frv/include/asm/bitops.h
> index e3ea644..a1d00b0 100644
> --- a/arch/frv/include/asm/bitops.h
> +++ b/arch/frv/include/asm/bitops.h
> @@ -406,8 +406,6 @@ int __ilog2_u64(u64 n)
>   #define ext2_set_bit_atomic(lock,nr,addr)	test_and_set_bit  ((nr) ^ 0x18, (addr))
>   #define ext2_clear_bit_atomic(lock,nr,addr)	test_and_clear_bit((nr) ^ 0x18, (addr))
>
> -#include<asm-generic/bitops/minix-le.h>
> -
>   #endif /* __KERNEL__ */
>
>   #endif /* _ASM_BITOPS_H */
> diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
> index 23cea66..e856c1b 100644
> --- a/arch/h8300/include/asm/bitops.h
> +++ b/arch/h8300/include/asm/bitops.h
> @@ -202,7 +202,6 @@ static __inline__ unsigned long __ffs(unsigned long word)
>   #include<asm-generic/bitops/lock.h>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif /* __KERNEL__ */
>
> diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
> index 336984a..b76f7e0 100644
> --- a/arch/ia64/include/asm/bitops.h
> +++ b/arch/ia64/include/asm/bitops.h
> @@ -461,7 +461,6 @@ static __inline__ unsigned long __arch_hweight64(unsigned long x)
>   #define ext2_set_bit_atomic(l,n,a)	test_and_set_bit(n,a)
>   #define ext2_clear_bit_atomic(l,n,a)	test_and_clear_bit(n,a)
>
> -#include<asm-generic/bitops/minix.h>
>   #include<asm-generic/bitops/sched.h>
>
>   #endif /* __KERNEL__ */
> diff --git a/arch/m32r/include/asm/bitops.h b/arch/m32r/include/asm/bitops.h
> index cdfb4c8..6300f22 100644
> --- a/arch/m32r/include/asm/bitops.h
> +++ b/arch/m32r/include/asm/bitops.h
> @@ -268,7 +268,6 @@ static __inline__ int test_and_change_bit(int nr, volatile void * addr)
>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif /* __KERNEL__ */
>
> diff --git a/arch/m68k/include/asm/bitops_mm.h b/arch/m68k/include/asm/bitops_mm.h
> index f31ed5a..5f06275 100644
> --- a/arch/m68k/include/asm/bitops_mm.h
> +++ b/arch/m68k/include/asm/bitops_mm.h
> @@ -325,36 +325,6 @@ static inline int __fls(int x)
>   #include<asm-generic/bitops/hweight.h>
>   #include<asm-generic/bitops/lock.h>
>
> -/* Bitmap functions for the minix filesystem */
> -
> -static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
> -{
> -	const unsigned short *p = vaddr, *addr = vaddr;
> -	unsigned short num;
> -
> -	if (!size)
> -		return 0;
> -
> -	size = (size>>  4) + ((size&  15)>  0);
> -	while (*p++ == 0xffff) {
> -		if (--size == 0)
> -			return (p - addr)<<  4;
> -	}
> -
> -	num = *--p;
> -	return ((p - addr)<<  4) + ffz(num);
> -}
> -
> -#define minix_test_and_set_bit(nr, addr)	__test_and_set_bit((nr) ^ 16, (unsigned long *)(addr))
> -#define minix_set_bit(nr,addr)			__set_bit((nr) ^ 16, (unsigned long *)(addr))
> -#define minix_test_and_clear_bit(nr, addr)	__test_and_clear_bit((nr) ^ 16, (unsigned long *)(addr))
> -
> -static inline int minix_test_bit(int nr, const void *vaddr)
> -{
> -	const unsigned short *p = vaddr;
> -	return (p[nr>>  4]&  (1U<<  (nr&  15))) != 0;
> -}
> -
>   /* Bitmap functions for little endian. */
>
>   #define __set_le_bit(nr, addr)	\
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index 07ce5aa..6a2202c 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -706,7 +706,6 @@ static inline int ffs(int word)
>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif /* __KERNEL__ */
>
> diff --git a/arch/mn10300/include/asm/bitops.h b/arch/mn10300/include/asm/bitops.h
> index e1a9768..94ee844 100644
> --- a/arch/mn10300/include/asm/bitops.h
> +++ b/arch/mn10300/include/asm/bitops.h
> @@ -234,7 +234,6 @@ int ffs(int x)
>   	test_and_clear_bit((nr), (addr))
>
>   #include<asm-generic/bitops/le.h>
> -#include<asm-generic/bitops/minix-le.h>
>
>   #endif /* __KERNEL__ */
>   #endif /* __ASM_BITOPS_H */
> diff --git a/arch/parisc/include/asm/bitops.h b/arch/parisc/include/asm/bitops.h
> index 919d7ed..43c516f 100644
> --- a/arch/parisc/include/asm/bitops.h
> +++ b/arch/parisc/include/asm/bitops.h
> @@ -234,6 +234,4 @@ static __inline__ int fls(int x)
>
>   #endif	/* __KERNEL__ */
>
> -#include<asm-generic/bitops/minix-le.h>
> -
>   #endif /* _PARISC_BITOPS_H */
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index eb9ce7f..bf5ccfc 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -308,20 +308,6 @@ unsigned long find_next_le_bit(const unsigned long *addr,
>   #define ext2_clear_bit_atomic(lock, nr, addr) \
>   	test_and_clear_le_bit((nr), (unsigned long*)addr)
>
> -/* Bitmap functions for the minix filesystem.  */
> -
> -#define minix_test_and_set_bit(nr,addr) \
> -	__test_and_set_le_bit(nr, (unsigned long *)addr)
> -#define minix_set_bit(nr,addr) \
> -	__set_le_bit(nr, (unsigned long *)addr)
> -#define minix_test_and_clear_bit(nr,addr) \
> -	__test_and_clear_le_bit(nr, (unsigned long *)addr)
> -#define minix_test_bit(nr,addr) \
> -	test_le_bit(nr, (unsigned long *)addr)
> -
> -#define minix_find_first_zero_bit(addr,size) \
> -	find_first_zero_le_bit((unsigned long *)addr, size)
> -
>   #include<asm-generic/bitops/sched.h>
>
>   #endif /* __KERNEL__ */
> diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
> index 1bd1e11..e537613 100644
> --- a/arch/s390/include/asm/bitops.h
> +++ b/arch/s390/include/asm/bitops.h
> @@ -842,7 +842,6 @@ static inline int find_next_le_bit(void *vaddr, unsigned long size,
>   #define ext2_clear_bit_atomic(lock, nr, addr)     \
>   	test_and_clear_le_bit((nr), (unsigned long *)(addr))
>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif /* __KERNEL__ */
>
> diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
> index fc5cd5b..90fa3e4 100644
> --- a/arch/sh/include/asm/bitops.h
> +++ b/arch/sh/include/asm/bitops.h
> @@ -96,7 +96,6 @@ static inline unsigned long ffz(unsigned long word)
>   #include<asm-generic/bitops/sched.h>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix.h>
>   #include<asm-generic/bitops/fls.h>
>   #include<asm-generic/bitops/__fls.h>
>   #include<asm-generic/bitops/fls64.h>
> diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bitops_32.h
> index 75da6f8..25a6766 100644
> --- a/arch/sparc/include/asm/bitops_32.h
> +++ b/arch/sparc/include/asm/bitops_32.h
> @@ -105,7 +105,6 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
>   #include<asm-generic/bitops/find.h>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif /* __KERNEL__ */
>
> diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
> index 66db28e..38e9aa1 100644
> --- a/arch/sparc/include/asm/bitops_64.h
> +++ b/arch/sparc/include/asm/bitops_64.h
> @@ -96,8 +96,6 @@ static inline unsigned int __arch_hweight8(unsigned int w)
>   #define ext2_clear_bit_atomic(lock,nr,addr) \
>   	test_and_clear_bit((nr) ^ 0x38,(unsigned long *)(addr))
>
> -#include<asm-generic/bitops/minix.h>
> -
>   #endif /* __KERNEL__ */
>
>   #endif /* defined(_SPARC64_BITOPS_H) */
> diff --git a/arch/tile/include/asm/bitops.h b/arch/tile/include/asm/bitops.h
> index 5447add..132e6bb 100644
> --- a/arch/tile/include/asm/bitops.h
> +++ b/arch/tile/include/asm/bitops.h
> @@ -123,6 +123,5 @@ static inline unsigned long __arch_hweight64(__u64 w)
>   #include<asm-generic/bitops/find.h>
>   #include<asm-generic/bitops/sched.h>
>   #include<asm-generic/bitops/le.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif /* _ASM_TILE_BITOPS_H */
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 3c95e07..69d5813 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -463,7 +463,5 @@ static inline int fls(int x)
>   #define ext2_clear_bit_atomic(lock, nr, addr)			\
>   	test_and_clear_bit((nr), (unsigned long *)(addr))
>
> -#include<asm-generic/bitops/minix.h>
> -
>   #endif /* __KERNEL__ */
>   #endif /* _ASM_X86_BITOPS_H */
> diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
> index a56b7b5..c8fac8d 100644
> --- a/arch/xtensa/include/asm/bitops.h
> +++ b/arch/xtensa/include/asm/bitops.h
> @@ -125,7 +125,6 @@ static inline unsigned long __fls(unsigned long word)
>   #include<asm-generic/bitops/hweight.h>
>   #include<asm-generic/bitops/lock.h>
>   #include<asm-generic/bitops/sched.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif	/* __KERNEL__ */
>
> diff --git a/fs/minix/Kconfig b/fs/minix/Kconfig
> index 0fd7ca9..6624684 100644
> --- a/fs/minix/Kconfig
> +++ b/fs/minix/Kconfig
> @@ -15,3 +15,11 @@ config MINIX_FS
>   	  module will be called minix.  Note that the file system of your root
>   	  partition (the one containing the directory /) cannot be compiled as
>   	  a module.
> +
> +config MINIX_FS_NATIVE_ENDIAN
> +	def_bool MINIX_FS
> +	depends on H8300 || M32R || MICROBLAZE || MIPS || S390 || SUPERH || SPARC || XTENSA || (M68K&&  !MMU)
> +
> +config MINIX_FS_BIG_ENDIAN_16BIT_INDEXED
> +	def_bool MINIX_FS
> +	depends on M68K&&  MMU
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index 407b1c8..9dfd62c 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -88,4 +88,83 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
>   	return list_entry(inode, struct minix_inode_info, vfs_inode);
>   }
>
> +#if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN)&&  \
> +	defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
> +
> +#error Minix file system byte order broken
> +
> +#elif defined(CONFIG_MINIX_FS_NATIVE_ENDIAN)
> +
> +/*
> + * big-endian 32 or 64 bit indexed bitmaps on big-endian system or
> + * little-endian bitmaps on little-endian system
> + */
> +
> +#define minix_test_and_set_bit(nr, addr)	\
> +	__test_and_set_bit((nr), (unsigned long *)(addr))
> +#define minix_set_bit(nr, addr)		\
> +	__set_bit((nr), (unsigned long *)(addr))
> +#define minix_test_and_clear_bit(nr, addr) \
> +	__test_and_clear_bit((nr), (unsigned long *)(addr))
> +#define minix_test_bit(nr, addr)		\
> +	test_bit((nr), (unsigned long *)(addr))
> +#define minix_find_first_zero_bit(addr, size) \
> +	find_first_zero_bit((unsigned long *)(addr), (size))
> +
> +#elif defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
> +
> +/*
> + * big-endian 16bit indexed bitmaps
> + */
> +
> +static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
> +{
> +	const unsigned short *p = vaddr, *addr = vaddr;
> +	unsigned short num;
> +
> +	if (!size)
> +		return 0;
> +
> +	size = (size>>  4) + ((size&  15)>  0);
> +	while (*p++ == 0xffff) {
> +		if (--size == 0)
> +			return (p - addr)<<  4;
> +	}
> +
> +	num = *--p;
> +	return ((p - addr)<<  4) + ffz(num);
> +}
> +
> +#define minix_test_and_set_bit(nr, addr)	\
> +	__test_and_set_bit((nr) ^ 16, (unsigned long *)(addr))
> +#define minix_set_bit(nr, addr)	\
> +	__set_bit((nr) ^ 16, (unsigned long *)(addr))
> +#define minix_test_and_clear_bit(nr, addr)	\
> +	__test_and_clear_bit((nr) ^ 16, (unsigned long *)(addr))
> +
> +static inline int minix_test_bit(int nr, const void *vaddr)
> +{
> +	const unsigned short *p = vaddr;
> +	return (p[nr>>  4]&  (1U<<  (nr&  15))) != 0;
> +}
> +
> +#else
> +
> +/*
> + * little-endian bitmaps
> + */
> +
> +#define minix_test_and_set_bit(nr, addr)	\
> +	__test_and_set_le_bit((nr), (unsigned long *)(addr))
> +#define minix_set_bit(nr, addr)		\
> +	__set_le_bit((nr), (unsigned long *)(addr))
> +#define minix_test_and_clear_bit(nr, addr) \
> +	__test_and_clear_le_bit((nr), (unsigned long *)(addr))
> +#define minix_test_bit(nr, addr)		\
> +	test_le_bit((nr), (unsigned long *)(addr))
> +#define minix_find_first_zero_bit(addr, size) \
> +	find_first_zero_le_bit((unsigned long *)(addr), (size))
> +
> +#endif
> +
>   #endif /* FS_MINIX_H */
> diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
> index dd7c014..280ca7a 100644
> --- a/include/asm-generic/bitops.h
> +++ b/include/asm-generic/bitops.h
> @@ -40,6 +40,5 @@
>   #include<asm-generic/bitops/non-atomic.h>
>   #include<asm-generic/bitops/le.h>
>   #include<asm-generic/bitops/ext2-atomic.h>
> -#include<asm-generic/bitops/minix.h>
>
>   #endif /* __ASM_GENERIC_BITOPS_H */
> diff --git a/include/asm-generic/bitops/minix-le.h b/include/asm-generic/bitops/minix-le.h
> deleted file mode 100644
> index f366cfa..0000000
> --- a/include/asm-generic/bitops/minix-le.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#ifndef _ASM_GENERIC_BITOPS_MINIX_LE_H_
> -#define _ASM_GENERIC_BITOPS_MINIX_LE_H_
> -
> -#define minix_test_and_set_bit(nr,addr)	\
> -	__test_and_set_le_bit((nr), (unsigned long *)(addr))
> -#define minix_set_bit(nr,addr)		\
> -	__set_le_bit((nr), (unsigned long *)(addr))
> -#define minix_test_and_clear_bit(nr,addr) \
> -	__test_and_clear_le_bit((nr), (unsigned long *)(addr))
> -#define minix_test_bit(nr,addr)		\
> -	test_le_bit((nr), (unsigned long *)(addr))
> -#define minix_find_first_zero_bit(addr,size) \
> -	find_first_zero_le_bit((unsigned long *)(addr), (size))
> -
> -#endif /* _ASM_GENERIC_BITOPS_MINIX_LE_H_ */
> diff --git a/include/asm-generic/bitops/minix.h b/include/asm-generic/bitops/minix.h
> deleted file mode 100644
> index 91f42e8..0000000
> --- a/include/asm-generic/bitops/minix.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#ifndef _ASM_GENERIC_BITOPS_MINIX_H_
> -#define _ASM_GENERIC_BITOPS_MINIX_H_
> -
> -#define minix_test_and_set_bit(nr,addr)	\
> -	__test_and_set_bit((nr),(unsigned long *)(addr))
> -#define minix_set_bit(nr,addr)		\
> -	__set_bit((nr),(unsigned long *)(addr))
> -#define minix_test_and_clear_bit(nr,addr) \
> -	__test_and_clear_bit((nr),(unsigned long *)(addr))
> -#define minix_test_bit(nr,addr)		\
> -	test_bit((nr),(unsigned long *)(addr))
> -#define minix_find_first_zero_bit(addr,size) \
> -	find_first_zero_bit((unsigned long *)(addr),(size))
> -
> -#endif /* _ASM_GENERIC_BITOPS_MINIX_H_ */


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
