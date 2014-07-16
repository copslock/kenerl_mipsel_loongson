Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 18:20:54 +0200 (CEST)
Received: from mail-we0-f172.google.com ([74.125.82.172]:41333 "EHLO
        mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861298AbaGPQUhfeXus convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jul 2014 18:20:37 +0200
Received: by mail-we0-f172.google.com with SMTP id x48so1200592wes.3
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:organization:references
         :user-agent:face:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=8FMKMg8D1RKHHtO4jtUjEA6Tk7CvCdEK46U77+QGRdY=;
        b=pWNBhgbMMB3kX3vHSwq9s+0kCziRWPgh5oAzMCrbChdMPPkuCakopHi7idxK0/0ncJ
         o8Xe+kM0ErQrYEdE2tRhuYdG3GB4kiF+A5y5uklh9SXgWDA8floBxjZR9YKwgtKbhW61
         f4EAqinHn7vviLxnL+0mcNHfQacPdLesPk0EUojXqvBqPF75GHhifi6u46DKe16ZnXfp
         U5aiO0WDMvoEQaFQO8d8gcoqrGp26N0EdlZTv0+8/rI3Z3tFdD5PWcWZ+Dl/IMk7Uj4i
         G4CgI/ERgvvIIJVqV1aLxlxDYXoe1K+aQuIbCnf+u9aRrWZBc6YWE0ahK76KZltGjsfv
         OFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to
         :organization:references:user-agent:face:date:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=8FMKMg8D1RKHHtO4jtUjEA6Tk7CvCdEK46U77+QGRdY=;
        b=leHFw68WwEacWnFvQQfgH5R8oY0UKCFm4kW1je/cRhxrTo8q5+GUwrzrg1vgLZq5fo
         brhCGtNNassS+ibl6U7kidjgfvl5xCmOOoNbgFF1aeqWXyFWMcb5w5EcjAymf4QQ5Vqe
         DM4dhth5lMUC0O/4T3HZMgLb4CZ71BNB4Hcglei3TlxsFisFj6o6twYVbK7EKyOsY5VV
         0kKEcSA4V7sr1uvluh59+SKfo+CzMsOVAh3FU1XEyxI/YS2yydz2hOJunlKk2kiiF3Sm
         FmJlOJoR+mdOpbdfxkVIG8b/fwWyiTak2vQZ8ILMJPd+1+B8X+XXAapQ/4trv1/wUez5
         cOww==
X-Gm-Message-State: ALoCoQmXmbdEp1xp9dq0finZN+eIZXREs4gXC+dThoIDdRiR67XkKdatXQzxWUEdY3eW8Eorx9KY
X-Received: by 10.181.5.39 with SMTP id cj7mr15054890wid.79.1405527632131;
        Wed, 16 Jul 2014 09:20:32 -0700 (PDT)
Received: from mpn-glaptop.roam.corp.google.com ([2620:0:105f:311:c05c:b62d:85fd:69b9])
        by mx.google.com with ESMTPSA id wi9sm40690458wjc.23.2014.07.16.09.20.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 09:20:31 -0700 (PDT)
From:   Michal Nazarewicz <mina86@mina86.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, m.szyprowski@samsung.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: use generic dma-contiguous.h
In-Reply-To: <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Organization: http://mina86.com/
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Notmuch/0.17+15~gb65ca8e (http://notmuchmail.org) Emacs/24.4.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP:  50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Hashcash: 1:20:140716:linux-arch@vger.kernel.org::ikVP6ny+B0p2H+Jx:000000000000000000000000000000000000Imt
X-Hashcash: 1:20:140716:x86@kernel.org::hd9DW4HOvkjdXUdk:0000VgH
X-Hashcash: 1:20:140716:catalin.marinas@arm.com::kTka2XaB0MNLBUHc:000000000000000000000000000000000000002J/m
X-Hashcash: 1:20:140716:will.deacon@arm.com::KKl9z/ZEK9eJ1EjB:0000000000000000000000000000000000000000002qQR
X-Hashcash: 1:20:140716:gregkh@linuxfoundation.org::V66IRISnXsm3ps2j:0000000000000000000000000000000000038v+
X-Hashcash: 1:20:140716:mingo@redhat.com::B+eUlrjt/YNehRev:04T0w
X-Hashcash: 1:20:140716:linux-arm-kernel@lists.infradead.org::5GSPr4tmTPZ1KDD7:00000000000000000000000003/fJ
X-Hashcash: 1:20:140716:hpa@zytor.com::UipkHc6zjaJLQsKJ:00004w8I
X-Hashcash: 1:20:140716:zubair.kakakhel@imgtec.com::m7QTYUjfWQ9Krc/a:000000000000000000000000000000000005jjE
X-Hashcash: 1:20:140716:linux-kernel@vger.kernel.org::Qoa5HXm6jUHs03gv:0000000000000000000000000000000005D9O
X-Hashcash: 1:20:140716:arnd@arndb.de::gsl0oMCLybGcDUqu:00006WVF
X-Hashcash: 1:20:140716:ralf@linux-mips.org::9dzxX0rr0Sd144W9:0000000000000000000000000000000000000000005bP9
X-Hashcash: 1:20:140716:m.szyprowski@samsung.com::0PuRdwurMtIQH3kV:00000000000000000000000000000000000008i20
X-Hashcash: 1:20:140716:linux-mips@linux-mips.org::tBO2w++gCl0dO04R:000000000000000000000000000000000000Axhp
X-Hashcash: 1:20:140716:tglx@linutronix.de::AV74fn752xyxpQH9:0000000000000000000000000000000000000000000FKSy
Date:   Wed, 16 Jul 2014 18:20:29 +0200
Message-ID: <xa1td2d5b7hu.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <mpn@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mina86@mina86.com
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

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> wrote:
> dma-contiguous.h is now in asm-generic. Use that to avoid code
> repetition in arm64.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  arch/arm64/include/asm/Kbuild           |  1 +
>  arch/arm64/include/asm/dma-contiguous.h | 28 ----------------------------
>  2 files changed, 1 insertion(+), 28 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/dma-contiguous.h
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 0b3fcf8..92bf7cb 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -9,6 +9,7 @@ generic-y += current.h
>  generic-y += delay.h
>  generic-y += div64.h
>  generic-y += dma.h
> +generic-y += dma-contiguous.h
>  generic-y += emergency-restart.h
>  generic-y += early_ioremap.h
>  generic-y += errno.h
> diff --git a/arch/arm64/include/asm/dma-contiguous.h b/arch/arm64/include/asm/dma-contiguous.h
> deleted file mode 100644
> index 14c4c0c..0000000
> --- a/arch/arm64/include/asm/dma-contiguous.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#ifndef _ASM_DMA_CONTIGUOUS_H
> -#define _ASM_DMA_CONTIGUOUS_H
> -
> -#ifdef __KERNEL__
> -#ifdef CONFIG_DMA_CMA
> -
> -#include <linux/types.h>
> -
> -static inline void
> -dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> -
> -#endif
> -#endif
> -
> -#endif
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michał “mina86” Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
