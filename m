Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 10:09:16 +0200 (CEST)
Received: from mail-la0-f48.google.com ([209.85.215.48]:36758 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011165AbbHGIJMmFWSz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 10:09:12 +0200
Received: by lagz9 with SMTP id z9so17683036lag.3
        for <linux-mips@linux-mips.org>; Fri, 07 Aug 2015 01:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xUP/+nJNczl38Sxv9i9i6J3erjo7NBtcdExkYUAIVF0=;
        b=bCne2LegNlQVVhQXA4T16Zw+fKndTwUsoT8o4tqU3wvIRMByNQuYfYDzcexOJTUx3R
         UuEVGB9BYsTh8FOHHeS6bfIbNpNVCROrlRcQkLlaCZYb9AK7T3nBSMfMqJTKd1mHv0o4
         vxufsyAIvWHF9Gm/LXwHctpUDrbB9g29UkMxKDDAyySgmBVnVuzOlugDHY4yJZ2MimxX
         xwFnZ5IrM3Fpp0W9epD3gLVkdBxF/3rMLXUWoA+lkqbCD63N9kxFZe7HLTpp+fgxR0iN
         7weC1HfDXa4u75XhdTxrgMk2DL7/42zV+4O6sF535cpAjseDJVzYC5rh8wbpSlDLuvB7
         iSHQ==
X-Gm-Message-State: ALoCoQmBfyt7upy8WJuIkPlx8KqMPFPGqb02gs7WbYtS5B5uyVXpwDPR7Yv2fE2u/Ag18x9dANNv
X-Received: by 10.112.171.68 with SMTP id as4mr6369489lbc.64.1438934947068;
        Fri, 07 Aug 2015 01:09:07 -0700 (PDT)
Received: from [10.0.0.11] ([80.82.22.190])
        by smtp.googlemail.com with ESMTPSA id xh11sm1987075lac.4.2015.08.07.01.09.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2015 01:09:06 -0700 (PDT)
Message-ID: <55C467A0.4020601@linaro.org>
Date:   Fri, 07 Aug 2015 10:09:04 +0200
From:   Tomasz Nowicki <tomasz.nowicki@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Firefox/31.0 Thunderbird/31.8.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org
CC:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tomasz.nowicki@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomasz.nowicki@linaro.org
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

On 07.08.2015 02:33, David Daney wrote:
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
>                      Tomasz Nowicki <tomasz.nowicki@linaro.org>
>                      Robert Richter <rrichter@cavium.com>
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 137 +++++++++++++++++++++-
>   1 file changed, 135 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index 615b2af..2056583 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -6,6 +6,7 @@
>    * as published by the Free Software Foundation.
>    */
>
> +#include <linux/acpi.h>
>   #include <linux/module.h>
>   #include <linux/interrupt.h>
>   #include <linux/pci.h>
> @@ -26,7 +27,7 @@
>   struct lmac {
>   	struct bgx		*bgx;
>   	int			dmac;
> -	unsigned char		mac[ETH_ALEN];
> +	u8			mac[ETH_ALEN];
>   	bool			link_up;
>   	int			lmacid; /* ID within BGX */
>   	int			lmacid_bd; /* ID on board */
> @@ -835,6 +836,133 @@ static void bgx_get_qlm_mode(struct bgx *bgx)
>   	}
>   }
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
>   #if IS_ENABLED(CONFIG_OF_MDIO)
>
>   static int bgx_init_of_phy(struct bgx *bgx)
> @@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
>
>   static int bgx_init_phy(struct bgx *bgx)
>   {
> -	return bgx_init_of_phy(bgx);
> +	int err = bgx_init_of_phy(bgx);
> +
> +	if (err != -ENODEV)
> +		return err;
> +
> +	return bgx_init_acpi_phy(bgx);
>   }
>

If kernel can work with DT and ACPI (both compiled in), it should take 
only one path instead of probing DT and ACPI sequentially. How about:

@@ -902,10 +925,9 @@ static int bgx_probe(struct pci_dev *pdev, const 
struct pci_device_id *ent)
  	bgx_vnic[bgx->bgx_id] = bgx;
  	bgx_get_qlm_mode(bgx);

-	snprintf(bgx_sel, 5, "bgx%d", bgx->bgx_id);
-	np = of_find_node_by_name(NULL, bgx_sel);
-	if (np)
-		bgx_init_of(bgx, np);
+	err = acpi_disabled ? bgx_init_of_phy(bgx) : bgx_init_acpi_phy(bgx);
+	if (err)
+		goto err_enable;

  	bgx_init_hw(bgx);


Regards,
Tomasz
