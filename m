Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 10:52:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20771 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993922AbdEXIwUz9olv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 10:52:20 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CC9F87ECD9B2;
        Wed, 24 May 2017 09:52:10 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 24 May
 2017 09:52:13 +0100
Subject: Re: [PATCH 1/7] lib: Add shared copies of some GCC library routines
To:     Palmer Dabbelt <palmer@dabbelt.com>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <liqin.linux@gmail.com>,
        <lennox.wu@gmail.com>, <ysato@users.sourceforge.jp>,
        <dalias@libc.org>, <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170523220546.16758-2-palmer@dabbelt.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <4448bb28-fa2f-3a4c-753e-46bc4c3815a3@imgtec.com>
Date:   Wed, 24 May 2017 09:52:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170523220546.16758-2-palmer@dabbelt.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Palmer


On 23/05/17 23:05, Palmer Dabbelt wrote:
> Many ports (m32r, microblaze, mips, parisc, score, and sparc) use
> functionally identical copies of various GCC library routine files,
> which came up as we were submitting the RISC-V port (which also uses
> some of these).
>
> This patch adds a new copy of these library routine files, which are
> functionally identical to the various other copies.  These are
> availiable via Kconfig as CONFIG_LIB_$ROUTINE, which currently isn't
> used anywhere.

Note that, on MIPS, we had to mark the compiler intrinsics as notrace 
(see commit aedcfbe06558a9f53002e82d5be64c6c94687726) because if the 
compiler requires the intrinsic in the ftrace path, it then tries to 
trace itself leading to infinite recursion and stack overflow. So I'd 
suggest you mark the generic versions notrace as well.

Thanks,
Matt


