Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2016 21:00:41 +0100 (CET)
Received: from mail-io0-f181.google.com ([209.85.223.181]:34471 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbcKYUAdgjy4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2016 21:00:33 +0100
Received: by mail-io0-f181.google.com with SMTP id c21so134591218ioj.1
        for <linux-mips@linux-mips.org>; Fri, 25 Nov 2016 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WHOVGmhr88t1wpyXT2SWfBq0T1DyEzS3bONwjNvJRl8=;
        b=kFvAaH6Y3EAEl4Tf1WCSgKcfLYTjrWFYhhPabI7a3V/ARns5L6jSuhSdO7iiTBacln
         8rDWMCSPetGGbCBxFz7/3d/QPfND8fpwWwHfj2b6vTaUILHYcbzWauoSedQwYYIZSblh
         /GBFZTr4068KqusfDEBqYVigq1OZ4J79C8+pjFuD1FBfBn5IkLti/PmHqMAL41tFxOdG
         Heb9BQfF4Wt9KpKfwYp0MuUVTddK0qVffxm1Av3lAbBEoURW9nU9BX+IPdcbHC4m0OdX
         0J6obeIUk36SJMSGTFlI/RnKtDeyG/5oXuqGInmM8f6kmzPmy2mV7c47+g9bahKVvVD5
         b8qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WHOVGmhr88t1wpyXT2SWfBq0T1DyEzS3bONwjNvJRl8=;
        b=Ox0bmRMzi6hz133xItuZNtoZQZdBCy7NuKg8iAprZEyV/8dGn7gv0L77BLDlSq+828
         KhuxMkToIGVhwycrhqZIiipNsDF2sgs34EUPZ7NZDh2mD3chCtGwQEYUneblLrMritFC
         a4dpYD4/K7BPuNq5YAx4sqGSxxZ8zKMNSlpbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WHOVGmhr88t1wpyXT2SWfBq0T1DyEzS3bONwjNvJRl8=;
        b=Y0fQ85eOprYdJn0/nal7m00nOlPRRjQd6MFdlP8/udPIa+kGMUZBB+tTKzgCnfJCH+
         OlyvCuDDq1KyvULOPhqZ3n7MgRyToXTC2t1qyiBwxuI/uy3hm4YJKVZrB64mXlnVCwVz
         ghY/ul9ygicyT/qW6rBa34q2Cm7Utk2Pspjf7r3c7XDgz1n76XKKnqXCojKOM3oPYi55
         QMmJOSlKzxrO/N4Ax0In+o4eKAtAlwkKi4y79NnwzuajMRFm7k2sR+xEnNQBRgnDIcJk
         ANaXumYL3EbgmNpPVOa3T4B2rigfofW1KrQ/tRCAg3CYKeTvizTFPd5+a8d+TcxwF5tb
         ieBA==
X-Gm-Message-State: AKaTC01xIR4y/cOkzBRFYivbHZMr/mOCCf7u0Fokuc47brL6Q3Z3xAbWGXjnnu5It7bQit2t/zMF1r+qfqemSRSo
X-Received: by 10.36.28.2 with SMTP id c2mr8537241itc.105.1480104027470; Fri,
 25 Nov 2016 12:00:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.161.201 with HTTP; Fri, 25 Nov 2016 12:00:26 -0800 (PST)
In-Reply-To: <1480008765-3876-1-git-send-email-matt.redfearn@imgtec.com>
References: <1480008765-3876-1-git-send-email-matt.redfearn@imgtec.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 25 Nov 2016 12:00:26 -0800
X-Google-Sender-Auth: -2vu7ubIZuPnFDpqHyB3pzZPNts
Message-ID: <CAGXu5jLT-V3+3_KSAfxbN3yY22xRh3tvs1wpL+mwk1En8MC6Bg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add support for ARCH_MMAP_RND_{COMPAT_}BITS
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Cashman <dcashman@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55896
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

On Thu, Nov 24, 2016 at 9:32 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> arch_mmap_rnd() uses hard-coded limits of 16MB for the randomisation
> of mmap within 32bit processes and 256MB in 64bit processes. Since v4.4
> other arches support tuning this value in /proc/sys/vm/mmap_rnd_bits.
> Add support for this to MIPS.
>
> Set the minimum(default) number of bits randomisation for 32bit to 8 -
> which with 4k pagesize is unchanged from the current 16MB total
> randomness. The minimum(default) for 64bit is 12bits, again with 4k
> pagesize this is the same as the current 256MB.
>
> This patch is necessary for MIPS32 to pass the Android CTS tests, with
> the number of random bits set to 15.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>
>  arch/mips/Kconfig   | 16 ++++++++++++++++
>  arch/mips/mm/mmap.c | 10 +++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde43d34..d72cf6129b2c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -13,6 +13,8 @@ config MIPS
>         select HAVE_PERF_EVENTS
>         select PERF_USE_VMALLOC
>         select HAVE_ARCH_KGDB
> +       select HAVE_ARCH_MMAP_RND_BITS if MMU
> +       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_CBPF_JIT if !CPU_MICROMIPS
> @@ -3073,6 +3075,20 @@ config MMU
>         bool
>         default y
>
> +config ARCH_MMAP_RND_BITS_MIN
> +       default 12 if 64BIT
> +       default 8
> +
> +config ARCH_MMAP_RND_BITS_MAX
> +       default 18 if 64BIT
> +       default 15
> +
> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
> +       default 8
> +
> +config ARCH_MMAP_RND_COMPAT_BITS_MAX
> +       default 15
> +
>  config I8253
>         bool
>         select CLKSRC_I8253
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index d08ea3ff0f53..d6d92c02308d 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -146,14 +146,14 @@ unsigned long arch_mmap_rnd(void)
>  {
>         unsigned long rnd;
>
> -       rnd = get_random_long();
> -       rnd <<= PAGE_SHIFT;
> +#ifdef CONFIG_COMPAT
>         if (TASK_IS_32BIT_ADDR)
> -               rnd &= 0xfffffful;
> +               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
>         else
> -               rnd &= 0xffffffful;
> +#endif /* CONFIG_COMPAT */
> +               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
>
> -       return rnd;
> +       return rnd << PAGE_SHIFT;
>  }
>
>  void arch_pick_mmap_layout(struct mm_struct *mm)
> --
> 2.7.4
>

Excellent!

Reviewed-by: Kees Cook <keescook@chromium.org>

Out of curiosity, how were the maxs of 15 and 18 chosen?

-Kees

-- 
Kees Cook
Nexus Security
