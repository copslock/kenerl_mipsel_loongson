Return-Path: <SRS0=+lB5=UX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E141C43613
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9552054F
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NbqKe19X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfFXPkI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:40:08 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36768 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFXPkH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 24 Jun 2019 11:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BtLJYS2pbo8gfBfK3+LW+FXb5v0L7I5asBNqbGWt/ss=; b=NbqKe19XKOrUqUMQYY6OHxVFI
        lXReB/NBf2iwMArBO9z8xRF1R2HLsIobpo6zlyBoSKDRtM2XXbHE+gFHJs1pLPOq+m4/LCgxqaU/e
        W+1HjvaPJbkedxXAI+plW4Hu63Lg1XC5iGrn40pT+ZeHbxTrPghVWs+2KYVmYu8mMVA5Ygq1cFepQ
        zYO+6FqXUCQ70SvCjKZ0Cd4HUDZcHBMHMqfeU94kNK8AoIyntrF8Lche09yfw0lJwM+OkDjGfm+q1
        nQma/qQ4AQArsvTowQXWbbB5VoRrl/FFj2fqiXZv3d+1aQ34h9MuVrNWDyaoeTUXxfTMn2nMNaXaK
        vynDdG3VA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59046)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hfR4U-0000b6-Lo; Mon, 24 Jun 2019 16:39:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hfR4Q-0006Qa-Nx; Mon, 24 Jun 2019 16:39:50 +0100
Date:   Mon, 24 Jun 2019 16:39:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     =?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>
Cc:     sean.wang@mediatek.com, f.fainelli@gmail.com, davem@davemloft.net,
        matthias.bgg@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        frank-w@public-files.de, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/5] net: dsa: mt7530: Convert to PHYLINK API
Message-ID: <20190624153950.hdsuhrvfd77heyor@shell.armlinux.org.uk>
References: <20190624145251.4849-1-opensource@vdorst.com>
 <20190624145251.4849-2-opensource@vdorst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624145251.4849-2-opensource@vdorst.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Mon, Jun 24, 2019 at 04:52:47PM +0200, Ren� van Dorst wrote:
