Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 17:56:54 +0100 (CET)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:63488 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727Ab3LXCsFeoStY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Dec 2013 03:48:05 +0100
Received: by mail-bk0-f51.google.com with SMTP id 6so2204890bkj.38
        for <multiple recipients>; Mon, 23 Dec 2013 18:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AXgIaaWfnAECBamFU6FYVkiulkrvZIN0SAXkpr+ARWk=;
        b=arS3nBQX2wVn+anVOKPFKCJ0+LfXlgsuhHGCTufu/xaM8ZrIuSICEhPSnvwJQkWYA2
         aitaxFrz8ubsvF/u2zLD23lVWNp0nfEuQLHmPRK0Tox43MagfgIyyI5vA6JJNK7Z89Yj
         +Bv0An4DcSX9l/EjQj4lFMWcIzUZ9aHEnlyv9otsmLINblQUbZlm83TIw2KVsF4DsQNW
         EQ/tMJR5sVVHY84C/DINdH6Bkw5Hh80ipaacPCbMCPSCKZe++rrEoQVSnjahmyOWhVzb
         JLZBNDvxuddnXGExT2W72oB4irG2a3UtE0JAI203uUoJrGVTK9rhbscRtKzvcA6G7eq3
         9u6g==
MIME-Version: 1.0
X-Received: by 10.204.172.145 with SMTP id l17mr12734229bkz.26.1387853279804;
 Mon, 23 Dec 2013 18:47:59 -0800 (PST)
Received: by 10.205.32.129 with HTTP; Mon, 23 Dec 2013 18:47:59 -0800 (PST)
In-Reply-To: <1385755623-25219-2-git-send-email-aaro.koskinen@iki.fi>
References: <1385755623-25219-1-git-send-email-aaro.koskinen@iki.fi>
        <1385755623-25219-2-git-send-email-aaro.koskinen@iki.fi>
Date:   Tue, 24 Dec 2013 10:47:59 +0800
Message-ID: <CAAhV-H6So-HaR4FWbGDTJeERPf_2-Fz483J_EK0=g4MknbxABQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: fix blast_icache32 on loongson2
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=bcaec52c5f5bbe640704ee3ec504
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38800
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

--bcaec52c5f5bbe640704ee3ec504
Content-Type: text/plain; charset=ISO-8859-1

Yes, this patch and the previous one can solve the Loongson-2's problem.


