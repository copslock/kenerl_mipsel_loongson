Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 09:05:19 +0200 (CEST)
Received: from mail-yb0-x244.google.com ([IPv6:2607:f8b0:4002:c09::244]:34065
        "EHLO mail-yb0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeGZHFPMtVJ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2018 09:05:15 +0200
Received: by mail-yb0-x244.google.com with SMTP id e9-v6so263485ybq.1
        for <linux-mips@linux-mips.org>; Thu, 26 Jul 2018 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUh+ihv71o/dpEu+DXw5hSCvc7iyF7vIyltmHnOb30Q=;
        b=fC/kNVB8KC7MnOoEMWHQ0cFxmujabehkgxX1yP4QrVB+Z7NcmMCCbyRdZlXwVGuVZz
         59EQrfbQudk34j11gj10CiTH1HEg+TOdmx06b7qMa270mRQF/1sCnXnXMnZiCFn211lP
         FIysHzFtAiLpHp7YEB1wCNIUuvhOVxSNVWJnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUh+ihv71o/dpEu+DXw5hSCvc7iyF7vIyltmHnOb30Q=;
        b=k7YdZVxXh+h+fjXuw5bK/Qh8WWo/cy7da7/Fo1Eo3Aqoz17VhQp+ooWR678NvNYr+H
         MxdbyotJK+JTYI6EMOQrHMqptBpgD+LGPrZPwNYUQUBQfZZTXBBekqABDdDBKBi3qHYw
         xe/bIhfT9F+NvgZtH9HvduxUH5x6i2loRK12T/F2G4cJed6SXH/JIqLeAKuCp8TNti6G
         DBmQTJlr+37jHAdkkgaDb7RnZEHKuLUfAz8ldvIdVPC92tbju+c4XQH8nyiKw0UScu9i
         7v8xCJSv5eQpkUgf6zqt0P4xC72BIyjqfNL+aYVes+bKU2gj1e+FhvjgilLnjoTENJiq
         kKZg==
X-Gm-Message-State: AOUpUlEI0iNIt7SU44L4TNl+WU+6SOMvNeM7neGirt+XTge1E4zqth+V
        Svg00W/eNuvKuY/Vl9fYHdvuaTeFCc1qg/1RU/XmRw==
X-Google-Smtp-Source: AAOMgpe50BBD3q5N/ITliJWOTpDDfLo2Hu+bh0nHHffcaw4Lg3WpIfZ1n2ftC4KlxiUorU1NRWnoKnB9hwZpENoVJHI=
X-Received: by 2002:a25:bfc8:: with SMTP id q8-v6mr330420ybm.361.1532588708959;
 Thu, 26 Jul 2018 00:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180626153035.361-1-anders.roxell@linaro.org>
In-Reply-To: <20180626153035.361-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Jul 2018 09:04:57 +0200
Message-ID: <CADYN=9+HHA+uFJT+QX9hvM1nunTg6zqwVwBeSuAVFAYjBanhSg@mail.gmail.com>
Subject: Re: [PATCH] mips: configs: remove no longer needed config option
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <anders.roxell@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anders.roxell@linaro.org
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

On Tue, 26 Jun 2018 at 17:30, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Since commit eedf265aa003 ("devpts: Make each mount of devpts an
> independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
> in the defconfig anymore.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/mips/configs/ip27_defconfig    | 1 -
>  arch/mips/configs/nlm_xlp_defconfig | 1 -
>  arch/mips/configs/nlm_xlr_defconfig | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
> index 91a9c13e2c82..fbcbfc365c64 100644
> --- a/arch/mips/configs/ip27_defconfig
> +++ b/arch/mips/configs/ip27_defconfig
> @@ -262,7 +262,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_MANY_PORTS=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  CONFIG_HW_RANDOM_TIMERIOMEM=m
>  CONFIG_I2C_CHARDEV=m
>  CONFIG_I2C_ALI1535=m
> diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
> index e8e1dd8e0e99..aec323ed6968 100644
> --- a/arch/mips/configs/nlm_xlp_defconfig
> +++ b/arch/mips/configs/nlm_xlp_defconfig
> @@ -403,7 +403,6 @@ CONFIG_SERIO_SERPORT=m
>  CONFIG_SERIO_LIBPS2=y
>  CONFIG_SERIO_RAW=m
>  CONFIG_VT_HW_CONSOLE_BINDING=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  CONFIG_LEGACY_PTY_COUNT=0
>  CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_N_HDLC=m
> diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
> index c4477a4d40c1..88c185da23ce 100644
> --- a/arch/mips/configs/nlm_xlr_defconfig
> +++ b/arch/mips/configs/nlm_xlr_defconfig
> @@ -336,7 +336,6 @@ CONFIG_SERIO_SERPORT=m
>  CONFIG_SERIO_LIBPS2=y
>  CONFIG_SERIO_RAW=m
>  CONFIG_VT_HW_CONSOLE_BINDING=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  CONFIG_LEGACY_PTY_COUNT=0
>  CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_N_HDLC=m
> --
> 2.18.0
>

Ping.
