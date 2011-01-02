Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 21:43:01 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:58863 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab1ABUm6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 21:42:58 +0100
Received: by wyf22 with SMTP id 22so12827074wyf.36
        for <multiple recipients>; Sun, 02 Jan 2011 12:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=kFGknynK0L9LAGcdk9hiXOB/GoNSWWDq5V0Vr6i7jIw=;
        b=K0NgEd5JDnSWx6hqt/UTDq0UzyoaV1o1Z03n/J35NR9tsONaWmntooc7kP70rSEGoG
         zcsTmnnyLzYCUcHJXYLuStxSyAKtcVxFPrtbn0HF8UvajksGF0zGKaoAJYkIw+JStpR6
         Qkd+ih1kFQin3QlNi1yaeJ3HbUPY8C7on0FTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=b6D4ykYF5rb2/xbbh6SWXbVUTxf9zLXbLvkfiRYE0lQ7wzl0TaxJJ/2NiW0BFFPirV
         GkYaL8ODoLqgDLNacl130WAs8fnCw/WgApiZorJI1A9Nb0CvgVmKRjZzxXCnuyGo9NDw
         O6Y41Bjw9PsOeHi25edHe3yhCf3Ba+KFGsP68=
Received: by 10.216.48.6 with SMTP id u6mr19508665web.77.1294000972364;
        Sun, 02 Jan 2011 12:42:52 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id t11sm8883454wes.41.2011.01.02.12.42.50
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 12:42:50 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v4 01/16] MIPS: add initial support for the Atheros AR71XX/AR724X/AR931X SoCs
Date:   Sun, 2 Jan 2011 21:43:13 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-24-server; KDE/4.5.1; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>,
        Kathy Giori <Kathy.Giori@atheros.com>
References: <1293994589-6794-1-git-send-email-juhosg@openwrt.org> <1293994589-6794-2-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1293994589-6794-2-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201101022143.13712.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello,

On Sunday 02 January 2011 19:56:14 Gabor Juhos wrote:
> This patch adds initial support for various Atheros SoCs based on the
> MIPS 24Kc core. The following models are supported at the moment:
> 
>   - AR7130
>   - AR7141
>   - AR7161
>   - AR9130
>   - AR9132
>   - AR7240
>   - AR7241
>   - AR7242
> 
> The current patch contains minimal support only, but the resulting
> kernel can boot into user-space with using of an initramfs image on
> various boards which are using these SoCs. Support for more built-in
> devices and individual boards will be implemented in further patches.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
> Changes since RFC:
>     - the ATH79_DEV_UART Kconfig option is removed, and the URT platform
>       code has been moved into dev-common[ch]
> 
> Changes since v1:
>     - ath79_device_{start,stop} has been renamed to
> ath79_device_reset_{set,clear} to to reflect the purpose of these
> functions better
>     - some definitions has been moved from 'arch/mips/ath79/common.h' to
>       'arch/mips/include/asm/mach-ath79/ath79.h' to make them available for
>       future drivers
>     - rebased against 2.6.37-rc7
> 
> Changes since v2:
>     - don't use __init for function declarations
> 
> Changes since v3:
>     - rebase against 2.6.37-rc8
[snip]

> +
> +static DEFINE_SPINLOCK(ath79_device_reset_lock);
> +
> +u32 ath79_cpu_freq;
> +EXPORT_SYMBOL_GPL(ath79_cpu_freq);
> +
> +u32 ath79_ahb_freq;
> +EXPORT_SYMBOL_GPL(ath79_ahb_freq);
> +
> +u32 ath79_ddr_freq;
> +EXPORT_SYMBOL_GPL(ath79_ddr_freq);

Why not use the Clock API with fixed rates just like how it is done for AR7?

> +
> +enum ath79_soc_type ath79_soc;
> +
> +void __iomem *ath79_pll_base;
> +void __iomem *ath79_reset_base;
> +EXPORT_SYMBOL_GPL(ath79_reset_base);
> +void __iomem *ath79_ddr_base;
> +

[snip]
--
Florian
