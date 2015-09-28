Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 12:54:23 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38758 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007847AbbI1KyVO-YVl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2015 12:54:21 +0200
Received: by wiclk2 with SMTP id lk2so95395512wic.1
        for <linux-mips@linux-mips.org>; Mon, 28 Sep 2015 03:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ASU5RfedncYvvoiKdi8IF5cnjMKK32kzH//TLrB3gu0=;
        b=A4J91Mar47h+C+rSUOUeJaWBOFTrn58dwiomJRKrEyMFRI4/i71/rjYnVH7WjnhEoH
         3fY2abRSR349Ba0q20sMeB2a/+vW7A8uXtGEY/KuuvY+M4/DIyYBziHTlD3Mfevbu95N
         p7qlv1eR1fxzjmbEs3UJOWVIPszHBAk4GFA69r/tMEeduLlMgRrUglmTZLbSS6ZvPA6N
         J0mgmQIDR0PJcEpJ+Oqz13QzLOfc3XZAjRh+wddRHUtFgEWkDA4E1LKGXghu0riAf7KI
         fdSsjPiRdOk34a2EmtzQ+5RAtk744mWeVLqC/l/cm90pM32FCj0jSbaxScK3Yomt/uXv
         /WrA==
X-Gm-Message-State: ALoCoQmIiYSkADKfpkUl7X5ocJZ+qVC3cheyDqoTIqqbjxYATLVgXraoyoBZkR74AtkV7H2+wmKA
MIME-Version: 1.0
X-Received: by 10.194.118.5 with SMTP id ki5mr20498716wjb.94.1443437654988;
 Mon, 28 Sep 2015 03:54:14 -0700 (PDT)
Received: by 10.27.186.146 with HTTP; Mon, 28 Sep 2015 03:54:14 -0700 (PDT)
In-Reply-To: <1443435011-17061-1-git-send-email-markos.chandras@imgtec.com>
References: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>
        <1443435011-17061-1-git-send-email-markos.chandras@imgtec.com>
Date:   Mon, 28 Sep 2015 11:54:14 +0100
Message-ID: <CAOFt0_ANW6uHVU4+bTP8=oXJ8OjsEiuFPkz3GCcTZFLHs5xo4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Initial implementation of a VDSO
From:   Alex Smith <alex@alex-smith.me.uk>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        linux-kernel@vger.kernel.org,
        Matthew Fortune <matthew.fortune@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

Hi Markos,

Thanks for finishing this off. Just got a few of minor comments.

On 28 September 2015 at 11:10, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> diff --git a/arch/mips/vdso/elf.S b/arch/mips/vdso/elf.S
> new file mode 100644
> index 000000000000..60c23d0d452c
> --- /dev/null
> +++ b/arch/mips/vdso/elf.S
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright (C) 2015 Imagination Technologies
> + * Author: Alex Smith <alex.smith@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include "vdso.h"
> +
> +#include <linux/elfnote.h>
> +#include <linux/version.h>
> +
> +ELFNOTE_START(Linux, 0, "a")
> +       .long LINUX_VERSION_CODE
> +ELFNOTE_END
> +
> +/*
> + * The .MIPS.abiflags section must be defined with the FP ABI flags set
> + * to 'any' to be able to link with both old and new libraries.
> + * Newer toolchains are capable of automatically generating this, but we want
> + * to work with older toolchains as well. Therefore, we define the contents of
> + * this section here (under different names), and then genvdso will patch
> + * it to have the correct name and type.
> + *
> + * We base the .MIPS.abiflags section on preprocessor definitions rather than
> + * CONFIG_* because we need to match the particular ABI we are building the
> + * VDSO for.
> + *
> + * See https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking
> + * for the .MIPS.abitflags and .gnu.attributes section description.
> + */

s/abitflags/abiflags/

> diff --git a/arch/mips/vdso/vdso.h b/arch/mips/vdso/vdso.h
> new file mode 100644
> index 000000000000..64b98967e245
> --- /dev/null
> +++ b/arch/mips/vdso/vdso.h
> @@ -0,0 +1,79 @@
> +/*
> + * Copyright (C) 2015 Imagination Technologies
> + * Author: Alex Smith <alex.smith@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <asm/sgidefs.h>
> +
> +#if _MIPS_SIM != _MIPS_SIM_ABI64 && defined(CONFIG_64BIT)
> +
> +/* Building 32-bit VDSO for the 64-bit kernel. Fake a 32-bit Kconfig. */
> +#undef CONFIG_64BIT
> +#define CONFIG_32BIT 1
> +
> +#endif
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/asm.h>
> +#include <asm/page.h>
> +#include <asm/vdso.h>
> +
> +static inline unsigned long get_vdso_base(void)
> +{
> +       unsigned long addr;
> +
> +       /*
> +        * Get the base load address of the VDSO. We have to avoid generating
> +        * relocations and references to the GOT because ld.so does not peform
> +        * relocations on the VDSO. We use the current offset from the VDSO base
> +        * and perform a PC-relative branch which gives the absolute address in
> +        * ra, and take the difference. The assembler chokes on
> +        * "li %0, _start - .", so embed the offset as a word and branch over
> +        * it.
> +        *
> +        * TODO: Is there a better way to do this?

Unless somebody else can come up with a better way to do this I'd say
this TODO can go :)

Also perhaps move the description of what the code is doing (from "We
use the current offset from the VDSO base" onwards) down to after the
#else since it applies  to that code rather than the R6 code which
comes first.

> +        */
> +
> +#ifdef CONFIG_CPU_MIPSR6
> +       /*
> +        * We can't use cpu_has_mips_r6 since it will create a relocation
> +        * in the VDSO because of the global cpu_data[] variable.
> +        */

I think it would be more correct to say here that cpu_data doesn't
even exist to the VDSO because it's a kernel symbol.

> +
> +       /* lapc <symbol> is an alias to addiupc reg, <symbol> - .
> +        *
> +        * We can't use addiupc because there is no label-label
> +        * support for the addiupc reloc
> +        */
> +       __asm__("lapc   %0, _start                      \n"
> +               : "=r" (addr) : :);

Just curious - if lapc is just an alias to addiupc, why does that work
but not addiupc? IIRC I did try addiupc previously but removed it
because it wasn't working, didn't know about lapc!

Thanks,
Alex
