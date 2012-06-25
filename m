Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 01:11:40 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:39465 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902233Ab2FYXLd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 01:11:33 +0200
Received: by pbbrq13 with SMTP id rq13so7780964pbb.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jun 2012 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+sOS1E5/ke5OPIFj/77n0kHt6ArCAIQRpDTGC0cnuFs=;
        b=hqpXqGe6Svi/PP2BEDHpR6nObBAVQr9v7uMSRrUqfgoeOaPYRLi9qEMKSaBvS6ZPIB
         AfIMMkr9ZuD11IxuhF6EM4KHa8V/V10oeq0lub0wObqewLPTSG6OeQlWTukoyuuhrSmF
         5oRS+kVuWliMTjxtOnAelgxUmk0qRtsNqpIseiSIF7w1c3yPhD5GKj3m7iUhfS9AKskl
         iQadtyYpE55pxnS9vGR8shNAQM/OPNgQDprgVq7oWVuszqucj/baf1IDRW9ltmP8RmFf
         LMbmXmua4GytjGEkvUQPb7IXXGuTBcF/WIZNw3ODhBTFn/k7ZfFx3gwrlp4tQdNEABm0
         1Wew==
Received: by 10.68.200.102 with SMTP id jr6mr46585347pbc.0.1340665886330;
        Mon, 25 Jun 2012 16:11:26 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id na10sm9846305pbc.23.2012.06.25.16.11.24
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 16:11:25 -0700 (PDT)
Message-ID: <4FE8F01B.2020207@gmail.com>
Date:   Mon, 25 Jun 2012 16:11:23 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, david.daney@cavium.com
Subject: Re: [PATCH 1/4] netdev/phy: Handle IEEE802.3 clause 45 Ethernet PHYs
References: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>   <1340411056-18988-2-git-send-email-ddaney.cavm@gmail.com> <20120625.153440.17010814246237639.davem@davemloft.net>
In-Reply-To: <20120625.153440.17010814246237639.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/25/2012 03:34 PM, David Miller wrote:
> From: David Daney<ddaney.cavm@gmail.com>
> Date: Fri, 22 Jun 2012 17:24:13 -0700
>
>> From: David Daney<david.daney@cavium.com>
>>
>> The IEEE802.3 clause 45 MDIO bus protocol allows for directly
>> addressing PHY registers using a 21 bit address, and is used by many
>> 10G Ethernet PHYS.  Already existing is the ability of MDIO bus
>> drivers to use clause 45, with the MII_ADDR_C45 flag.  Here we add
>> struct phy_c45_device_ids to hold the device identifier registers
>> present in clause 45. struct phy_device gets a couple of new fields:
>> c45_ids to hold the identifiers and is_c45 to signal that it is clause
>> 45.
>>
>> Normally the MII_ADDR_C45 flag is ORed with the register address to
>> indicate a clause 45 transaction.  Here we also use this flag in the
>> *device* address passed to get_phy_device() to indicate that probing
>> should be done with clause 45 transactions.
>>
>> EXPORT phy_device_create() so that the follow-on patch to of_mdio.c
>> can use it to create phy devices for PHYs, that have non-standard
>> device identifier registers, based on the device tree bindings.
>>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>
> I see no value in having two ways to say that clause-45 transactions
> should be used.
>
> Either make it a PHY device attribute, or specify it in the address
> in the register accesses, but not both.
>

Do you realize that at the time get_phy_device() is called, there is no 
PHY device?  So there can be no attribute, nor are we passing a register 
address.  Neither of these suggestions apply to this situation.

We need to know a priori if it is c22 or c45.  So we need to communicate 
the type somehow to get_phy_device().  I chose an unused bit in the addr 
parameter to do this, another option would be to add a separate 
parameter to get_phy_device() specifying the type.



> Also your patch is full of coding style errors, I simply couldn't
> stomache applying this even if I agreed with the substance of the
> changes:
>
>> +	     i<  ARRAY_SIZE(c45_ids->device_ids)&&
>> +		     c45_ids->devices_in_package == 0;
>
> c45_ids on the second line should line up with the initial 'i'
> on the first line.
>
>> +		c45_ids->devices_in_package = (phy_reg&  0xffff)<<  16;
>> +
>> +
>> +		reg_addr = MII_ADDR_C45 | i<<  16 | 5;
>
> There is not reason in the world to have two empty lines there, it
> looks awful.

OK, I will fix those...

>
>> +		/*
>> +		 * If mostly Fs, there is no device there,
>> +		 * let's get out of here.
>> +		 */
>
> Format comments:
>
> 	/* Like
> 	 * this.
> 	 */
>
> Not.
>
> 	/*
> 	 * Like
> 	 * this.
> 	 */

... and this one too I guess.  Really you and Linus should come to a 
consensus on this one.

[...]
>
>> +/*
>> + * phy_c45_device_ids: 802.3-c45 Device Identifiers
>> + *
>> + * devices_in_package: Bit vector of devices present.
>> + * device_ids: The device identifer for each present device.
>> + */
>
> If you're going to list the struct members use the correct kerneldoc
> format to do so.

OK.

David Daney
