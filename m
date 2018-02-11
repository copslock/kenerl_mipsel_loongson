Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 11:34:04 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.18]:46581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990435AbeBKKd5oMG06 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 11:33:57 +0100
Received: from [79.235.153.113] ([79.235.153.113]) by
 3c-app-gmx-bs58.server.lan (via HTTP); Sun, 11 Feb 2018 11:33:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-5d735b1e-9f56-47cc-8f85-3635dd4efe48-1518345226674@3c-app-gmx-bs58>
From:   =?UTF-8?Q?=22J=C3=BCrgen_Urban=22?= <JuergenUrban@gmx.de>
To:     "Fredrik Noring" <noring@nocrew.org>
Cc:     "Maciej W. Rozycki" <macro@mips.com>, linux-mips@linux-mips.org
Subject: Aw: [RFC] MIPS: R5900: Use mandatory SYNC.L in exception handlers
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Feb 2018 11:33:46 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20180211082913.GF2222@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211082913.GF2222@localhost.localdomain>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:di4SexNf9U3JmcTb0RQKtK3WD9YN/AM9zSi3fxIxuhG
 0QjWnAJpaqXxyMhek5kWvsNCByQI2tL9GtdgW4FhDVjGALqXn9
 GE5l9ZcCJ2nV208m2gIGMwmrep6/0bs8lBCOirpcQRCILzN2Fd
 DMfxD+G7lBLTK4VS9VfefURNxFn7227GaRj+8dW0m3CgH8Qahj
 dGCvJQVRkN1sPAqY7QtsE219mTaGQo5NsURm8CDXSJF+7LDBE0
 qQkVVBPITakLuU4d46XaXiGGVRCWaT5m4xr3D8DOdIkK8YkrwP bI861Y=
X-UI-Out-Filterresults: notjunk:1;V01:K0:VG0c4xVJe8M=:pTwIQfWKe7ZI68YkdTyHxc
 4E/Rb/SLa5lMt9n+EHPVYdytaTxHQARqa+oRuWE+mUeq9yN7/fEADlhmbolKd+O3BFBCAlgLY
 RUArdp1P+hQaofmRNoZaKd0RKkP6n1NCgYgHY/JJ69EzTAt8Jj5hhBMBBUuR5Xxz0/J7DVAbM
 d+JTzUPkqXlNBXGjX/fO0Xduua16CkJnm/SPHGkji87rSyhbZTacU6jzc6huEULhYPsfAicgU
 /u/pJCJNIor+7NwUUXyMTgGYEC7zu1jrCxnQ74hAjELagXfbIXacK5ta/jz7luLeoAbdmYFOQ
 a3xE/3D6p5B3+SuA4mzOPMDF+F0LpglWr++5e5k0n69dTF+kGDdZNUj8MyQ6hc0x2A2JCi2ru
 x00rNCq3VdDyUthu+zvdLS+4CjfsLsrKuYCeuQHLAu7ZEmlQfiPeXOSVaz2e8FbBcOT7z9AB+
 kYlRtcKfykHphDWhdghfFhGl9VsCS9N5/zyrFMGkiBCjBLhwIXGu
Return-Path: <JuergenUrban@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: JuergenUrban@gmx.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello Fredrik,

> Gesendet: Sonntag, 11. Februar 2018 um 09:29 Uhr
> Von: "Fredrik Noring" <noring@nocrew.org>
> An: "Maciej W. Rozycki" <macro@mips.com>, "Jürgen Urban" <JuergenUrban@gmx.de>
> Cc: linux-mips@linux-mips.org
> Betreff: [RFC] MIPS: R5900: Use mandatory SYNC.L in exception handlers
>
> Hi Jürgen,
> 
> Would you be able to explain the notes
> 
> 	/* In an error exception handler the user space could be uncached. */
> 
> in the patch ported from v2.6 below?