>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>   include/lib/libgcc.h | 44 ++++++++++++++++++++++++++++++++
>   lib/Kconfig          | 18 +++++++++++++
>   lib/Makefile         |  8 ++++++
>   lib/ashldi3.c        | 45 ++++++++++++++++++++++++++++++++
>   lib/ashrdi3.c        | 46 +++++++++++++++++++++++++++++++++
>   lib/cmpdi2.c         | 42 ++++++++++++++++++++++++++++++
>   lib/lshrdi3.c        | 45 ++++++++++++++++++++++++++++++++
>   lib/muldi3.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   lib/ucmpdi2.c        | 35 +++++++++++++++++++++++++
>   9 files changed, 355 insertions(+)
>   create mode 100644 include/lib/libgcc.h
>   create mode 100644 lib/ashldi3.c
>   create mode 100644 lib/ashrdi3.c
>   create mode 100644 lib/cmpdi2.c
>   create mode 100644 lib/lshrdi3.c
>   create mode 100644 lib/muldi3.c
>   create mode 100644 lib/ucmpdi2.c
>
> diff --git a/include/lib/libgcc.h b/include/lib/libgcc.h
> new file mode 100644
> index 000000000000..a5397e34e005
> --- /dev/null
> +++ b/include/lib/libgcc.h
> @@ -0,0 +1,44 @@
> +/*
> + * include/lib/libgcc.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */
> +
> +
> +#ifndef __LIB_LIBGCC_H
> +#define __LIB_LIBGCC_H
> +
> +#include <asm/byteorder.h>
> +
> +typedef int word_type __attribute__ ((mode (__word__)));
> +
> +#ifdef __BIG_ENDIAN
> +struct DWstruct {
> +	int high, low;
> +};
> +#elif defined(__LITTLE_ENDIAN)
> +struct DWstruct {
> +	int low, high;
> +};
> +#else
> +#error I feel sick.
> +#endif
> +
> +typedef union {
> +	struct DWstruct s;
> +	long long ll;
> +} DWunion;
> +
> +#endif /* __ASM_LIBGCC_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0c8b78a9ae2e..24c08ae53c20 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -565,3 +565,21 @@ config PRIME_NUMBERS
>   	tristate
>   
>   endmenu
> +
> +config LIB_ASHLDI3
> +	def_bool n
> +
> +config LIB_ASHRDI3
> +	def_bool n
> +
> +config LIB_LSHRDI3
> +	def_bool n
> +
> +config LIB_MULDI3
> +	def_bool n
> +
> +config LIB_CMPDI2
> +	def_bool n
> +
> +config LIB_UCMPDI2
> +	def_bool n
> diff --git a/lib/Makefile b/lib/Makefile
> index 0166fbc0fa81..d111c6d9224a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -243,3 +243,11 @@ UBSAN_SANITIZE_ubsan.o := n
>   obj-$(CONFIG_SBITMAP) += sbitmap.o
>   
>   obj-$(CONFIG_PARMAN) += parman.o
> +
> +# GCC library routines
> +obj-$(CONFIG_LIB_ASHLDI3) += ashldi3.o
> +obj-$(CONFIG_LIB_ASHRDI3) += ashrdi3.o
> +obj-$(CONFIG_LIB_LSHRDI3) += lshrdi3.o
> +obj-$(CONFIG_LIB_MULDI3) += multi3.o
> +obj-$(CONFIG_LIB_CMPDI2) += cmpdi2.o
> +obj-$(CONFIG_LIB_UCMPDI2) += ucmpdi2.o
> diff --git a/lib/ashldi3.c b/lib/ashldi3.c
> new file mode 100644
> index 000000000000..5a4c731546b0
> --- /dev/null
> +++ b/lib/ashldi3.c
> @@ -0,0 +1,45 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */
> +
> +
> +#include <linux/export.h>
> +
> +#include <lib/libgcc.h>
> +
> +long long __ashldi3(long long u, word_type b)
> +{
> +	DWunion uu, w;
> +	word_type bm;
> +
> +	if (b == 0)
> +		return u;
> +
> +	uu.ll = u;
> +	bm = 32 - b;
> +
> +	if (bm <= 0) {
> +		w.s.low = 0;
> +		w.s.high = (unsigned int) uu.s.low << -bm;
> +	} else {
> +		const unsigned int carries = (unsigned int) uu.s.low >> bm;
> +
> +		w.s.low = (unsigned int) uu.s.low << b;
> +		w.s.high = ((unsigned int) uu.s.high << b) | carries;
> +	}
> +
> +	return w.ll;
> +}
> +EXPORT_SYMBOL(__ashldi3);
> diff --git a/lib/ashrdi3.c b/lib/ashrdi3.c
> new file mode 100644
> index 000000000000..31b34ca7252c
> --- /dev/null
> +++ b/lib/ashrdi3.c
> @@ -0,0 +1,46 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */
> +
> +#include <linux/export.h>
> +
> +#include <lib/libgcc.h>
> +
> +long long __ashrdi3(long long u, word_type b)
> +{
> +	DWunion uu, w;
> +	word_type bm;
> +
> +	if (b == 0)
> +		return u;
> +
> +	uu.ll = u;
> +	bm = 32 - b;
> +
> +	if (bm <= 0) {
> +		/* w.s.high = 1..1 or 0..0 */
> +		w.s.high =
> +		    uu.s.high >> 31;
> +		w.s.low = uu.s.high >> -bm;
> +	} else {
> +		const unsigned int carries = (unsigned int) uu.s.high << bm;
> +
> +		w.s.high = uu.s.high >> b;
> +		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> +	}
> +
> +	return w.ll;
> +}
> +EXPORT_SYMBOL(__ashrdi3);
> diff --git a/lib/cmpdi2.c b/lib/cmpdi2.c
> new file mode 100644
> index 000000000000..a0d7701d9386
> --- /dev/null
> +++ b/lib/cmpdi2.c
> @@ -0,0 +1,42 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */
> +
> +#include <linux/export.h>
> +
> +#include <lib/libgcc.h>
> +
> +word_type __cmpdi2(long long a, long long b)
> +{
> +	const DWunion au = {
> +		.ll = a
> +	};
> +	const DWunion bu = {
> +		.ll = b
> +	};
> +
> +	if (au.s.high < bu.s.high)
> +		return 0;
> +	else if (au.s.high > bu.s.high)
> +		return 2;
> +
> +	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> +		return 0;
> +	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> +		return 2;
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL(__cmpdi2);
> diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
> new file mode 100644
> index 000000000000..c5a5c23b2e92
> --- /dev/null
> +++ b/lib/lshrdi3.c
> @@ -0,0 +1,45 @@
> +/*
> + * lib/lshrdi3.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <lib/libgcc.h>
> +
> +long long __lshrdi3(long long u, word_type b)
> +{
> +	DWunion uu, w;
> +	word_type bm;
> +
> +	if (b == 0)
> +		return u;
> +
> +	uu.ll = u;
> +	bm = 32 - b;
> +
> +	if (bm <= 0) {
> +		w.s.high = 0;
> +		w.s.low = (unsigned int) uu.s.high >> -bm;
> +	} else {
> +		const unsigned int carries = (unsigned int) uu.s.high << bm;
> +
> +		w.s.high = (unsigned int) uu.s.high >> b;
> +		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> +	}
> +
> +	return w.ll;
> +}
> +EXPORT_SYMBOL(__lshrdi3);
> diff --git a/lib/muldi3.c b/lib/muldi3.c
> new file mode 100644
> index 000000000000..b361dca557af
> --- /dev/null
> +++ b/lib/muldi3.c
> @@ -0,0 +1,72 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */
> +
> +#include <linux/export.h>
> +#include <lib/libgcc.h>
> +
> +#define W_TYPE_SIZE 32
> +
> +#define __ll_B ((unsigned long) 1 << (W_TYPE_SIZE / 2))
> +#define __ll_lowpart(t) ((unsigned long) (t) & (__ll_B - 1))
> +#define __ll_highpart(t) ((unsigned long) (t) >> (W_TYPE_SIZE / 2))
> +
> +/* If we still don't have umul_ppmm, define it using plain C.  */
> +#if !defined(umul_ppmm)
> +#define umul_ppmm(w1, w0, u, v)						\
> +	do {								\
> +		unsigned long __x0, __x1, __x2, __x3;			\
> +		unsigned short __ul, __vl, __uh, __vh;			\
> +									\
> +		__ul = __ll_lowpart(u);					\
> +		__uh = __ll_highpart(u);				\
> +		__vl = __ll_lowpart(v);					\
> +		__vh = __ll_highpart(v);				\
> +									\
> +		__x0 = (unsigned long) __ul * __vl;			\
> +		__x1 = (unsigned long) __ul * __vh;			\
> +		__x2 = (unsigned long) __uh * __vl;			\
> +		__x3 = (unsigned long) __uh * __vh;			\
> +									\
> +		__x1 += __ll_highpart(__x0); /* this can't give carry */\
> +		__x1 += __x2; /* but this indeed can */			\
> +		if (__x1 < __x2) /* did we get it? */			\
> +		__x3 += __ll_B; /* yes, add it in the proper pos */	\
> +									\
> +		(w1) = __x3 + __ll_highpart(__x1);			\
> +		(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);\
> +	} while (0)
> +#endif
> +
> +#if !defined(__umulsidi3)
> +#define __umulsidi3(u, v) ({				\
> +	DWunion __w;					\
> +	umul_ppmm(__w.s.high, __w.s.low, u, v);		\
> +	__w.ll;						\
> +	})
> +#endif
> +
> +long long __muldi3(long long u, long long v)
> +{
> +	const DWunion uu = {.ll = u};
> +	const DWunion vv = {.ll = v};
> +	DWunion w = {.ll = __umulsidi3(uu.s.low, vv.s.low)};
> +
> +	w.s.high += ((unsigned long) uu.s.low * (unsigned long) vv.s.high
> +		+ (unsigned long) uu.s.high * (unsigned long) vv.s.low);
> +
> +	return w.ll;
> +}
> +EXPORT_SYMBOL(__muldi3);
> diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
> new file mode 100644
> index 000000000000..49a53505c8e3
> --- /dev/null
> +++ b/lib/ucmpdi2.c
> @@ -0,0 +1,35 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <lib/libgcc.h>
> +
> +word_type __ucmpdi2(unsigned long long a, unsigned long long b)
> +{
> +	const DWunion au = {.ll = a};
> +	const DWunion bu = {.ll = b};
> +
> +	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
> +		return 0;
> +	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
> +		return 2;
> +	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> +		return 0;
> +	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> +		return 2;
> +	return 1;
> +}
> +EXPORT_SYMBOL(__ucmpdi2);
