Return-Path: <SRS0=rpqp=SU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C2C10F14
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027B421479
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JlYc5LnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfDRF01 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:26:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43736 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRF01 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 18 Apr 2019 01:26:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id t23so490075vso.10
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVoqbwyN443Uxffv4ADeYKBc3zmgcqP5SCaKkpPU0Ag=;
        b=JlYc5LnYPCwWgX5oqj7ynsTkg9HwSCKe5lZ5zN605L7Uvo1glCbNDCtQfk8GyTRI13
         ROZ9wJjLihPw49RRrvvr1sPQAGB3Bk/uVz5KXlTfPr4zLd1Qk3TnxysN1P6IizUWSim9
         CZommiTKB0IOC+Nf2V/4WJTnJI7JYYMqf0DOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVoqbwyN443Uxffv4ADeYKBc3zmgcqP5SCaKkpPU0Ag=;
        b=Ydj6UWjmlo3gs/3FpA4r+NklsOBw1/qiNEVBwZrwUmy1aboMw+RI0PAW+UOAj9BN/q
         NukHDtkjARDdQLwyJECNtOcH6DlUZQTmB8LIr2pXZHDyv4ZuU1szIJQfToHjqQ8NP2g7
         FHGjeDhEOQnyWzgEbJ9kPERgHxx6b5gB7eDLkGV6D2v0bpgJNo5zxU2XVzfEIbnHtFx5
         sYt4awrteA7fPZcwG2KivDVHjgIXa7qLB/aYGYFwMQSVq2Dl5srjQXritybFuUr4Zk9U
         wyPlB2V8TYmEWNqRdEvrZwEPdWLASorMJHMwCCfWHvGUx4mwBP93lr6xIpJHTGwhr9q8
         AHkw==
X-Gm-Message-State: APjAAAUbZyejEEUfGdBBbZZAxxrbG0kzNQOqVsVL+jSJwJeDFDk7kaY5
        SsELvgNwUoFEOoSdxygmTOTF6xHaDFY=
X-Google-Smtp-Source: APXvYqxiNHI5YiIYpAupxlQkzEreUl7pyljmsSzK7aeEoZ2nYTOv7DoVSq9LhE+VcpNaO7JbG5nMKQ==
X-Received: by 2002:a67:e315:: with SMTP id j21mr51347363vsf.10.1555565186170;
        Wed, 17 Apr 2019 22:26:26 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id t207sm384942vkb.21.2019.04.17.22.26.23
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:26:23 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id e2so483958vsc.13
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:26:23 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr50384241vsp.66.1555565182826;
 Wed, 17 Apr 2019 22:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-6-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-6-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:26:11 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+V_kJk-Lu=u82CrA291EPpgJtX951EKigprozXt7=ORA@mail.gmail.com>
Message-ID: <CAGXu5j+V_kJk-Lu=u82CrA291EPpgJtX951EKigprozXt7=ORA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] arm: Properly account for stack randomization
 and stack guard gap
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

On Wed, Apr 17, 2019 at 12:28 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This commit takes care of stack randomization and stack guard gap when
> computing mmap base address and checks if the task asked for randomization.
> This fixes the problem uncovered and not fixed for arm here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html

Please use the official archive instead. This includes headers, linked
patches, etc:
https://lkml.kernel.org/r/20170622200033.25714-1-riel@redhat.com

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/mm/mmap.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index f866870db749..bff3d00bda5b 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -18,8 +18,9 @@
>          (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
>
>  /* gap between mmap and stack */
> -#define MIN_GAP (128*1024*1024UL)
> -#define MAX_GAP ((TASK_SIZE)/6*5)
> +#define MIN_GAP                (128*1024*1024UL)

Might as well fix this up as SIZE_128M

> +#define MAX_GAP                ((TASK_SIZE)/6*5)
> +#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))

STACK_RND_MASK is already defined so you don't need to add it here, yes?

>  static int mmap_is_legacy(struct rlimit *rlim_stack)
>  {
> @@ -35,6 +36,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
>  static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>  {
>         unsigned long gap = rlim_stack->rlim_cur;
> +       unsigned long pad = stack_guard_gap;
> +
> +       /* Account for stack randomization if necessary */
> +       if (current->flags & PF_RANDOMIZE)
> +               pad += (STACK_RND_MASK << PAGE_SHIFT);
> +
> +       /* Values close to RLIM_INFINITY can overflow. */
> +       if (gap + pad > gap)
> +               gap += pad;
>
>         if (gap < MIN_GAP)
>                 gap = MIN_GAP;
> --
> 2.20.1
>

But otherwise, yes:

Acked-by: Kees Cook <keescook@chromium.org>

--
Kees Cook
