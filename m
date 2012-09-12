Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 18:16:23 +0200 (CEST)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:35557 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903340Ab2ILQQP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 18:16:15 +0200
Received: by vcbgb22 with SMTP id gb22so2407795vcb.36
        for <multiple recipients>; Wed, 12 Sep 2012 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=oXDpucRhCkwlYX1m+Tfy470zElP33reNOq0fAHcyB8k=;
        b=g1FRBVjZDL/oF12R5x1rkHYe3sFS09CQBZiXjBZIt603SM3VNIFkvOmwSfDaTjd0GI
         QKMqFshtlOIlQTxAoDha3Ny/v2r8JmPMLZLhvz2EmXNkrCJeh10GamazqT0nX+rmreoC
         GyQlo7G9KOvFXZD4HYrLrlD6zVEMCncjJ24gAbF5N3v6WiCE9BU5u5OUIjErDk/W4/rs
         D+rNd/WA8q9Ci2Sl4w7h2bEdL4FIIdoSfxDKjzA1+CuxH5SenE/F7/b4xpeDtnkkaQDN
         PH/nuZrgRyaC7UEnzNbpFAjuAr2UDRwBubH3Bi5Z5VCCJjpK8BCixL6fLJBI2PYJTlkX
         4DMA==
MIME-Version: 1.0
Received: by 10.52.18.244 with SMTP id z20mr23359837vdd.85.1347466569443; Wed,
 12 Sep 2012 09:16:09 -0700 (PDT)
Received: by 10.220.50.135 with HTTP; Wed, 12 Sep 2012 09:16:09 -0700 (PDT)
In-Reply-To: <1347465937-7056-1-git-send-email-cyril@ti.com>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
Date:   Wed, 12 Sep 2012 18:16:09 +0200
X-Google-Sender-Auth: wGlSj2Ng-D3KFipHiLmHQ-ErF5w
Message-ID: <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
Subject: Re: [PATCH] of: specify initrd location using 64-bit
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Cyril Chemparathy <cyril@ti.com>
Cc:     devicetree-discuss@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux@openrisc.net, linuxppc-dev@lists.ozlabs.org,
        microblaze-uclinux@itee.uq.edu.au, a-jacquiot@ti.com,
        arnd@arndb.de, benh@kernel.crashing.org, bigeasy@linutronix.de,
        blogic@openwrt.org, david.daney@cavium.com, dhowells@redhat.com,
        grant.likely@secretlab.ca, hpa@zytor.com, jonas@southpole.se,
        linus.walleij@linaro.org, linux@arm.linux.org.uk,
        m.szyprowski@samsung.com, mahesh@linux.vnet.ibm.com,
        mingo@redhat.com, monstr@monstr.eu, msalter@redhat.com,
        nico@linaro.org, paul.gortmaker@windriver.com, paulus@samba.org,
        ralf@linux-mips.org, rob.herring@calxeda.com, suzuki@in.ibm.com,
        tglx@linutronix.de, tj@kernel.org, x86@kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34478
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Sep 12, 2012 at 6:05 PM, Cyril Chemparathy <cyril@ti.com> wrote:
> On some PAE architectures, the entire range of physical memory could reside
> outside the 32-bit limit.  These systems need the ability to specify the
> initrd location using 64-bit numbers.
>
> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> use 64-bit numbers instead of the current unsigned long.

> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)

Why not phys_addr_t?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
