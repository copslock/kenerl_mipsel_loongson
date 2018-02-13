Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 22:48:34 +0100 (CET)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:34784
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994629AbeBMVs06VxUt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 22:48:26 +0100
Received: by mail-pl0-x244.google.com with SMTP id bd10so2455908plb.1
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2018 13:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9sSn1gU9aGOuO7jtXpWohD5cV1sK0XdkIaRcGvEaSw=;
        b=D66MweLGE00fmyAmmPZ4ZV9lYmCn8bYpUIz4cYxywsnw0R4LaJOEd5DaQT4x501fDK
         zWAew67R5/JreWA4/O6A9Sn3VdPIWzzrlnK3B0+FZEqespBcG2MXeWORR3AmlH3A8Ik4
         ar6UN9+BOBGevm2Y4P6Ghy86MeFMOdaUUeOcJDZ6rgDJdlaVeng9LTOrfDutVTyvEFZQ
         UZF+H5urvY10ImBvJfP+184dNfcPr9xZ74K/RrV5uiMXMJy/8mgZbC3tG3m1V2PwqVzv
         svilGJdXNxdzbWvh27ZDtJvD84npxp/e3zmJYD3E97w1GvbZLGfh61GxRVQpUw9AUb67
         z95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Q9sSn1gU9aGOuO7jtXpWohD5cV1sK0XdkIaRcGvEaSw=;
        b=hwieuTWa4TY11umG0smQ2N9LvfiLrtwhUl6JZJ8S3mU1TwQqjFHHiRFB0QnvbJao/p
         4wM6BfikiACA7Lq/08tUEEWKd6agdqZYrSTaeGixTVRo6AqzdIEvytJZ14XJrMCAXtjq
         FUTjax/8xX6ZZOJxifYI1+oBfowtIMsLCSGDhgUJIQ0GleKu5DufdBVgbdaSNpv3R6cu
         eVmhftPgMp+sMRVXfJ2Ki8HnZ1SDb1lfVF52rfh4NBjDMv1xC1KPEFUB8CbdOdXj2u2s
         +IUTlf9OqZOzK//Bm8IsBJ2EkxWSsj+5W3GCualrSC6JbSV2l7rsUdr44g9U+PWoefVz
         cbvg==
X-Gm-Message-State: APf1xPD6XCp+VTx/wQGYtKuXIAnC6fzfWDznrZKN209Lvvtuw3CDw5sU
        Gk3AYheuNoxZgni/CH9KKmaMpw==
X-Google-Smtp-Source: AH8x2277lPakFMCXx9tWxLhqGaGMiPPe1MdndcQwH5uHuLMwZgfyXXjELHAqoQ4tmNQ24vi6fPWpaQ==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9-v6mr2345592plk.212.1518558499466;
        Tue, 13 Feb 2018 13:48:19 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v65sm5780882pfv.61.2018.02.13.13.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 13:48:18 -0800 (PST)
Date:   Tue, 13 Feb 2018 13:48:18 -0800 (PST)
X-Google-Original-Date: Tue, 13 Feb 2018 13:40:29 PST (-0800)
Subject:     Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
In-Reply-To: <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
CC:     antonynpavlov@gmail.com, linux-mips@linux-mips.org,
        jhogan@kernel.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, matt.redfearn@mips.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     matt.redfearn@mips.com
Message-ID: <mhng-a034032e-b23a-4c52-8965-1e9d6e133f43@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Fri, 09 Feb 2018 05:22:52 PST (-0800), matt.redfearn@mips.com wrote:
> When these are included into arch Kconfig files, maintaining
> alphabetical ordering of the selects means these get split up. To allow
> for keeping things tidier and alphabetical, rename the selects to
> GENERIC_LIB_*
>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks!  Do you want me to take this in my tree?

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

> ---
>  arch/riscv/Kconfig |  6 +++---
>  lib/Kconfig        | 12 ++++++------
>  lib/Makefile       | 12 ++++++------
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2c6adf12713a..5f1e2188d029 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -99,9 +99,9 @@ config ARCH_RV32I
>  	bool "RV32I"
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select 32BIT
> -	select GENERIC_ASHLDI3
> -	select GENERIC_ASHRDI3
> -	select GENERIC_LSHRDI3
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_LSHRDI3
>
>  config ARCH_RV64I
>  	bool "RV64I"
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c5e84fbcb30b..946d0890aad6 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -584,20 +584,20 @@ config STRING_SELFTEST
>
>  endmenu
>
> -config GENERIC_ASHLDI3
> +config GENERIC_LIB_ASHLDI3
>  	bool
>
> -config GENERIC_ASHRDI3
> +config GENERIC_LIB_ASHRDI3
>  	bool
>
> -config GENERIC_LSHRDI3
> +config GENERIC_LIB_LSHRDI3
>  	bool
>
> -config GENERIC_MULDI3
> +config GENERIC_LIB_MULDI3
>  	bool
>
> -config GENERIC_CMPDI2
> +config GENERIC_LIB_CMPDI2
>  	bool
>
> -config GENERIC_UCMPDI2
> +config GENERIC_LIB_UCMPDI2
>  	bool
> diff --git a/lib/Makefile b/lib/Makefile
> index d11c48ec8ffd..7e1ef77e86a3 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -252,9 +252,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>  obj-$(CONFIG_PARMAN) += parman.o
>
>  # GCC library routines
> -obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
> -obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
> -obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
> -obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
> -obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
> -obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
> +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> +obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
