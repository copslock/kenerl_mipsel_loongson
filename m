Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 02:39:28 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37161 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011607AbaJ2Bj0e1qEu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 02:39:26 +0100
Received: by mail-ig0-f173.google.com with SMTP id r10so383927igi.6
        for <multiple recipients>; Tue, 28 Oct 2014 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jXqD1hD3Rxok/wfYeEZVLRhqX9WXhXAPuT4WM81Ic94=;
        b=RD3zgZJ1FSmxKTIj56pqdcy6txZIfSxQOlKPHy6rTTfwBDqlyHvlJUKicEhA8/oBC8
         j8iYiex+xiCDCQyCvn1/++jqM8DXxPRMwGuk1S4cWgZ16hOKzgfYlomgC7Chwue77Ghf
         KDQSjaoyIiSp3ilHrW5/BbUEiEaCUtFehh6seUG5g5iPE+mmYjY2QhetuIP0EBoc/KV6
         36vF8+EI24PIoanYT1KPqFC/f0mFSQ76Ch59qKmKgC93mZuVHEX2s6/QTU5e43ZJGgEX
         JeblrUCCap636OnsdfA4dL1mfPKTQ1qDFCslkvWf7AzCXkfnavE4VW8GKjrB/jHnAok9
         a3qw==
MIME-Version: 1.0
X-Received: by 10.42.74.136 with SMTP id w8mr7626257icj.11.1414546760468; Tue,
 28 Oct 2014 18:39:20 -0700 (PDT)
Received: by 10.64.128.167 with HTTP; Tue, 28 Oct 2014 18:39:20 -0700 (PDT)
In-Reply-To: <1414495714-40815-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1414495714-40815-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Date:   Wed, 29 Oct 2014 09:39:20 +0800
Message-ID: <CAAhV-H6Vi2nuqx=MNhEiJH7m=7qafckgDWe0jnBiq5x=BF7QxQ@mail.gmail.com>
Subject: Re: [PATCH] mips: cma: Do not reserve memory if not required
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

I meet the same problem on Loongson-3, and this patch resolve my
problem. Thanks.
Tested-by: Huacai Chen <chenhc@lemote.com>

On Tue, Oct 28, 2014 at 7:28 PM, Zubair Lutfullah Kakakhel
<Zubair.Kakakhel@imgtec.com> wrote:
> Even if CMA is disabled, the for_each_memblock macro expands
> to run reserve_bootmem once. Hence, reserve_bootmem attempts to
> reserve location 0 of size 0.
>
> Add a check to avoid that.
>
> Issue was highlighted during testing with EVA enabled.
> resrve_bootmem used to exit gracefully when passed arguments to
> reserve 0 size location at 0 without EVA.
>
> But with EVA enabled, macros would point to different addresses
> and the code would trigger a BUG.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Tested-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/kernel/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 938f157..eacfd7d 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -683,7 +683,8 @@ static void __init arch_mem_init(char **cmdline_p)
>         dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
>         /* Tell bootmem about cma reserved memblock section */
>         for_each_memblock(reserved, reg)
> -               reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
> +               if (reg->size != 0)
> +                       reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
>  }
>
>  static void __init resource_init(void)
> --
> 1.9.1
>
>
