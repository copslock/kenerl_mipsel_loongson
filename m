Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2018 09:56:08 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:36286
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbeCMI4BaUAYc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2018 09:56:01 +0100
Received: by mail-io0-x241.google.com with SMTP id e30so14835791ioc.3;
        Tue, 13 Mar 2018 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=O77kUL2a+AMdQ7TlSitH2uSivsuI8670QlwCwdaFWts=;
        b=ZbxYNDyxi60X8phLTL0K51wyg5NxLmpen8qnwmnStbf69AcSgg1dP27uQjUmNRGQ2n
         H7UMgjSuwFw2lHxZDT8aPUOyi7Y2p8NdNxznd8ltNKADWaW0LlTqeoXuyFz/JfDmTA0l
         pk6mXt73QpqQbm2rarrn/rr+Q9pu72um4qbkc9Tds/aoIdnslGmXLeTIwI7XgmOhctDY
         CuWYOXVnRCLB4ujSWmHbHnjG2zJWcOiTzufWqBYfo8mHeSePyKMtXMb/371PdZXO5f93
         ASNrhemrhJbOfL7pTR8Ja0q35sv7hp1m3og/u8OadXwWfIge+p1ApS+EwgHIlQZ5PlDi
         /hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=O77kUL2a+AMdQ7TlSitH2uSivsuI8670QlwCwdaFWts=;
        b=dTCjR+k2ekoGcLzFKUpIUnqCI8GwM6mem7owb67rzJWbXZJPJh+Nl9GjU6Lp/E3vW+
         E3lqcRn1ICmBiUVe3ft90R38ZSoUXHWrVgQ/g6/3g9pt8Kh7N3d+Lyw+xUDof7sPFuEr
         qXxBm9sicJsksl5IEK/iPE3HdtYID0kiE1iD+0tb0+icwtPu+8j+clRlBLcWJEu/N2iB
         4OzYf0CHbPeUmKt6+L8I8ah7eVduJR10t/iApsxHGDuqohyjFzqzQvk+6dlN4KwfJkHe
         mJA851rECPl0wlXa2bbSqQ+a+5gfe/gRgbstal8q+Fl44BGFtoQmetEkn8azaAsTghYh
         WwMA==
X-Gm-Message-State: AElRT7HMBxoaNUFYNgpL11Ax5Hnro5M2334YWYhTtSdBvwAOTDLafwa2
        bgXIt6BkuQOEyL6tyYEXznTJ1LqpsELBLGmOoi0=
X-Google-Smtp-Source: AG47ELstT6TZ9+89Yl0XcGz8yZQzqzoRynkVzgusdjycDhKbPQ//C1a6iSyvrJNDzsbjkoJKiJX8lQPWLzgu/AylxIs=
X-Received: by 10.107.161.200 with SMTP id k191mr11368539ioe.270.1520931355013;
 Tue, 13 Mar 2018 01:55:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.187.195 with HTTP; Tue, 13 Mar 2018 01:55:53 -0700 (PDT)
In-Reply-To: <1520820258-19225-1-git-send-email-chenhc@lemote.com>
References: <1520820258-19225-1-git-send-email-chenhc@lemote.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 13 Mar 2018 16:55:53 +0800
X-Google-Sender-Auth: CwX3XcGfYV0mAA9-6WR75NC1Lq4
Message-ID: <CAAhV-H4zFAMjg9W2f1VfYrgLnDfNDPaUHUechGDT+v3o_8WNTg@mail.gmail.com>
Subject: Re: [PATCH V2] ZBOOT: fix stack protector in compressed boot phase
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Yoshinori, Rich and SuperH developers,

I'm not familiar with SuperH assembly, but SuperH has the same bug
obviously. Could you please fix that?

Huacai

