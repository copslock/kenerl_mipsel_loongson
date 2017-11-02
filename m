Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 13:43:49 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:47164 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993310AbdKBMnlT7J8N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 13:43:41 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eAEqR-0006oC-DF; Thu, 02 Nov 2017 13:43:39 +0100
Date:   Thu, 2 Nov 2017 13:43:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH 6/7] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171102124339.GF4772@lunn.ch>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-7-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102003606.19913-7-david.daney@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

> +static int bgx_probe(struct platform_device *pdev)
> +{
> +	struct mac_platform_data platform_data;
> +	const __be32 *reg;
> +	u32 port;
> +	u64 addr;
> +	struct device_node *child;
> +	struct platform_device *new_dev;
> +	struct platform_device *pki_dev;
> +	int numa_node, interface;
> +	int i;
> +	int r = 0;
> +	char id[64];
> +	u64 data;
> +
> +	reg = of_get_property(pdev->dev.of_node, "reg", NULL);
> +	addr = of_translate_address(pdev->dev.of_node, reg);
> +	interface = (addr >> 24) & 0xf;
> +	numa_node = (addr >> 36) & 0x7;
> +
> +	/* Assign 8 CAM entries per LMAC */
> +	for (i = 0; i < 32; i++) {
> +		data = i >> 3;
> +		oct_csr_write(data, BGX_CMR_RX_ADRX_CAM(numa_node, interface, i));
> +	}
> +
> +	for_each_available_child_of_node(pdev->dev.of_node, child) {
> +		snprintf(id, sizeof(id), "%llx.%u.ethernet-mac",
> +			 (unsigned long long)addr, port);
> +		new_dev = of_platform_device_create(child, id, &pdev->dev);
> +		if (!new_dev) {
> +			dev_err(&pdev->dev, "Error creating %s\n", id);
> +			continue;
> +		}
> +		platform_data.mac_type = BGX_MAC;
> +		platform_data.numa_node = numa_node;
> +		platform_data.interface = interface;
> +		platform_data.port = port;
> +		if (is_xcv)
> +			platform_data.src_type = XCV;
> +		else
> +			platform_data.src_type = QLM;
> +
> +		/* Add device to the list of created devices so we can remove it
> +		 * on exit.
> +		 */
> +		pdev_item = kmalloc(sizeof(*pdev_item), GFP_KERNEL);
> +		pdev_item->pdev = new_dev;
> +		mutex_lock(&pdev_list_lock);
> +		list_add(&pdev_item->list, &pdev_list);
> +		mutex_unlock(&pdev_list_lock);
> +
> +		i = atomic_inc_return(&pki_id);
> +		pki_dev = platform_device_register_data(&new_dev->dev,
> +							is_mix ? "octeon_mgmt" : "ethernet-mac-pki",
> +							i, &platform_data, sizeof(platform_data));
> +		dev_info(&pdev->dev, "Created %s %u: %p\n",
> +			 is_mix ? "MIX" : "PKI", pki_dev->id, pki_dev);

Is there any change of these ethernet ports being used to connect to
an Ethernet switch. We have had issues in the past with these sort of
platform devices combined with DSA.

	 Andrew
