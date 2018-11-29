Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2018 15:22:37 +0100 (CET)
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46236 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994795AbeK2OWfG5bVQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2018 15:22:35 +0100
Received: by mail-qt1-f193.google.com with SMTP id y20so2069660qtm.13;
        Thu, 29 Nov 2018 06:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dp1c5m9Go758zqpd0U6yL4XdcMp/QelpMOB8347WFtA=;
        b=r5XcfkyBJ8tFEdiaa2ebi9N+s6ioZtG+0R4eDVXdNHB3Eew1f9VHetQD5KDx7Q44wn
         KQfLxjN5oDbIcqZlex22OGAK2yB/19CG3YxDGnsGQGWRbSa9Pifz1sR/VenLsBVnrMLw
         qlmpNs3DDpU6w9GcNM5vwnc6x/qVzE2xgSLmishQBAtAladWPtg3xc8BNWFEEsabbF5J
         xcjZCmrSl/Vx1lf9BktD4e7JC3+XchJBpgEE2prK4px+7Yuljzpg/Wo5JpKLfljzOodB
         h5Ok00lvRmZb4nUKjrsc8JxrCeuyV9U/8YLCPedpPnDAFVUTte8qyP1fv8imcTaOydbp
         7Nvw==
X-Gm-Message-State: AA+aEWbbsAcx+/IMCjcg33MiXfzTX5Q4vvEu+F0ORZPyy1HY35mJe49v
        D9jNu8nFCcMzhxk4/wufi6QMAyJEJb9XNzYUI40=
X-Google-Smtp-Source: AFSGD/XJaHcKePzx11S3n8QhdfLtER9xpVM+eDuxlxPNHoa0dhNrsDTwh051V+acJkGm5sjqJhai1WbJTiA0FwaPsLA=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr1517085qtr.319.1543501354279;
 Thu, 29 Nov 2018 06:22:34 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-7-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543481016-18500-7-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 15:22:16 +0100
Message-ID: <CAK8P3a0rTwm_pCtQXyn_fyJttihKJ6Gpq97mw-r5ySUNBksCig@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mips: generate uapi header and system call table files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thu, Nov 29, 2018 at 9:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
> index 7a4becd..ed4bd03 100644
> --- a/arch/mips/include/uapi/asm/Kbuild
> +++ b/arch/mips/include/uapi/asm/Kbuild
> @@ -1,5 +1,11 @@
>  # UAPI Header export list
>  include include/uapi/asm-generic/Kbuild.asm
>
> +generated-y += unistd_n32.h
> +generated-y += unistd_n64.h
> +generated-y += unistd_o32.h
> +generated-y += unistd_nr_n32.h
> +generated-y += unistd_nr_n64.h
> +generated-y += unistd_nr_o32.h
>  generic-y += bpf_perf_event.h
>  generic-y += ipcbuf.h

I'd argue that the unistd_nr_*.h headers should not be in the uapi directory
but instead be included only from the in-kernel header.


> diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
> new file mode 100644
> index 0000000..402a085
> --- /dev/null
> +++ b/arch/mips/kernel/scall64-n64.S
> @@ -0,0 +1,117 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> + * Copyright (C) 2001 MIPS Technologies, Inc.
> + */
> +#include <linux/errno.h>
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/irqflags.h>

It looks like you change and rename this file at the same time.
Generally speaking, I would not do that in one patch. Either
leave the slightly inconsistent name unchanged, or rename
it in a separate patch.

         Arnd