On Sat, Nov 30, 2013 at 4:07 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Commit 14bd8c082016cd1f67fdfd702e4cf6367869a712 (MIPS: Loongson: Get
> rid of Loongson 2 #ifdefery all over arch/mips.) failed to add Loongson2
> specific blast_icache32 functions. Fix that.
>
> The patch fixes the following crash seen with 3.13-rc1:
>
> [    3.652000] Reserved instruction in kernel code[#1]:
> [...]
> [    3.652000] Call Trace:
> [    3.652000] [<ffffffff802223c8>] blast_icache32_page+0x8/0xb0
> [    3.652000] [<ffffffff80222c34>] r4k_flush_cache_page+0x19c/0x200
> [    3.652000] [<ffffffff802d17e4>] do_wp_page.isra.97+0x47c/0xe08
> [    3.652000] [<ffffffff802d51b0>] handle_mm_fault+0x938/0x1118
> [    3.652000] [<ffffffff8021bd40>] __do_page_fault+0x140/0x540
> [    3.652000] [<ffffffff80206be4>] resume_userspace_check+0x0/0x10
> [    3.652000]
> [    3.652000] Code: 00200825  64834000  00200825 <bc900000> bc900020
>  bc900040  bc900060  bc900080  bc9000a0
> [    3.656000] ---[ end trace cd8a48f722f5c5f7 ]---
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/include/asm/r4kcache.h | 43
> ++++++++++++++++++++--------------------
>  arch/mips/mm/c-r4k.c             |  7 +++++++
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/arch/mips/include/asm/r4kcache.h
> b/arch/mips/include/asm/r4kcache.h
> index 91d20b0..c84cadd 100644
> --- a/arch/mips/include/asm/r4kcache.h
> +++ b/arch/mips/include/asm/r4kcache.h
> @@ -357,8 +357,8 @@ static inline void invalidate_tcache_page(unsigned
> long addr)
>                   "i" (op));
>
>  /* build blast_xxx, blast_xxx_page, blast_xxx_page_indexed */
> -#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize) \
> -static inline void blast_##pfx##cache##lsize(void)                     \
> +#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize, extra)   \
> +static inline void extra##blast_##pfx##cache##lsize(void)              \
>  {                                                                      \
>         unsigned long start = INDEX_BASE;                               \
>         unsigned long end = start + current_cpu_data.desc.waysize;      \
> @@ -376,7 +376,7 @@ static inline void blast_##pfx##cache##lsize(void)
>              \
>         __##pfx##flush_epilogue                                         \
>  }                                                                      \
>                                                                         \
> -static inline void blast_##pfx##cache##lsize##_page(unsigned long page) \
> +static inline void extra##blast_##pfx##cache##lsize##_page(unsigned long
> page) \
>  {                                                                      \
>         unsigned long start = page;                                     \
>         unsigned long end = page + PAGE_SIZE;                           \
> @@ -391,7 +391,7 @@ static inline void
> blast_##pfx##cache##lsize##_page(unsigned long page) \
>         __##pfx##flush_epilogue                                         \
>  }                                                                      \
>                                                                         \
> -static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long
> page) \
> +static inline void
> extra##blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
>  {                                                                      \
>         unsigned long indexmask = current_cpu_data.desc.waysize - 1;    \
>         unsigned long start = INDEX_BASE + (page & indexmask);          \
> @@ -410,23 +410,24 @@ static inline void
> blast_##pfx##cache##lsize##_page_indexed(unsigned long page)
>         __##pfx##flush_epilogue                                         \
>  }
>
> -__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D,
> Hit_Writeback_Inv_D, 16)
> -__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 16)
> -__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D,
> Hit_Writeback_Inv_D, 32)
> -__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 32)
> -__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D,
> Hit_Writeback_Inv_D, 64)
> -__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 64)
> -__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 128)
> -
> -__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D,
> Hit_Invalidate_D, 16)
> -__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D,
> Hit_Invalidate_D, 32)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 16)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 32)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 64)
> -__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 128)
> +__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D,
> Hit_Writeback_Inv_D, 16, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16, )
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 16, )
> +__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D,
> Hit_Writeback_Inv_D, 32, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I,
> Hit_Invalidate_I_Loongson2, 32, loongson2_)
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 32, )
> +__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D,
> Hit_Writeback_Inv_D, 64, )
> +__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64, )
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 64, )
> +__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD,
> Hit_Writeback_Inv_SD, 128, )
> +
> +__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D,
> Hit_Invalidate_D, 16, )
> +__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D,
> Hit_Invalidate_D, 32, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 16, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 32, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 64, )
> +__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD,
> Hit_Invalidate_SD, 128, )
>
>  /* build blast_xxx_range, protected_blast_xxx_range */
>  #define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot, extra)       \
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 73f02da..49e572d 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -237,6 +237,8 @@ static void r4k_blast_icache_page_setup(void)
>                 r4k_blast_icache_page = (void *)cache_noop;
>         else if (ic_lsize == 16)
>                 r4k_blast_icache_page = blast_icache16_page;
> +       else if (ic_lsize == 32 && current_cpu_type() == CPU_LOONGSON2)
> +               r4k_blast_icache_page = loongson2_blast_icache32_page;
>         else if (ic_lsize == 32)
>                 r4k_blast_icache_page = blast_icache32_page;
>         else if (ic_lsize == 64)
> @@ -261,6 +263,9 @@ static void r4k_blast_icache_page_indexed_setup(void)
>                 else if (TX49XX_ICACHE_INDEX_INV_WAR)
>                         r4k_blast_icache_page_indexed =
>                                 tx49_blast_icache32_page_indexed;
> +               else if (current_cpu_type() == CPU_LOONGSON2)
> +                       r4k_blast_icache_page_indexed =
> +                               loongson2_blast_icache32_page_indexed;
>                 else
>                         r4k_blast_icache_page_indexed =
>                                 blast_icache32_page_indexed;
> @@ -284,6 +289,8 @@ static void r4k_blast_icache_setup(void)
>                         r4k_blast_icache = blast_r4600_v1_icache32;
>                 else if (TX49XX_ICACHE_INDEX_INV_WAR)
>                         r4k_blast_icache = tx49_blast_icache32;
> +               else if (current_cpu_type() == CPU_LOONGSON2)
> +                       r4k_blast_icache = loongson2_blast_icache32;
>                 else
>                         r4k_blast_icache = blast_icache32;
>         } else if (ic_lsize == 64)
> --
> 1.8.4.4
>
>

