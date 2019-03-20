Return-Path: <SRS0=BbLz=RX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1498C43381
	for <linux-mips@archiver.kernel.org>; Wed, 20 Mar 2019 13:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A282146E
	for <linux-mips@archiver.kernel.org>; Wed, 20 Mar 2019 13:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCTNEx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:04:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34662 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCTNEx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 20 Mar 2019 09:04:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so2367180qtm.1;
        Wed, 20 Mar 2019 06:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wddUSSDius11UZyiAbEzXtYgG8gvmxfQ0FLbE4Ctdg=;
        b=sQtloULPHQksH1WlGY6iMyptaTBWv3XkjzYquW55kmOUS1eK4Kpv5v+mNZe69wXCnc
         rjJyiy/xsfQzRec1BHhjmi7eThEdGMsH39g70YHX1W4B05i7s60NV8jFD4AMd/GPW1lj
         oL46zeus4gwOrCM7ZAuuKmjcIbAYyQyDgu3P5Tt9Uabsn+cMKaxeBZ5Huj22T4XwnnZP
         a49ME/430y9KXUC6Nfit4fSanGtDxjBiKQF4oFg6s5uNq9RD5sVPG2m4wgP9ns8GVKVn
         dgnw849SQUjzOg1Fso9MKjjIi7IEE08W9RPx/FhAd+x/HuTVkUMPfc8Wq7IvfoKM2czD
         4+Pg==
X-Gm-Message-State: APjAAAVrmB+u13vi6NCxQl3gBo/QKDCrjQSddFrW9ZwUNiZYNrvho1TA
        tC++GF7uk1r5Ou2i61GNDyU9zIMmZF2zE4ck8uo=
X-Google-Smtp-Source: APXvYqySSLwR+4OGaKtI9pztTfCuIlZ5by7SMM6vCOJotO2MKZcP5LG/Y6qq4L04GPO5POq+Cxc1GPkYZ29VIKVxXF4=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr4684094qto.343.1553087091631;
 Wed, 20 Mar 2019 06:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
 <CAK8P3a0-7LRE4ByO2Uf4tb5mR49SbZzBu0AgHpS=03FAMWFLgQ@mail.gmail.com> <CAK7LNATjXoNrbt2SSgR4omiQEBppOkF6mdcVJjpw2B+ihGQvGw@mail.gmail.com>
In-Reply-To: <CAK7LNATjXoNrbt2SSgR4omiQEBppOkF6mdcVJjpw2B+ihGQvGw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Mar 2019 14:04:34 +0100
Message-ID: <CAK8P3a3Y+r95FNpHjPznD5g1PSS=OuYdzT8VH9XNY2DTUhB-Tw@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Mar 20, 2019 at 11:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Wed, Mar 20, 2019 at 6:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Mar 20, 2019 at 7:41 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >
> > > It is unclear to me how to fix it.
> > > That's why I ended up with "depends on !MIPS".
> > >
> > >
> > >   MODPOST vmlinux.o
> > > arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> > > sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> > > arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined
> > > references to `mips_gcr_base'
> > >
> > >
> > > Perhaps, MIPS folks may know how to fix it.
> >
> > I would guess like this:
> >
> > diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> > index 8bc5df49b0e1..a27483fedb7d 100644
> > --- a/arch/mips/include/asm/mips-cm.h
> > +++ b/arch/mips/include/asm/mips-cm.h
> > @@ -79,7 +79,7 @@ static inline int mips_cm_probe(void)
> >   *
> >   * Returns true if a CM is present in the system, else false.
> >   */
> > -static inline bool mips_cm_present(void)
> > +static __always_inline bool mips_cm_present(void)
> >  {
> >  #ifdef CONFIG_MIPS_CM
> >         return mips_gcr_base != NULL;
> > @@ -93,7 +93,7 @@ static inline bool mips_cm_present(void)
> >   *
> >   * Returns true if the system implements an L2-only sync region, else false.
> >   */
> > -static inline bool mips_cm_has_l2sync(void)
> > +static __always_inline bool mips_cm_has_l2sync(void)
> >  {
> >  #ifdef CONFIG_MIPS_CM
> >         return mips_cm_l2sync_base != NULL;
> >
>
>
> Thanks, I applied the above, but I still see
>  undefined reference to `mips_gcr_base'
>
>
> I attached .config to produce this error.
>
> I use prebuilt mips-linux-gcc from
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/

I got to this patch experimentally, it fixes the problem for me:

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 394673991bab..d70d02da038b 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -181,7 +181,7 @@ static int __init mips_sc_probe_cm3(void)
        return 0;
 }

-static inline int __init mips_sc_probe(void)
+static __always_inline int __init mips_sc_probe(void)
 {
        struct cpuinfo_mips *c = &current_cpu_data;
        unsigned int config1, config2;
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 830c93a010c3..186c28463bf3 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -548,7 +548,7 @@ static inline unsigned long __fls(unsigned long word)
  * Returns 0..SZLONG-1
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static inline unsigned long __ffs(unsigned long word)
+static __always_inline unsigned long __ffs(unsigned long word)
 {
        return __fls(word & -word);
 }


It does look like a gcc bug though, as at least some of the references
are from a function that got split out from an inlined function but that
has no remaining call sites.

       Arnd
