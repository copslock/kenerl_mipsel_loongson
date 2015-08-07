Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 20:15:05 +0200 (CEST)
Received: from mail-bn1on0065.outbound.protection.outlook.com ([157.56.110.65]:36310
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013300AbbHGSPDli7ly (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Aug 2015 20:15:03 +0200
Received: from BN3PR0701MB1720.namprd07.prod.outlook.com (10.163.39.19) by
 BN3PR0701MB1219.namprd07.prod.outlook.com (10.160.115.13) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 7 Aug 2015 18:14:52 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1720.namprd07.prod.outlook.com (10.163.39.19) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 7 Aug 2015 18:14:49 +0000
Message-ID: <55C4F597.50103@caviumnetworks.com>
Date:   Fri, 7 Aug 2015 11:14:47 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Graeme Gregory <gg@slimlogic.co.uk>
CC:     David Daney <ddaney.cavm@gmail.com>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Robert Richter <rrichter@cavium.com>,
        "Tomasz Nowicki" <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>,
        "David Daney" <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com> <20150807145414.GA5468@xora-haswell.xora.org.uk>
In-Reply-To: <20150807145414.GA5468@xora-haswell.xora.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0081.namprd07.prod.outlook.com (25.163.126.49)
 To BN3PR0701MB1720.namprd07.prod.outlook.com (25.163.39.19)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1720;2:I1b1mHhkqbSbxY68gPl47fYr0idWVROg8QsdmMy0bppHrm4PRvcTA/UmIQFSctO935bGK2NiarkZsX7ZuCmioMHN16zYgStt3x0ycSL30stUIXxzif5ZoHzmWhRzmkDjcesgZcwHjrSSl9RYrs6Lf5uz1eVO/pA1xTJYkeEtolQ=;3:RZA+8fZV9y/hbwjTHqWNeZkna92hogzRlnI8wHdkGG1FNCYZhkf1d2xFwujiHCF24UfutMIYveQh3uzhufEDk4TJLFV8BtD+J61X0vM7hwIofj7zMC9rVhk9DvH78Q8FTYfG1im2ueNYz/PI1Q+y0WOusvgsRWD7K9QxWqw3D8Oc9J/QLumFe3GX9OJvDpho;25:+vV79j7cFSuP5r3xtwXwmHcFDOeTfdt1ETzzpRBML28DxO7k7mPN/krbBcPESbrq8dumu/H2VR8XcmG5wMYjs7B8G/dRSeX2C1N+zekCM/6IO5tgjY1j9MDNnJqKzn+TC9ceTT5X6n7y1Am3MbTOTWwqflv8Ph33kKldz6MBraM5pqVzjd58Y+FeyjjrdTGSTnzC2fYgYXZsQ3I9e6II81PoXnSM9xqjiDYuhhXwlBrBiZhgTnoslDwbSk4BkTzKoiebuxz31e5EOUqg5StRXA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(42134001)(42139001);SRVR:BN3PR0701MB1720;UriScan:;BCL:0;PCL:0;RULEID:(42134001)(42139001);SRVR:BN3PR0701MB1219;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1720;20:FsF6l26zS9F4LvA5mVD240jxfftRyMM2nQcdH1/TKyaqZ9KRUIZumP3q5FozW5czljDqDZv/X4C5TOcXkvhRRdeGjpR3ko0EbcOj5Q8xThfZzgzek28T83bLRlPm+Mu4tloepNHM0bdZrCmAdr6mPXCrtSeX4XE7cn2x85A4gUB4oT2/Q0fR49bs9imJITPn7Wm4OQzDnUMjpSOQC/ItQXnmNfDDrHR5HJstLH4joqUqYs8E4BIzbFYN8Umt4POM4yNrZQLoMXAtMC0YojGuQRl+t7NAac1LrCZESmjdL78pyomkrYtxO7kbLFM8K5SFFSqJf+fNn6ZHpKXMsCYwvIVqlmRo4Wvt6/lOp6rMCobEp61YHXAJhfoTNVXnsP043Xz8vllhxF30TajapDFWnI931TkRbRYodjAXod93SF4oI8ZvVLeKtYMKui+D0bqTZoybPsvYKRjz5xW3GuZbWk1X/qrgtcZh1FEOo0sCAS4A0OKIlqFgzXhyCG6H8rSkQgiYCjZLmAUQrRUpshmvd7IelUNPTEXF6jDXnaYhxWHzgae6jkt7up+daVng0lk2brRj+dZAx9Lp+qJSRS81aKc4JGFNlisbuKII4iuqfGc=;4:dDR6ZP8tjnxvvryv3qK65U0HBtS10FJfujigaoQP+Kbp7BR8HEKmoxMMI17ZurKaOJ74aeD8/92OJjOaaHWAqzCOSQX11V8ZVZLV/RtpsUBWNZL+yBUhqwdpR0+GyIFAvHocnndHb7+5WBdh8/hOSpmCvkfPdj5U4pbXSWaqq7gbRZBe6fCQdgqKYMtAS8M+hGoKD7ecKr7pR99WpZ8Ofv9XDrUu1YaPhtrYe6Fwx7yK0B/Bfc2XFTJUJLQSn0FBnxUElHbINN03wmRYfjhujN/qN8pq6V8V2qCAVKHyGvk=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB17201DB5B2ED5D791B0493059A730@BN3PR0701MB1720.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1720;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1720;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(377454003)(24454002)(189002)(479174004)(199003)(50466002)(105586002)(62966003)(42186005)(189998001)(65956001)(46102003)(77156002)(2950100001)(65806001)(64706001)(36756003)(77096005)(40100003)(47776003)(66066001)(15975445007)(4001350100001)(106356001)(110136002)(87976001)(64126003)(54356999)(83506001)(69596002)(122386002)(19580405001)(53416004)(33656002)(81156007)(4001540100001)(19580395003)(65816999)(5001830100001)(23756003)(5001860100001)(92566002)(68736005)(50986999)(76176999)(97736004)(5001960100002)(101416001)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1720;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN3PR0701MB1720;23:/wmgoCJGqFBKy7KojCLBCXQedpm1We56pTVZm?=
 =?iso-8859-1?Q?l2hFul26oXC1nsvPFTEJLDAMB2891HIvHDCjYh8La/fpWlAyESgcFu1nVQ?=
 =?iso-8859-1?Q?jRw13y92caCKraW+gghj3vLEAGA0Ez9hr6R7byVK/iHManUt/67XMG4Ntu?=
 =?iso-8859-1?Q?8tC5N7S36yHgf+swVjMnALYAfTQfZof2/LoRDww8Al53X0b9k8S9bwMwIH?=
 =?iso-8859-1?Q?0DLYtSWwmK6xRZtqa+JFnbjDsHH/3Tm0yWxTuauDjotFTazri8kZ/GONpv?=
 =?iso-8859-1?Q?hi1kfzlHeeF0R2Ai2yWUPXN+wydlohPyRje/xHPVsx25oC7kaIXxCWMITZ?=
 =?iso-8859-1?Q?pCvgu+v1qBv7G1riX0iSvjyZeHIyLkMfDcdV+qV2mLg1xJDGDuq3O5L92v?=
 =?iso-8859-1?Q?p7AFTVg/iHIjj/+PbQBZUpA65YCACho3if0PTmo3sJqcZwUZg3Ha+3e0nM?=
 =?iso-8859-1?Q?K2TVD5BUg9gv7DYQ56D0gUufOmtDwzlcWSF5cgbm3kcUzhaTjx4Lgz5s2C?=
 =?iso-8859-1?Q?FaCBTbbh2LhPugM9A/nb4dC310S631jLkJk1EvFq8ZxZrp12R/vUwKDb4B?=
 =?iso-8859-1?Q?eDkr6p93C7Ffgjzmbc9lkOawrCGZZyL/BsWXu5X8OlziWAmaEkei2/HtNN?=
 =?iso-8859-1?Q?LFWYzPvSysJ/EGdkkQHto+A6g8j++WjS3NeygGfUBIZPddGjbPOY9Ce/1+?=
 =?iso-8859-1?Q?UNXflVuvCfBQxux3TsizMck0tgwmkg7k8OtERad0lhMcRjeS69foUUFlEc?=
 =?iso-8859-1?Q?cRuOWrXdTbuc4iSSc/Kfeaojc+a3viFmFUTVXtNxUMwlFe9C9mtNSBM0Qb?=
 =?iso-8859-1?Q?cmOZpdlQ78XLPjjkfpoglpj21mJlYHTCfexAKYGNkLw0LhVMgHtCizTwdV?=
 =?iso-8859-1?Q?PtFX+omKxz/0NoO/KI7eSeAMK3MdzF9ia0fk36s4xgMn7FdRivuhXttOj6?=
 =?iso-8859-1?Q?eSSxfFRJMtJXnYXkjmd64phmv7nw+9u/G+dJ0gw52ImpFxHXxrzD6W+8C5?=
 =?iso-8859-1?Q?aTGZvbHaLoyCfVVTb7PsQGGcOBvUO22H9zt0sXs0AHG5RAEokhx7GvkZJ/?=
 =?iso-8859-1?Q?AH02mUYgdx05ogjljJwf7AI4sQVYgODeDy4RWzNeB0wlx+UC02qMCr0HrS?=
 =?iso-8859-1?Q?FOqyjBhmwj41EV26CPmc4XEx5bMeUd86vgzTPD68uNbDIuLFNh6h8KWXEN?=
 =?iso-8859-1?Q?enbvHKdxN3r1Z/9iVbVWplLZVqH7cJctxcMa+97xFZlr63zsJj1LqIYGku?=
 =?iso-8859-1?Q?WpDxPdKfLtK3WrHlHjK8f0Ld360nD6VDm2+wDvAJhRZ1rgwCn36xalXQZ1?=
 =?iso-8859-1?Q?Oss2fKPtEm8br5GaZ/PTFJhB2k5vUNU4XcB2i6ejvI+QcGqG08YqASjIft?=
 =?iso-8859-1?Q?Y2lVmwBnhk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1720;5:3RHIu/2cqlTAcTkaIE2wdhk7NIDWNfKgnxiGrrnDTsbz+wv3fd4vt7N2/0rkzqRqLR/o6YK5rBPuLnNcjZq1zPvJ7O91NxLLsAkSvtyCMmWms7j3hDozpv01sgEyCpbxYaDFyenYjwJqrwiBJSKxNw==;24:K4LWE4yZTFIhTW3bjmnjcPFCqUhFpdEGDVIVijSMx0If5eyfOIMHI8CTHelv+thIs+xJNfBdWw2blJr9NcU5htoawMvuvN8KdA3PGv57ZDc=;20:B4cHGQ9N+RvbixB00EFHTRsaCWQKobA1qh04fMumvokRBOcxmHxqfYsOIRiHlydAmWHOOcFib9HDbkqhhd/fpw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2015 18:14:49.8814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1720
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1219;2:17lmE3fxC/r3V0tYOHWgz0AQnPu5sW43S6LQAW1QB3GUT3alAoefyWSiA0mNfWee+0mRSBMvu75NnXKttBK7GmeUgbZh5XD251e57K/iU6lG+6OK9+PQ1APZlX8nUWTRsZIpDuJmW0rPvl445FfLSCuGIo4VT7E8gX4CsELLZGw=;3:fAp4t/Uobev24TfrdWxQZeu6F75TZUPVBgiF511PYXgoGphC7p3mmV5kzNah5qm9i/GwLPg9vy4ylRx2TM+leF43XMp1hK6B2uV27WbVM5dHzf3G9J5rnCmwNLbm/v8Z6iBU6oTzXHBexLp5WGKpAGfEI5HcbojmInMRhgD1DDybtOi3pxzeZadXnFVJDTZg;25:GU0SmTYCVVNMwfx4ahwNtBj/rqBVZUn8rvBEfhhZ7VaKboC1oZMQMg1Jsm8CoMhKGi78qXmPBO6Y0V35EwXzfUT8pN+F3ro3YJDnwadvWqyfnU7HAk05Tn6ZnFlT5gw8IsWib+golR+kd7TmCFkVyrGIfkHRbtFO0kWoicS8/mvFM1fNpiSiWXaxkklH4Uk2Z0NuCpJaKNZFUcQxxPqB2JHMXzRCKh93RC3sbyRqh8zu8D09+Ue8XstwFKItRvj7gqzx3gHMIETQNKVPX3DuZA==;23:drBx5eWz/8aXhiPsilyrQ2z1IOLcfzDDaErYCyAlRIxdSPwDvGQNxaEDo1km0bcnmJ+rp43t+NlhaNqTu5OnYrimvyYBALUP6IwetogkMZ97ypAyJXVkmn9o3CM3zXpqbpjhVG6Du8M3lBB+OKVr/18TsL0wFNLUu50+yhgbym2JOlgCZLgzjvrCgWxjmPAObxOQj8Vsbsc5Tkq15GvLbxTsbvsDLhOvXKGLAjDHPMBTEa8vblMc0So8Enq+tue4
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48726
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

On 08/07/2015 07:54 AM, Graeme Gregory wrote:
> On Thu, Aug 06, 2015 at 05:33:10PM -0700, David Daney wrote:
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
[...]
>> +
>> +static int acpi_get_mac_address(struct acpi_device *adev, u8 *dst)
>> +{
>> +	const union acpi_object *prop;
>> +	u64 mac_val;
>> +	u8 mac[ETH_ALEN];
>> +	int i, j;
>> +	int ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(addr_propnames); i++) {
>> +		ret = acpi_dev_get_property(adev, addr_propnames[i],
>> +					    ACPI_TYPE_INTEGER, &prop);
>
> Shouldn't this be trying to use device_property_read_* API and making
> the DT/ACPI path the same where possible?
>

Ideally, something like you suggest would be possible.  However, there 
are a couple of problems trying to do it in the kernel as it exists today:

1) There is no 'struct device *' here, so device_property_read_* is not 
applicable.

2) There is no standard ACPI binding for MAC addresses, so it is 
impossible to create a hypothetical fw_get_mac_address(), which would be 
analogous to of_get_mac_address().

Other e-mail threads have suggested that the path to an elegant solution 
is to inter-mix a bunch of calls to acpi_dev_get_property*() and 
fwnode_property_read*() as to use these more generic 
fwnode_property_read*() functions whereever possible.  I rejected this 
approach as it seems cleaner to me to consistently use a single set of APIs.

Thanks,
David Daney



> Graeme
>
>> +		if (ret)
>> +			continue;
>> +
>> +		mac_val = prop->integer.value;
>> +
>> +		if (mac_val & (~0ULL << 48))
>> +			continue;	/* more than 6 bytes */
>> +
>> +		for (j = 0; j < ARRAY_SIZE(mac); j++)
>> +			mac[j] = (u8)(mac_val >> (8 * j));
>> +		if (!is_valid_ether_addr(mac))
>> +			continue;
>> +
>> +		memcpy(dst, mac, ETH_ALEN);
>> +
>> +		return 0;
>> +	}
>> +
>> +	return ret ? ret : -EINVAL;
>> +}
>> +
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
>> +
>> +	phy_id = prop->integer.value;
>> +
>> +	phy_dev = bus_find_device(&mdio_bus_type, NULL, (void *)&phy_id,
>> +				  bgx_match_phy_id);
>> +	if (!phy_dev)
>> +		goto out;
>> +
>> +	bgx->lmac[bgx->lmac_count].phydev = to_phy_device(phy_dev);
>> +out:
>> +	bgx->lmac_count++;
>> +	return AE_OK;
>> +}
>> +
>> +static acpi_status bgx_acpi_match_id(acpi_handle handle, u32 lvl,
>> +				     void *context, void **ret_val)
>> +{
>> +	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	struct bgx *bgx = context;
>> +	char bgx_sel[5];
>> +
>> +	snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>> +	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &string))) {
>> +		pr_warn("Invalid link device\n");
>> +		return AE_OK;
>> +	}
>> +
>> +	if (strncmp(string.pointer, bgx_sel, 4))
>> +		return AE_OK;
>> +
>> +	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
>> +			    bgx_acpi_register_phy, NULL, bgx, NULL);
>> +
>> +	kfree(string.pointer);
>> +	return AE_CTRL_TERMINATE;
>> +}
>> +
>> +static int bgx_init_acpi_phy(struct bgx *bgx)
>> +{
>> +	acpi_get_devices(NULL, bgx_acpi_match_id, bgx, (void **)NULL);
>> +	return 0;
>> +}
>> +
>> +#else
>> +
>> +static int bgx_init_acpi_phy(struct bgx *bgx)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +#endif /* CONFIG_ACPI */
>> +
>>   #if IS_ENABLED(CONFIG_OF_MDIO)
>>
>>   static int bgx_init_of_phy(struct bgx *bgx)
>> @@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
>>
>>   static int bgx_init_phy(struct bgx *bgx)
>>   {
>> -	return bgx_init_of_phy(bgx);
>> +	int err = bgx_init_of_phy(bgx);
>> +
>> +	if (err != -ENODEV)
>> +		return err;
>> +
>> +	return bgx_init_acpi_phy(bgx);
>>   }
>>
>>   static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
