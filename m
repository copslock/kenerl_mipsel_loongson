Return-Path: <SRS0=rpqp=SU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF715C10F0E
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9D217F9
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fB72dc+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfDRFbs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:31:48 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36508 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfDRFbr (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 18 Apr 2019 01:31:47 -0400
Received: by mail-vk1-f193.google.com with SMTP id w140so216632vkd.3
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdpJY50vmVyqQ1PqbhbBydmQ/xHEoQMQSJOB3RmLp0Q=;
        b=fB72dc+b7uA3lZK0fM9coqknIBIeertJI7ikFyB/vi7+UhDzB4cM6BaPZBCgwdkMbP
         I6OuKXmEOkVuVbufdWR2exS5gdkih7q9m6sKqDvBv1Q9ecvRbsRvxC0p09WYg4f8ZR9Y
         lqwGyEe02y/u1sfKZHci1wzyCEwvxabZUD3T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdpJY50vmVyqQ1PqbhbBydmQ/xHEoQMQSJOB3RmLp0Q=;
        b=HTi+1UFBEL8WUW9MQBF+fr9EnYt8BGgMxqjpcNYBpZ/L8d127Y7Pn2tMpBZmQOZf04
         4Y3ERFqQp9b4GPRma72Cz+MLrNkFXjJhKTbv+KTVVz72Xlg/kd4uF9Ow5Zl6nISodM4W
         9DfBKLD2EvJi93VwW3QsBe0edetv0jtFUTPenZE5ZQAzMsOOIm/dqceJr8M8FPRK7icD
         p4ta8nTJlnJSnrEr0Ng1o+3aZxCBXeLZXodgzkfZxOaDAUba+6iAgJlNwtZU7N1IrM4B
         knmBA062o787BWE7VRlsL7rUvQBFXiIikdkPYNn5cOL5smyJ8GDlPovF0mR+XndTVSWd
         eJHw==
X-Gm-Message-State: APjAAAWgv1YMIQhjj6J1+CN7ITfJ0Ffd5hmJxHM5sB/ClRewAOjrMI3t
        x/k7RdNTIgaZ4i6N8AIn4T7ky7lPWcw=
X-Google-Smtp-Source: APXvYqw/7eUCrZE16zhtvBUrFaZyPbfVMOv0xjRHXK9NShU0TfiY4yp6xZgVra9n9mtjxXGhY/HG0A==
X-Received: by 2002:a1f:900d:: with SMTP id s13mr50196070vkd.41.1555565505133;
        Wed, 17 Apr 2019 22:31:45 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id p6sm399343vke.16.2019.04.17.22.31.43
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:31:44 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id x84so221600vkd.1
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:31:43 -0700 (PDT)
X-Received: by 2002:a1f:3458:: with SMTP id b85mr50194265vka.4.1555565503193;
 Wed, 17 Apr 2019 22:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-11-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-11-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:31:32 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJSgHKjrQ2Z-aKofqroUDBjPnLOjiORw9pHT_cANhAqpg@mail.gmail.com>
Message-ID: <CAGXu5jJSgHKjrQ2Z-aKofqroUDBjPnLOjiORw9pHT_cANhAqpg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] mips: Use generic mmap top-down layout
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

On Wed, Apr 17, 2019 at 12:33 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> mips uses a top-down layout by default that fits the generic functions.
> At the same time, this commit allows to fix problem uncovered
> and not fixed for mips here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/Kconfig                 |  1 +
>  arch/mips/include/asm/processor.h |  5 ---
>  arch/mips/mm/mmap.c               | 67 -------------------------------
>  3 files changed, 1 insertion(+), 72 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 4a5f5b0ee9a9..ec2f07561e4d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -14,6 +14,7 @@ config MIPS
>         select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_USE_QUEUED_SPINLOCKS
> +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>         select ARCH_WANT_IPC_PARSE_VERSION
>         select BUILDTIME_EXTABLE_SORT
>         select CLONE_BACKWARDS
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index aca909bd7841..fba18d4a9190 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -29,11 +29,6 @@
>
>  extern unsigned int vced_count, vcei_count;
>
> -/*
> - * MIPS does have an arch_pick_mmap_layout()
> - */
> -#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
> -
>  #ifdef CONFIG_32BIT
>  #ifdef CONFIG_KVM_GUEST
>  /* User space process size is limited to 1GB in KVM Guest Mode */
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index ffbe69f3a7d9..61e65a69bb09 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -20,43 +20,6 @@
>  unsigned long shm_align_mask = PAGE_SIZE - 1;  /* Sane caches */
>  EXPORT_SYMBOL(shm_align_mask);
>
> -/* gap between mmap and stack */
> -#define MIN_GAP                (128*1024*1024UL)
> -#define MAX_GAP                ((STACK_TOP)/6*5)
> -#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
> -
> -static int mmap_is_legacy(struct rlimit *rlim_stack)
> -{
> -       if (current->personality & ADDR_COMPAT_LAYOUT)
> -               return 1;
> -
> -       if (rlim_stack->rlim_cur == RLIM_INFINITY)
> -               return 1;
> -
> -       return sysctl_legacy_va_layout;
> -}
> -
> -static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
> -{
> -       unsigned long gap = rlim_stack->rlim_cur;
> -       unsigned long pad = stack_guard_gap;
> -
> -       /* Account for stack randomization if necessary */
> -       if (current->flags & PF_RANDOMIZE)
> -               pad += (STACK_RND_MASK << PAGE_SHIFT);
> -
> -       /* Values close to RLIM_INFINITY can overflow. */
> -       if (gap + pad > gap)
> -               gap += pad;
> -
> -       if (gap < MIN_GAP)
> -               gap = MIN_GAP;
> -       else if (gap > MAX_GAP)
> -               gap = MAX_GAP;
> -
> -       return PAGE_ALIGN(STACK_TOP - gap - rnd);
> -}
> -
>  #define COLOUR_ALIGN(addr, pgoff)                              \
>         ((((addr) + shm_align_mask) & ~shm_align_mask) +        \
>          (((pgoff) << PAGE_SHIFT) & shm_align_mask))
> @@ -154,36 +117,6 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>                         addr0, len, pgoff, flags, DOWN);
>  }
>
> -unsigned long arch_mmap_rnd(void)
> -{
> -       unsigned long rnd;
> -
> -#ifdef CONFIG_COMPAT
> -       if (TASK_IS_32BIT_ADDR)
> -               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
> -       else
> -#endif /* CONFIG_COMPAT */
> -               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
> -
> -       return rnd << PAGE_SHIFT;
> -}
> -
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> -{
> -       unsigned long random_factor = 0UL;
> -
> -       if (current->flags & PF_RANDOMIZE)
> -               random_factor = arch_mmap_rnd();
> -
> -       if (mmap_is_legacy(rlim_stack)) {
> -               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -               mm->get_unmapped_area = arch_get_unmapped_area;
> -       } else {
> -               mm->mmap_base = mmap_base(random_factor, rlim_stack);
> -               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> -       }
> -}
> -
>  static inline unsigned long brk_rnd(void)
>  {
>         unsigned long rnd = get_random_long();
> --
> 2.20.1
>


-- 
Kees Cook
