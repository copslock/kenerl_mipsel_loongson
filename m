Return-Path: <SRS0=rpqp=SU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E294C10F0E
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42421479
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="edeVbOaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDRFaq (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:30:46 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44345 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfDRFaq (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 18 Apr 2019 01:30:46 -0400
Received: by mail-vk1-f193.google.com with SMTP id q189so206497vkq.11
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLtDzKXu09gPBmOTPhLlCKa/1j1gZ8w+6fLRYpgkXVc=;
        b=edeVbOaBMLhN2dBQJXpv+D+6vAjewlRc9kM5lTmzsJMTYvnZuw8u8Y7DqZfh26UEgW
         OHIgnpHVLQHXols38+FJXscMQV6lYZx93+goYy0WamrsRBkh1x83txAmNxUkD0xqfkb/
         5V9w/CLbuOWB3OiL1UReRwHKvROTO3KbTfB1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLtDzKXu09gPBmOTPhLlCKa/1j1gZ8w+6fLRYpgkXVc=;
        b=Mdr8ERv/q0YMbhx2aLaPBKRoub+kxuZoRs5QWftm6UYRVDTGZcdFzzlFiI8hBJ/4wD
         NiVTihWRPFvPsqrud20oq0NNFYXCbvQxsuhg+l7/rnpgREy0FS8zluwPVCC/7ZSmf2Qq
         muC4RVlcq1jk5q58kiLbSW45HAvKxkC+gs3jYg9UFguLMcGIUzaeBjEzBrjnI8itvlaa
         +vaiRfjocW/9Ep2k1LRKDFh7Z2tI7KvgD334biDOhKIrFlPe/VbopHSNkAPdtQPhaga9
         GV20l/2G83Pz0606q+KB72U2hDIgg+iOfUbHsHZJBp9SZ/b9SUZ2Smov8z92MkYX26hZ
         iSxg==
X-Gm-Message-State: APjAAAUL9M2Ke1fJ8I44skkVvTG9z64U5UtpDCJiLkxSj4uOfCQiCstJ
        uF8z/TKlTgcDeZYhM3Oepn1BdbNRSbI=
X-Google-Smtp-Source: APXvYqz5ifsB3QyY03SjW9lkHqVO+rqMkSEFFS4nihHFrM259s84bXzojHWQ1OcuVcNo4ovuLlyARw==
X-Received: by 2002:a1f:acd1:: with SMTP id v200mr48283044vke.7.1555565444605;
        Wed, 17 Apr 2019 22:30:44 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id s187sm287274vkg.28.2019.04.17.22.30.43
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:30:43 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id w13so512015vsc.4
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:30:43 -0700 (PDT)
X-Received: by 2002:a67:e881:: with SMTP id x1mr52185580vsn.48.1555565442783;
 Wed, 17 Apr 2019 22:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-9-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-9-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:30:31 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+-M5VGsPqZ6JyqH6w=HP9NLK2KEAQqen99ssUg5mC89A@mail.gmail.com>
Message-ID: <CAGXu5j+-M5VGsPqZ6JyqH6w=HP9NLK2KEAQqen99ssUg5mC89A@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] mips: Properly account for stack randomization
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

On Wed, Apr 17, 2019 at 12:31 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This commit takes care of stack randomization and stack guard gap when
> computing mmap base address and checks if the task asked for randomization.
> This fixes the problem uncovered and not fixed for mips here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html

same URL change here please...

>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/mm/mmap.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index 2f616ebeb7e0..3ff82c6f7e24 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -21,8 +21,9 @@ unsigned long shm_align_mask = PAGE_SIZE - 1; /* Sane caches */
>  EXPORT_SYMBOL(shm_align_mask);
>
>  /* gap between mmap and stack */
> -#define MIN_GAP (128*1024*1024UL)
> -#define MAX_GAP ((TASK_SIZE)/6*5)
> +#define MIN_GAP                (128*1024*1024UL)
> +#define MAX_GAP                ((TASK_SIZE)/6*5)
> +#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
>
>  static int mmap_is_legacy(struct rlimit *rlim_stack)
>  {
> @@ -38,6 +39,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
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

-- 
Kees Cook
