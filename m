Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 19:37:26 +0200 (CEST)
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:19691
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013231AbbHGRhYUru1y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Aug 2015 19:37:24 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BY1PR0701MB1721.namprd07.prod.outlook.com (10.162.111.140) with Microsoft
 SMTP Server (TLS) id 15.1.225.19; Fri, 7 Aug 2015 17:37:14 +0000
Message-ID: <55C4ECC6.7050908@caviumnetworks.com>
Date:   Fri, 7 Aug 2015 10:37:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Mark Rutland <mark.rutland@arm.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <grant.likely@linaro.org>,
        <rob.herring@linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Robert Richter <rrichter@cavium.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        <deviectree@vger.kernel.org>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com> <20150807140106.GE7646@leverpostej>
In-Reply-To: <20150807140106.GE7646@leverpostej>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR07CA0041.namprd07.prod.outlook.com (25.162.170.179) To
 BY1PR0701MB1721.namprd07.prod.outlook.com (25.162.111.140)
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1721;2:jzpi8t47Hd9RG71+l701xNvQi51C7APYk+vHSfpoLjqB6b5ZT1UrE7C1wc4cVZouLyL98JfAosRtzd77zRB2KuoU2WphIpKuV/ioQqbOZcTZy0V+fc385mHKD5hD1uSDOlY0BNTnISd/i57ARgfc8aMeAT6DwqcmOyjDayY/f/8=;3:hFkGG+t3HHUB2kn4BAXT9n/oydoryG+z9zSwT52TymstSPHCCKUIToTtF16sxFcDLVjHK/k5o5/KWIpYYnKvimbeJor1iwrK2z/i3fru91sUPI2WRH0viNqjScMCejtT0atxT5aeIEf90EIGAP395A==;25:dNNJEk+vqhBWyc3seB/C/19SEYNHWlXlMUl+WwiF75q2wfmk81bl6NeRCsELEIPoPWbypmm60jnufVIAvYWkurgA4dqh6JwX4lkWtJFDEy7rtdmRXiy346HbK1te4wDBwFEigYRGigYAgakqKYbKoU9GPiK0NfCaapqmtH5TFjjHrNHfJYsUB0+0FTGx7k11Wl1NwHGO9GMXevwgDtPWIqiGAdjMZVIABY+jelsEA2h/s32k8FTE6femNHqtdIxHoV5th48qC7JUOj4HXGpDgw==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1721;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1721;20:K8Brj2a+Dk52Zqy+2XX6VkMjU0HRNu3QnfRroa6zpIxUxNwF0yqngiAdYjdPNUB7r+tb1iWmwibpYQ3gEGoS7ggZHL1LWYn9kSptUW1N3iRv+FYeHUMDZmZaiYwYGoKzZHQghKgbcYnCZjYuHiG+yruqSYTPHLFdIYjWmB23JwUjuUPDo/Csrqo7zOOsstzigJwccBKeq813xeWVCe6puV+o3G/eU/jmLGcJUMHInxmVDzT9ennzt9IwrqEqx42VTIPJpvgFJQf3ypB87INdXHnjLidBG4qEDvB0VL2nqrjkHF/qgwPiOP6dc36NLxIXJeCCOuQjOcl124yT2WfHlMlYbFvEGsKvXtOC0ViAeWwB5JUODcEknh9DD+UEVuXUH+Cv1KAJ0fqpd/giHb2tqfrjQSsu2Lhzgrna1LtkSW8ekvLWt+c6gcd1BJx8ck80ytgX9EyywYjflocgJR/zl6r5BAmDxDnWve7z7HXaGrSYyYgmlN1c593YXb/1J3WW8xV9G67k0bz29g7RvER/PCZpK4Vx2ubYqgIpdmr3Yr1jRSXVaJEaM6Jf8zCWXzxVNGQej5vpzMKGfTLp0mlbvpNWwDhpkvcaYYtX89gouqc=;4:I607PQhl/uOrKll1QYIxKxPwoEOIBZCnaOkVGLGkQM77U23ibjqfZ7tAsUA1dEfxarRstLkOqxZGL5hIriMRNIcSB2AsLD9CcVpuiF8tNu19mc6WeR8FxFdZp2644gZzJOT05LPT1D7dy4MtR3sNHbwAhLnLu21GZWtW12YzJHYC7lBFZwSZHMUhBaeTEr9AOX/4FeMsIvMxj2uAeo5qlb0ETQLviUw22Am9KaRPp/BGPMx28FKnw3aLBcH84QUSgOCKEWgDJ+BxevGrjxW72Gd1MIh38j1mbVSQlvlLIFo=
X-Microsoft-Antispam-PRVS: <BY1PR0701MB17215DF1D9FD8E5914CFF23C9A730@BY1PR0701MB1721.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BY1PR0701MB1721;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1721;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(377454003)(199003)(189002)(24454002)(479174004)(106356001)(62966003)(97736004)(77156002)(64706001)(83506001)(92566002)(40100003)(59896002)(46102003)(19580405001)(122386002)(50466002)(189998001)(65956001)(65806001)(33656002)(66066001)(80316001)(19580395003)(110136002)(87266999)(47776003)(54356999)(23756003)(42186005)(4001540100001)(50986999)(64126003)(65816999)(77096005)(76176999)(4001350100001)(81156007)(68736005)(87976001)(5001960100002)(5001920100001)(53416004)(2950100001)(36756003)(5001860100001)(5001830100001)(69596002)(105586002)(101416001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1721;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BY1PR0701MB1721;23:vsuClcw7QiqIyxqdwPNOn1Dvmz/vp31GDZnHu?=
 =?iso-8859-1?Q?xujXH9A+IgWPo4EzD+agnuGUSxgHEFPd/iMiKoEF3o5Twpk9oRInFYEL6Y?=
 =?iso-8859-1?Q?Mj9tCROc94eNAMEhBFV3DDIKrzTSBio71DyZsjA+bd/s2DYdLi9/KYs7Hd?=
 =?iso-8859-1?Q?jjvvn5+lHIySKYxSBsWKthYi6F5WZXeGFaM+xyVjh4GJZsT+qIGm1ewG6l?=
 =?iso-8859-1?Q?g+Qad0F0NZvP20j2LEtXn3QlgX2q++SDzziuZHj8vbiWSK0KdcVSJfV7bO?=
 =?iso-8859-1?Q?wCRXUjFAHhQgYn9z5DiA7dO4q5dUiPHRIANIuIoRiEd5oUQK8vdcUkW59J?=
 =?iso-8859-1?Q?YtmiIhJi+WTx4og5FM9D4TpMjNufOIotkIpR96HI4e3fq3UJFUABMPVEoZ?=
 =?iso-8859-1?Q?MT/vo7m+YNrjUWfOr9ceAkbl9mlL040K5UgBkxQslp0BPRnSOGIJW/VIpe?=
 =?iso-8859-1?Q?zSRVJ6ug1RsmNi0Et1oTPibYYojH0AhR2t0Bk/afsWb6jCIhPflubixPug?=
 =?iso-8859-1?Q?BzD0QKSlg+NGW6uezxJ3a/uOhlJSjPECDVgV1lFrGrvHJOSPTpxQsYRALM?=
 =?iso-8859-1?Q?vFgK40ln+75A8pw5v7p3afZ+Zo3mUlVYZ1RPs0sI9hnl7fh9txPKiZuOw6?=
 =?iso-8859-1?Q?+9Qj2UYk+z8VYD3sZ5lidTOi8jxenONIY21RKnBiLtRA01d20G+EGSNJh0?=
 =?iso-8859-1?Q?6citIk3uUN5V1Jti6lUiuth/Xz5IA4RZ6F2Jj7N575fjjtYg22Fo0wLMDL?=
 =?iso-8859-1?Q?p5O9fCe7TpPUEK4XzvoN5Qb2WTh4YPuA4fCAwHOIHfx+H58uwqbCWK05pQ?=
 =?iso-8859-1?Q?k54zjcZx1gfc/mkPeQ1DxQa9/qfMa/kZS0gGPQT1b+UYAH52d/n2K/kXkd?=
 =?iso-8859-1?Q?4S2AlfCb/+CcEnThTVEpfW7OpQAc1TVFjto9JKbHCio5ce3E9MJ6vhf1Q+?=
 =?iso-8859-1?Q?2Xlyxfg7JjGQ52ZvafOX7cYWfhylIlQO509U/TpsfBWia/ehiWAPIK6mu/?=
 =?iso-8859-1?Q?WJSGKz6Ymm0QtsHqfguLF4L7Y5TNQnzM9JREekIHRJd/PPetIVyI0rIeyN?=
 =?iso-8859-1?Q?+4p8e+qHP0mtOysSeCT5R+MwbA46qL84ls3NimmNgM+KlETX06tmF5i0bO?=
 =?iso-8859-1?Q?hn4jFm250JLvlN4qbrpOIX7FVu42tl3rDPaI/fxjJjc9OafmEgUY9rO8qi?=
 =?iso-8859-1?Q?/3I2RG6iwifZNN5TiHcrTncJlRG5VfdGfs/Uw8sIRmU/ITct191Dlgv7Lg?=
 =?iso-8859-1?Q?ud48wAxm6UdQm3HzawgyjCQMCyBSC8vj1ek5HFU2s7QfnEVEiye4GsvrQD?=
 =?iso-8859-1?Q?6L/C6wlhJkcx/BgzZjuF8zDEmVnaJT9dg2foG72YiMHLrOHKuRLW8UBDmI?=
 =?iso-8859-1?Q?fYkv3j/FZ9Gjm61TgdvUYotrRHXEdgWILX3FaM+Y99NNV6TdbxTsA=3D?=
 =?iso-8859-1?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1721;5:87lQevdv0v6w9qWzfLfb9JA9p7svrHhYp8zQ8PQCiPR04cyEHObRPUV2MeoJ/Dzz0dAtlN5qrRTd+pJlNbWkiSmUuTJkoFK5AWK4WTZzWHgGxfryvqrDWfxc8eWohbxI/oo0hYcZ6oCZr72tLHXLjA==;24:zVQVf5dr6aO0vYeFEOnWAo/U50PpcWGoBVA7YFfXMYSd74uJF7b7xWRa9ouzklnlcLe23Y6BkNrRuJmmCoGHGtyQGab0ij2qnzXtHPeiAqI=;20:jMYEKq7Z3SNTT94G3H+yuZHqMFTZ9BXKQg9jOar+HdI6cQ4krGJDg61L/BN+M/9ihq1ouB+HHhGdmxUQ/ICauA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2015 17:37:14.3454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1721
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 08/07/2015 07:01 AM, Mark Rutland wrote:
> On Fri, Aug 07, 2015 at 01:33:10AM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Find out which PHYs belong to which BGX instance in the ACPI way.
>>
>> Set the MAC address of the device as provided by ACPI tables. This is
>> similar to the implementation for devicetree in
>> of_get_mac_address(). The table is searched for the device property
>> entries "mac-address", "local-mac-address" and "address" in that
>> order. The address is provided in a u64 variable and must contain a
>> valid 6 bytes-len mac addr.
>>
>> Based on code from: Narinder Dhillon <ndhillon@cavium.com>
>>                      Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>                      Robert Richter <rrichter@cavium.com>
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Signed-off-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 137 +++++++++++++++++++++-
>>   1 file changed, 135 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>> index 615b2af..2056583 100644
>> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>> @@ -6,6 +6,7 @@
>>    * as published by the Free Software Foundation.
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/module.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/pci.h>
>> @@ -26,7 +27,7 @@
>>   struct lmac {
>>   	struct bgx		*bgx;
>>   	int			dmac;
>> -	unsigned char		mac[ETH_ALEN];
>> +	u8			mac[ETH_ALEN];
>>   	bool			link_up;
>>   	int			lmacid; /* ID within BGX */
>>   	int			lmacid_bd; /* ID on board */
>> @@ -835,6 +836,133 @@ static void bgx_get_qlm_mode(struct bgx *bgx)
>>   	}
>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +
>> +static int bgx_match_phy_id(struct device *dev, void *data)
>> +{
>> +	struct phy_device *phydev = to_phy_device(dev);
>> +	u32 *phy_id = data;
>> +
>> +	if (phydev->addr == *phy_id)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static const char * const addr_propnames[] = {
>> +	"mac-address",
>> +	"local-mac-address",
>> +	"address",
>> +};
>
> If these are going to be generally necessary, then we should get them
> adopted as standardised _DSD properties (ideally just one of them).

As far as I can tell, and please correct me if I am wrong, ACPI-6.0 
doesn't contemplate MAC addresses.

Today we are using "mac-address", which is an Integer containing the MAC 
address in its lowest order 48 bits in Little-Endian byte order.

The hardware and ACPI tables are here today, and we would like to 
support it.  If some future ACPI specification specifies a standard way 
to do this, we will probably adapt the code to do this in a standard manner.


>
> [...]
>
>> +static acpi_status bgx_acpi_register_phy(acpi_handle handle,
>> +					 u32 lvl, void *context, void **rv)
>> +{
>> +	struct acpi_reference_args args;
>> +	const union acpi_object *prop;
>> +	struct bgx *bgx = context;
>> +	struct acpi_device *adev;
>> +	struct device *phy_dev;
>> +	u32 phy_id;
>> +
>> +	if (acpi_bus_get_device(handle, &adev))
>> +		goto out;
>> +
>> +	SET_NETDEV_DEV(&bgx->lmac[bgx->lmac_count].netdev, &bgx->pdev->dev);
>> +
>> +	acpi_get_mac_address(adev, bgx->lmac[bgx->lmac_count].mac);
>> +
>> +	bgx->lmac[bgx->lmac_count].lmacid = bgx->lmac_count;
>> +
>> +	if (acpi_dev_get_property_reference(adev, "phy-handle", 0, &args))
>> +		goto out;
>> +
>> +	if (acpi_dev_get_property(args.adev, "phy-channel", ACPI_TYPE_INTEGER, &prop))
>> +		goto out;
>
> Likewise for any inter-device properties, so that we can actually handle
> them in a generic fashion, and avoid / learn from the mistakes we've
> already handled with DT.

This is the fallacy of the ACPI is superior to DT argument.  The 
specification of PHY topology and MAC addresses is well standardized in 
DT, there is no question about what the proper way to specify it is. 
Under ACPI, it is the Wild West, there is no specification, so each 
system design is forced to invent something, and everybody comes up with 
an incompatible implementation.

That said, this is all specific to our BGX device, so anything we do 
doesn't break other devices.

David Daney
