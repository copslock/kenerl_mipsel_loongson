Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 16:54:20 +0200 (CEST)
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33737 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012265AbbHGOyShYs20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 16:54:18 +0200
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A969820306
        for <linux-mips@linux-mips.org>; Fri,  7 Aug 2015 10:54:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 07 Aug 2015 10:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=slimlogic.co.uk;
         h=cc:content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=pJTZK
        3VjcM6PoVveSxLeD+PFw0k=; b=UlSg19iApuZ4ACUqBDGtB8YHHwJb3vHVYs0HM
        OQq39Ns0xfetOUVnMCQ5gYS5pYkW3GBs3n5qSwHxKdf9fzgW9dy8N/woM68bZ1KX
        /Qo2yAGCsRf3TGhYIzfkSo3uu6n9+J9t1uH5wwEeCB4l8mIHc+dRbi8Dr1M2+xDg
        +AzvTM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=pJTZK3VjcM6PoVveSxLeD+PFw0k=; b=ZxjHo
        250G/QXMSqA3wd9U3ISh2RV/vI0iSYS59cuRHM77JSAJmzFW8W8nyGsvdsfNeCOU
        MvsXrcWoC05+ZCiLaB48ydIWYLjyD7y1I/8RuhlohnlRsdM4Vg/FhpWQsB+/7/wv
        Cd0Ju9dIIojyeSHOmjuGrbjUrJqH25tYJNlCVI=
