Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2018 08:48:02 +0100 (CET)
Received: from mail-qk1-x741.google.com ([IPv6:2607:f8b0:4864:20::741]:44681
        "EHLO mail-qk1-x741.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990895AbeKRHr5zbdOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Nov 2018 08:47:57 +0100
Received: by mail-qk1-x741.google.com with SMTP id n12so44095462qkh.11;
        Sat, 17 Nov 2018 23:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9jUmSTLaGX0A7LyE7aM7FouS47os25e/5PoGajRO0w=;
        b=jAN2iaJegYuO7y2ZKWZRRtWbl2StGyxw+Y3Ox6vHmmX1u2mpwTX33rfiW8Rnh0yT8U
         VVfx/9FWFpzETBNWLWvFFlz9/UMtPz62DIHQFevJZPuOsK3mGmkfS/8yBtfOWU6MLJQr
         ZPiSKBIMvUpuXc09hQBvCHHuNS5su52O3gDhV+N6L343+bjvYGBZlmwMcXyd4MqquJot
         xZAcShyQkOZyMJx1uPOyYChnnnG7qrY88Zhd8tL4i8+2aXc5SQJFLGJBAceou0Je/K7z
         vm3sHwjFX7SPavSdCrnjDcpaKyNhgIjiD+TnJJ7ri9uZ6eObpw/b+q63HlCLrWBxLcye
         Y7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9jUmSTLaGX0A7LyE7aM7FouS47os25e/5PoGajRO0w=;
        b=On/GeaW5PpeKstl5C53Aimr3sMQAFGee3aon3qRcR36pgGEmkkhUaVBs+jHHKPn2Uo
         SqP22mDQOQYtPf2Gc/KP/WKqWyWVhq4g026WvS0Y4jeFEFcN0p+RQXeVKBWyl0zNGeGH
         5S89qW8WadN6PKW69ABQu8gGFYp//9reKV2/LRxRJOeXkt2Zp4g3zfpVj6AqPy9a3ngM
         YqsPMWMjSn1i7R6VJZ2m3rfeS8MNpq3zhaBu1cZOwror2T4cw/gcjezJtO5XkK2uwXF2
         8VWEtOchMiQTqmsKrf0xa4fiGoOrjlpqFBXIGVAULuvB+0G9QmGZ/eaae4AQrd1csqJl
         BAcw==
X-Gm-Message-State: AGRZ1gKiFMGnHtIvrwWj+uXEDcGtu7fsmQ42LqnCTAKnuhTRLyDwXWe+
        Rbu4dkx125U4cVQ8OEKNLdB1zFc/foZ5hNyLXxk=
X-Google-Smtp-Source: AJdET5d0B2HeX5Nvr+wGZPdX7m6Rl24zd7KaVOpOiDtE/8uwUkfLAjvZ94pD068kW1H4Q3oUAYfLsNkd4p788UzoOuk=
X-Received: by 2002:a0c:bf0d:: with SMTP id m13mr16906324qvi.139.1542527276900;
 Sat, 17 Nov 2018 23:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org> <20181117185715.25198-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20181117185715.25198-3-ard.biesheuvel@linaro.org>
From:   Y Song <ys114321@gmail.com>
Date:   Sun, 18 Nov 2018 07:47:27 +0000
Message-ID: <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
To:     ard.biesheuvel@linaro.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        rick.p.edgecombe@intel.com, eric.dumazet@gmail.com,
        jannh@google.com, Kees Cook <keescook@chromium.org>,
        jeyu@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ys114321@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ys114321@gmail.com
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

On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> All arch overrides of the __weak bpf_jit_free() amount to the same
> thing: the allocated memory was never mapped read-only, and so
> it does not have to be remapped to read-write before being freed.
>
> So in preparation of permitting arches to serve allocations for BPF
> JIT programs from other regions than the module region, refactor
> the existing bpf_jit_free() implementations to use the shared code
> where possible, and only specialize the remap and free operations.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/mips/net/bpf_jit.c           |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
>  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
>  kernel/bpf/core.c                 | 15 +++++----------
>  5 files changed, 14 insertions(+), 31 deletions(-)
>
> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> index 1b69897274a1..5696bd7dccc7 100644
> --- a/arch/mips/net/bpf_jit.c
> +++ b/arch/mips/net/bpf_jit.c
> @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>         kfree(ctx.offsets);
>  }
>
> -void bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index a1ea1ea6b40d..5b5ce4a1b44b 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>         return;
>  }
>
> -void bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 84c8f013a6c6..f64f1294bd62 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>         return fp;
>  }
>
> -/* Overriding bpf_jit_free() as we don't set images read-only. */
> -void bpf_jit_free(struct bpf_prog *fp)
> +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> index 01bda6bc9e7f..589950d152cc 100644
> --- a/arch/sparc/net/bpf_jit_comp_32.c
> +++ b/arch/sparc/net/bpf_jit_comp_32.c
> @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
>         return;
>  }
>
> -void bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1a796e0799ec..29f766dac203 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>         return hdr;
>  }
>
> -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       u32 pages = hdr->pages;
> -
> +       bpf_jit_binary_unlock_ro(hdr);
>         module_memfree(hdr);
> -       bpf_jit_uncharge_modmem(pages);
>  }
>
> -/* This symbol is only overridden by archs that have different
> - * requirements than the usual eBPF JITs, f.e. when they only
> - * implement cBPF JIT, do not set images read-only, etc.
> - */

Do you want to move the above comments to
new weak function bpf_jit_binary_free?

> -void __weak bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_free(struct bpf_prog *fp)
>  {
>         if (fp->jited) {
>                 struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
> +               u32 pages = hdr->pages;
>
> -               bpf_jit_binary_unlock_ro(hdr);
>                 bpf_jit_binary_free(hdr);
> +               bpf_jit_uncharge_modmem(pages);
>
>                 WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>         }
> --
> 2.17.1
>
