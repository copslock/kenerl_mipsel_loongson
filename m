Return-Path: <SRS0=rpqp=SU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DEEC10F0E
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 04:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259622184B
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 04:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BwFdgFLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbfDREce (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:32:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42926 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfDREcd (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 18 Apr 2019 00:32:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id f15so443655vsk.9
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 21:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emqG7/19kpW5wZ57vs/jCWwiZdoRZXGDohb1D974Avc=;
        b=BwFdgFLFNee7q4d/odil7gkB/UOuVM/QIlnvE7TGVcPxV0znLQ4z7fs87fH9FD/p2Q
         QIWn2YByOZWf2cz5EWUgLnTt8H1YHdlzqE3vWASVSstFIxPSA4Jhvnkwf4hkz5pNBDia
         3hMlCG7M0QDEQlArREt5/8jUB1Ed/r+jW9qXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emqG7/19kpW5wZ57vs/jCWwiZdoRZXGDohb1D974Avc=;
        b=EXjK95D/XPt5zIVJbyjDz7VzZuJct+EhsMJKWi+fyrwhcdZIGd9EYO1d1Xc3sO/ywE
         6IrMbnpW2IZhyqePlgWhwXUkoRrGXeEkOCXNuALPp4I2bgxE+8foUApRmbztO7XVXVNb
         lLJzPhsZM7KJgNEZIeK+LFZJTQy2sukodBqX4rktIK2SoSes3Ckzjyhn3IM0HkX3cGbm
         SlP3GA6OtpNTTWXm6b3YAMUumF2+jw5l8Z3OWBBZK86C4tjdKp99LWc2ellLm2QWvmT0
         Z8Eb79/DvCMPSib+KDCeNTlMaf/W0fevULamsi1AsIc6kzne6m6Mw/LeQw2F8phiGy+s
         vOrw==
X-Gm-Message-State: APjAAAV/IJ+pTrxik5ZUo7Wz6oqR6WbkmlA10yDVbCGyBUbHjYqnU3oK
        EiAkq21IffE4KqUMgPPZqN1BBCBGVqA=
X-Google-Smtp-Source: APXvYqyx052ED9G9p+XbJjtjRDk747O4yF3mUvZuOlDua2XuSl8p4KZpuusgx9XjmBP54Xv+qrDMtw==
X-Received: by 2002:a67:7e90:: with SMTP id z138mr49758433vsc.204.1555561951900;
        Wed, 17 Apr 2019 21:32:31 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id c204sm472530vkd.14.2019.04.17.21.32.29
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 21:32:30 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id s2so455792vsi.5
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 21:32:29 -0700 (PDT)
X-Received: by 2002:a67:bc13:: with SMTP id t19mr2517845vsn.222.1555561949440;
 Wed, 17 Apr 2019 21:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-3-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-3-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Apr 2019 23:32:17 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKVa2YgAkWH1e26kxd2j6C4WsJ38+Z3K1z7JRvr_jDX6Q@mail.gmail.com>
Message-ID: <CAGXu5jKVa2YgAkWH1e26kxd2j6C4WsJ38+Z3K1z7JRvr_jDX6Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] arm64: Make use of is_compat_task instead of
 hardcoding this test
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Apr 17, 2019 at 12:25 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Each architecture has its own way to determine if a task is a compat task,
> by using is_compat_task in arch_mmap_rnd, it allows more genericity and
> then it prepares its moving to mm/.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 842c8a5fcd53..ed4f9915f2b8 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -54,7 +54,7 @@ unsigned long arch_mmap_rnd(void)
>         unsigned long rnd;
>
>  #ifdef CONFIG_COMPAT
> -       if (test_thread_flag(TIF_32BIT))
> +       if (is_compat_task())
>                 rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
>         else
>  #endif
> --
> 2.20.1
>


-- 
Kees Cook
