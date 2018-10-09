Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2018 08:11:16 +0200 (CEST)
Received: from mail-ot1-x343.google.com ([IPv6:2607:f8b0:4864:20::343]:36283
        "EHLO mail-ot1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991063AbeJIGLNRkhfw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Oct 2018 08:11:13 +0200
Received: by mail-ot1-x343.google.com with SMTP id k5so441973ote.3
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2018 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=k81Q47zZbuWrkQ6Ct1x5qo+tt0ZSBhaDMK1mvTzU3HQ=;
        b=GyJrIT/5DGlq7oo1bW1Zzyj+ABTtaAv3vCcmNN4SqZUlTsFJDfANP2LlNOdexP9sWF
         8TLTrBLm5xKDjL1aCRGdcEigHT9KNrZRIFLK9rHRAr4HDaHe/rVBMIg2Reo0qT2+Nzmu
         7DpGyD9vkjls4bksI47LPZ+2ipXv64LNUIqucaEgKp9AC3zEOqoMiXD61VFpYHsLBnbw
         Ux+K1nCXbvVZYJTBdXcLSeq/JzaRRGdN9cI6om2qlAF3/0oOP3UIBnWzUciVruAjTRRt
         gR46BF6Z0PREoaNHGSZ06cCD65inxMOjZUyJtFEiCycqf98JyGhEEPhiUSmrbvYJf7d1
         NJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=k81Q47zZbuWrkQ6Ct1x5qo+tt0ZSBhaDMK1mvTzU3HQ=;
        b=Zh9LYrVlt+FC4qIfP4Yc4b0ny7OWjyBEVW9b/uXvZvd1Itx9fTwo3BVyUO/LUa6vB5
         30+iu8fqehcfR0XcAatyG5ps7BchIadHkaDCr7VT6XXIm4XVWSX2TI4zz/GLFzQr+a2j
         stIxNPnixXqdtRMut8LRjk4fqiF2fhxgfSIG1VPN/2Oezvicq0OQhOavdDz3F7mPWFHZ
         vdfMWgsUWzM71hFDSt5Rjwzobh535eLBQGm+9vAQKJlwZdyVayZbh2iSDYUJAZ/wcgIv
         SYR2ptKX2Ux5DKTcUrBpizcMi6oXyX7HQM3UG002vbYFTnK/QzORX9Cm3pYVh681wbUH
         A47Q==
X-Gm-Message-State: ABuFfohumgU+bH5lM3DHDKE8UGKm4L/KzN6gLUbL5KXr5kkvNTEHKgea
        84xKiBUUzifoyAIC/Z70mSIuen5b8vJLKFLVSLk=
X-Google-Smtp-Source: ACcGV63O93I4bzIBitLgh7ylMhtshDZwQVZuGHtQmH/B7j6pTNt73BCkKDv/vbwHTO4us8o4nLkAMlVT/xuUgWa+MFE=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12mr16617023otf.90.1539065466876;
 Mon, 08 Oct 2018 23:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181008211554.5355-1-ard.biesheuvel@linaro.org>
 <20181008211554.5355-4-ard.biesheuvel@linaro.org> <CAHmME9rDfVbGLpeV9-LDOUo1on2UB7UHd8jBKcWycf9HYkar=g@mail.gmail.com>
 <CAKv+Gu96PKVnymyJyR-9-3HGTryNT=c2kYfXwmHX-QS6DzWf5Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu96PKVnymyJyR-9-3HGTryNT=c2kYfXwmHX-QS6DzWf5Q@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 9 Oct 2018 02:10:37 -0400
Message-ID: <CAH8yC8kqsDAYyTyn3W6oThH5qRX3Qw=2SYr_eA=L03JN0NSBSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] crypto: siphash - drop _aligned variants
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <noloader@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noloader@gmail.com
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

On Tue, Oct 9, 2018 at 2:00 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 9 October 2018 at 06:11, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Hi Ard,
> > ...
> > As you might expect, when compiling in __siphash_unaligned and
> > __siphash_aligned on the x86 at the same time, __siphash_unaligned is
> > replaced with just "jmp __siphash_aligned", as gcc recognized that
> > indeed the same code is generated.
> >
> Yeah, I noticed something similar on arm64, although we do get a stack
> frame there.
>
> > However, on platforms where get_unaligned_* does do something
> > different, it looks to me like this patch now always calls the
> > unaligned code, even when the input data _is_ an aligned address
> > already, which is worse behaviour than before. While it would be
> > possible for the get_unaligned_* function headers to also detect this
> > and fallback to the faster version at compile time, by the time
> > get_unaligned_* is used in this patch, it's no longer in the header,
> > but rather in siphash.c, which means the compiler no longer knows that
> > the address is aligned, and so we hit the slow path. This especially
> > impacts architectures like MIPS, for example. This is why the original
> > code, prior to this patch, checks the alignment in the .h and then
> > selects which codepath afterwards. So while this patch might handle
> > the ARM use case, it seems like a regression on all other platforms.
> > See, for example, the struct passing in net/core/secure_seq.c, which
> > sends intentionally aligned and packed structs to siphash, which then
> > benefits from using the faster instructions on certain platforms.
> >
> > It seems like what you're grappling with on the ARM side of things is
> > that CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS only half means what it
> > says on some ISAs, complicating this logic. It seems like the ideal
> > thing to do, given that, would be to just not set
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on those, so that we can fall
> > back to the unaligned path always, like this patch suggests. Or if
> > that's _too_ drastic, perhaps introduce another variable like
> > CONFIG_MOSTLY_EFFICIENT_UNALIGNED_ACCESS.
> >
> Perhaps we should clarify better what
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS means.
>
> One could argue that it means there is no point in reorganizing your
> data to make it appear aligned, because the unaligned accessors are
> cheap. Instead, it is used as a license to cast unaligned pointers to
> any type (which C does not permit btw), even in the example.

I recommend avoiding this strategy. One of the libraries I help with
used a similar strategy and was constantly putting out 1-off fires
when GCC assumed, say, 4- or 8-byte alignments. Integer stuff was
fine. The problems did not surface until vectorization at -O3 when the
misaligned buffers started causing exceptions.

To be clear, there were very few problems. It might surface with GCC
4.9 on ARM in one function; and then surface again with GCC 5.1 on
x86_64 on another function; and then surface again under Cygwin for
another function with GCC 6.3.

The pattern was finally gutted in favor of the classic stuff - treat
the data unaligned an walk the buffer OR'ing in to a datatype. Or,
memcpy it into aligned datatypes. Modern compilers recognize the
pattern and it will be optimized they way you hope.

Older GCC's, like say, GCC 4.3, may not do as well. But it is the
price paid for portability and bug free code. And nowadays those old
GCC's and Clang's are getting more rare. There's no sense in doing
something quickly if you can't arrive at the correct result or you
crash at runtime.

> So in the case of siphash, that would mean always taking the unaligned
> path if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set, or only for
> unaligned data if it is not.

Jeff
