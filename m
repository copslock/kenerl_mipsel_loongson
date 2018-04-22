Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Apr 2018 21:18:34 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:62842 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991307AbeDVTS0nqm2s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Apr 2018 21:18:26 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2630B410BB;
        Sun, 22 Apr 2018 21:18:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id LgC0IIU9Ef7R; Sun, 22 Apr 2018 21:18:20 +0200 (CEST)
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
To:     Mathias Kresin <dev@kresin.me>, john@phrozen.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     martin.blumenstingl@googlemail.com, stable@vger.kernel.org
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <2c128bec-ce46-5063-cd61-6f4257ba2a3e@hauke-m.de>
Date:   Sun, 22 Apr 2018 21:18:17 +0200
MIME-Version: 1.0
In-Reply-To: <1523176203-18926-1-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8
Content-Language: de-LU
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 04/08/2018 10:30 AM, Mathias Kresin wrote:
> While doing a global software reset, these bits are not cleared and let
> some bootloader fail to initialise the GPHYs. The bootloader don't
> expect the GPHYs in reset, as they aren't during power on.
> 
> The asserts were a workaround for a wrong syscon-reboot mask. With a
> mask set which includes the GPHY resets, these resets aren't required
> any more.
> 
> Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
> Cc: stable@vger.kernel.org # 4.14+
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  drivers/soc/lantiq/gphy.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
> index 8d86594..8c31ae7 100644
> --- a/drivers/soc/lantiq/gphy.c
> +++ b/drivers/soc/lantiq/gphy.c
> @@ -30,7 +30,6 @@ struct xway_gphy_priv {
>  	struct clk *gphy_clk_gate;
>  	struct reset_control *gphy_reset;
>  	struct reset_control *gphy_reset2;
> -	struct notifier_block gphy_reboot_nb;
>  	void __iomem *membase;
>  	char *fw_name;
>  };
> @@ -64,24 +63,6 @@ static const struct of_device_id xway_gphy_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, xway_gphy_match);
>  
> -static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
> -{
> -	return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
> -}
> -
> -static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
> -				   unsigned long code, void *unused)
> -{
> -	struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
> -
> -	if (priv) {
> -		reset_control_assert(priv->gphy_reset);
> -		reset_control_assert(priv->gphy_reset2);
> -	}
> -
> -	return NOTIFY_DONE;
> -}
> -
>  static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
>  			  dma_addr_t *dev_addr)
>  {
> @@ -205,14 +186,6 @@ static int xway_gphy_probe(struct platform_device *pdev)
>  	reset_control_deassert(priv->gphy_reset);
>  	reset_control_deassert(priv->gphy_reset2);
>  
> -	/* assert the gphy reset because it can hang after a reboot: */
> -	priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
> -	priv->gphy_reboot_nb.priority = -1;
> -
> -	ret = register_reboot_notifier(&priv->gphy_reboot_nb);
> -	if (ret)
> -		dev_warn(dev, "Failed to register reboot notifier\n");
> -
>  	platform_set_drvdata(pdev, priv);
>  
>  	return ret;
> @@ -224,17 +197,10 @@ static int xway_gphy_remove(struct platform_device *pdev)
>  	struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	reset_control_assert(priv->gphy_reset);
> -	reset_control_assert(priv->gphy_reset2);
> -
>  	iowrite32be(0, priv->membase);
>  
>  	clk_disable_unprepare(priv->gphy_clk_gate);
>  
> -	ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
> -	if (ret)
> -		dev_warn(dev, "Failed to unregister reboot notifier\n");
> -
>  	return 0;
>  }
>  
> 
