Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 10:30:24 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:45649 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2BXJaU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 10:30:20 +0100
Received: by bkcjk13 with SMTP id jk13so2378021bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 01:30:15 -0800 (PST)
Received-SPF: pass (google.com: domain of f.fainelli@gmail.com designates 10.204.149.147 as permitted sender) client-ip=10.204.149.147;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of f.fainelli@gmail.com designates 10.204.149.147 as permitted sender) smtp.mail=f.fainelli@gmail.com; dkim=pass header.i=f.fainelli@gmail.com
Received: from mr.google.com ([10.204.149.147])
        by 10.204.149.147 with SMTP id t19mr680244bkv.124.1330075815275 (num_hops = 1);
        Fri, 24 Feb 2012 01:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MYC//gsSD5oSZl9SlBNK5sxc0DL3iqXGDaqao88MkT0=;
        b=lJ+17O88iRFsAiMWlPeeUjdxqmcosG8o2XweR3hCwnQ1aMXqlRBAoiF7GvzgfsUGzo
         q4bcpoa7xgoG2wFpSkCCTReFx8qLEDwru4HgF6klxOGLmIqkIuRwNAYeoi7tuuHdExUP
         fGI/9zWJ/tOms+2ZEUyHwdLEtnIJ9ZkJdrbHs=
Received: by 10.204.149.147 with SMTP id t19mr565891bkv.124.1330075815189;
        Fri, 24 Feb 2012 01:30:15 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id i2sm7448403bkd.10.2012.02.24.01.30.13
        (version=SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 01:30:13 -0800 (PST)
Message-ID: <4F47587D.5050303@openwrt.org>
Date:   Fri, 24 Feb 2012 10:29:33 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, devel@driverdev.osuosl.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] staging/octeon: Fix PHY binding in octeon-ethernet driver.
References: <1330024771-25396-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1330024771-25396-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 32537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Le 02/23/12 20:19, David Daney a écrit :
> From: David Daney<david.daney@cavium.com>
>
> Commit d6c25be (mdio-octeon: use an unique MDIO bus name.) changed the
> names used to refer to MDIO buses.  The ethernet driver must be
> changed to match, so that the PHY drivers can be attached.
>
> Cc: Florian Fainelli<florian@openwrt.org>
> Signed-off-by: David Daney<david.daney@cavium.com>
Acked-by: Florian Fainelli <florian@openwrt.org>
> ---
>   drivers/staging/octeon/ethernet-mdio.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
> index 63800ba..e31949c 100644
> --- a/drivers/staging/octeon/ethernet-mdio.c
> +++ b/drivers/staging/octeon/ethernet-mdio.c
> @@ -164,9 +164,9 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
>
>   	int phy_addr = cvmx_helper_board_get_mii_address(priv->port);
>   	if (phy_addr != -1) {
> -		char phy_id[20];
> +		char phy_id[MII_BUS_ID_SIZE + 3];
>
> -		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "0", phy_addr);
> +		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "mdio-octeon-0", phy_addr);
>
>   		priv->phydev = phy_connect(dev, phy_id, cvm_oct_adjust_link, 0,
>   					PHY_INTERFACE_MODE_GMII);
