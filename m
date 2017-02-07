Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 05:19:02 +0100 (CET)
Received: from mail-pf0-x22b.google.com ([IPv6:2607:f8b0:400e:c00::22b]:34921
        "EHLO mail-pf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdBGESyEdDFJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 05:18:54 +0100
Received: by mail-pf0-x22b.google.com with SMTP id f144so29502799pfa.2
        for <linux-mips@linux-mips.org>; Mon, 06 Feb 2017 20:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NbBWQ1Hapk84ES1/BJPIbo5MftEzs/ShBYgRUvh94dM=;
        b=Kp003pvr6R4dhUD3DpVQRhrYi9jKCX5L+HzsuxeFVC2FEj7fuWFEq5pLec01FYQhIc
         XGnnmvH9IPPeXMhqLLOZrIghOdAz1StvTWwiPF/rkSTLGNaQUcpriUr4AGBl1yIb2TG5
         xP3Dr1+Kxv6x2n+PG45TJcHCgnqQpv6sZOYm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NbBWQ1Hapk84ES1/BJPIbo5MftEzs/ShBYgRUvh94dM=;
        b=C8dZkx7MtNijk7OR3uV1+JoTHsCoX9bKwnfbeVnObUbTUibvC49iOtKN+P7EU53JUj
         3bTPwtgw8sm1DoG01msuVZ9AD4E+Bnbqumh3zbnbM1g0eXbf6ClewiDPvqfW7wKDEA43
         BgfkCqEqFzAp/TJW0ljor/XqZCUplg4tQp4iQgV3uVZWZdlp7cFX/RFQJeF6BRh0xN+h
         303rf62k5YBk4ZwRa2H1dKuUMv1lWKDE4BVM1aDhsCXK6MwkTp2EUl35hJFhn48MHBuN
         M0YKpGSzHkoFqyGq99NzR2pMJl0pn0kZ9VcINnthRaZGqdjAorp9UHBBv7gXcTqX5RO5
         3vFg==
X-Gm-Message-State: AIkVDXKK9kzgSkLWoXmEdZERA1u4hudro2eTBi0tyOrptqvkQiPDoV2ENAmBzbuN8STi3aUR
X-Received: by 10.99.94.195 with SMTP id s186mr17798140pgb.197.1486441128112;
        Mon, 06 Feb 2017 20:18:48 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id d63sm320712pfg.65.2017.02.06.20.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 20:18:47 -0800 (PST)
Date:   Tue, 7 Feb 2017 09:48:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] MIPS: BMIPS: Update defconfig
Message-ID: <20170207041845.GN3131@vireshk-i7>
References: <20170206215119.87099-1-code@mmayer.net>
 <20170206215119.87099-2-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206215119.87099-2-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 06-02-17, 13:51, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Ran "make savedefconfig" to bring bmips_stb_defconfig up to date.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  arch/mips/configs/bmips_stb_defconfig | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> index 4eb5d6e..3be15cb 100644
> --- a/arch/mips/configs/bmips_stb_defconfig
> +++ b/arch/mips/configs/bmips_stb_defconfig
> @@ -9,7 +9,6 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
>  # CONFIG_SWAP is not set
>  CONFIG_NO_HZ=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_RD_GZIP=y
>  CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
> @@ -24,7 +23,6 @@ CONFIG_INET=y
>  # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
>  # CONFIG_INET_XFRM_MODE_TUNNEL is not set
>  # CONFIG_INET_XFRM_MODE_BEET is not set
> -# CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_CFG80211=y
>  CONFIG_NL80211_TESTMODE=y
> @@ -34,8 +32,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_STANDALONE is not set
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> -CONFIG_PRINTK_TIME=y
> -CONFIG_BRCMSTB_GISB_ARB=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_INTELEXT=y
> @@ -51,16 +47,15 @@ CONFIG_USB_USBNET=y
>  # CONFIG_INPUT is not set
>  # CONFIG_SERIO is not set
>  # CONFIG_VT is not set
> -# CONFIG_DEVKMEM is not set
>  CONFIG_SERIAL_8250=y
>  # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_HW_RANDOM is not set
> -CONFIG_POWER_SUPPLY=y
>  CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_BRCMSTB=y
>  CONFIG_POWER_RESET_SYSCON=y
> +CONFIG_POWER_SUPPLY=y
>  # CONFIG_HWMON is not set
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> @@ -82,6 +77,7 @@ CONFIG_CIFS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ASCII=y
>  CONFIG_NLS_ISO8859_1=y
> +CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_CMDLINE_BOOL=y

This is what happens when people don't update defconfigs properly :)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