> Convert mt7530 to PHYLINK API
> 
> Signed-off-by: Ren� van Dorst <opensource@vdorst.com>
> ---
>  drivers/net/dsa/mt7530.c | 237 +++++++++++++++++++++++++++++----------
>  drivers/net/dsa/mt7530.h |   9 ++
>  2 files changed, 187 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 3181e95586d6..9c5e4dd00826 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -13,7 +13,7 @@
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
>  #include <linux/of_platform.h>
> -#include <linux/phy.h>
> +#include <linux/phylink.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -633,63 +633,6 @@ mt7530_get_sset_count(struct dsa_switch *ds, int port, int sset)
>  	return ARRAY_SIZE(mt7530_mib);
>  }
>  
> -static void mt7530_adjust_link(struct dsa_switch *ds, int port,
> -			       struct phy_device *phydev)
> -{
> -	struct mt7530_priv *priv = ds->priv;
> -
> -	if (phy_is_pseudo_fixed_link(phydev)) {
> -		dev_dbg(priv->dev, "phy-mode for master device = %x\n",
> -			phydev->interface);
> -
> -		/* Setup TX circuit incluing relevant PAD and driving */
> -		mt7530_pad_clk_setup(ds, phydev->interface);
> -
> -		if (priv->id == ID_MT7530) {
> -			/* Setup RX circuit, relevant PAD and driving on the
> -			 * host which must be placed after the setup on the
> -			 * device side is all finished.
> -			 */
> -			mt7623_pad_clk_setup(ds);
> -		}
> -	} else {
> -		u16 lcl_adv = 0, rmt_adv = 0;
> -		u8 flowctrl;
> -		u32 mcr = PMCR_USERP_LINK | PMCR_FORCE_MODE;
> -
> -		switch (phydev->speed) {
> -		case SPEED_1000:
> -			mcr |= PMCR_FORCE_SPEED_1000;
> -			break;
> -		case SPEED_100:
> -			mcr |= PMCR_FORCE_SPEED_100;
> -			break;
> -		}
> -
> -		if (phydev->link)
> -			mcr |= PMCR_FORCE_LNK;
> -
> -		if (phydev->duplex) {
> -			mcr |= PMCR_FORCE_FDX;
> -
> -			if (phydev->pause)
> -				rmt_adv = LPA_PAUSE_CAP;
> -			if (phydev->asym_pause)
> -				rmt_adv |= LPA_PAUSE_ASYM;
> -
> -			lcl_adv = linkmode_adv_to_lcl_adv_t(
> -				phydev->advertising);
> -			flowctrl = mii_resolve_flowctrl_fdx(lcl_adv, rmt_adv);
> -
> -			if (flowctrl & FLOW_CTRL_TX)
> -				mcr |= PMCR_TX_FC_EN;
> -			if (flowctrl & FLOW_CTRL_RX)
> -				mcr |= PMCR_RX_FC_EN;
> -		}
> -		mt7530_write(priv, MT7530_PMCR_P(port), mcr);
> -	}
> -}
> -
>  static int
>  mt7530_cpu_port_enable(struct mt7530_priv *priv,
>  		       int port)
> @@ -1323,6 +1266,178 @@ mt7530_setup(struct dsa_switch *ds)
>  	return 0;
>  }
>  
> +static void mt7530_phylink_mac_config(struct dsa_switch *ds, int port,
> +				      unsigned int mode,
> +				      const struct phylink_link_state *state)
> +{
> +	struct mt7530_priv *priv = ds->priv;
> +	u32 mcr = PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | PMCR_BACKOFF_EN |
> +		  PMCR_BACKPR_EN | PMCR_TX_EN | PMCR_RX_EN;
> +
> +	switch (port) {
> +	case 0: /* Internal phy */
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		if (state->interface != PHY_INTERFACE_MODE_GMII)
> +			goto unsupported;
> +		break;
> +	/* case 5: Port 5 is not supported! */
> +	case 6: /* 1st cpu port */
> +		if (state->interface != PHY_INTERFACE_MODE_RGMII &&
> +		    state->interface != PHY_INTERFACE_MODE_TRGMII)
> +			goto unsupported;
> +
> +		/* Setup TX circuit incluing relevant PAD and driving */
> +		mt7530_pad_clk_setup(ds, state->interface);
> +
> +		if (priv->id == ID_MT7530) {
> +			/* Setup RX circuit, relevant PAD and driving on the
> +			 * host which must be placed after the setup on the
> +			 * device side is all finished.
> +			 */
> +			mt7623_pad_clk_setup(ds);
> +		}
> +		break;
> +	default:
> +		dev_err(ds->dev, "%s: unsupported port: %i\n", __func__, port);
> +		return;
> +	}
> +
> +	if (!state->an_enabled || mode == MLO_AN_FIXED) {
> +		mcr |= PMCR_FORCE_MODE;
> +
> +		if (state->speed == SPEED_1000)
> +			mcr |= PMCR_FORCE_SPEED_1000;
> +		if (state->speed == SPEED_100)
> +			mcr |= PMCR_FORCE_SPEED_100;
> +		if (state->duplex == DUPLEX_FULL)
> +			mcr |= PMCR_FORCE_FDX;
> +		if (state->link || mode == MLO_AN_FIXED)
> +			mcr |= PMCR_FORCE_LNK;

This should be removed - state->link is not for use in mac_config.
Even in fixed mode, the link can be brought up/down by means of a
gpio, and this should be dealt with via the mac_link_* functions.

> +		if (state->pause || phylink_test(state->advertising, Pause))
> +			mcr |= PMCR_TX_FC_EN | PMCR_RX_FC_EN;
> +		if (state->pause & MLO_PAUSE_TX)
> +			mcr |= PMCR_TX_FC_EN;
> +		if (state->pause & MLO_PAUSE_RX)
> +			mcr |= PMCR_RX_FC_EN;

This is clearly wrong - if any bit in state->pause is set, then we
end up with both PMCR_TX_FC_EN | PMCR_RX_FC_EN set.  If we have Pause
Pause set in the advertising mask, then both are set.  This doesn't
seem right - are these bits setting the advertisement, or are they
telling the MAC to use flow control?

> +	}
> +
> +	mt7530_write(priv, MT7530_PMCR_P(port), mcr);
> +
> +	return;
> +
> +unsupported:
> +	dev_err(ds->dev, "%s: P%d: Unsupported phy_interface mode: %d (%s)\n",
> +		__func__, port, state->interface, phy_modes(state->interface));
> +}
> +
> +static void mt7530_phylink_mac_link_down(struct dsa_switch *ds, int port,
> +					 unsigned int mode,
> +					 phy_interface_t interface)
> +{
> +	/* Do nothing */
> +}
> +
> +static void mt7530_phylink_mac_link_up(struct dsa_switch *ds, int port,
> +				       unsigned int mode,
> +				       phy_interface_t interface,
> +				       struct phy_device *phydev)
> +{
> +	/* Do nothing */
> +}

