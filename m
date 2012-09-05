Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 23:22:25 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:60035 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903404Ab2IEVWU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 23:22:20 +0200
Received: by pbbrq8 with SMTP id rq8so1594905pbb.36
        for <multiple recipients>; Wed, 05 Sep 2012 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=W2rVSZPlvP+2xOBQJm83D3E0BWQpoZ4cGB3zci18QaA=;
        b=JHB6aZNsiP5004ojuLLB7oYY1plwuiOgLZC/Y2e59AWMuaINxv1hljW1MVQupz5pY7
         NB4irb1g+t0XT7QKw0WWuSi9xX1L8pXjx3hsPpnAYksgSI7MTkuEOYTWJifjQGIUS46+
         sKk7NX32JKTli0Mnkg8vlNaIq8zzCPKF4EPr21eZ5d9qquhdTvAJN6mdVDoI/Gq1sI3U
         iz8P167jaR6JdD2cFFjqFdDJjOd+U+C6PxBE4ObLnntL3BUGA3GX/N9XRhhReTYDpNB9
         q8jpE5SK4JKy2H6NSBEIpVD46paqCTTSHOPlX1DTDsHsVE7bXFxF/GEWmZWFmb2fzF0x
         nAmA==
Received: by 10.66.76.106 with SMTP id j10mr51447795paw.51.1346880133586;
        Wed, 05 Sep 2012 14:22:13 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id uj3sm171742pbc.39.2012.09.05.14.22.11
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 14:22:12 -0700 (PDT)
Message-ID: <5047C27E.7070007@gmail.com>
Date:   Wed, 05 Sep 2012 14:22:06 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] MIPS: Remove kernel_uses_smartmips_rixi macro definition.
References: <1346876878-25965-1-git-send-email-sjhill@mips.com> <1346876878-25965-5-git-send-email-sjhill@mips.com>
In-Reply-To: <1346876878-25965-5-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/05/2012 01:27 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Remove the 'kernel_uses_smartmips_rixi' macro definitions from
> the architecture header files.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>   arch/mips/include/asm/cpu-features.h               |    3 ---
>   .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    2 --
>   2 files changed, 5 deletions(-)
>
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index c78a77b..7452d78 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -95,9 +95,6 @@
>   #ifndef cpu_has_smartmips
>   #define cpu_has_smartmips      (cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
>   #endif
> -#ifndef kernel_uses_smartmips_rixi
> -#define kernel_uses_smartmips_rixi 0

As I said in the other message, you will want to have the replacement 
for this instance of kernel_uses_smartmips_rixi in place before you do 
the other conversions.

That said, at the end of the patch set, this does need to go, so 
something like this will be needed.

David Daney

> -#endif
>   #ifndef cpu_has_ri
>   #define cpu_has_ri		(cpu_data[0].options & MIPS_CPU_RI)
>   #endif
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> index a58addb..971bdc2 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> @@ -58,8 +58,6 @@
>   #define cpu_has_veic		0
>   #define cpu_hwrena_impl_bits	0xc0000000
>
> -#define kernel_uses_smartmips_rixi (cpu_data[0].cputype != CPU_CAVIUM_OCTEON)
> -
>   #define ARCH_HAS_IRQ_PER_CPU	1
>   #define ARCH_HAS_SPINLOCK_PREFETCH 1
>   #define spin_lock_prefetch(x) prefetch(x)
>
