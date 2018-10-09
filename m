Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2018 06:11:46 +0200 (CEST)
Received: from frisell.zx2c4.com ([192.95.5.64]:55843 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990697AbeJIELmHMqE0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Oct 2018 06:11:42 +0200
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a74eead4
        for <linux-mips@linux-mips.org>;
        Tue, 9 Oct 2018 04:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=2m2hhbnb1RgjSyYB1aQ/pqucqDo=; b=owH7uW
        8s4FR+CkWqDyJKHOu5RLZVg4f3V1CoO7g/BiwWXjnieLBhTNn4+PoCtLpb1OYqRh
        whm8jjCGHGRKmej6YqKgbDRmnbVthG3fbGx958GxkdeQLxSOsr81dy2zqfhoYieG
        d0gA1LjM6mB9v3G+eKDQODNzqk9Coc2Hwt93fN8FOw5BZopjTyNkyiKj75SOgoBm
        ezpOirl79ZPf3GGCG0yAkMTdQEY6hdavxePEf90KogNSzDgxtBeBY0g3BVS7ain4
        iqYJJ5nXyitPH7msBPq2MIh+YeXAe1Q8iJN4iOYJa6TYp1EF8ZLcyMnA5e323J51
        BHLVEx4UlzMX98sg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 29ec6246 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Tue, 9 Oct 2018 04:10:41 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id o21so200195otb.13
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2018 21:11:32 -0700 (PDT)
X-Gm-Message-State: ABuFfojXpVl14m5Xi1yIe+UODI4cfJJy4gpL/kXCVUc6MvkE/I09AQjO
        jDJOuG8xxMQJ3rQAIgSpgTdBygM1g3BcJpKU4Zo=
X-Google-Smtp-Source: ACcGV60fACJAbmkU/q2HwleCG4/ZNNkBtHOdVVMUs/Z5HCln29/GBfGx4Qj0oUO0muguqMQcUMEgUtZ4qRnp0KoC0AQ=
X-Received: by 2002:a9d:48b9:: with SMTP id d54mr15059115otf.144.1539058291530;
 Mon, 08 Oct 2018 21:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181008211554.5355-1-ard.biesheuvel@linaro.org> <20181008211554.5355-4-ard.biesheuvel@linaro.org>
In-Reply-To: <20181008211554.5355-4-ard.biesheuvel@linaro.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 9 Oct 2018 06:11:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9rDfVbGLpeV9-LDOUo1on2UB7UHd8jBKcWycf9HYkar=g@mail.gmail.com>
Message-ID: <CAHmME9rDfVbGLpeV9-LDOUo1on2UB7UHd8jBKcWycf9HYkar=g@mail.gmail.com>
Subject: Re: [PATCH 3/3] crypto: siphash - drop _aligned variants
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hi Ard,

On Mon, Oct 8, 2018 at 11:16 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On ARM v6 and later, we define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> because the ordinary load/store instructions (ldr, ldrh, ldrb) can
> tolerate any misalignment of the memory address. However, load/store
> double and load/store multiple instructions (ldrd, ldm) may still only
> be used on memory addresses that are 32-bit aligned, and so we have to
> use the CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS macro with care, or we
> may end up with a severe performance hit due to alignment traps that
> require fixups by the kernel.
>
> Fortunately, the get_unaligned() accessors do the right thing: when
> building for ARMv6 or later, the compiler will emit unaligned accesses
> using the ordinary load/store instructions (but avoid the ones that
> require 32-bit alignment). When building for older ARM, those accessors
> will emit the appropriate sequence of ldrb/mov/orr instructions. And on
> architectures that can truly tolerate any kind of misalignment, the
> get_unaligned() accessors resolve to the leXX_to_cpup accessors that
> operate on aligned addresses.
>
> Since the compiler will in fact emit ldrd or ldm instructions when
> building this code for ARM v6 or later, the solution is to use the
> unaligned accessors on the aligned code paths. Given the above, this
> either produces the same code, or better in the ARMv6+ case. However,
> since that removes the only difference between the aligned and unaligned
> variants, we can drop the aligned variant entirely.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  include/linux/siphash.h | 106 +++++++++-----------
>  lib/siphash.c           | 103 ++-----------------
>  2 files changed, 54 insertions(+), 155 deletions(-)
>
> diff --git a/include/linux/siphash.h b/include/linux/siphash.h
> index fa7a6b9cedbf..ef3c36b0ae0f 100644
> --- a/include/linux/siphash.h
> +++ b/include/linux/siphash.h
> @@ -15,16 +15,14 @@
>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> +#include <asm/unaligned.h>
>
>  #define SIPHASH_ALIGNMENT __alignof__(u64)
>  typedef struct {
>         u64 key[2];
>  } siphash_key_t;
>
> -u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key);
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key);
> -#endif
> +u64 __siphash(const void *data, size_t len, const siphash_key_t *key);
>
>  u64 siphash_1u64(const u64 a, const siphash_key_t *key);
>  u64 siphash_2u64(const u64 a, const u64 b, const siphash_key_t *key);
> @@ -48,26 +46,6 @@ static inline u64 siphash_4u32(const u32 a, const u32 b, const u32 c,
>  }
>
>
> -static inline u64 ___siphash_aligned(const __le64 *data, size_t len,
> -                                    const siphash_key_t *key)
> -{
> -       if (__builtin_constant_p(len) && len == 4)
> -               return siphash_1u32(le32_to_cpup((const __le32 *)data), key);
> -       if (__builtin_constant_p(len) && len == 8)
> -               return siphash_1u64(le64_to_cpu(data[0]), key);
> -       if (__builtin_constant_p(len) && len == 16)
> -               return siphash_2u64(le64_to_cpu(data[0]), le64_to_cpu(data[1]),
> -                                   key);
> -       if (__builtin_constant_p(len) && len == 24)
> -               return siphash_3u64(le64_to_cpu(data[0]), le64_to_cpu(data[1]),
> -                                   le64_to_cpu(data[2]), key);
> -       if (__builtin_constant_p(len) && len == 32)
> -               return siphash_4u64(le64_to_cpu(data[0]), le64_to_cpu(data[1]),
> -                                   le64_to_cpu(data[2]), le64_to_cpu(data[3]),
> -                                   key);
> -       return __siphash_aligned(data, len, key);
> -}
> -
>  /**
>   * siphash - compute 64-bit siphash PRF value
>   * @data: buffer to hash
> @@ -77,11 +55,30 @@ static inline u64 ___siphash_aligned(const __le64 *data, size_t len,
>  static inline u64 siphash(const void *data, size_t len,
>                           const siphash_key_t *key)
>  {
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -       if (!IS_ALIGNED((unsigned long)data, SIPHASH_ALIGNMENT))
> -               return __siphash_unaligned(data, len, key);
> -#endif
> -       return ___siphash_aligned(data, len, key);
> +       if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> +               if (__builtin_constant_p(len) && len == 4)
> +                       return siphash_1u32(get_unaligned_le32(data),
> +                                           key);
> +               if (__builtin_constant_p(len) && len == 8)
> +                       return siphash_1u64(get_unaligned_le64(data),
> +                                           key);
> +               if (__builtin_constant_p(len) && len == 16)
> +                       return siphash_2u64(get_unaligned_le64(data),
> +                                           get_unaligned_le64(data + 8),
> +                                           key);
> +               if (__builtin_constant_p(len) && len == 24)
> +                       return siphash_3u64(get_unaligned_le64(data),
> +                                           get_unaligned_le64(data + 8),
> +                                           get_unaligned_le64(data + 16),
> +                                           key);
> +               if (__builtin_constant_p(len) && len == 32)
> +                       return siphash_4u64(get_unaligned_le64(data),
> +                                           get_unaligned_le64(data + 8),
> +                                           get_unaligned_le64(data + 16),
> +                                           get_unaligned_le64(data + 24),
> +                                           key);
> +       }
> +       return __siphash(data, len, key);
>  }
>
>  #define HSIPHASH_ALIGNMENT __alignof__(unsigned long)
> @@ -89,12 +86,7 @@ typedef struct {
>         unsigned long key[2];
>  } hsiphash_key_t;
>
> -u32 __hsiphash_aligned(const void *data, size_t len,
> -                      const hsiphash_key_t *key);
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -u32 __hsiphash_unaligned(const void *data, size_t len,
> -                        const hsiphash_key_t *key);
> -#endif
> +u32 __hsiphash(const void *data, size_t len, const hsiphash_key_t *key);
>
>  u32 hsiphash_1u32(const u32 a, const hsiphash_key_t *key);
>  u32 hsiphash_2u32(const u32 a, const u32 b, const hsiphash_key_t *key);
> @@ -103,24 +95,6 @@ u32 hsiphash_3u32(const u32 a, const u32 b, const u32 c,
>  u32 hsiphash_4u32(const u32 a, const u32 b, const u32 c, const u32 d,
>                   const hsiphash_key_t *key);
>
> -static inline u32 ___hsiphash_aligned(const __le32 *data, size_t len,
> -                                     const hsiphash_key_t *key)
> -{
> -       if (__builtin_constant_p(len) && len == 4)
> -               return hsiphash_1u32(le32_to_cpu(data[0]), key);
> -       if (__builtin_constant_p(len) && len == 8)
> -               return hsiphash_2u32(le32_to_cpu(data[0]), le32_to_cpu(data[1]),
> -                                    key);
> -       if (__builtin_constant_p(len) && len == 12)
> -               return hsiphash_3u32(le32_to_cpu(data[0]), le32_to_cpu(data[1]),
> -                                    le32_to_cpu(data[2]), key);
> -       if (__builtin_constant_p(len) && len == 16)
> -               return hsiphash_4u32(le32_to_cpu(data[0]), le32_to_cpu(data[1]),
> -                                    le32_to_cpu(data[2]), le32_to_cpu(data[3]),
> -                                    key);
> -       return __hsiphash_aligned(data, len, key);
> -}
> -
>  /**
>   * hsiphash - compute 32-bit hsiphash PRF value
>   * @data: buffer to hash
> @@ -130,11 +104,27 @@ static inline u32 ___hsiphash_aligned(const __le32 *data, size_t len,
>  static inline u32 hsiphash(const void *data, size_t len,
>                            const hsiphash_key_t *key)
>  {
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -       if (!IS_ALIGNED((unsigned long)data, HSIPHASH_ALIGNMENT))
> -               return __hsiphash_unaligned(data, len, key);
> -#endif
> -       return ___hsiphash_aligned(data, len, key);
> +       if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> +               if (__builtin_constant_p(len) && len == 4)
> +                       return hsiphash_1u32(get_unaligned_le32(data),
> +                                            key);
> +               if (__builtin_constant_p(len) && len == 8)
> +                       return hsiphash_2u32(get_unaligned_le32(data),
> +                                            get_unaligned_le32(data + 4),
> +                                            key);
> +               if (__builtin_constant_p(len) && len == 12)
> +                       return hsiphash_3u32(get_unaligned_le32(data),
> +                                            get_unaligned_le32(data + 4),
> +                                            get_unaligned_le32(data + 8),
> +                                            key);
> +               if (__builtin_constant_p(len) && len == 16)
> +                       return hsiphash_4u32(get_unaligned_le32(data),
> +                                            get_unaligned_le32(data + 4),
> +                                            get_unaligned_le32(data + 8),
> +                                            get_unaligned_le32(data + 12),
> +                                            key);
> +       }
> +       return __hsiphash(data, len, key);
>  }
>
>  #endif /* _LINUX_SIPHASH_H */
> diff --git a/lib/siphash.c b/lib/siphash.c
> index 3ae58b4edad6..3b2ba1a10ad9 100644
> --- a/lib/siphash.c
> +++ b/lib/siphash.c
> @@ -49,40 +49,7 @@
>         SIPROUND; \
>         return (v0 ^ v1) ^ (v2 ^ v3);
>
> -u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
> -{
> -       const u8 *end = data + len - (len % sizeof(u64));
> -       const u8 left = len & (sizeof(u64) - 1);
> -       u64 m;
> -       PREAMBLE(len)
> -       for (; data != end; data += sizeof(u64)) {
> -               m = le64_to_cpup(data);
> -               v3 ^= m;
> -               SIPROUND;
> -               SIPROUND;
> -               v0 ^= m;
> -       }
> -#if defined(CONFIG_DCACHE_WORD_ACCESS) && BITS_PER_LONG == 64
> -       if (left)
> -               b |= le64_to_cpu((__force __le64)(load_unaligned_zeropad(data) &
> -                                                 bytemask_from_count(left)));
> -#else
> -       switch (left) {
> -       case 7: b |= ((u64)end[6]) << 48;
> -       case 6: b |= ((u64)end[5]) << 40;
> -       case 5: b |= ((u64)end[4]) << 32;
> -       case 4: b |= le32_to_cpup(data); break;
> -       case 3: b |= ((u64)end[2]) << 16;
> -       case 2: b |= le16_to_cpup(data); break;
> -       case 1: b |= end[0];
> -       }
> -#endif
> -       POSTAMBLE
> -}
> -EXPORT_SYMBOL(__siphash_aligned);
> -
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
> +u64 __siphash(const void *data, size_t len, const siphash_key_t *key)
>  {
>         const u8 *end = data + len - (len % sizeof(u64));
>         const u8 left = len & (sizeof(u64) - 1);
> @@ -112,8 +79,7 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
>  #endif
>         POSTAMBLE
>  }
> -EXPORT_SYMBOL(__siphash_unaligned);
> -#endif
> +EXPORT_SYMBOL(__siphash);
>
>  /**
>   * siphash_1u64 - compute 64-bit siphash PRF value of a u64
> @@ -250,39 +216,7 @@ EXPORT_SYMBOL(siphash_3u32);
>         HSIPROUND; \
>         return (v0 ^ v1) ^ (v2 ^ v3);
>
> -u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
> -{
> -       const u8 *end = data + len - (len % sizeof(u64));
> -       const u8 left = len & (sizeof(u64) - 1);
> -       u64 m;
> -       HPREAMBLE(len)
> -       for (; data != end; data += sizeof(u64)) {
> -               m = le64_to_cpup(data);
> -               v3 ^= m;
> -               HSIPROUND;
> -               v0 ^= m;
> -       }
> -#if defined(CONFIG_DCACHE_WORD_ACCESS) && BITS_PER_LONG == 64
> -       if (left)
> -               b |= le64_to_cpu((__force __le64)(load_unaligned_zeropad(data) &
> -                                                 bytemask_from_count(left)));
> -#else
> -       switch (left) {
> -       case 7: b |= ((u64)end[6]) << 48;
> -       case 6: b |= ((u64)end[5]) << 40;
> -       case 5: b |= ((u64)end[4]) << 32;
> -       case 4: b |= le32_to_cpup(data); break;
> -       case 3: b |= ((u64)end[2]) << 16;
> -       case 2: b |= le16_to_cpup(data); break;
> -       case 1: b |= end[0];
> -       }
> -#endif
> -       HPOSTAMBLE
> -}
> -EXPORT_SYMBOL(__hsiphash_aligned);
> -
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -u32 __hsiphash_unaligned(const void *data, size_t len,
> +u32 __hsiphash(const void *data, size_t len,
>                          const hsiphash_key_t *key)
>  {
>         const u8 *end = data + len - (len % sizeof(u64));
> @@ -312,8 +246,7 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
>  #endif
>         HPOSTAMBLE
>  }
> -EXPORT_SYMBOL(__hsiphash_unaligned);
> -#endif
> +EXPORT_SYMBOL(__hsiphash);
>
>  /**
>   * hsiphash_1u32 - compute 64-bit hsiphash PRF value of a u32
> @@ -418,30 +351,7 @@ EXPORT_SYMBOL(hsiphash_4u32);
>         HSIPROUND; \
>         return v1 ^ v3;
>
> -u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
> -{
> -       const u8 *end = data + len - (len % sizeof(u32));
> -       const u8 left = len & (sizeof(u32) - 1);
> -       u32 m;
> -       HPREAMBLE(len)
> -       for (; data != end; data += sizeof(u32)) {
> -               m = le32_to_cpup(data);
> -               v3 ^= m;
> -               HSIPROUND;
> -               v0 ^= m;
> -       }
> -       switch (left) {
> -       case 3: b |= ((u32)end[2]) << 16;
> -       case 2: b |= le16_to_cpup(data); break;
> -       case 1: b |= end[0];
> -       }
> -       HPOSTAMBLE
> -}
> -EXPORT_SYMBOL(__hsiphash_aligned);
> -
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -u32 __hsiphash_unaligned(const void *data, size_t len,
> -                        const hsiphash_key_t *key)
> +u32 __hsiphash(const void *data, size_t len, const hsiphash_key_t *key)
>  {
>         const u8 *end = data + len - (len % sizeof(u32));
>         const u8 left = len & (sizeof(u32) - 1);
> @@ -460,8 +370,7 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
>         }
>         HPOSTAMBLE
>  }
> -EXPORT_SYMBOL(__hsiphash_unaligned);
> -#endif
> +EXPORT_SYMBOL(__hsiphash);
>
>  /**
>   * hsiphash_1u32 - compute 32-bit hsiphash PRF value of a u32
> --
> 2.11.0
>

As you might expect, when compiling in __siphash_unaligned and
__siphash_aligned on the x86 at the same time, __siphash_unaligned is
replaced with just "jmp __siphash_aligned", as gcc recognized that
indeed the same code is generated.

However, on platforms where get_unaligned_* does do something
different, it looks to me like this patch now always calls the
unaligned code, even when the input data _is_ an aligned address
already, which is worse behaviour than before. While it would be
possible for the get_unaligned_* function headers to also detect this
and fallback to the faster version at compile time, by the time
get_unaligned_* is used in this patch, it's no longer in the header,
but rather in siphash.c, which means the compiler no longer knows that
the address is aligned, and so we hit the slow path. This especially
impacts architectures like MIPS, for example. This is why the original
code, prior to this patch, checks the alignment in the .h and then
selects which codepath afterwards. So while this patch might handle
the ARM use case, it seems like a regression on all other platforms.
See, for example, the struct passing in net/core/secure_seq.c, which
sends intentionally aligned and packed structs to siphash, which then
benefits from using the faster instructions on certain platforms.

It seems like what you're grappling with on the ARM side of things is
that CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS only half means what it
says on some ISAs, complicating this logic. It seems like the ideal
thing to do, given that, would be to just not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on those, so that we can fall
back to the unaligned path always, like this patch suggests. Or if
that's _too_ drastic, perhaps introduce another variable like
CONFIG_MOSTLY_EFFICIENT_UNALIGNED_ACCESS.

By the way, have you confirmed that the compiler actually does emit
ldrd and ldm here?

Jason