These two are where you should be forcing the link up or down if
required (basically, inband modes should let the link come up/down
irrespective of these functions, otherwise it should be forced.)

> +
> +static void mt7530_phylink_validate(struct dsa_switch *ds, int port,
> +				    unsigned long *supported,
> +				    struct phylink_link_state *state)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
> +
> +	switch (port) {
> +	case 0: /* Internal phy */
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		if (state->interface != PHY_INTERFACE_MODE_NA &&
> +		    state->interface != PHY_INTERFACE_MODE_GMII)
> +			goto unsupported;
> +		break;
> +	/* case 5: Port 5 not supported! */
> +	case 6: /* 1st cpu port */
> +		if (state->interface != PHY_INTERFACE_MODE_RGMII &&
> +		    state->interface != PHY_INTERFACE_MODE_TRGMII)

PHY_INTERFACE_MODE_NA ?

> +			goto unsupported;
> +		break;
> +	default:
> +		linkmode_zero(supported);
> +		dev_err(ds->dev, "%s: unsupported port: %i\n", __func__, port);
> +		return;
> +	}
> +
> +	phylink_set(mask, Autoneg);
> +	phylink_set(mask, Pause);
> +	phylink_set(mask, Asym_Pause);
> +	phylink_set(mask, MII);
> +
> +	phylink_set(mask, 10baseT_Half);
> +	phylink_set(mask, 10baseT_Full);
> +	phylink_set(mask, 100baseT_Half);
> +	phylink_set(mask, 100baseT_Full);
> +	phylink_set(mask, 1000baseT_Full);
> +	phylink_set(mask, 1000baseT_Half);

You seem to be missing phylink_set_port_modes() here.

> +
> +	linkmode_and(supported, supported, mask);
> +	linkmode_and(state->advertising, state->advertising, mask);
> +	return;
> +
> +unsupported:
> +	linkmode_zero(supported);
> +	dev_err(ds->dev, "%s: unsupported interface mode: [0x%x] %s\n",
> +		__func__, state->interface, phy_modes(state->interface));

Not a good idea to print this at error level; sometimes we just probe
for support.

Eg, think about a SFP cage, and a SFP is plugged in that uses a PHY
interface mode that the MAC can't support - we detect that by the
validation failing, and printing a more meaningful message in phylink
itself.