The tx79architecture.pdf says:
2.4 kuseg becomes an uncached area when an error exception (Status.ERL = 1) occurs (FLX04)
2.4.1 Phenomenon
There are cases in which kuseg (0x0000_0000 – 0x7FFF_FFFF) becomes uncached in an error exception handler (Status.ERL==1) and data consistency with cached area (kseg, ksseg, kseg0) is lost.
2.4.2 Corrective measures
In an error exception handler (Status.ERL==1), when accessing kuseg (0x0000_0000 – 0x7FFF_FFFF), access it after guarding using SYNC.L as follows:
SYNC.L
SW ku seg

Best regards
Jürgen

> diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
> index b463f2aa5a61..79390b194e6d 100644
> --- a/arch/mips/include/asm/ftrace.h
> +++ b/arch/mips/include/asm/ftrace.h
> @@ -19,9 +19,12 @@
>  extern void _mcount(void);
>  #define mcount _mcount
>  
> +#ifdef CONFIG_CPU_R5900
>  #define safe_load(load, src, dst, error)		\
>  do {							\
>  	asm volatile (					\
> +		/* In an error exception handler the user space could be uncached. */ \
> +		"sync.l							\n"	\
>  		"1: " load " %[tmp_dst], 0(%[tmp_src])\n"	\
>  		"   li %[tmp_err], 0\n"			\
>  		"2: .insn\n"				\
> @@ -40,7 +43,55 @@ do {							\
>  		: "memory"				\
>  	);						\
>  } while (0)
> +#else
> +#define safe_load(load, src, dst, error)		\
> +do {							\
> +	asm volatile (					\
> +		"1: " load " %[" STR(dst) "], 0(%[" STR(src) "])\n"\
> +		"   li %[" STR(error) "], 0\n"		\
> +		"2:\n"					\
> +							\
> +		".section .fixup, \"ax\"\n"		\
> +		"3: li %[" STR(error) "], 1\n"		\
> +		"   j 2b\n"				\
> +		".previous\n"				\
> +							\
> +		".section\t__ex_table,\"a\"\n\t"	\
> +		STR(PTR) "\t1b, 3b\n\t"			\
> +		".previous\n"				\
> +							\
> +		: [dst] "=&r" (dst), [error] "=r" (error)\
> +		: [src] "r" (src)			\
> +		: "memory"				\
> +	);						\
> +} while (0)
> +#endif
>  
> +#ifdef CONFIG_CPU_R5900
> +#define safe_store(store, src, dst, error)	\
> +do {						\
> +	asm volatile (				\
> +		/* In an error exception handler the user space could be uncached. */ \
> +		"sync.l							\n"	\
> +		"1: " store " %[" STR(src) "], 0(%[" STR(dst) "])\n"\
> +		"   li %[" STR(error) "], 0\n"	\
> +		"2:\n"				\
> +						\
> +		".section .fixup, \"ax\"\n"	\
> +		"3: li %[" STR(error) "], 1\n"	\
> +		"   j 2b\n"			\
> +		".previous\n"			\
> +						\
> +		".section\t__ex_table,\"a\"\n\t"\
> +		STR(PTR) "\t1b, 3b\n\t"		\
> +		".previous\n"			\
> +						\
> +		: [error] "=r" (error)		\
> +		: [dst] "r" (dst), [src] "r" (src)\
> +		: "memory"			\
> +	);					\
> +} while (0)
> +#else
>  #define safe_store(store, src, dst, error)	\
>  do {						\
>  	asm volatile (				\
> @@ -62,6 +113,7 @@ do {						\
>  		: "memory"			\
>  	);					\
>  } while (0)
> +#endif
>  
>  #define safe_load_code(dst, src, error) \
>  	safe_load(STR(lw), src, dst, error)
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> index b71306947290..a4eecafc524b 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -315,11 +315,14 @@ do {									\
>  	__gu_err;							\
>  })
>  
> +#ifdef CONFIG_CPU_R5900
>  #define __get_data_asm(val, insn, addr)					\
>  {									\
>  	long __gu_tmp;							\
>  									\
>  	__asm__ __volatile__(						\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	"sync.l							\n"	\
>  	"1:	"insn("%1", "%3")"				\n"	\
>  	"2:							\n"	\
>  	"	.insn						\n"	\
> @@ -336,10 +339,32 @@ do {									\
>  									\
>  	(val) = (__typeof__(*(addr))) __gu_tmp;				\
>  }
> +#else
> +#define __get_data_asm(val, insn, addr)					\
> +{									\
> +	long __gu_tmp;							\
> +									\
> +	__asm__ __volatile__(						\
> +	"1:	"insn("%1", "%3")"				\n"	\
> +	"2:							\n"	\
> +	"	.section .fixup,\"ax\"				\n"	\
> +	"3:	li	%0, %4					\n"	\
> +	"	j	2b					\n"	\
> +	"	.previous					\n"	\
> +	"	.section __ex_table,\"a\"			\n"	\
> +	"	"__UA_ADDR "\t1b, 3b				\n"	\
> +	"	.previous					\n"	\
> +	: "=r" (__gu_err), "=r" (__gu_tmp)				\
> +	: "0" (0), "o" (__m(addr)), "i" (-EFAULT));			\
> +									\
> +	(val) = (__typeof__(*(addr))) __gu_tmp;				\
> +}
> +#endif
>  
>  /*
>   * Get a long long 64 using 32 bit registers.
>   */
> +#ifdef CONFIG_CPU_R5900
>  #define __get_data_asm_ll32(val, insn, addr)				\
>  {									\
>  	union {								\
> @@ -348,7 +373,11 @@ do {									\
>  	} __gu_tmp;							\
>  									\
>  	__asm__ __volatile__(						\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	"sync.l							\n"	\
>  	"1:	" insn("%1", "(%3)")"				\n"	\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	"sync.l							\n"	\
>  	"2:	" insn("%D1", "4(%3)")"				\n"	\
>  	"3:							\n"	\
>  	"	.insn						\n"	\
> @@ -367,6 +396,33 @@ do {									\
>  									\
>  	(val) = __gu_tmp.t;						\
>  }
> +#else
> +#define __get_data_asm_ll32(val, insn, addr)				\
> +{									\
> +	union {								\
> +		unsigned long long	l;				\
> +		__typeof__(*(addr))	t;				\
> +	} __gu_tmp;							\
> +									\
> +	__asm__ __volatile__(						\
> +	"1:	" insn("%1", "(%3)")"				\n"	\
> +	"2:	" insn("%D1", "4(%3)")"				\n"	\
> +	"3:	.section	.fixup,\"ax\"			\n"	\
> +	"4:	li	%0, %4					\n"	\
> +	"	move	%1, $0					\n"	\
> +	"	move	%D1, $0					\n"	\
> +	"	j	3b					\n"	\
> +	"	.previous					\n"	\
> +	"	.section	__ex_table,\"a\"		\n"	\
> +	"	" __UA_ADDR "	1b, 4b				\n"	\
> +	"	" __UA_ADDR "	2b, 4b				\n"	\
> +	"	.previous					\n"	\
> +	: "=r" (__gu_err), "=&r" (__gu_tmp.l)				\
> +	: "0" (0), "r" (addr), "i" (-EFAULT));				\
> +									\
> +	(val) = __gu_tmp.t;						\
> +}
> +#endif
>  
>  #ifndef CONFIG_EVA
>  #define __put_kernel_common(ptr, size) __put_user_common(ptr, size)
> @@ -456,6 +512,38 @@ do {									\
>  	__pu_err;							\
>  })
>  
> +#define __put_user_check_atomic(x, ptr, size)				\
> +({									\
> +	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
> +	__typeof__(*(ptr)) __pu_val = (x);				\
> +	int __pu_err = -EFAULT;						\
> +									\
> +	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size))) {	\
> +		__put_kernel_common(ptr, size);				\
> +	}								\
> +	__pu_err;							\
> +})
> +
> +#ifdef CONFIG_CPU_R5900
> +#define __put_data_asm(insn, ptr)					\
> +{									\
> +	__asm__ __volatile__(						\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	"sync.l							\n"	\
> +	"1:	"insn("%z2", "%3")"	# __put_data_asm	\n"	\
> +	"2:							\n"	\
> +	"	.section	.fixup,\"ax\"			\n"	\
> +	"3:	li	%0, %4					\n"	\
> +	"	j	2b					\n"	\
> +	"	.previous					\n"	\
> +	"	.section	__ex_table,\"a\"		\n"	\
> +	"	" __UA_ADDR "	1b, 3b				\n"	\
> +	"	.previous					\n"	\
> +	: "=r" (__pu_err)						\
> +	: "0" (0), "Jr" (__pu_val), "o" (__m(ptr)),			\
> +	  "i" (-EFAULT));						\
> +}
> +#else
>  #define __put_data_asm(insn, ptr)					\
>  {									\
>  	__asm__ __volatile__(						\
> @@ -473,7 +561,32 @@ do {									\
>  	: "0" (0), "Jr" (__pu_val), "o" (__m(ptr)),			\
>  	  "i" (-EFAULT));						\
>  }
> +#endif
>  
> +#ifdef CONFIG_CPU_R5900
> +#define __put_data_asm_ll32(insn, ptr)					\
> +{									\
> +	__asm__ __volatile__(						\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	"sync.l							\n"	\
> +	"1:	"insn("%2", "(%3)")"	# __put_data_asm_ll32	\n"	\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	"sync.l							\n"	\
> +	"2:	"insn("%D2", "4(%3)")"				\n"	\
> +	"3:							\n"	\
> +	"	.section	.fixup,\"ax\"			\n"	\
> +	"4:	li	%0, %4					\n"	\
> +	"	j	3b					\n"	\
> +	"	.previous					\n"	\
> +	"	.section	__ex_table,\"a\"		\n"	\
> +	"	" __UA_ADDR "	1b, 4b				\n"	\
> +	"	" __UA_ADDR "	2b, 4b				\n"	\
> +	"	.previous"						\
> +	: "=r" (__pu_err)						\
> +	: "0" (0), "r" (__pu_val), "r" (ptr),				\
> +	  "i" (-EFAULT));						\
> +}
> +#else
>  #define __put_data_asm_ll32(insn, ptr)					\
>  {									\
>  	__asm__ __volatile__(						\
> @@ -493,6 +606,7 @@ do {									\
>  	: "0" (0), "r" (__pu_val), "r" (ptr),				\
>  	  "i" (-EFAULT));						\
>  }
> +#endif
>  
>  extern void __put_user_unknown(void);
>  
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index b280a3d775a1..625b74de1ce4 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -488,10 +488,15 @@ do {                                                        \
>  
>  #else /* __BIG_ENDIAN */
>  
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
> +	/* FIXME: Is ".set push\n" etc. needed? */
> +	/* In an error exception handler the user space could be uncached. */
>  #define     _LoadHW(addr, value, res, type)  \
>  do {                                                        \
>  		__asm__ __volatile__ (".set\tnoat\n"        \
> +			"sync.l\n\t"                        \
>  			"1:\t"type##_lb("%0", "1(%2)")"\n"  \
> +			"sync.l\n\t"                        \
>  			"2:\t"type##_lbu("$1", "0(%2)")"\n\t"\
>  			"sll\t%0, 0x8\n\t"                  \
>  			"or\t%0, $1\n\t"                    \
> @@ -511,10 +516,14 @@ do {                                                        \
>  } while(0)
>  
>  #ifndef CONFIG_CPU_MIPSR6
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
> +	/* In an error exception handler the user space could be uncached. */
>  #define     _LoadW(addr, value, res, type)   \
>  do {                                                        \
>  		__asm__ __volatile__ (                      \
> +			"sync.l\n\t"                        \
>  			"1:\t"type##_lwl("%0", "3(%2)")"\n" \
> +			"sync.l\n\t"                        \
>  			"2:\t"type##_lwr("%0", "(%2)")"\n\t"\
>  			"li\t%1, 0\n"                       \
>  			"3:\n\t"                            \
> @@ -569,11 +578,15 @@ do {                                                        \
>  #endif /* CONFIG_CPU_MIPSR6 */
>  
>  
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
> +	/* In an error exception handler the user space could be uncached. */
>  #define     _LoadHWU(addr, value, res, type) \
>  do {                                                        \
>  		__asm__ __volatile__ (                      \
>  			".set\tnoat\n"                      \
> +			"sync.l\n\t"                        \
>  			"1:\t"type##_lbu("%0", "1(%2)")"\n" \
> +			"sync.l\n\t"                        \
>  			"2:\t"type##_lbu("$1", "0(%2)")"\n\t"\
>  			"sll\t%0, 0x8\n\t"                  \
>  			"or\t%0, $1\n\t"                    \
> @@ -594,10 +607,14 @@ do {                                                        \
>  } while(0)
>  
>  #ifndef CONFIG_CPU_MIPSR6
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
> +	/* In an error exception handler the user space could be uncached. */
>  #define     _LoadWU(addr, value, res, type)  \
>  do {                                                        \
>  		__asm__ __volatile__ (                      \
> +			"sync.l\n\t"                        \
>  			"1:\t"type##_lwl("%0", "3(%2)")"\n" \
> +			"sync.l\n\t"                        \
>  			"2:\t"type##_lwr("%0", "(%2)")"\n\t"\
>  			"dsll\t%0, %0, 32\n\t"              \
>  			"dsrl\t%0, %0, 32\n\t"              \
> @@ -616,10 +633,14 @@ do {                                                        \
>  			: "r" (addr), "i" (-EFAULT));       \
>  } while(0)
>  
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
> +	/* In an error exception handler the user space could be uncached. */
>  #define     _LoadDW(addr, value, res)  \
>  do {                                                        \
>  		__asm__ __volatile__ (                      \
> +			"sync.l\n\t"                        \
>  			"1:\tldl\t%0, 7(%2)\n"              \
> +			"sync.l\n\t"                        \
>  			"2:\tldr\t%0, (%2)\n\t"             \
>  			"li\t%1, 0\n"                       \
>  			"3:\n\t"                            \
> @@ -721,11 +742,15 @@ do {                                                        \
>  } while(0)
>  #endif /* CONFIG_CPU_MIPSR6 */
>  
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
> +	/* In an error exception handler the user space could be uncached. */
>  #define     _StoreHW(addr, value, res, type) \
>  do {                                                        \
>  		__asm__ __volatile__ (                      \
>  			".set\tnoat\n"                      \
> +			"sync.l\n\t"                        \
>  			"1:\t"type##_sb("%1", "0(%2)")"\n"  \
> +			"sync.l\n\t"                        \
>  			"srl\t$1,%1, 0x8\n"                 \
>  			"2:\t"type##_sb("$1", "1(%2)")"\n"  \
>  			".set\tat\n\t"                      \
> @@ -745,10 +770,13 @@ do {                                                        \
>  } while(0)
>  
>  #ifndef CONFIG_CPU_MIPSR6
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
>  #define     _StoreW(addr, value, res, type)  \
>  do {                                                        \
>  		__asm__ __volatile__ (                      \
> +			"sync.l\n\t"                        \
>  			"1:\t"type##_swl("%1", "3(%2)")"\n" \
> +			"sync.l\n\t"                        \
>  			"2:\t"type##_swr("%1", "(%2)")"\n\t"\
>  			"li\t%0, 0\n"                       \
>  			"3:\n\t"                            \
> @@ -765,10 +793,14 @@ do {                                                        \
>  		: "r" (value), "r" (addr), "i" (-EFAULT));  \
>  } while(0)
>  
> +	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
> +	/* In an error exception handler the user space could be uncached. */
>  #define     _StoreDW(addr, value, res) \
>  do {                                                        \
>  		__asm__ __volatile__ (                      \
> +			"sync.l\n\t"                        \
>  			"1:\tsdl\t%1, 7(%2)\n"              \
> +			"sync.l\n\t"                        \
>  			"2:\tsdr\t%1, (%2)\n\t"             \
>  			"li\t%0, 0\n"                       \
>  			"3:\n\t"                            \
> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
> index 2ff84f4b1717..36e48682e1e1 100644
> --- a/arch/mips/lib/csum_partial.S
> +++ b/arch/mips/lib/csum_partial.S
> @@ -357,7 +357,10 @@ EXPORT_SYMBOL(csum_partial)
>   * addr    : Address
>   * handler : Exception handler
>   */
> +/* FIXME: #ifdef CONFIG_CPU_R5900 */
>  #define EXC(insn, type, reg, addr, handler)	\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	sync.l;						\
>  	.if \mode == LEGACY_MODE;		\
>  9:		insn reg, addr;			\
>  		.section __ex_table,"a";	\
> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index 489bc9cffcbd..b37731f53f46 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -46,6 +46,11 @@
>  #define ___BUILD_EVA_INSN(insn, reg, addr) __EVAFY(insn, reg, addr)
>  
>  #define EX(insn,reg,addr,handler)			\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	.set push;					\
> +	.set noreorder;					\
> +	sync.l;						\
> +	.set pop;					\
>  	.if \mode == LEGACY_MODE;			\
>  9:		insn	reg, addr;			\
>  	.else;						\
> @@ -171,6 +176,19 @@
>  #ifdef CONFIG_CPU_MICROMIPS
>  	LONG_SRL	t7, t0, 1
>  #endif
> +#ifdef CONFIG_CPU_R5900
> +	/* Each instruction has a leading sync.l */
> +#if LONGSIZE == 4
> +	.set		noat
> +	/* 2 instructions for 4 Byte. */
> +	LONG_SLL	AT, t0, 1
> +	PTR_SUBU	t1, AT
> +	.set		at
> +#else
> +	/* Verify memset for R5900 with 64 bit. 2 instructions for 8 Byte. */
> +	PTR_SUBU	t1, t0
> +#endif
> +#else
>  #if LONGSIZE == 4
>  	PTR_SUBU	t1, FILLPTRG
>  #else
> @@ -179,6 +197,7 @@
>  	PTR_SUBU	t1, AT
>  	.set		at
>  #endif
> +#endif /* CONFIG_CPU_R5900 */
>  	jr		t1
>  	PTR_ADDU	a0, t0			/* dest ptr */
>  
> diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
> index 44cc346fd400..0cf9a6660130 100644
> --- a/arch/mips/lib/strncpy_user.S
> +++ b/arch/mips/lib/strncpy_user.S
> @@ -13,6 +13,8 @@
>  #include <asm/regdef.h>
>  
>  #define EX(insn,reg,addr,handler)			\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	sync.l;							\
>  9:	insn	reg, addr;				\
>  	.section __ex_table,"a";			\
>  	PTR	9b, handler;				\
> diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
> index 474979641a8d..55f7e069a960 100644
> --- a/arch/mips/lib/strnlen_user.S
> +++ b/arch/mips/lib/strnlen_user.S
> @@ -12,6 +12,8 @@
>  #include <asm/regdef.h>
>  
>  #define EX(insn,reg,addr,handler)			\
> +	/* In an error exception handler the user space could be uncached. */ \
> +	sync.l;							\
>  9:	insn	reg, addr;				\
>  	.section __ex_table,"a";			\
>  	PTR	9b, handler;				\
>
