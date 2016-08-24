Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2016 04:12:35 +0200 (CEST)
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37869 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbcHXCM01QTnc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2016 04:12:26 +0200
Received: by mail-wm0-f47.google.com with SMTP id i5so6328579wmg.0
        for <linux-mips@linux-mips.org>; Tue, 23 Aug 2016 19:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZxaRxiwgDnkDQlJ085EUQylY/6W4En/ccbU2dQNqlec=;
        b=YBweyVGKFOKV7mJkgynbihUxLKnEdYN2B3yEpQd+WrLFyxD5KDKchnZoWeTiokT8An
         FmB6SCU/bK4oiK+LksDrXSUJV9wwvXfXqPXLMU/G9n0L0uHUt1PsQorTYvgYdi3wEaCu
         +1grTkLPY7nHtih8ZNS8yDgWrJSofUt6GK7myutugDlRrXvlKlWjqPv/eJ8sUwwmExtk
         hXmP9RHsk+Bd3GD2LXBzkTcZlF5rAHWGlQhOctmAq++JBW9OnQpwqP+PRG4tJyi6Da1x
         Uz8nvD74tEvywspBylQCODjU7jWpc+SXariLzMW4M2wzYTZa/pOD/3k2zEsrwSjmGFU/
         fgzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZxaRxiwgDnkDQlJ085EUQylY/6W4En/ccbU2dQNqlec=;
        b=m0QeRIhVApdUqgIy1nbojLYflldozGLfKufen68TCaQB2iVY9atPsuw45xo7rEevyp
         8Cqm9VywDegRGUG4TC+Y+MWVbUOZ1mO/Y6ZgOftYM8jW0YAAkJ/XUIe+gQJGQtr8m5UU
         UVY+RSGdiZ+Y9ULDxdDb4zK88cgvDWTuqUGBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZxaRxiwgDnkDQlJ085EUQylY/6W4En/ccbU2dQNqlec=;
        b=edVj+apTJ2Fsw28fAGhgMgDLUpVqsuH+bOr5D8uq4XG8mB+KLGz0tg/XCkSc7S7+OZ
         clEP5LAbfxlfRm+0Vg0oeldST30IRJClj3HMXK/bLvEiHlMX3cVla+psftkCMRB4yQpx
         Rx1mzq2tQ1PzJSiUlrtp5/tlfxb4I3wfQ9jTgv/Md0MrMPBKkO6FJzKMk8fvZocNGNAi
         e1mnY48uoM5SvrVX8xpMnW8e2QcfgD179IgSmv7nEmOdb/Rowhzi2Gi+8rorXGgQpUMJ
         RCuIEJDmMuuTmcdxskEmc//lW6yna48K3BLS8/ViEZbyp8au9nFktkac1cLk76PuQoml
         rqww==
X-Gm-Message-State: AEkooutuV6xRsG2ke4gKDhmcfAQR7jhKLbCt0EIBS/klLbfFbz+BEUGniSQRfu54t7wpsHaG7xJkdJz4bREIPcYF
X-Received: by 10.194.28.5 with SMTP id x5mr350087wjg.11.1472004740909; Tue,
 23 Aug 2016 19:12:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.167.78 with HTTP; Tue, 23 Aug 2016 19:12:20 -0700 (PDT)
In-Reply-To: <1471970749-24867-1-git-send-email-yamada.masahiro@socionext.com>
References: <1471970749-24867-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Aug 2016 22:12:20 -0400
X-Google-Sender-Auth: yAjHDjkreS4nlnLNa4oKw59dwC4
Message-ID: <CAGXu5jJqhXmpnmaDYhJz6oDU7vqxAftgJZCW9zZJFJSSyKU-Ng@mail.gmail.com>
Subject: Re: [PATCH] treewide: replace config_enabled() with IS_ENABLED() (2nd round)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Garnier <thgarnie@google.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Aug 23, 2016 at 12:45 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Commit 97f2645f358b ("tree-wide: replace config_enabled() with
> IS_ENABLED()") mostly killed config_enabled(), but some new users
> have appeared for v4.8-rc1.  They are all used for a boolean option,
> so can be replaced with IS_ENABLED() safely.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  arch/mips/include/asm/page.h | 4 ++--
>  arch/s390/kernel/setup.c     | 6 ++----
>  arch/x86/mm/kaslr.c          | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index ea0cd97..5f98759 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -164,7 +164,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>   */
>  static inline unsigned long ___pa(unsigned long x)
>  {
> -       if (config_enabled(CONFIG_64BIT)) {
> +       if (IS_ENABLED(CONFIG_64BIT)) {
>                 /*
>                  * For MIPS64 the virtual address may either be in one of
>                  * the compatibility segements ckseg0 or ckseg1, or it may
> @@ -173,7 +173,7 @@ static inline unsigned long ___pa(unsigned long x)
>                 return x < CKSEG0 ? XPHYSADDR(x) : CPHYSADDR(x);
>         }
>
> -       if (!config_enabled(CONFIG_EVA)) {
> +       if (!IS_ENABLED(CONFIG_EVA)) {
>                 /*
>                  * We're using the standard MIPS32 legacy memory map, ie.
>                  * the address x is going to be in kseg0 or kseg1. We can
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index ba5f456..7f7ba5f2 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -204,11 +204,9 @@ static void __init conmode_default(void)
>  #endif
>                 }
>         } else if (MACHINE_IS_KVM) {
> -               if (sclp.has_vt220 &&
> -                   config_enabled(CONFIG_SCLP_VT220_CONSOLE))
> +               if (sclp.has_vt220 && IS_ENABLED(CONFIG_SCLP_VT220_CONSOLE))
>                         SET_CONSOLE_VT220;
> -               else if (sclp.has_linemode &&
> -                        config_enabled(CONFIG_SCLP_CONSOLE))
> +               else if (sclp.has_linemode && IS_ENABLED(CONFIG_SCLP_CONSOLE))
>                         SET_CONSOLE_SCLP;
>                 else
>                         SET_CONSOLE_HVC;
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index ec8654f..bda8d5e 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -77,7 +77,7 @@ static inline unsigned long get_padding(struct kaslr_memory_region *region)
>   */
>  static inline bool kaslr_memory_enabled(void)
>  {
> -       return kaslr_enabled() && !config_enabled(CONFIG_KASAN);
> +       return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
>
>  /* Initialize base and padding for each memory region randomized with KASLR */
> --
> 1.9.1
>



-- 
Kees Cook
Nexus Security
