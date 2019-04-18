Return-Path: <SRS0=rpqp=SU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDBCC10F0B
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EE62184B
	for <linux-mips@archiver.kernel.org>; Thu, 18 Apr 2019 05:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOmVLE2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfDRFVB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:21:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43510 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfDRFVA (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 18 Apr 2019 01:21:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id t23so484616vso.10
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcA/uYI8DV5Uk3TdhA5fHXy0czTBgFSx6RCoxfz+//4=;
        b=ZOmVLE2kWQEfxAwJtqNT7fptm5m89yjN9pJ4hwhI4Z8f49vkIG1SsNzihNlPHXzko1
         XXEV3xLUvXrMTYVGVNWYLrrCC0hIAZCueqmowWDl/0KTMFCsqx1U+m/G2nteU8eiooyN
         6sDfWAdWlsvCPZQuCGxF8OqTfh2ZEPtoetyBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcA/uYI8DV5Uk3TdhA5fHXy0czTBgFSx6RCoxfz+//4=;
        b=VzbOzoBdeMc7340Etc6UryEfWnUwEiM+F2wcf9lv3ewdSCdKcyu7Kv7r3eKxoJ4y5t
         wJFEwrCcgYwXAmr7wSvRcvQdUUoZ58VParJGUEjOUDMSAXtHPqyI7aEsD4yEegPF/R72
         N2rsUl35tcZ6OW4xvxtg9u2KqydDpSyPGd8clHvpm3Uh2RaTkQQ136Y6QSk10boRVQSM
         zACwkaZJ3mtWikFVkuUug8rmABDgphpl2oESogj24V76MqTyb6M5zQH4/iCYs++4a7zZ
         yuQt4J+MJ+X5vE0zOl2qjVpKsX8SeEXOZc/UoECL1NUG6IDauYu/54Y80kMqBDk7X5Vj
         h0SA==
X-Gm-Message-State: APjAAAXkBZTIIdFCcFAVGkV7ejRvaIIjSPxCFsph9aKy2txCqmL2dLHi
        iElKCAqWdLES+LIO4UH+7CmhaXK2GAk=
X-Google-Smtp-Source: APXvYqyI89sKK44gqikPDaGUhHZ+vpk2dJ8vfo1Rs7E2VUguNSlygJAdyCIoVlhja+Ka1aBIxjylxA==
X-Received: by 2002:a67:76d7:: with SMTP id r206mr50572934vsc.25.1555564859461;
        Wed, 17 Apr 2019 22:20:59 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id r63sm257861vsc.15.2019.04.17.22.20.56
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:20:56 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id c13so360833uao.12
        for <linux-mips@vger.kernel.org>; Wed, 17 Apr 2019 22:20:56 -0700 (PDT)
X-Received: by 2002:a9f:3fce:: with SMTP id m14mr49582984uaj.96.1555564855818;
 Wed, 17 Apr 2019 22:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-2-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-2-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:20:44 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKuOaGtb0S++_xpS=sxPLFwFqSgaecWae5iJ8f8eaQzDA@mail.gmail.com>
Message-ID: <CAGXu5jKuOaGtb0S++_xpS=sxPLFwFqSgaecWae5iJ8f8eaQzDA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] mm, fs: Move randomize_stack_top from fs to mm
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

On Wed, Apr 17, 2019 at 12:24 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This preparatory commit moves this function so that further introduction
> of generic topdown mmap layout is contained only in mm/util.c.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/binfmt_elf.c    | 20 --------------------
>  include/linux/mm.h |  2 ++
>  mm/util.c          | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 7d09d125f148..045f3b29d264 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -662,26 +662,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   * libraries.  There is no binary dependent code anywhere else.
>   */
>
> -#ifndef STACK_RND_MASK
> -#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))    /* 8MB of VA */
> -#endif
> -
> -static unsigned long randomize_stack_top(unsigned long stack_top)
> -{
> -       unsigned long random_variable = 0;
> -
> -       if (current->flags & PF_RANDOMIZE) {
> -               random_variable = get_random_long();
> -               random_variable &= STACK_RND_MASK;
> -               random_variable <<= PAGE_SHIFT;
> -       }
> -#ifdef CONFIG_STACK_GROWSUP
> -       return PAGE_ALIGN(stack_top) + random_variable;
> -#else
> -       return PAGE_ALIGN(stack_top) - random_variable;
> -#endif
> -}
> -
>  static int load_elf_binary(struct linux_binprm *bprm)
>  {
>         struct file *interpreter = NULL; /* to shut gcc up */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 76769749b5a5..087824a5059f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2312,6 +2312,8 @@ extern int install_special_mapping(struct mm_struct *mm,
>                                    unsigned long addr, unsigned long len,
>                                    unsigned long flags, struct page **pages);
>
> +unsigned long randomize_stack_top(unsigned long stack_top);
> +
>  extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
>
>  extern unsigned long mmap_region(struct file *file, unsigned long addr,
> diff --git a/mm/util.c b/mm/util.c
> index d559bde497a9..a54afb9b4faa 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -14,6 +14,8 @@
>  #include <linux/hugetlb.h>
>  #include <linux/vmalloc.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/elf.h>
> +#include <linux/random.h>
>
>  #include <linux/uaccess.h>
>
> @@ -291,6 +293,26 @@ int vma_is_stack_for_current(struct vm_area_struct *vma)
>         return (vma->vm_start <= KSTK_ESP(t) && vma->vm_end >= KSTK_ESP(t));
>  }
>
> +#ifndef STACK_RND_MASK
> +#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))     /* 8MB of VA */
> +#endif

Oh right, here's the generic one... this should probably just copy
arm64's version instead. Then x86 can be tweaked (it uses
mmap_is_ia32() instead of is_compat_task() by default, but has a weird
override..)

Regardless, yes, this is a direct code move:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> +
> +unsigned long randomize_stack_top(unsigned long stack_top)
> +{
> +       unsigned long random_variable = 0;
> +
> +       if (current->flags & PF_RANDOMIZE) {
> +               random_variable = get_random_long();
> +               random_variable &= STACK_RND_MASK;
> +               random_variable <<= PAGE_SHIFT;
> +       }
> +#ifdef CONFIG_STACK_GROWSUP
> +       return PAGE_ALIGN(stack_top) + random_variable;
> +#else
> +       return PAGE_ALIGN(stack_top) - random_variable;
> +#endif
> +}
> +
>  #if defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
>  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  {
> --
> 2.20.1
>


-- 
Kees Cook
