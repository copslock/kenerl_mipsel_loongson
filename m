Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 01:55:10 +0200 (CEST)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44540 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860024AbaFXXzHGqpN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 01:55:07 +0200
Received: by mail-ob0-f173.google.com with SMTP id va2so1241468obc.32
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YekSIZRQ3QnkLAwIJxqv05Gz8Gv46xg6ugZ7lSl0fSU=;
        b=bbArQaaEqDg35DMi3AbXkyo31vKOcwvJhjzZRrmbiDVYb5X/dLkFlJ0afTmvm+IqvB
         JjQB29g0lMV8UppJzYjjp0qs2WcNXY4kpn63ZIdg7bTJy+vI6jOcQjGWWTqOjWSAPSun
         GQAWn9uGsJkdgvKciFXOYhS3chZMtq+4zue07kMkX5ksgkLvyCiHTmuKz5oG3uwV63oX
         JrSwG6EhTQonlECGpzXosf0f+GFRo0K2EeiEfIpKFfPtQutKeRXJ+qWSNVfp0sa1Frli
         Y35pSWEv6bMRArfYzdqSIcCR650cfwEWCzu+II9oU21lG0G05znZDtZzitxDnHHdUaV9
         Lfsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YekSIZRQ3QnkLAwIJxqv05Gz8Gv46xg6ugZ7lSl0fSU=;
        b=cu1UpqxxbEOUc6yVqo6NxbhDmF/T71wfuHX5/AuPS3FPZMmRDHNlC5BqrT8kUTMwOC
         PSVMIybl3GEREc6W3bDrGKOsFU/Ird64LO+lut1nAxvHeZDhOBppNxZjIXgnxW860CY1
         vzRFCEy6AD++Spw2V/Z/DjqT0Ld+G6VpdemiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YekSIZRQ3QnkLAwIJxqv05Gz8Gv46xg6ugZ7lSl0fSU=;
        b=Wz3vy9Q7F5YOHvCzRi2G5T16bV4IuE7h77iJN7vJUej5gasFGfh8F6kJyae/WK9+aw
         IlIM/wv4BnakJ9qyVtCgXgirNcWLVDz4yJbZEy9ThupoEPSJuzLpd4ivX92zVOxzQWWl
         Sb0W1HHAyK9969+aJlH2QzexoRPJM6b19spV8aegFZUGUn9H4xE+x1ws1Udh4UDhbfIv
         jksFC95ydLCMU0G2IYxVNGuUgvjNAJGvUCWOJP/NY3tLECfft3alZyL/W6BHxBJUyX3U
         WMXGWWjuCtut8arSlEPnlmLAXn7gvEj3nNQDrD0VJmE1Kwo0pF1bGA4EU7CWZ1CSCeU2
         wE6A==
X-Gm-Message-State: ALoCoQlJ3VB5CnRPt7nUKwVh5DfZdjDTBdXu4uS86k/I6sN8thTzl4PxfTKo6u8HABLYw7dtGh7s
MIME-Version: 1.0
X-Received: by 10.182.33.106 with SMTP id q10mr4405841obi.19.1403654100693;
 Tue, 24 Jun 2014 16:55:00 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 16:55:00 -0700 (PDT)
In-Reply-To: <1403650817-21641-1-git-send-email-benchan@chromium.org>
References: <1403650817-21641-1-git-send-email-benchan@chromium.org>
Date:   Tue, 24 Jun 2014 16:55:00 -0700
X-Google-Sender-Auth: Ew9HiDbn-tloOk_N5jrjQN8AufI
Message-ID: <CAGXu5j+gntXQQdC4aOiH9mOTv5rEqXqbQ1rt2XN_BkWznLR=7A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ZBOOT: implement stack protector in compressed boot phase
From:   Kees Cook <keescook@chromium.org>
To:     Ben Chan <benchan@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        Olof Johansson <olofj@chromium.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40786
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

On Tue, Jun 24, 2014 at 4:00 PM, Ben Chan <benchan@chromium.org> wrote:
> This patch implements the stack protector code in MIPS compressed boot
> phase based on the same code added to arm in commit
> 8779657d29c0ebcc0c94ede4df2f497baf1b563f "stackprotector: Introduce
> CONFIG_CC_STACKPROTECTOR_STRONG" by Kees Cook <keescook@chromium.org>
>
> Signed-off-by: Ben Chan <benchan@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Olof Johansson <olofj@chromium.org>
> ---
>  arch/mips/boot/compressed/decompress.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index c00c4dd..b49c7ad 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -67,10 +67,24 @@ void error(char *x)
>  #include "../../../../lib/decompress_unxz.c"
>  #endif
>
> +unsigned long __stack_chk_guard;
> +
> +void __stack_chk_guard_setup(void)
> +{
> +       __stack_chk_guard = 0x000a0dff;
> +}
> +
> +void __stack_chk_fail(void)
> +{
> +       error("stack-protector: Kernel stack is corrupted\n");
> +}
> +
>  void decompress_kernel(unsigned long boot_heap_start)
>  {
>         unsigned long zimage_start, zimage_size;
>
> +       __stack_chk_guard_setup();
> +
>         zimage_start = (unsigned long)(&__image_begin);
>         zimage_size = (unsigned long)(&__image_end) -
>             (unsigned long)(&__image_begin);
> --
> 2.0.0.526.g5318336

Yup, that looks correct to me. As in the ARM case, gathering entropy
for the canary here is overkill, so this is sufficient to build and
provide basic canary support in the decompression phase of boot.

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
