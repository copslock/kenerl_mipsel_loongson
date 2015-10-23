Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 22:40:23 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34729 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008629AbbJWUkVkOguI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 22:40:21 +0200
Received: by padhk11 with SMTP id hk11so127365859pad.1;
        Fri, 23 Oct 2015 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZPrPUntZAtud3d+V4k2NMZ9l2iUIuOgMMoDiAvna8Jk=;
        b=tvI1JooJc2tgYBjgnu6AqEVdgkPk2Nwd7pUF8jkONTgu7EOgFotzHXH3xdNB3U75hy
         oYXvVZu7t3BHVzNp62Xch7RCUK16fv0862iKwj0HGbQu2Gu+ulPNU+pk42EXuwU/hXTy
         CbiJcBBypNyJSCdc46kDDm6GaeiJt00A1i3QxiRnSigAO3qI3UzYWBgBm5FwpI1lC2rf
         rZb6/OVrB4jdxtAiMQ8Ela2MJLglCNrhBUn7+05/gRv4bPiC6JSArW3avg5mBSLhcKMi
         jUAvT8ihHhmkOxHqVoS30vjLcntPC4speym2drz5oeHIVXWvGi+micqGB0cGuHkIm8rf
         8yUg==
X-Received: by 10.68.197.9 with SMTP id iq9mr7056325pbc.123.1445632815580;
        Fri, 23 Oct 2015 13:40:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id hq8sm20579639pad.35.2015.10.23.13.40.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 13:40:15 -0700 (PDT)
Date:   Fri, 23 Oct 2015 13:40:13 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/10] phy: phy_brcmstb_sata: remove unused definitions
Message-ID: <20151023204013.GO13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49666
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

On Fri, Oct 23, 2015 at 10:44:18AM +0900, Jaedon Shin wrote:
> Remove unused definitions.

The first one is actually a duplicate (oops!), so is that technically
"unused" or just redundant?

Pedantry aside:

Acked-by: Brian Norris <computersforpeace@gmail.com>

> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/phy/phy-brcmstb-sata.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 8a2cb16a1937..0be55dafe9ea 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -26,8 +26,6 @@
>  
>  #define SATA_MDIO_BANK_OFFSET				0x23c
>  #define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
> -#define SATA_MDIO_REG_SPACE_SIZE			0x1000
> -#define SATA_MDIO_REG_LENGTH				0x1f00
>  
>  #define MAX_PORTS					2
>  
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
