Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 13:51:56 +0200 (CEST)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:43718
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994540AbeHTLvvY6d2V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 13:51:51 +0200
Received: by mail-oi0-x244.google.com with SMTP id b15-v6so25216407oib.10
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2018 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bi16MZ4qg0+k2uhcDoe8pnFPQx0rM+NLv6l+djrk2CQ=;
        b=MUUv9u51tOJDVfyCcEbP29T5DrjX5T7BuJE+iSAgvJ1txxKWqJEPeC/5pnr8cB/bpt
         c4Ps3Aq4t1ZXE4lbIUHXbDhfnA9VrE9LDcgJB4QAN21kfZq71DCrQ2tb8TQAhPg2CDvk
         iSlWnKIp9e0gBgO8NPVc66iKvLNNbezmIWzw/mjrLEIRVcYLr0rDFuEIHl3O8xcaKCDE
         AoSoUaVFEaUZpnybjWpc7pDwo2S0QnevpF5j1meU6hppIBjKsne4LD8ci6bwx2hfXUMj
         MbLYPMYP4hNItVsODdhjDtH7e4AquMcQouik4MYJwjh+JLfqSKmvHW7SoCrJATzA5UMc
         N1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bi16MZ4qg0+k2uhcDoe8pnFPQx0rM+NLv6l+djrk2CQ=;
        b=fqpdYXf6ytPkr1TlBHjRJj2FBtje0R0ScTgooMTunTKSzlrjNLoXNxlqYhoNYK9kQV
         SFHWKfhYzq4dM0kNcN/DTSpN9GDKvOpCLc2i7vi4BVwJOMiwinhkxDYFW5gp+CPt7gSn
         PKOjU2Kj1oyrAyUHqF8esyk/OKlvlAqHs5vqVHs+L0DIc1Z/qmRXaO0DgSfxV2YRiX3e
         0ySoayp4D7Qe+Lgp1WYHL3CInZkcH8DA2CmPUafjUShoDr3Mdbcbyd5wW7RJqPqF8o6L
         CdmLyADPKiOMqSJlMpGST97iq4kLCCB9FaaTVsbC8ocgBZzlBISw8d7qgGjrlakbzenj
         a89w==
X-Gm-Message-State: AOUpUlGPwlZhSX2vf/oWJcinPmJm1si9jY6R8c850Rm931nTtw8UZLFw
        hNdtS0P8p/aEszzak+4XMyCtZq4ZQm+7rsPy2jU=
X-Google-Smtp-Source: AA+uWPwbMQTbs1IVCl1ogXRRdBFCWul2hjZCEchOfqeEPSOtKHFEdEXnxV1Y+FBsFtYTtCvGMCHoq5/Zu4Bqx6X/Tjc=
X-Received: by 2002:aca:c7c2:: with SMTP id x185-v6mr12655176oif.43.1534765904799;
 Mon, 20 Aug 2018 04:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <1983860.23LM468bU3@loki> <7994529.fS1YjVU6T6@loki>
In-Reply-To: <7994529.fS1YjVU6T6@loki>
From:   Mathieu Malaterre <mathieu.malaterre@gmail.com>
Date:   Mon, 20 Aug 2018 13:51:31 +0200
Message-ID: <CA+7wUswmW+ikFFmEDETgiBed1HzwZvuO7axqZ7W_e+XyEtr=xA@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: Fix memory reservation in bootmem_init for
 certain non-usermem setups
To:     dev-NTEO@vplace.de
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.malaterre@gmail.com
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

On Mon, Aug 20, 2018 at 1:10 PM Tobias Wolf <dev-NTEO@vplace.de> wrote:
>
> Commit 67a3ba25aa95 ("MIPS: Fix incorrect mem=X@Y handling") introduced a new
> issue for rt288x where "PHYS_OFFSET" is 0x0 but the calculated "ramstart" is
> not. As the prerequisite of custom memory map has been removed, this results
> in the full memory range of 0x0 - 0x8000000 to be marked as reserved for this
> platform.
>
> This patch adds the originally intended prerequisite again.
>
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>

You are missing the Fixes: line

Ref:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

You could use 67a3ba25aa95 as an example.


> ---
>  arch/mips/kernel/setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 563188ac6fa2..c3ca55128926 100644
>
> v2: Correctly compare that usermem is not null.
> v3: Added/changed position of changelog and fixed sender address.
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -371,6 +371,8 @@ static unsigned long __init bootmap_bytes(unsigned long
> pages)
>         return ALIGN(bytes, sizeof(long));
>  }
>
> +static int usermem __initdata;
> +
>  static void __init bootmem_init(void)
>  {
>         unsigned long reserved_end;
> @@ -444,7 +446,7 @@ static void __init bootmem_init(void)
>         /*
>          * Reserve any memory between the start of RAM and PHYS_OFFSET
>          */
> -       if (ramstart > PHYS_OFFSET)
> +       if (usermem && ramstart > PHYS_OFFSET)
>                 add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
>                                   BOOT_MEM_RESERVED);
>
> @@ -654,8 +656,6 @@ static void __init bootmem_init(void)
>   * initialization hook for anything else was introduced.
>   */
>
> -static int usermem __initdata;
> -
>  static int __init early_parse_mem(char *p)
>  {
>         phys_addr_t start, size;
>
>
>
>


-- 
Mathieu
