Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 18:34:35 +0100 (CET)
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34042 "EHLO
        mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006617AbbKRReclF4BA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 18:34:32 +0100
Received: by ykfs79 with SMTP id s79so77468145ykf.1;
        Wed, 18 Nov 2015 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BF0jaLoh8c795eNpfIYmOTsMkVEvGWDg6AlamPYbFb4=;
        b=SOqHhYfgf1QDLPnxsjIR43G/CdyhSFTzlwKpg+egikCMDlZXdDK2HAGOmkun3lxg50
         oTQvULmXlSBo7bxRCzBmnUmtyJr4vJvkzAKlmb5uOsYIzwO3zpYJR7WqNkfUbMqp6pw4
         xuofFfFjmBw8TUC26C67xhZdPbqtJyoJyE+V1tZ6zAg8vMLitETdD15WuG5CHhWskY8A
         J/6bV89AmCTnVQewRjyYS29khd0s9gr2gEl+wjMBbs2GD6qIqAJ9COq5g9o6gFVtVpOJ
         uVbIjTeYeezE28RY/0sPzLb+t5Lv+GKppVVpLUn9mgNvvYo5xXXIHfjHzQ+zDlbTk8EO
         K3mQ==
X-Received: by 10.129.106.193 with SMTP id f184mr46825498ywc.157.1447790486631;
        Tue, 17 Nov 2015 12:01:26 -0800 (PST)
Received: from mtj.duckdns.org ([2620:10d:c091:200::a:4bca])
        by smtp.gmail.com with ESMTPSA id u8sm7425748ywa.19.2015.11.17.12.01.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 12:01:26 -0800 (PST)
Date:   Tue, 17 Nov 2015 15:01:23 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [v4 02/10] ata: ahci_brcmstb: add quirk for broken ncq
Message-ID: <20151117200123.GD22864@mtj.duckdns.org>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
 <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

Hello,

On Fri, Oct 30, 2015 at 11:01:16PM +0900, Jaedon Shin wrote:
> +static void brcm_sata_quirks(struct platform_device *pdev,
> +			     struct brcm_ahci_priv *priv)
> +{
> +	if (priv->quirks & BRCM_AHCI_QUIRK_NONCQ) {
> +		void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
> +		void __iomem *ahci;
> +		struct resource *res;
> +		u32 reg;
> +
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "ahci");
> +		ahci = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(ahci))
> +			return;
> +
> +		reg = brcm_sata_readreg(ctrl);
> +		reg |= OVERRIDE_HWINIT;
> +		brcm_sata_writereg(reg, ctrl);
> +
> +		/* Clear out the NCQ bit so the AHCI driver will not issue
> +		 * FPDMA/NCQ commands.
> +		 */
> +		reg = readl(ahci + HOST_CAP);
> +		reg &= ~HOST_CAP_NCQ;
> +		writel(reg, ahci + HOST_CAP);
> +
> +		reg = brcm_sata_readreg(ctrl);
> +		reg &= ~OVERRIDE_HWINIT;
> +		brcm_sata_writereg(reg, ctrl);
> +
> +		devm_iounmap(&pdev->dev, ahci);
> +		devm_release_mem_region(&pdev->dev, res->start,
> +					resource_size(res));
> +	}
> +}

Does the controller actually need HOST_CAP_NCQ bit turned off to work
correctly?  If the only thing necessary is the host not issuing NCQ
commands, setting AHCI_HFLAG_NO_NCQ should do.

>  static void brcm_sata_init(struct brcm_ahci_priv *priv)
>  {
>  	/* Configure endianness */
> @@ -256,6 +297,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  
> +	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
> +		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
> +
> +	brcm_sata_quirks(pdev, priv);

What's the point of "branch - set a bit - test the bit" sequence?
Just do

	if (of_device_is_compatiable(...))
		brcm_ahci_disable_ncq(...);

Thanks.

-- 
tejun
