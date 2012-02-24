Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 18:21:46 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13803 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903760Ab2BXRVl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 18:21:41 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f47c7880000>; Fri, 24 Feb 2012 09:23:20 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 24 Feb 2012 09:21:37 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 24 Feb 2012 09:21:37 -0800
Message-ID: <4F47C720.6050503@cavium.com>
Date:   Fri, 24 Feb 2012 09:21:36 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Florian Fainelli <florian@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging/octeon: Fix PHY binding in octeon-ethernet driver.
References: <1330024771-25396-1-git-send-email-ddaney.cavm@gmail.com> <4F47587D.5050303@openwrt.org>
In-Reply-To: <4F47587D.5050303@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Feb 2012 17:21:37.0591 (UTC) FILETIME=[C3C19470:01CCF318]
X-archive-position: 32550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/24/2012 01:29 AM, Florian Fainelli wrote:
> Le 02/23/12 20:19, David Daney a écrit :
>> From: David Daney<david.daney@cavium.com>
>>
>> Commit d6c25be (mdio-octeon: use an unique MDIO bus name.) changed the
>> names used to refer to MDIO buses. The ethernet driver must be
>> changed to match, so that the PHY drivers can be attached.
>>
>> Cc: Florian Fainelli<florian@openwrt.org>
>> Signed-off-by: David Daney<david.daney@cavium.com>
> Acked-by: Florian Fainelli <florian@openwrt.org>


I would also add (and should have in the original post), that the commit 
causing the regression was merged for 3.3.  So if possible, it would be 
nice to get this in before the final 3.3.

Thanks,
David Daney

>> ---
>> drivers/staging/octeon/ethernet-mdio.c | 4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/octeon/ethernet-mdio.c
>> b/drivers/staging/octeon/ethernet-mdio.c
>> index 63800ba..e31949c 100644
>> --- a/drivers/staging/octeon/ethernet-mdio.c
>> +++ b/drivers/staging/octeon/ethernet-mdio.c
>> @@ -164,9 +164,9 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
>>
>> int phy_addr = cvmx_helper_board_get_mii_address(priv->port);
>> if (phy_addr != -1) {
>> - char phy_id[20];
>> + char phy_id[MII_BUS_ID_SIZE + 3];
>>
>> - snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "0", phy_addr);
>> + snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "mdio-octeon-0",
>> phy_addr);
>>
>> priv->phydev = phy_connect(dev, phy_id, cvm_oct_adjust_link, 0,
>> PHY_INTERFACE_MODE_GMII);
>
>