On Mon, Mar 12, 2018 at 10:04 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
>
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
>
> V2: Fix build on ARM.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/arm/boot/compressed/head.S        | 4 ++++
>  arch/arm/boot/compressed/misc.c        | 7 -------
>  arch/mips/boot/compressed/decompress.c | 7 -------
>  arch/mips/boot/compressed/head.S       | 4 ++++
>  arch/sh/boot/compressed/head_32.S      | 4 ++++
>  arch/sh/boot/compressed/head_64.S      | 4 ++++
>  arch/sh/boot/compressed/misc.c         | 7 -------
>  7 files changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 45c8823..bae1fc6 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -547,6 +547,10 @@ not_relocated:     mov     r0, #0
>                 bic     r4, r4, #1
>                 blne    cache_on
>
> +               ldr     r0, =__stack_chk_guard
> +               ldr     r1, =0x000a0dff
> +               str     r1, [r0]
> +
>  /*
>   * The C runtime environment should now be setup sufficiently.
>   * Set up some pointers, and start decompressing.
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 16a8a80..e518ef5 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -130,11 +130,6 @@ asmlinkage void __div0(void)
>
>  unsigned long __stack_chk_guard;
>
> -void __stack_chk_guard_setup(void)
> -{
> -       __stack_chk_guard = 0x000a0dff;
> -}
> -
>  void __stack_chk_fail(void)
>  {
>         error("stack-protector: Kernel stack is corrupted\n");
> @@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
>  {
>         int ret;
>
> -       __stack_chk_guard_setup();
> -
>         output_data             = (unsigned char *)output_start;
>         free_mem_ptr            = free_mem_ptr_p;
>         free_mem_end_ptr        = free_mem_ptr_end_p;
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index fdf99e9..5ba431c 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -78,11 +78,6 @@ void error(char *x)
>
>  unsigned long __stack_chk_guard;
>
> -void __stack_chk_guard_setup(void)
> -{
> -       __stack_chk_guard = 0x000a0dff;
> -}
> -
>  void __stack_chk_fail(void)
>  {
>         error("stack-protector: Kernel stack is corrupted\n");
> @@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>  {
>         unsigned long zimage_start, zimage_size;
>
> -       __stack_chk_guard_setup();
> -
>         zimage_start = (unsigned long)(&__image_begin);
>         zimage_size = (unsigned long)(&__image_end) -
>             (unsigned long)(&__image_begin);
> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index 409cb48..00d0ee0 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -32,6 +32,10 @@ start:
>         bne     a2, a0, 1b
>          addiu  a0, a0, 4
>
> +       PTR_LA  a0, __stack_chk_guard
> +       PTR_LI  a1, 0x000a0dff
> +       sw      a1, 0(a0)
> +
>         PTR_LA  a0, (.heap)          /* heap address */
>         PTR_LA  sp, (.stack + 8192)  /* stack address */
>
> diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
> index 7bb1681..a3fdb05 100644
> --- a/arch/sh/boot/compressed/head_32.S
> +++ b/arch/sh/boot/compressed/head_32.S
> @@ -76,6 +76,10 @@ l1:
>         mov.l   init_stack_addr, r0
>         mov.l   @r0, r15
>
> +       mov.l   __stack_chk_guard, r0
> +       mov     #0x000a0dff, r1
> +       mov.l   r1, @r0
> +
>         /* Decompress the kernel */
>         mov.l   decompress_kernel_addr, r0
>         jsr     @r0
> diff --git a/arch/sh/boot/compressed/head_64.S b/arch/sh/boot/compressed/head_64.S
> index 9993113..8b4d540 100644
> --- a/arch/sh/boot/compressed/head_64.S
> +++ b/arch/sh/boot/compressed/head_64.S
> @@ -132,6 +132,10 @@ startup:
>         addi    r22, 4, r22
>         bne     r22, r23, tr1
>
> +       movi    datalabel __stack_chk_guard, r0
> +       movi    0x000a0dff, r1
> +       st.l    r0, 0, r1
> +
>         /*
>          * Decompress the kernel.
>          */
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
> index 627ce8e..fe4c079 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -106,11 +106,6 @@ static void error(char *x)
>
>  unsigned long __stack_chk_guard;
>
> -void __stack_chk_guard_setup(void)
> -{
> -       __stack_chk_guard = 0x000a0dff;
> -}
> -
>  void __stack_chk_fail(void)
>  {
>         error("stack-protector: Kernel stack is corrupted\n");
> @@ -130,8 +125,6 @@ void decompress_kernel(void)
>  {
>         unsigned long output_addr;
>
> -       __stack_chk_guard_setup();
> -
>  #ifdef CONFIG_SUPERH64
>         output_addr = (CONFIG_MEMORY_START + 0x2000);
>  #else
> --
> 2.7.0
>
