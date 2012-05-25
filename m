Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2012 13:20:40 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:49146 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903638Ab2EYLUd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2012 13:20:33 +0200
Received: by lbbgg6 with SMTP id gg6so713632lbb.36
        for <linux-mips@linux-mips.org>; Fri, 25 May 2012 04:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=ofPOSc1YkN0xhG+++4rYBeyVpX88qdDJUpUWUHS7XcI=;
        b=AQqCX5Pe0hRGGuD4fNXH3O53GSTu6CsiLgs1HTZmumsUtxG3kCEMMrIcmohZkyii7g
         idHeU8nUCJn2SnxLl2FU1z4rhimU2/3JYloUz7OpBiooXNoVNrbi6memP4oHMTixBF8J
         sEbUVdrKkpPlbB+8Bax3nwmCoquq/bFsRjtoBexw18fF3AgllPKwwEe/LnhkRlhGFLgb
         vyMHut2NBFZqFDPXSFPWcDidZEMni/NuoT/zm+dSbT6PstkDGCao/S8y9jiF+XNwJGYx
         ScmPbiVQWVIg0HcVE4ylS5htBUdCyV/dKtF8OvIZIEUQ0XYvni7bLF96UN2Kq2QaBltC
         LcfQ==
Received: by 10.112.49.227 with SMTP id x3mr1354645lbn.73.1337944827942;
        Fri, 25 May 2012 04:20:27 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-95-133.pppoe.mtu-net.ru. [91.79.95.133])
        by mx.google.com with ESMTPS id mo3sm3562213lab.2.2012.05.25.04.20.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 May 2012 04:20:23 -0700 (PDT)
Message-ID: <4FBF6AD9.6060001@mvista.com>
Date:   Fri, 25 May 2012 15:19:53 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2] Update all configuration files for new features.
References: <1337893403-24696-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1337893403-24696-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkwtwVr6PGLao1JDMLrKYWRW81zQGgbbgKcbhEDgF0L7CwkriWd14bh0m/GTI4VrXpZdRAx
X-archive-position: 33466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 25-05-2012 1:03, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/configs/malta_defconfig     | 1793 ++++++++++++++++++++++++++++++++-
>   arch/mips/configs/maltaaprp_defconfig | 1739 ++++++++++++++++++++++++++++++++
>   arch/mips/configs/maltasmtc_defconfig | 1746 ++++++++++++++++++++++++++++++++
>   arch/mips/configs/maltasmvp_defconfig | 1750 ++++++++++++++++++++++++++++++++
>   arch/mips/configs/maltaup_defconfig   | 1734 +++++++++++++++++++++++++++++++
>   5 files changed, 8730 insertions(+), 32 deletions(-)
>   create mode 100644 arch/mips/configs/maltaaprp_defconfig
>   create mode 100644 arch/mips/configs/maltasmtc_defconfig
>   create mode 100644 arch/mips/configs/maltasmvp_defconfig
>   create mode 100644 arch/mips/configs/maltaup_defconfig

> diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
> index 5527abb..d412195 100644
> --- a/arch/mips/configs/malta_defconfig
> +++ b/arch/mips/configs/malta_defconfig
> @@ -1,58 +1,465 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/mips 3.4.0 Kernel Configuration
> +#
> +CONFIG_MIPS=y
> +
> +#
> +# Machine selection
> +#
> +CONFIG_ZONE_DMA=y
> +# CONFIG_MIPS_ALCHEMY is not set
> +# CONFIG_AR7 is not set
> +# CONFIG_ATH79 is not set
> +# CONFIG_BCM47XX is not set
> +# CONFIG_BCM63XX is not set
> +# CONFIG_MIPS_COBALT is not set
> +# CONFIG_MACH_DECSTATION is not set
> +# CONFIG_MACH_JAZZ is not set
> +# CONFIG_MACH_JZ4740 is not set
> +# CONFIG_LANTIQ is not set
> +# CONFIG_LASAT is not set
> +# CONFIG_MACH_LOONGSON is not set

    I think you should use 'make savedefconfig' to save space on non-seleected 
items. At least 'malta_defconfig' was clearly generated that way before -- 
using that target has become a common practice nowadays.

WBR, Sergei
