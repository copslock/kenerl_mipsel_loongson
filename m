Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 14:49:29 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:53233 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903820Ab2HNMtW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 14:49:22 +0200
Received: by eekc13 with SMTP id c13so122498eek.36
        for <multiple recipients>; Tue, 14 Aug 2012 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=1JcyFwKHflNO8HJcWCHSVYN/dKuA1FpaoyJDSjlAVno=;
        b=ebUvFrFpscDWBl5QddU5w/PZITi9itTQFp4bkl4aW6c1KbK8XCRbTvuIytX45wbLbM
         SV4cIZioHrza57A9WsMEm+Fxecl3yJ/vqLiCB8tn50KkEuNgzcfmUyfxcHF+1CYgW1q9
         at1R/JR2lOIl5xeP0LxGqRLflT6gPSM4fDrQSVrAO0uZsk8+LxE13X4xbeOdM3hrpNjd
         NUGQysO9n/I60JfOk83Z0CwEcaq+dzgmgVKX35azq4GYjHVgtRAN1hvhOLCdn4xG0SuX
         wa08AioZyUT57mWjXBX1xjiXxywrChmTAbVkiH8i3+Z9zQtsWq3hDv2SDh5koG2hoXfV
         Nv1w==
Received: by 10.14.180.68 with SMTP id i44mr19271664eem.20.1344948557489;
        Tue, 14 Aug 2012 05:49:17 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id h42sm6642267eem.5.2012.08.14.05.49.16
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 05:49:16 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org, gregkh@suse.de,
        wuzhangjin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 4/5] USB: Add EHCI bus glue for Loongson1x SoCs (UPDATED)
Date:   Tue, 14 Aug 2012 14:49:04 +0200
Message-ID: <2068844.Lgd4iRJr0U@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.4 (Linux/3.2.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1326868876-20271-1-git-send-email-keguang.zhang@gmail.com>
References: <1326868876-20271-1-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hello Kelvin,

On Wednesday 18 January 2012 14:41:16 Kelvin Cheung wrote:
> Use ehci_setup() in ehci_ls1x_reset().
> 
> The Loongson1x SoCs have a built-in EHCI controller.
> This patch adds the necessary glue code to make the generic EHCI
> driver usable for them.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---

I do not see this driver doing anything fancy which would require an entirely 
new ehci implementation so consider using the generic ehci platform driver 
(drivers/usb/host/ehci-platforms.c) instead.

>  drivers/usb/Kconfig          |    1 +
>  drivers/usb/host/ehci-hcd.c  |    5 ++
>  drivers/usb/host/ehci-ls1x.c |  159 
++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/host/ehci-ls1x.c
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 85d5a01..78ac78b 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -68,6 +68,7 @@ config USB_ARCH_HAS_EHCI
>  	default y if ARCH_MSM
>  	default y if MICROBLAZE
>  	default y if SPARC_LEON
> +	default y if MACH_LOONGSON1

Do this in arch/mips/Kconfig instead.
--
Florian
