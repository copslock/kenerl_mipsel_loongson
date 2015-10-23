Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 23:26:09 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36081 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010009AbbJWV0HCQsur (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 23:26:07 +0200
Received: by pacfv9 with SMTP id fv9so133887566pac.3;
        Fri, 23 Oct 2015 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nMC4JgTRVUBKny61JuT2uU239Ze8yZwFqttFPoCHH2E=;
        b=n8/XZyuGXehEr9apRj2tSxZjqo45B0k0lqFbgEiGXv5WH+CNyqtKEHO3j6UtB6n5X5
         a5KyQTy2ZlJhCLoVVsx2pspsh+Dj5hUI4CifbAfZkTA18Y1+mNzbuI504sUx9lzUtaHF
         6LLXnZc7zSwnB4+O0e3LqAO/l3lknbfF+T8J4Ge8LnAvNorjvMA8Qn4wOKash95NYUJx
         2jTYi4/8HyFt4wYNGnY7rSyfNzJ49IAwsslI0eqXF2RrzeqbRwusoVMA0JPOV8OIAkRw
         zTSUvMX1SQml80twEfxT5PwweCOHvDkVzYV7oTOf2RMhzEGk+9mI1epn1S0xUNnVlYOt
         ORWA==
X-Received: by 10.68.189.69 with SMTP id gg5mr7394431pbc.55.1445635561245;
        Fri, 23 Oct 2015 14:26:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id bs3sm20600543pbd.89.2015.10.23.14.26.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 14:26:00 -0700 (PDT)
Date:   Fri, 23 Oct 2015 14:25:58 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Message-ID: <20151023212558.GS13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi Jadeon,

Hmm, my suspicions about the PHY driver are probably meant to be applied
here. I don't think this change is sufficient.

On Fri, Oct 23, 2015 at 10:44:16AM +0900, Jaedon Shin wrote:
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
>    #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
>    #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
>    #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
> - #define SATA_TOP_CTRL_PHY_OFFS				0x8
> + #define SATA_TOP_CTRL_28NM_PHY_OFFS			0x8
> + #define SATA_TOP_CTRL_40NM_PHY_OFFS			0x4

I don't remember the exact 40nm vs. 28nm map that well, but judging by
the code-is-the-documentation, the 28nm layout is like this:

base + 0x0C = port 0, phy control 1
base + 0x10 = port 0, phy control 2
base + 0x14 = port 1, phy control 1
base + 0x18 = port 1, phy control 2

but the 40nm layout is differnt, where the ports are interleaved:

base + 0x0C = port 0, phy control 1
base + 0x10 = port 1, phy control 1
base + 0x14 = port 0, phy control 2
base + 0x18 = port 1, phy control 2

So, your patch gets phy control 1 correct for both ports, but it doesn't
get phy control 2 correct. (Or at least, even if my guess at the 40nm
layout is wrong, your patch makes "port 0, phy control 2" collide with
"port 1, phy control 1", which is most certainly a bug.)

Are you sure you're testing this properly? Did you try using both ports
at the same time? And please, apply the same scrutiny to the PHY driver.
(e.g., did you test SSC? did you test both ports?)

Brian

>   #define SATA_TOP_MAX_PHYS				2
>  #define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
>  #define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
> @@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
>  
>  static const struct of_device_id ahci_of_match[] = {
>  	{.compatible = "brcm,bcm7445-ahci",
> -			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
> +			.data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
> +	{.compatible = "brcm,bcm7346-ahci",
> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +	{.compatible = "brcm,bcm7360-ahci",
> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
> +	{.compatible = "brcm,bcm7362-ahci",
> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
