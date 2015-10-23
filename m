Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 07:02:03 +0200 (CEST)
Received: from mail-io0-f172.google.com ([209.85.223.172]:36104 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008435AbbJWFCBRxtGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 07:02:01 +0200
Received: by ioll68 with SMTP id l68so114201953iol.3;
        Thu, 22 Oct 2015 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qjpQbZB+9PktMRidePGgB1EkGxDtpmgqn9eig2l00oY=;
        b=x6pMe9zjrAH8xzF0D0aNlaw85EKVcqrmlH6ujn9Lnm7AeYkXRyFjbfn+jK5F8j+InU
         kFUYB2iy37CmZoJc7aHdGxZBPezEhurQPlciqPdba2esmhR5ZsLFEXJB7n96Vaya0mvp
         1WjampfaKPHNhRyiZ3gyR4YeNUaWouwn3BMU9tv/zTXh3+pNdk3Wzx6FJdklY2Xi5TEy
         LsEw0wV8FMy2Pik1lMI1KM8Q387hYJ/mxsF9H4w/ggWYqa1WYRjGOMFD1aLYvwzauKar
         J9l6bBgJGKe+n29ylX5FgYgFJS8/4CK3eoe4A+hdgwy5ccZ/hyFDRbYBOf5a3I9lxGRe
         SXvQ==
X-Received: by 10.107.160.208 with SMTP id j199mr19800267ioe.146.1445576515489;
 Thu, 22 Oct 2015 22:01:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.165 with HTTP; Thu, 22 Oct 2015 22:01:16 -0700 (PDT)
In-Reply-To: <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 22 Oct 2015 22:01:16 -0700
Message-ID: <CAGVrzcZfJ448Ae64rOMmxxj8wh8w5XoYVmi66VP6y+2h6NpszA@mail.gmail.com>
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>
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
X-archive-position: 49656
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
> Add offsets for 40nm BMIPS based set-top box platforms.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/ata/ahci_brcmstb.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 8cf6f7d4798f..59eb526cf4f6 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -50,7 +50,8 @@
>    #define SATA_TOP_CTRL_2_SW_RST_RX                    BIT(2)
>    #define SATA_TOP_CTRL_2_SW_RST_TX                    BIT(3)
>    #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET             BIT(14)
> - #define SATA_TOP_CTRL_PHY_OFFS                                0x8
> + #define SATA_TOP_CTRL_28NM_PHY_OFFS                   0x8
> + #define SATA_TOP_CTRL_40NM_PHY_OFFS                   0x4
>   #define SATA_TOP_MAX_PHYS                             2
>  #define SATA_TOP_CTRL_SATA_TP_OUT                      0x1c
>  #define SATA_TOP_CTRL_CLIENT_INIT_CTRL                 0x20
> @@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
>
>  static const struct of_device_id ahci_of_match[] = {
>         {.compatible = "brcm,bcm7445-ahci",
> -                       .data = (void *)SATA_TOP_CTRL_PHY_OFFS},
> +                       .data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
> +       {.compatible = "brcm,bcm7346-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +       {.compatible = "brcm,bcm7360-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +       {.compatible = "brcm,bcm7362-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},

Since you are introducing new compatible strings, you also need to
update the binding document in Documentation/devicetree/bindings/ata/

We could just use the compatible string for the first 40nm chip that
started featuring such a SATA3 AHCI compliant core, which seems to be
7231. Apart from the existing known workarounds (disabling NCQ, tuning
the PHY) it seems to be largely identical across all 40nm chips.

This is fine either way, and more information cannot hurt, these are
all production chips, so we can actually look back at the history to
know everything about them.
-- 
Florian