--bcaec52c5f5bbe640704ee3ec504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, this patch and the previous one can solve the Loongso=
n-2&#39;s problem.<br></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Sat, Nov 30, 2013 at 4:07 AM, Aaro Koskinen <span dir=
=3D"ltr">&lt;<a href=3D"mailto:aaro.koskinen@iki.fi" target=3D"_blank">aaro=
.koskinen@iki.fi</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Commit 14bd8c082016cd1f67fdfd702e4cf6367869a=
712 (MIPS: Loongson: Get<br>
rid of Loongson 2 #ifdefery all over arch/mips.) failed to add Loongson2<br=
>
specific blast_icache32 functions. Fix that.<br>
<br>
The patch fixes the following crash seen with 3.13-rc1:<br>
<br>
[ =A0 =A03.652000] Reserved instruction in kernel code[#1]:<br>
[...]<br>
[ =A0 =A03.652000] Call Trace:<br>
[ =A0 =A03.652000] [&lt;ffffffff802223c8&gt;] blast_icache32_page+0x8/0xb0<=
br>
[ =A0 =A03.652000] [&lt;ffffffff80222c34&gt;] r4k_flush_cache_page+0x19c/0x=
200<br>
[ =A0 =A03.652000] [&lt;ffffffff802d17e4&gt;] do_wp_page.isra.97+0x47c/0xe0=
8<br>
[ =A0 =A03.652000] [&lt;ffffffff802d51b0&gt;] handle_mm_fault+0x938/0x1118<=
br>
[ =A0 =A03.652000] [&lt;ffffffff8021bd40&gt;] __do_page_fault+0x140/0x540<b=
r>
[ =A0 =A03.652000] [&lt;ffffffff80206be4&gt;] resume_userspace_check+0x0/0x=
10<br>
[ =A0 =A03.652000]<br>
[ =A0 =A03.652000] Code: 00200825 =A064834000 =A000200825 &lt;bc900000&gt; =
bc900020 =A0bc900040 =A0bc900060 =A0bc900080 =A0bc9000a0<br>
[ =A0 =A03.656000] ---[ end trace cd8a48f722f5c5f7 ]---<br>
<br>
Signed-off-by: Aaro Koskinen &lt;<a href=3D"mailto:aaro.koskinen@iki.fi">aa=
ro.koskinen@iki.fi</a>&gt;<br>
---<br>
=A0arch/mips/include/asm/r4kcache.h | 43 ++++++++++++++++++++--------------=
------<br>
=A0arch/mips/mm/c-r4k.c =A0 =A0 =A0 =A0 =A0 =A0 | =A07 +++++++<br>
=A02 files changed, 29 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kca=
che.h<br>
index 91d20b0..c84cadd 100644<br>
--- a/arch/mips/include/asm/r4kcache.h<br>
+++ b/arch/mips/include/asm/r4kcache.h<br>
@@ -357,8 +357,8 @@ static inline void invalidate_tcache_page(unsigned long=
 addr)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;i&quot; (op));<br>
<br>
=A0/* build blast_xxx, blast_xxx_page, blast_xxx_page_indexed */<br>
-#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize) \<br>
-static inline void blast_##pfx##cache##lsize(void) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 \<br>
+#define __BUILD_BLAST_CACHE(pfx, desc, indexop, hitop, lsize, extra) =A0 \=
<br>
+static inline void extra##blast_##pfx##cache##lsize(void) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0\<br>
=A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br=
>
=A0 =A0 =A0 =A0 unsigned long start =3D INDEX_BASE; =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
=A0 =A0 =A0 =A0 unsigned long end =3D start + current_cpu_data.desc.waysize=
; =A0 =A0 =A0\<br>
@@ -376,7 +376,7 @@ static inline void blast_##pfx##cache##lsize(void) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
=A0 =A0 =A0 =A0 __##pfx##flush_epilogue =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
=A0} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br=
>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
-static inline void blast_##pfx##cache##lsize##_page(unsigned long page) \<=
br>
+static inline void extra##blast_##pfx##cache##lsize##_page(unsigned long p=
age) \<br>
=A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br=
>
=A0 =A0 =A0 =A0 unsigned long start =3D page; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
=A0 =A0 =A0 =A0 unsigned long end =3D page + PAGE_SIZE; =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
@@ -391,7 +391,7 @@ static inline void blast_##pfx##cache##lsize##_page(uns=
igned long page) \<br>
=A0 =A0 =A0 =A0 __##pfx##flush_epilogue =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
=A0} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br=
>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
-static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long =
page) \<br>
+static inline void extra##blast_##pfx##cache##lsize##_page_indexed(unsigne=
d long page) \<br>
=A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br=
>
=A0 =A0 =A0 =A0 unsigned long indexmask =3D current_cpu_data.desc.waysize -=
 1; =A0 =A0\<br>
