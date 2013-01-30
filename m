Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 02:11:45 +0100 (CET)
Received: from webmail.solarflare.com ([12.187.104.25]:14398 "EHLO
        webmail.solarflare.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833269Ab3A3BLodZpEq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jan 2013 02:11:44 +0100
Received: from [10.17.20.137] (10.17.20.137) by ocex02.SolarFlarecom.com
 (10.20.40.31) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Jan
 2013 17:11:35 -0800
Message-ID: <1359508293.4144.29.camel@bwh-desktop.uk.solarflarecom.com>
Subject: Re: [PATCH 1/2] NET: ethernet/netlogic: Netlogic XLR/XLS GMAC driver
From:   Ben Hutchings <bhutchings@solarflare.com>
To:     <ganesanr@broadcom.com>
CC:     <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>
Date:   Wed, 30 Jan 2013 01:11:33 +0000
In-Reply-To: <1359450699-26141-1-git-send-email-ganesanr@broadcom.com>
References: <1359450699-26141-1-git-send-email-ganesanr@broadcom.com>
Organization: Solarflare
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.17.20.137]
X-TM-AS-Product-Ver: SMEX-10.0.0.1412-7.000.1014-19594.005
X-TM-AS-Result: No--18.095400-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-archive-position: 35620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhutchings@solarflare.com
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

On Tue, 2013-01-29 at 14:41 +0530, ganesanr@broadcom.com wrote:
> From: Ganesan Ramalingam <ganesanr@broadcom.com>
> 
> Add support for the Network Accelerator Engine on Netlogic XLR/XLS
> MIPS SoCs. The XLR/XLS NAE blocks can be configured as one 10G
> interface or four 1G interfaces. This driver supports blocks
> with 1G ports.
> 
> Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
> ---
>  This patch has to be merged through netdev tree.
>  Please review and let me know if there are any comments or suggestions.
> 
>  drivers/net/ethernet/Kconfig            |    1 +
>  drivers/net/ethernet/Makefile           |    1 +
>  drivers/net/ethernet/netlogic/Kconfig   |    8 +
>  drivers/net/ethernet/netlogic/Makefile  |    1 +
>  drivers/net/ethernet/netlogic/xlr_net.c | 1132 +++++++++++++++++++++++++++++++
>  drivers/net/ethernet/netlogic/xlr_net.h | 1098 ++++++++++++++++++++++++++++++
>  6 files changed, 2241 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/ethernet/netlogic/Kconfig
>  create mode 100644 drivers/net/ethernet/netlogic/Makefile
>  create mode 100644 drivers/net/ethernet/netlogic/xlr_net.c
>  create mode 100644 drivers/net/ethernet/netlogic/xlr_net.h

Why add a netlogic directory when the company is now a part of Broadcom?

[...]
> --- /dev/null
> +++ b/drivers/net/ethernet/netlogic/xlr_net.c
[...]
> +/* Ethtool operation */
> +static int xlr_get_settings(struct net_device *ndev, struct ethtool_cmd *ecmd)
> +{
> +	return 0;
> +}
> +
> +static int xlr_set_settings(struct net_device *ndev, struct ethtool_cmd *ecmd)
> +{
> +	return 0;
> +}
> +
> +static void xlr_get_drvinfo(struct net_device *ndev,
> +		struct ethtool_drvinfo *drvinfo)
> +{
> +	return;
> +}
> +
> +static u32 xlr_get_link(struct net_device *ndev)
> +{
> +	return 0;
> +}
> +
> +static struct ethtool_ops xlr_ethtool_ops = {
> +	.get_settings = xlr_get_settings,
> +	.set_settings = xlr_set_settings,
> +	.get_drvinfo = xlr_get_drvinfo,
> +	.get_link = xlr_get_link,
> +};

Either implement them or don't.  I'm guessing that phylib can handle
get_settings and set_settings for you.

[...]
> +static netdev_tx_t xlr_net_start_xmit(struct sk_buff *skb,
> +               struct net_device *ndev)
> +{
> +       struct nlm_fmn_msg msg;
> +       struct xlr_net_priv *priv = netdev_priv(ndev);
> +       int ret;
> +       u16 qmap;
> +       u32 flags;
> +
> +       qmap = skb->queue_mapping;
> +       xlr_make_tx_desc(&msg, virt_to_phys(skb->data), skb);
> +       flags = nlm_cop2_enable();
> +       ret = nlm_fmn_send(2, 0, priv->nd->tx_stnid, &msg);
> +       nlm_cop2_restore(flags);
> +       return NETDEV_TX_OK;
> +}

If nlm_fmn_send() fails then you need to free the skbuff.

[...]
> +static void xlr_stats(struct net_device *ndev, struct net_device_stats *stats)
> +{
> +	struct xlr_net_priv *priv = netdev_priv(ndev);
> +
> +	stats->rx_packets = nlm_read_reg(priv->base_addr, RX_PACKET_COUNTER);
> +	stats->tx_packets = nlm_read_reg(priv->base_addr, TX_PACKET_COUNTER);
> +	stats->rx_bytes = nlm_read_reg(priv->base_addr, RX_BYTE_COUNTER);
> +	stats->tx_bytes = nlm_read_reg(priv->base_addr, TX_BYTE_COUNTER);

32-bit byte counters for a 1G/10G device?  Seriously?

[...]
> +struct net_device_stats *xlr_get_stats(struct net_device *ndev)
> +{
> +	struct net_device_stats *stats = &ndev->stats;
> +
> +	xlr_stats(ndev, stats);
> +	return stats;
> +}

You should probably be implementing ndo_get_stats64 to provide 64-bit
stats even on a 32-bit kernel.

> +static int xlr_net_probe(struct platform_device *pdev)
> +{
[...]
> +	ndev->watchdog_timeo = 1000 * HZ;
[...]

A watchdog timeout of 1000 seconds is ridiculous.  I guess someone just
kept seeing the watchdog fire and increasing the timeout, and never
thought about *why* this was happening.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
