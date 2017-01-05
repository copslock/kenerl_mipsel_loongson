Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 19:33:01 +0100 (CET)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34896 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992380AbdAEScya83ca (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jan 2017 19:32:54 +0100
Received: by mail-wm0-f65.google.com with SMTP id l2so72825892wml.2
        for <linux-mips@linux-mips.org>; Thu, 05 Jan 2017 10:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYHjLmGh05WG3e0zxZfQGRXvxfOVjhTCdpSRFxmK5K0=;
        b=V7tyKAnL4HEk8wX+3hlO+JtEK0arEvTlhFbvqqNHxm8OeDorYeTmZrWpXHlS1lLpfI
         RaXWxJ2JPq5dhwFxAqDBLnlzFn1U3NvBPW6xfptukU2BpxS2mMpo1UNfH+NUJ+CyYacz
         wEJGOlJeMx0nw2BYLvE2B5Ey10TtftTuFHhEx4qyA56uGbsThnNYb1e/mu9HWmb0AhNi
         3Fsp9dx9WM7LDtGiRc1oJ3tKYR0lGMReowMpjvE+Ox+uD2iyWACZihEh6g0PXRrxw69W
         phMotM+jJvcDqndhdMfRVF0DuXWFFjkj+JQF6xEmStr2LpdtQHP1MlvZo5SUCTk2qAUl
         DB7Q==
X-Gm-Message-State: AIkVDXKhz2ES5bq5JWH7NsAr2IiUNy6HIjHemyqq5+ZKPoeWMezodbuMqzgzBQhrRCHYWA==
X-Received: by 10.28.24.74 with SMTP id 71mr64340036wmy.74.1483641169193;
        Thu, 05 Jan 2017 10:32:49 -0800 (PST)
Received: from kozik-lap ([109.66.157.170])
        by smtp.googlemail.com with ESMTPSA id d10sm104763892wja.20.2017.01.05.10.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jan 2017 10:32:48 -0800 (PST)
Date:   Thu, 5 Jan 2017 20:32:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config
 option
Message-ID: <20170105183242.cwyymvr37mdqb6mj@kozik-lap>
References: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <k.kozlowski.k@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzk@kernel.org
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

On Thu, Jan 05, 2017 at 01:57:41PM +0530, Viresh Kumar wrote:
> This doesn't have any benefit apart from saving a small amount of memory
> when it is disabled. The ifdef hackery in the code makes it dirty
> unnecessarily.
> 
> Clean it up by removing the Kconfig option completely. Few defconfigs
> are also updated and CONFIG_CPU_FREQ_STAT_DETAILS is replaced with
> CONFIG_CPU_FREQ_STAT now in them, as users wanted stats to be enabled.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/configs/exynos_defconfig         |  2 +-
>  arch/arm/configs/multi_v5_defconfig       |  2 +-
>  arch/arm/configs/multi_v7_defconfig       |  2 +-
>  arch/arm/configs/mvebu_v5_defconfig       |  2 +-
>  arch/arm/configs/pxa_defconfig            |  2 +-
>  arch/arm/configs/shmobile_defconfig       |  2 +-
>  arch/mips/configs/lemote2f_defconfig      |  1 -
>  arch/powerpc/configs/ppc6xx_defconfig     |  1 -
>  arch/sh/configs/sh7785lcr_32bit_defconfig |  2 +-
>  drivers/cpufreq/Kconfig                   |  8 --------
>  drivers/cpufreq/cpufreq_stats.c           | 14 --------------
>  11 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 79c415c33f69..809f0bf3042a 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -24,7 +24,7 @@ CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>  CONFIG_CPU_FREQ_GOV_USERSPACE=m

For Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