X-Sasl-enc: 74bmpBXYtO7JJ1gVmpu46wL8ZtBPiMG3BN2LPwu/oHZE 1438959257
Received: from localhost (host-92-22-10-194.as13285.net [92.22.10.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF75A68015A;
        Fri,  7 Aug 2015 10:54:16 -0400 (EDT)
Date:   Fri, 7 Aug 2015 15:54:14 +0100
From:   Graeme Gregory <gg@slimlogic.co.uk>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
Message-ID: <20150807145414.GA5468@xora-haswell.xora.org.uk>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
 <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gg@slimlogic.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gg@slimlogic.co.uk
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

On Thu, Aug 06, 2015 at 05:33:10PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Find out which PHYs belong to which BGX instance in the ACPI way.
> 
> Set the MAC address of the device as provided by ACPI tables. This is
> similar to the implementation for devicetree in
> of_get_mac_address(). The table is searched for the device property
> entries "mac-address", "local-mac-address" and "address" in that
> order. The address is provided in a u64 variable and must contain a
> valid 6 bytes-len mac addr.
> 
> Based on code from: Narinder Dhillon <ndhillon@cavium.com>
>                     Tomasz Nowicki <tomasz.nowicki@linaro.org>
>                     Robert Richter <rrichter@cavium.com>
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 137 +++++++++++++++++++++-
>  1 file changed, 135 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index 615b2af..2056583 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -6,6 +6,7 @@
>   * as published by the Free Software Foundation.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/pci.h>
> @@ -26,7 +27,7 @@
>  struct lmac {
>  	struct bgx		*bgx;
>  	int			dmac;
> -	unsigned char		mac[ETH_ALEN];
> +	u8			mac[ETH_ALEN];
>  	bool			link_up;
>  	int			lmacid; /* ID within BGX */
>  	int			lmacid_bd; /* ID on board */
> @@ -835,6 +836,133 @@ static void bgx_get_qlm_mode(struct bgx *bgx)
>  	}
>  }
>  
> +#ifdef CONFIG_ACPI
> +
> +static int bgx_match_phy_id(struct device *dev, void *data)
> +{
> +	struct phy_device *phydev = to_phy_device(dev);
> +	u32 *phy_id = data;
> +
> +	if (phydev->addr == *phy_id)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static const char * const addr_propnames[] = {
> +	"mac-address",
> +	"local-mac-address",
> +	"address",
> +};
> +
> +static int acpi_get_mac_address(struct acpi_device *adev, u8 *dst)
> +{
> +	const union acpi_object *prop;
> +	u64 mac_val;
> +	u8 mac[ETH_ALEN];
> +	int i, j;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(addr_propnames); i++) {
> +		ret = acpi_dev_get_property(adev, addr_propnames[i],
> +					    ACPI_TYPE_INTEGER, &prop);

Shouldn't this be trying to use device_property_read_* API and making
the DT/ACPI path the same where possible?

Graeme

> +		if (ret)
> +			continue;
> +
> +		mac_val = prop->integer.value;
> +
> +		if (mac_val & (~0ULL << 48))
> +			continue;	/* more than 6 bytes */
> +
> +		for (j = 0; j < ARRAY_SIZE(mac); j++)
> +			mac[j] = (u8)(mac_val >> (8 * j));
> +		if (!is_valid_ether_addr(mac))
> +			continue;
> +
> +		memcpy(dst, mac, ETH_ALEN);
> +
> +		return 0;
> +	}
> +
> +	return ret ? ret : -EINVAL;
> +}
> +
> +static acpi_status bgx_acpi_register_phy(acpi_handle handle,
> +					 u32 lvl, void *context, void **rv)
> +{
> +	struct acpi_reference_args args;
> +	const union acpi_object *prop;
> +	struct bgx *bgx = context;
> +	struct acpi_device *adev;
> +	struct device *phy_dev;
> +	u32 phy_id;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		goto out;
> +
> +	SET_NETDEV_DEV(&bgx->lmac[bgx->lmac_count].netdev, &bgx->pdev->dev);
> +
> +	acpi_get_mac_address(adev, bgx->lmac[bgx->lmac_count].mac);
> +
> +	bgx->lmac[bgx->lmac_count].lmacid = bgx->lmac_count;
> +
> +	if (acpi_dev_get_property_reference(adev, "phy-handle", 0, &args))
> +		goto out;
> +
> +	if (acpi_dev_get_property(args.adev, "phy-channel", ACPI_TYPE_INTEGER, &prop))
> +		goto out;
> +
> +	phy_id = prop->integer.value;
> +
> +	phy_dev = bus_find_device(&mdio_bus_type, NULL, (void *)&phy_id,
> +				  bgx_match_phy_id);
> +	if (!phy_dev)
> +		goto out;
> +
> +	bgx->lmac[bgx->lmac_count].phydev = to_phy_device(phy_dev);
> +out:
> +	bgx->lmac_count++;
> +	return AE_OK;
> +}
> +
> +static acpi_status bgx_acpi_match_id(acpi_handle handle, u32 lvl,
> +				     void *context, void **ret_val)
> +{
> +	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct bgx *bgx = context;
> +	char bgx_sel[5];
> +
> +	snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
> +	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &string))) {
> +		pr_warn("Invalid link device\n");
> +		return AE_OK;
> +	}
> +
> +	if (strncmp(string.pointer, bgx_sel, 4))
> +		return AE_OK;
> +
> +	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +			    bgx_acpi_register_phy, NULL, bgx, NULL);
> +
> +	kfree(string.pointer);
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static int bgx_init_acpi_phy(struct bgx *bgx)
> +{
> +	acpi_get_devices(NULL, bgx_acpi_match_id, bgx, (void **)NULL);
> +	return 0;
> +}
> +
> +#else
> +
> +static int bgx_init_acpi_phy(struct bgx *bgx)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif /* CONFIG_ACPI */
> +
>  #if IS_ENABLED(CONFIG_OF_MDIO)
>  
>  static int bgx_init_of_phy(struct bgx *bgx)
> @@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  
>  static int bgx_init_phy(struct bgx *bgx)
>  {
> -	return bgx_init_of_phy(bgx);
> +	int err = bgx_init_of_phy(bgx);
> +
> +	if (err != -ENODEV)
> +		return err;
> +
> +	return bgx_init_acpi_phy(bgx);
>  }
>  
>  static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
