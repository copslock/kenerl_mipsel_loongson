Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 12:39:17 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36296 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010244AbbJSKjPzPn89 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2015 12:39:15 +0200
Received: by oifu187 with SMTP id u187so4010780oif.3;
        Mon, 19 Oct 2015 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nAQ5BVEymzp2uiNRbala+FHwJQHHPb70DbHkYsi6yh0=;
        b=pdeytEinVFsYiOmimdNVcdwj1QVHyq3O5Xadvrwu8Jhn19sUNMa4UGjSjPqYz1MOfw
         XRocjrUm5jKT8KGVuAxjr40vEwlSlxJuqgG/vXAqjt+Ke4+joGnGjeBi9VFDaverVc44
         bux5S6zwaJ6M/SAsFLJ4Gmq6oHe66fuRHBG+w3fNWS4jVfuZ98v7fEECetc/24QejECB
         zK71mY1VTbWBghViwFTigmcIl9IVrGVLkS7d+4+eziHPMMb0EVonUEVTTWuhN42MpBn9
         n1h3Nv7CMC41BsaEwCWRINiMkNPmGzzDep5HLrJI1MRwDEbrHk24ITp6j2dOKOGaob9x
         zD+A==
MIME-Version: 1.0
X-Received: by 10.202.88.69 with SMTP id m66mr15353443oib.99.1445251150031;
 Mon, 19 Oct 2015 03:39:10 -0700 (PDT)
Received: by 10.60.34.132 with HTTP; Mon, 19 Oct 2015 03:39:09 -0700 (PDT)
In-Reply-To: <4345582.jiHe94XBb3@wuerfel>
References: <5082760.FgB9zHNfte@wuerfel>
        <5152101.mD2bWzUJ2V@wuerfel>
        <CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg@mail.gmail.com>
        <4345582.jiHe94XBb3@wuerfel>
Date:   Mon, 19 Oct 2015 12:39:09 +0200
X-Google-Sender-Auth: U7wI7HzezGv9E1zGemKS1SWm7vQ
Message-ID: <CAMuHMdUcAhocNosTB+YnQ0LiPui58ph13mrDYcE15vDjRAmscQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Mon, Oct 19, 2015 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 19 October 2015 09:34:15 Geert Uytterhoeven wrote:
>> On Wed, Oct 7, 2015 at 1:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>> >
>> > which truncates the result to 32 bit.
>>
>> Woops.
>>
>> See also my unanswered question in "atomic64 on 32-bit vs 64-bit (was:
>> Re: Add virtio gpu driver.)", which is still valid:
>> https://lkml.org/lkml/2015/6/28/18
>>
>
> Regarding your question of
>
>> Instead of sprinkling casts, is there any good reason why atomic64_read()
>> and atomic64_t aren't "long long" everywhere, cfr. u64?
>
>
> I assume the answer is that some (all?) 64-bit architectures intentionally
> return 'long' here, in order for atomic_long_read() to return 'long' on
> all architectures, given the definitions from
> include/asm-generic/atomic-long.h
>
> We would have to either change those, or we have to pick between
> atomic_long_* or atomic64_* to have a consistent return type.

I guess the main reason is this comment in include/asm-generic/atomic-long.h,
which I hadn't noticed before:

 * Casts for parameters are avoided for existing atomic functions in order to
 * avoid issues with cast-as-lval under gcc 4.x and other limitations that the
 * macros of a platform may have.

Still, it's a pity, as printing atomic_64 is one more place where casts are
needed in callers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
