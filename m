Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 07:02:22 +0200 (CEST)
Received: from mail-io0-f172.google.com ([209.85.223.172]:36306 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008435AbbJWFCUfmXJk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 07:02:20 +0200
Received: by ioll68 with SMTP id l68so114207267iol.3;
        Thu, 22 Oct 2015 22:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L10ZXtDK3BenWkv61u6n2qqdqTsUsdxKbB+UXjX0rUM=;
        b=d3KerPkFHTZodz5CsKH+OWcYvAtgfoqPscpqy2ztrkdNtYk1pCoD9AQpjGMAm46DUl
         FzwmyxjZ5lrBotbrkrWZt2B2qqefPAC1oa/TKA/mpiFd1u3AjjB/lZKLhH0PVZblOD9d
         p66l2iwEpftQDZcddvV8QIfyfKw/O/MxHPPBEWHFd63ZJBlo/DRCL8nME2lmsHjh0+7h
         ELm/hlZi8CNzzA/xnI4NeL1PDeH4XeTw0AMvaVegPcXnFimSYbeDRH4HX9s/JBB/DKTu
         J2Bd5g6wscWr5RENxn9E0LLYTusfv3McgwOTt2hcVn3v5RC+JBjosSYrB5JqRD2fcpJP
         Ea2w==
X-Received: by 10.107.164.167 with SMTP id d39mr11972054ioj.2.1445576535033;
 Thu, 22 Oct 2015 22:02:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.165 with HTTP; Thu, 22 Oct 2015 22:01:35 -0700 (PDT)
In-Reply-To: <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 22 Oct 2015 22:01:35 -0700
Message-ID: <CAGVrzcasH-E124cxEdJV7ejseWfuev+6tPQgtiaAjUHB8gJ=KA@mail.gmail.com>
Subject: Re: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable on BMIPS_GENERIC
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3 PHY.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/phy/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 47da573d0bab..c83e48661fd7 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -364,11 +364,11 @@ config PHY_TUSB1210
>
>  config PHY_BRCMSTB_SATA
>         tristate "Broadcom STB SATA PHY driver"
> -       depends on ARCH_BRCMSTB
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC
>         depends on OF
>         select GENERIC_PHY
>         help
> -         Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
> +         Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
>           Likely useful only with CONFIG_SATA_BRCMSTB enabled.
>
>  endmenu
> --
> 2.6.2
>



-- 
Florian
