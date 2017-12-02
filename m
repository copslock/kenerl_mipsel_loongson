Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 22:18:47 +0100 (CET)
Received: from mail-vk0-x243.google.com ([IPv6:2607:f8b0:400c:c05::243]:40585
        "EHLO mail-vk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990437AbdLBVShqZ3Ck (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Dec 2017 22:18:37 +0100
Received: by mail-vk0-x243.google.com with SMTP id w190so7500603vkd.7;
        Sat, 02 Dec 2017 13:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OU8Vb5ige5dLX5e97xwKOQFngYHoyehCkgNAzDoSIOc=;
        b=sHcCy3oiWMEaQUqDxrJUxyvv35LmEQxJ044Fo1fX0LjR2GQ4SBq8lQxx0BtOteWksd
         Bx6vf/2c6QUDXtkpAUYNIiMRNVgMKzw65VN8NYNMPuglyj5+Iw217o4u2UwXTX8mLT+i
         d+oWEeaaO2HON8yljtCTUGOXW4EZlWOgUrdeV5X/dwISiEaNr0q+QMKKQCqO0VfMLMnY
         RyU5cRtoVFdwqPHbxDizvK9qmq9Nq5/CFAg/FLV/Zg6eYw5G2CMfrDvvp/uJDVasq+84
         nvLIrtlkA/9EngNkw3uEWrRbcyy3OP8q4ND9h1lL6o/EhqsvTucuvNgE/7XGPp7jRs4O
         zcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OU8Vb5ige5dLX5e97xwKOQFngYHoyehCkgNAzDoSIOc=;
        b=Oo4eXLxgiwlQ50b0Q3IYHHOts8vuKBEpJmfoI8aTjWcgg0QXHixm7IV7eGyjyUFR97
         fOQzhh7gpGcuYVx7G7Qd1OY5ayoIiX5P7xawsaxgEOnHTrlSq/Gzeu00Dm32aSuHFkDu
         atx6wfhw/8MF/RCRVIwr9w5jyqbI7I2Y0G0ei8kAYPHEMX0qvCAlgz3QCxbd3GURdrxj
         56ofUzSVuG2X8hPZfd8qCsn83AT8Dv6ZHm1oNiGO+WaRZwWJ7h0/8OHIU5ymJPcB3CXR
         3ILFs5KJhioZiP0CEGEhUpvfrSut414YXtCywm5WbuHSK9xLbHeXmSLS8HwXwheOnw2f
         jQvA==
X-Gm-Message-State: AKGB3mJjOoX5Jt3vzfYIaPOmT5hyKxA6bwznZrNPZypV52ykbxyLMUM6
        XMNEhgGzzLCNoBkR1jh0p715AEbfQCYFFxd3HXw=
X-Google-Smtp-Source: AGs4zMYqeQcgnavmwLUw4bbnIqCgdMWo9a9up4PSysFAoA0DshkxrsxHTAY2/9hEoUv4ROITySMsv6detn0W630cfhU=
X-Received: by 10.31.139.135 with SMTP id n129mr7355404vkd.86.1512249511251;
 Sat, 02 Dec 2017 13:18:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.114 with HTTP; Sat, 2 Dec 2017 13:18:10 -0800 (PST)
In-Reply-To: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1504609608-7694-1-git-send-email-marcin.nowakowski@imgtec.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Sat, 2 Dec 2017 22:18:10 +0100
X-Google-Sender-Auth: lt_MaZ6UpGdY3EuDfPRN7vZKquw
Message-ID: <CA+7wUswXEPggGE0RLZ+=qdXd7xsHrSHAMHK47nx2RAtZ_pb-uw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix incorrect mem=X@Y handling
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61279
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

On Tue, Sep 5, 2017 at 1:06 PM, Marcin Nowakowski
<marcin.nowakowski@imgtec.com> wrote:
> Change 73fbc1eba7ff added a fix to ensure that the memory range between
> PHYS_OFFSET and low memory address specified by mem= cmdline argument is
> not later processed by free_all_bootmem.
> This change was incorrect for systems where the commandline specifies
> more than 1 mem argument, as it will cause all memory between
> PHYS_OFFSET and each of the memory offsets to be marked as reserved,
> which results in parts of the RAM marked as reserved (Creator CI20's
> u-boot has a default commandline argument 'mem=256M@0x0
> mem=768M@0x30000000').
>
> Change the behaviour to ensure that only the range between PHYS_OFFSET
> and the lowest start address of the memories is marked as protected.
>
> This change also ensures that the range is marked protected even if it's
> only defined through the devicetree and not only via commandline
> arguments.
>
> Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/kernel/setup.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index fe39397..a1c39ec 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -374,6 +374,7 @@ static void __init bootmem_init(void)
>         unsigned long reserved_end;
>         unsigned long mapstart = ~0UL;
>         unsigned long bootmap_size;
> +       phys_addr_t ramstart = ~0UL;
>         bool bootmap_valid = false;
>         int i;
>
> @@ -394,6 +395,21 @@ static void __init bootmem_init(void)
>         max_low_pfn = 0;
>
>         /*
> +        * Reserve any memory between the start of RAM and PHYS_OFFSET
> +        */
> +       for (i = 0; i < boot_mem_map.nr_map; i++) {
> +               if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
> +                       continue;
> +
> +               ramstart = min(ramstart, boot_mem_map.map[i].addr);
> +       }
> +
> +       if (ramstart > PHYS_OFFSET)
> +               add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
> +                                 BOOT_MEM_RESERVED);
> +
> +
> +       /*
>          * Find the highest page frame number we have available.
>          */
>         for (i = 0; i < boot_mem_map.nr_map; i++) {
> @@ -663,9 +679,6 @@ static int __init early_parse_mem(char *p)
>
>         add_memory_region(start, size, BOOT_MEM_RAM);
>
> -       if (start && start > PHYS_OFFSET)
> -               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
> -                               BOOT_MEM_RESERVED);
>         return 0;
>  }
>  early_param("mem", early_parse_mem);
> --
> 2.7.4
>
>

Teested-by: Mathieu Malaterre <malat@debian.org>

Would be nice to have it upstream at some point...

Thanks