=A0 =A0 =A0 =A0 unsigned long start =3D INDEX_BASE + (page &amp; indexmask)=
; =A0 =A0 =A0 =A0 =A0\<br>
@@ -410,23 +410,24 @@ static inline void blast_##pfx##cache##lsize##_page_i=
ndexed(unsigned long page)<br>
=A0 =A0 =A0 =A0 __##pfx##flush_epilogue =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
=A0}<br>
<br>
-__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,=
 16)<br>
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16)<b=
r>
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 16)<br>
-__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,=
 32)<br>
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32)<b=
r>
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 32)<br>
-__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,=
 64)<br>
-__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64)<b=
r>
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 64)<br>
-__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 128)<br>
-<br>
-__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D=
, 16)<br>
-__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D=
, 32)<br>
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 16)<br>
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 32)<br>
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 64)<br>
-__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 128)<br>
+__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,=
 16, )<br>
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 16, )=
<br>
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 16, )<br>
+__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,=
 32, )<br>
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32, )=
<br>
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I_Loongs=
on2, 32, loongson2_)<br>
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 32, )<br>
+__BUILD_BLAST_CACHE(d, dcache, Index_Writeback_Inv_D, Hit_Writeback_Inv_D,=
 64, )<br>
+__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 64, )=
<br>
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 64, )<br>
+__BUILD_BLAST_CACHE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_S=
D, 128, )<br>
+<br>
+__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D=
, 16, )<br>
+__BUILD_BLAST_CACHE(inv_d, dcache, Index_Writeback_Inv_D, Hit_Invalidate_D=
, 32, )<br>
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 16, )<br>
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 32, )<br>
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 64, )<br>
+__BUILD_BLAST_CACHE(inv_s, scache, Index_Writeback_Inv_SD, Hit_Invalidate_=
SD, 128, )<br>
<br>
=A0/* build blast_xxx_range, protected_blast_xxx_range */<br>
=A0#define __BUILD_BLAST_CACHE_RANGE(pfx, desc, hitop, prot, extra) =A0 =A0=
 =A0 \<br>
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c<br>
index 73f02da..49e572d 100644<br>
--- a/arch/mips/mm/c-r4k.c<br>
+++ b/arch/mips/mm/c-r4k.c<br>
@@ -237,6 +237,8 @@ static void r4k_blast_icache_page_setup(void)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache_page =3D (void *)cache_noo=
p;<br>
=A0 =A0 =A0 =A0 else if (ic_lsize =3D=3D 16)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache_page =3D blast_icache16_pa=
ge;<br>
+ =A0 =A0 =A0 else if (ic_lsize =3D=3D 32 &amp;&amp; current_cpu_type() =3D=
=3D CPU_LOONGSON2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache_page =3D loongson2_blast_ica=
che32_page;<br>
=A0 =A0 =A0 =A0 else if (ic_lsize =3D=3D 32)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache_page =3D blast_icache32_pa=
ge;<br>
=A0 =A0 =A0 =A0 else if (ic_lsize =3D=3D 64)<br>
@@ -261,6 +263,9 @@ static void r4k_blast_icache_page_indexed_setup(void)<b=
r>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (TX49XX_ICACHE_INDEX_INV_WAR)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache_page_index=
ed =3D<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx49_blast_=
icache32_page_indexed;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (current_cpu_type() =3D=3D CPU_LOONGS=
ON2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache_page_indexed=
 =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 loongson2_bla=
st_icache32_page_indexed;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache_page_index=
ed =3D<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blast_icach=
e32_page_indexed;<br>
@@ -284,6 +289,8 @@ static void r4k_blast_icache_setup(void)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache =3D blast_=
r4600_v1_icache32;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (TX49XX_ICACHE_INDEX_INV_WAR)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache =3D tx49_b=
last_icache32;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (current_cpu_type() =3D=3D CPU_LOONGS=
ON2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache =3D loongson=
2_blast_icache32;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r4k_blast_icache =3D blast_=
icache32;<br>
=A0 =A0 =A0 =A0 } else if (ic_lsize =3D=3D 64)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.4.4<br>
<br>
</font></span></blockquote></div><br></div>

--bcaec52c5f5bbe640704ee3ec504--
