Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2016 21:57:40 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:44940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992986AbcLVU5cPlDhw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Dec 2016 21:57:32 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 72A17203E9;
        Thu, 22 Dec 2016 20:57:29 +0000 (UTC)
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com [209.85.161.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D19203DC;
        Thu, 22 Dec 2016 20:57:28 +0000 (UTC)
Received: by mail-yw0-f177.google.com with SMTP id v81so18809056ywb.2;
        Thu, 22 Dec 2016 12:57:28 -0800 (PST)
X-Gm-Message-State: AIkVDXK1ahqTMi17t7Vnn1b9Y+Cr3x8VhIg9MlYkfwJp3A1fjFJvwymMsgZmU0jiJwmnLACKrP5PVenA53wk0w==
X-Received: by 10.129.141.82 with SMTP id w18mr6953774ywj.10.1482440247712;
 Thu, 22 Dec 2016 12:57:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.96.86 with HTTP; Thu, 22 Dec 2016 12:57:07 -0800 (PST)
In-Reply-To: <1482113266-13207-2-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com> <1482113266-13207-2-git-send-email-fancer.lancer@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 22 Dec 2016 14:57:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKNZRXzYKVFWRJraEZMvZ0Oj8CBoVFSAy+EWTi5Uavesw@mail.gmail.com>
Message-ID: <CAL_JsqKNZRXzYKVFWRJraEZMvZ0Oj8CBoVFSAy+EWTi5Uavesw@mail.gmail.com>
Subject: Re: [PATCH 01/21] MIPS memblock: Unpin dts memblock sanity check method
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, rabinv@axis.com,
        matt.redfearn@imgtec.com, James Hogan <james.hogan@imgtec.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Sun, Dec 18, 2016 at 8:07 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> It's necessary to check whether retrieved from dts memory regions
> fits to page alignment and limits restrictions. Sometimes it is
> necessary to perform the same checks, but ito add the memory regions

s/ito/to/

> into a different subsystem. MIPS is going to be that case.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/of/fdt.c       | 47 +++++++++++++++++++++++---------
>  include/linux/of_fdt.h |  1 +
>  2 files changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 1f98156..1ee958f 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -983,44 +983,65 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  #define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
>  #endif
>
> -void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> +int __init sanity_check_dt_memory(phys_addr_t *out_base,
> +                                 phys_addr_t *out_size)

As kbuild robot found, you don't want to use phys_addr_t here.
phys_addr_t varies with kernel config such as LPAE on ARM and the DT
does not.

>  {
> +       phys_addr_t base = *out_base, size = *out_size;
>         const u64 phys_offset = MIN_MEMBLOCK_ADDR;
>
>         if (!PAGE_ALIGNED(base)) {
>                 if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
> -                       pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
> +                       pr_err("Memblock 0x%llx - 0x%llx isn't page aligned\n",

These are not errors. The page alignment is an OS restriction. h/w
(which the DT describes) generally has little concept of page size
outside the MMUs.

Too many unrelated changes in this patch. Add the error return only
and make anything else a separate patch (though I would just drop
everything else).

I've not looked at the rest of the series, but why can't MIPS migrate
to using memblock directly and using the default DT functions using
memblock?

Rob
