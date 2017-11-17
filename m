Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 05:37:46 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:33479
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990476AbdKQEhhILoUO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 05:37:37 +0100
Received: by mail-it0-x243.google.com with SMTP id o130so1521989itg.0;
        Thu, 16 Nov 2017 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=czzuS22ok3ApxkO9CnOcq9cCz2AEvO8wHVlgIepVukA=;
        b=mpx1B1Lg4b2BnLKgrw56iJGCPbwC6mmzSoMxpdk9U3J9x1xLWBMGPqonlTpBQS8Xrs
         FdaXu3IDtnVtXP8/PTmhhusw08Co1dg86jlzotTP5Ik+lyWLQXAcmSQh58JWxR4d3R+r
         3wA+4O1uwZXrnYpKxsFeV6+aCTkhKOeL/88SdsvdkZ36natkaj6DF24qd9f8ccN1fCiu
         Dzwxc7I2GrUxp/KawkYUzY9cl6CL1abTuselQutzBNZY65fClBIfGSBmG2UMASC0PJgV
         tTKWGodpQ7TZqeIUrN8REpHD7S5g4cEFX+dkhWIIbtZTLiVWq1mi5Dxo/xYFDg15H2b+
         qx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=czzuS22ok3ApxkO9CnOcq9cCz2AEvO8wHVlgIepVukA=;
        b=ifUgwuBcUb3Vmkq1JeecOiKocZnieYjpjQkqQE8iI969ei0JaNt+Z9+l62y49PWEZ+
         2Fq0xY2BO7msNsiZ+JMG1DyOwt9qBBswp94orLrtbxBbIuqBsWo7G0GMyRhBTIQ2qAfX
         CouIySHLZb8AX/6+bocE7qSY7s3vpR+QsTFgrp5cbbQSC73z9CaJtfbjg/Wb4swUU5Dy
         rym0hQJdCpD0+lPj2ldop1h6NPZwSYG4hQm8ZPVo8vmul+BhHp/8QGPtAoogBupzxSts
         KWToMipdIJ67cSMhiK3jh/yDXA7iJZwR1Dufh6+hCyROjLDd9uZxyqQ2MbjZUEInBrXd
         E45Q==
X-Gm-Message-State: AJaThX7M+G+m2UQ0/BGxEEtXd6y0O5t2kgUjY84GCRykyd5C8v/6JQ50
        Hizn+iMybGy87GtrJNGIvoG+/+YDwjOqwky4jO0=
X-Google-Smtp-Source: AGs4zMZ/5nZ374YlY3VCMVGLDAqtKeV5nbQCFLEJvh+rTQAVl3zWcxWkhxqfTS+0zwGjD2APNNEA3iOnmtta+dKWlI8=
X-Received: by 10.36.130.131 with SMTP id t125mr5207450itd.104.1510893450944;
 Thu, 16 Nov 2017 20:37:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.28.131 with HTTP; Thu, 16 Nov 2017 20:37:30 -0800 (PST)
In-Reply-To: <20171115211755.25102-1-james.hogan@mips.com>
References: <20171115211755.25102-1-james.hogan@mips.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 17 Nov 2017 12:37:30 +0800
Message-ID: <CAAhV-H5Bhwxtec7cZKuov2i1F1mHaPHPOV0cD4ZZzWMJVkD1Zw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Add Loongson machine dependencies
To:     James Hogan <james.hogan@mips.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

I think it is better to make LOONGSON1_CPUFREQ depends on
CPU_LOONGSON1, and LOONGSON2_CPUFREQ depends on CPU_LOONGSON2

On Thu, Nov 16, 2017 at 5:17 AM, James Hogan <james.hogan@mips.com> wrote:
> From: James Hogan <jhogan@kernel.org>
>
> The MIPS loongson cpufreq drivers don't build unless configured for the
> correct machine type, due to dependency on machine specific architecture
> headers and symbols in machine specific platform code.
>
> More specifically loongson1-cpufreq.c uses RST_CPU_EN and RST_CPU,
> neither of which is defined in asm/mach-loongson32/regs-clk.h unless
> CONFIG_LOONGSON1_LS1B=y, and loongson2_cpufreq.c references
> loongson2_clockmod_table[], which is only defined in
> arch/mips/loongson64/lemote-2f/clock.c, i.e. when
> CONFIG_LEMOTE_MACH2F=y.
>
> Add these dependencies to Kconfig to avoid randconfig / allyesconfig
> build failures (e.g. when based on BMIPS which also has a cpufreq
> driver).
>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/cpufreq/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 4ebae43118ef..d8addbce40bc 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -275,6 +275,7 @@ config BMIPS_CPUFREQ
>
>  config LOONGSON2_CPUFREQ
>         tristate "Loongson2 CPUFreq Driver"
> +       depends on LEMOTE_MACH2F
>         help
>           This option adds a CPUFreq driver for loongson processors which
>           support software configurable cpu frequency.
> @@ -287,6 +288,7 @@ config LOONGSON2_CPUFREQ
>
>  config LOONGSON1_CPUFREQ
>         tristate "Loongson1 CPUFreq Driver"
> +       depends on LOONGSON1_LS1B
>         help
>           This option adds a CPUFreq driver for loongson1 processors which
>           support software configurable cpu frequency.
> --
> 2.14.1
>
>