> +}
> +
> +static int
> +mt7530_phylink_mac_link_state(struct dsa_switch *ds, int port,
> +			      struct phylink_link_state *state)
> +{
> +	struct mt7530_priv *priv = ds->priv;
> +	u32 pmsr;
> +
> +	if (port < 0 || port >= MT7530_NUM_PORTS)
> +		return -EINVAL;
> +
> +	pmsr = mt7530_read(priv, MT7530_PMSR_P(port));
> +
> +	state->link = (pmsr & PMSR_LINK);
> +	state->an_complete = state->link;
> +	state->duplex = (pmsr & PMSR_DPX) >> 1;
> +
> +	switch (pmsr & (PMSR_SPEED_1000 | PMSR_SPEED_100)) {
> +	case 0:
> +		state->speed = SPEED_10;
> +		break;
> +	case PMSR_SPEED_100:
> +		state->speed = SPEED_100;
> +		break;
> +	case PMSR_SPEED_1000:
> +		state->speed = SPEED_1000;
> +		break;
> +	default:
> +		state->speed = SPEED_UNKNOWN;
> +		break;
> +	}
> +
> +	state->pause = 0;
> +	if (pmsr & PMSR_RX_FC)
> +		state->pause |= MLO_PAUSE_RX;
> +	if (pmsr & PMSR_TX_FC)
> +		state->pause |= MLO_PAUSE_TX;
> +
> +	return 1;
> +}
> +
>  static const struct dsa_switch_ops mt7530_switch_ops = {
>  	.get_tag_protocol	= mtk_get_tag_protocol,
>  	.setup			= mt7530_setup,
> @@ -1331,7 +1446,6 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
>  	.phy_write		= mt7530_phy_write,
>  	.get_ethtool_stats	= mt7530_get_ethtool_stats,
>  	.get_sset_count		= mt7530_get_sset_count,
> -	.adjust_link		= mt7530_adjust_link,
>  	.port_enable		= mt7530_port_enable,
>  	.port_disable		= mt7530_port_disable,
>  	.port_stp_state_set	= mt7530_stp_state_set,
> @@ -1344,6 +1458,11 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
>  	.port_vlan_prepare	= mt7530_port_vlan_prepare,
>  	.port_vlan_add		= mt7530_port_vlan_add,
>  	.port_vlan_del		= mt7530_port_vlan_del,
> +	.phylink_validate	= mt7530_phylink_validate,
> +	.phylink_mac_link_state = mt7530_phylink_mac_link_state,
> +	.phylink_mac_config	= mt7530_phylink_mac_config,
> +	.phylink_mac_link_down	= mt7530_phylink_mac_link_down,
> +	.phylink_mac_link_up	= mt7530_phylink_mac_link_up,
>  };
>  
>  static const struct of_device_id mt7530_of_match[] = {
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index bfac90f48102..41d9a132ac70 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -198,6 +198,7 @@ enum mt7530_vlan_port_attr {
>  #define  PMCR_FORCE_SPEED_100		BIT(2)
>  #define  PMCR_FORCE_FDX			BIT(1)
>  #define  PMCR_FORCE_LNK			BIT(0)
> +#define  PMCR_FORCE_LNK_DOWN		PMCR_FORCE_MODE
>  #define  PMCR_COMMON_LINK		(PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | \
>  					 PMCR_BACKOFF_EN | PMCR_BACKPR_EN | \
>  					 PMCR_TX_EN | PMCR_RX_EN | \
> @@ -218,6 +219,14 @@ enum mt7530_vlan_port_attr {
>  					 PMCR_TX_FC_EN | PMCR_RX_FC_EN)
>  
>  #define MT7530_PMSR_P(x)		(0x3008 + (x) * 0x100)
> +#define  PMSR_EEE1G			BIT(7)
> +#define  PMSR_EEE100M			BIT(6)
> +#define  PMSR_RX_FC			BIT(5)
> +#define  PMSR_TX_FC			BIT(4)
> +#define  PMSR_SPEED_1000		BIT(3)
> +#define  PMSR_SPEED_100			BIT(2)
> +#define  PMSR_DPX			BIT(1)
> +#define  PMSR_LINK			BIT(0)
>  
>  /* Register for MIB */
>  #define MT7530_PORT_MIB_COUNTER(x)	(0x4000 + (x) * 0x100)
> -- 
> 2.20.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
