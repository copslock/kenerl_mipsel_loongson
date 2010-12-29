Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 06:31:29 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:34406 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab0L2FbZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Dec 2010 06:31:25 +0100
Received: by wwi17 with SMTP id 17so9888135wwi.24
        for <multiple recipients>; Tue, 28 Dec 2010 21:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xMaB7dJ8cjxzpBy5KEdu9WOuoxq1qNPiKsZsA43YXZQ=;
        b=reh/CU+Hblzn1Zx08OaBkB6Gr+NfV4bIG0GVMv1cUpOg/aIqbwPO8zRLHdnBI77b4T
         4oLw5DfDBPf2KsoDXSsUF7Wg4LvQ5eKYbA0/sO6rZDHCVBMW/oYki58M/x9atMshgxVV
         Fbcg/mp5rL+Py/RSexwfYn4ErPOMHtIP0ic4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b4P5un6+slnAxEV/ikCe7At4ZTT7Jv7DnHp+xcALcq/L/EhsYtCbL/oKeAJ9k4NgQw
         859dq2y6/uUV24YkxT99POs6xc01tFMGpQ1tGgNqtXupt1tiEqRygaQE8k16/m7mXnPD
         +q6EtidjgVVjUNQpA7yK6H363TSLewG71BHWo=
MIME-Version: 1.0
Received: by 10.216.82.9 with SMTP id n9mr15413428wee.35.1293600680309; Tue,
 28 Dec 2010 21:31:20 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Tue, 28 Dec 2010 21:31:20 -0800 (PST)
In-Reply-To: <1293289909-7635-1-git-send-email-wuzhangjin@gmail.com>
References: <1293289909-7635-1-git-send-email-wuzhangjin@gmail.com>
Date:   Wed, 29 Dec 2010 13:31:20 +0800
Message-ID: <AANLkTim0iWCSHqJhArYnwvtJ-0QSdwQSjVRQfxsMwoD3@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Reduce kernel image size for !CONFIG_DEBUG_ZBOOT
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Dec 25, 2010 at 11:11 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> !CONFIG_DEBUG_ZBOOT doesn't need puts() and puthex(), remove them and
> the according strings for !CONFIG_DEBUG_ZBOOT, as a result, it saves

         ^^^^^ --> corresponding

> about 1280 bytes.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/boot/compressed/Makefile     |    3 ++-
>  arch/mips/boot/compressed/decompress.c |    5 +++++
>  2 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 5042d51..aab6d7f 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -28,9 +28,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>  targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
>
>  # decompressor objects (linked with vmlinuz)
> -vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
> +vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o
>
>  ifdef CONFIG_DEBUG_ZBOOT
> +vmlinuzobjs-y += $(obj)/dbg.o
>  vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
>  vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)                += $(obj)/uart-alchemy.o
>  endif
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index 5cad0fa..c9cbff5 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -27,8 +27,13 @@ unsigned long free_mem_end_ptr;
>  extern unsigned char __image_begin, __image_end;
>
>  /* debug interfaces  */
> +#ifdef CONFIG_DEBUG_ZBOOT
>  extern void puts(const char *s);
>  extern void puthex(unsigned long long val);
> +#else
> +#define puts(s) do {} while (0)
> +#define puthex(val) do {} while (0)
> +#endif
>
>  void error(char *x)
>  {
> --
> 1.7.1
>
>
