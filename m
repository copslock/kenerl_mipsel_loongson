Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 01:23:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19379 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491116Ab1IMXXr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2011 01:23:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e6fe6480000>; Tue, 13 Sep 2011 16:24:56 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 13 Sep 2011 16:23:43 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 13 Sep 2011 16:23:41 -0700
Message-ID: <4E6FE5F9.2060604@cavium.com>
Date:   Tue, 13 Sep 2011 16:23:37 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Kumar Gala <galak@kernel.crashing.org>, grant.likely@secretlab.ca
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
References: <1314820906-14004-1-git-send-email-david.daney@cavium.com> <1314820906-14004-3-git-send-email-david.daney@cavium.com> <129FAAB3-C9AD-43F6-A8CB-96548A47C4DC@kernel.crashing.org>
In-Reply-To: <129FAAB3-C9AD-43F6-A8CB-96548A47C4DC@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2011 23:23:42.0937 (UTC) FILETIME=[2D534C90:01CC726C]
X-archive-position: 31070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6851

On 09/13/2011 04:07 PM, Kumar Gala wrote:
>
>> diff --git a/Documentation/devicetree/bindings/net/mdio-mux.txt b/Documentation/devicetree/bindings/net/mdio-mux.txt
>> new file mode 100644
>> index 0000000..a908312
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/mdio-mux.txt
>> @@ -0,0 +1,132 @@
>> +Common MDIO bus multiplexer/switch properties.
>> +
>> +An MDIO bus multiplexer/switch will have several child busses that are
>> +numbered uniquely in a device dependent manner.  The nodes for an MDIO
>> +bus multiplexer/switch will have one child node for each child bus.
>> +
>> +Required properties:
>> +- parent-bus : phandle to the parent MDIO bus.
>
> Should probably be mdio-parent-bus

Why?  We know it is MDIO.

Serial bus multiplexing is not a concept limited to MDIO.  We would want 
to use "parent-bus" for some I2C multiplexers as well.

>
>> +
>> +Optional properties:
>> +- Other properties specific to the multiplexer/switch hardware.
>> +
>> +Required properties for child nodes:
>> +- #address-cells =<1>;
>> +- #size-cells =<0>;
>> +- cell-index : The sub-bus number.
>
> What does sub-bus number mean?

There are N child buses (or sub-buses) coming out of the multiplexer. 
The cell-index is used as a handle or identifier for each of these.

The concrete example in Patch 3/3 is a multiplexer with four child 
buses.  The happen to have cell-indexes of 0, 1, 2 and 3.

In the GPIO case of patch 3/3, these directly correspond the the state 
of the two GPIO pins controlling the multiplexer.  The driver then uses 
the cell-index property to determine the state of the GPIO to connect 
any given child.

It is possible that the documentation part of the patch could be made 
more clear about this.

>
>> +
>> +
>> +Example :
>
[...]
>> +
>> +int mdio_mux_probe(struct platform_device *pdev,
>> +		   int (*switch_fn)(int cur, int desired, void *data),
>> +		   void *data)
>> +{
>> +	struct device_node *parent_bus_node;
>> +	struct device_node *child_bus_node;
>> +	int r, n, ret_val;
>> +	struct mii_bus *parent_bus;
>> +	struct mdio_mux_parent_bus *pb;
>> +	struct mdio_mux_child_bus *cb;
>> +
>> +	if (!pdev->dev.of_node)
>> +		return -ENODEV;
>> +
>> +	parent_bus_node = of_parse_phandle(pdev->dev.of_node, "parent-bus", 0);
>> +
>> +	if (!parent_bus_node)
>> +		return -ENODEV;
>> +
>> +	parent_bus = of_mdio_find_bus(parent_bus_node);
>
>
> So what happens if the parent bus probe happens after the mux probe?
>

The whole house of cards collapses.

Grant Likely has a patch to deal with this by retrying the probing,  but 
as far as I know, it has not been merged yet.
