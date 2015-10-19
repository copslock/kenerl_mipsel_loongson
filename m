Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 09:34:23 +0200 (CEST)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34154 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009147AbbJSHeVzcO0d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2015 09:34:21 +0200
Received: by oies66 with SMTP id s66so53692870oie.1;
        Mon, 19 Oct 2015 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bOiPXQMkIVvWLxvmuuf5N3Bdilvdaqcy0RKyNIwu6Nc=;
        b=E3iTsFoWytTdCECi5KmYp7box5OleJIgoqdC1HrOWQuBEvtYoo/glXeByYMkeANv6h
         MPmo9JAx0SR8xQDuXeYf6tOB7wM6VB3aSJFGtMqJCjqExvAEY5jOX6jgKUeO/4Twys1u
         XA2hXg4nLdwZR60CMWQgp+5VxKRO1hrdkifgfpvepLC9YnRgvyPvSw7CnEAzvK0A1Ydq
         X5ycmweZcJ9DXhNpy0aRaRsL7jS8eoTeFaSDjx4jlgf2de4L8+mC7ezubmfDIT77lNtv
         2OAUM/ljXyDMkdt2WkQr7a3sip0GejbT0dGoNE+RBEOGtQhVEEVjpYWfAeM+/ey8CSLM
         KNXg==
MIME-Version: 1.0
X-Received: by 10.202.65.11 with SMTP id o11mr7555490oia.18.1445240056095;
 Mon, 19 Oct 2015 00:34:16 -0700 (PDT)
Received: by 10.60.34.132 with HTTP; Mon, 19 Oct 2015 00:34:15 -0700 (PDT)
In-Reply-To: <5152101.mD2bWzUJ2V@wuerfel>
References: <5082760.FgB9zHNfte@wuerfel>
        <20151007104502.GH21513@n2100.arm.linux.org.uk>
        <6260324.3MlUEc3veg@wuerfel>
        <5152101.mD2bWzUJ2V@wuerfel>
Date:   Mon, 19 Oct 2015 09:34:15 +0200
X-Google-Sender-Auth: 3Kw7unQG3GO9lLEab03s1EGfvys
Message-ID: <CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49594
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

On Wed, Oct 7, 2015 at 1:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 October 2015 13:04:06 Arnd Bergmann wrote:
>> On Wednesday 07 October 2015 11:45:02 Russell King - ARM Linux wrote:
>> > On Wed, Oct 07, 2015 at 12:41:21PM +0200, Arnd Bergmann wrote:
>> > > The virtgpu driver prints the last_seq variable using the %ld or
>> > > %lu format string, which does not work correctly on all architectures
>> > > and causes this compiler warning on ARM:
>> > >
>> > > drivers/gpu/drm/virtio/virtgpu_fence.c: In function 'virtio_timeline_value_str':
>> > > drivers/gpu/drm/virtio/virtgpu_fence.c:64:22: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]
>> > >   snprintf(str, size, "%lu", atomic64_read(&fence->drv->last_seq));
>> > >                       ^
>> > > drivers/gpu/drm/virtio/virtgpu_debugfs.c: In function 'virtio_gpu_debugfs_irq_info':
>> > > drivers/gpu/drm/virtio/virtgpu_debugfs.c:37:16: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'long long int' [-Wformat=]
>> > >   seq_printf(m, "fence %ld %lld\n",
>> > >                 ^
>> > >
>> > > In order to avoid the warnings, this changes the format strings to %llu
>> > > and adds a cast to u64, which makes it work the same way everywhere.
>> >
>> > You have to wonder why atomic64_* functions do not use u64 types.
>> > If they're not reliant on manipulating 64-bit quantities, then what's
>> > the point of calling them atomic _64_.
>>
>> I haven't checked all architectures, but I assume what happens is that
>> 64-bit ones just #define atomic64_t atomic_long_t, so they don't have
>> to provide three sets of functions.
>
> scratch that, I just looked at all the architectures and found that it's
> just completely arbitrary, even within one architecture you get a mix
> of 'long' and 'long long', plus this gem from MIPS:
>
> static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
>
> which truncates the result to 32 bit.

Woops.

See also my unanswered question in "atomic64 on 32-bit vs 64-bit (was:
Re: Add virtio gpu driver.)", which is still valid:
https://lkml.org/lkml/2015/6/28/18

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
