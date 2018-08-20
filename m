Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 12:46:16 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39271 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbeHTKqKMT6v2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 12:46:10 +0200
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so24981730oib.6;
        Mon, 20 Aug 2018 03:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqd42STb/FlYdE/cqipgmH8KfOiHICyq25R7eQ2O8xM=;
        b=BV0vdTA9oJTArVCeK9aUbvqMCWkdC6ZjUrPSJE8z/p3ea/h/P2T9jpQIiKnTFNLC0Y
         OTBZgEx+Hi5eC8leyzBjvAnJF0jg/dYd0nTiT4AI7VE3fRBYY4mr5NMijVvaroQNe4qI
         9TaDCAUmUc4Y4RWYv9uWQHkRJVYCya9hF4fIvBN7LG1oh0WwLrYrVoMsLoCc1SFrEErI
         EjLaoa550vquhs2CyueUSqupfrg7yWL93mDpifQQ67ZF3ENXtctOGA4dsFWBOpkofsU3
         L9pL/yBKtOudCwUd5KdZTJVXrkVnYYVg4YtfJT8A/f5tqfe6huTZmtZMrsA5DHticfGF
         UUeA==
X-Gm-Message-State: AOUpUlF25OvkZ2aBVdpSe5icbkxVer0zFiPEI+ELi4jh8MJ7pIpZLGpG
        LyG8QyNtx+rCV7MMt8GRVATMEp3ji+W1E0pgfkg=
X-Google-Smtp-Source: AA+uWPzSg43GOzkiOWCQCMNvDTao9ejSFGHL//f1L/MUI43ZYdEl+7zPHwVbAaMymWpfEzKlJst0b7H36OkULw9QT48=
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr14379837oif.104.1534761963934;
 Mon, 20 Aug 2018 03:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <1983860.23LM468bU3@loki> <1609732.rDWVQJrTVM@loki>
In-Reply-To: <1609732.rDWVQJrTVM@loki>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 20 Aug 2018 12:45:50 +0200
Message-ID: <CA+7wUswnm74o1ip_b0mTDimMgrm1dMC0zqjqki7_sBrDg7r=qg@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Fix memory reservation in bootmem_init for
 certain non-usermem setups
To:     t.wolf@vplace.de
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Mon, Aug 20, 2018 at 12:06 PM Tobias Wolf <t.wolf@vplace.de> wrote:
>
> Commit 67a3ba25aa95 ("MIPS: Fix incorrect mem=X@Y handling") introduced a new
> issue for rt288x where "PHYS_OFFSET" is 0x0 but the calculated "ramstart" is
> not. As the prerequisite of custom memory map has been removed, this results
> in the full memory range of 0x0 - 0x8000000 to be marked as reserved for this
> platform.

Looks good to me.

Acked-by: Mathieu Malaterre <malat@debian.org>

> This patch adds the originally intended prerequisite again.
>
> v2: Correctly compare that usermem is not null.

Could you please CC: stable@vger.kernel.org and add the missing #version

> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>

nit:
One of the MIPS maintainer may complain your From: is different from
your Signed-off-by:

> ---
>  arch/mips/kernel/setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 563188ac6fa2..c3ca55128926 100644
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
