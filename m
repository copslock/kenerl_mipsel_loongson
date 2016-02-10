Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 19:02:37 +0100 (CET)
Received: from mail-bn1on0084.outbound.protection.outlook.com ([157.56.110.84]:47822
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012036AbcBJSCe1AggO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 19:02:34 +0100
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14) with Microsoft SMTP
 Server (TLS) id 15.1.403.16; Wed, 10 Feb 2016 18:02:26 +0000
Message-ID: <56BB7B2F.60307@caviumnetworks.com>
Date:   Wed, 10 Feb 2016 10:02:23 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     <linux-mmc@vger.kernel.org>, <david.daney@cavium.com>,
        <ulf.hansson@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
In-Reply-To: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA005.namprd07.prod.outlook.com (10.255.174.22) To
 SN1PR07MB2144.namprd07.prod.outlook.com (25.164.47.14)
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;2:x9x8sJMC5dkOS7mLff3Ntu1STgySVzof0Q1ZSq5BcMooC2YdBQiy5/Ca94blb9n6989Xyaw5HCV4T29b25Ch6A6XoLyPtEETqT/gILSj6HQ40HBKGqAN1D/Vdk3b+/0F6UuvmHRjn6halv2Tts1jwA==;3:D9/0hwfnrNOBwj2mGu9NPEiqmD0w20UU3ZFeUJADRtr8QsLCpClV1O9E+3dWcMSq9Y9rz1Cw5tmr1802qvxnKsxzJq6wZl8rrO9Rl2kv4rQLaUK67Bzt/V6qCioyvuKu;25:y9HNtXi/JXbkEcC49BG+H/xwBB8CL8BiqT/3qGkmE6MfcGe/Uy0ZRPXy9nZ5sGgxp0PNEPrDJr31P3xUkm4dSvZMflk3CTPVCpwvuTcq23SSSrqJ+nFvnb5aMHt/OrO7/0FvjNEZk9frAtkUmWLy4LeMJ629Cl1D/GZCQpzgKoE+ixRV53DFDqd0fr718iLXh5glMt8cK0Bol/AoLhIFwHXyOxzxM4isuY1dBzrgR8ipkLrewMblIUPQo5H7Fi8RbaLhBGwSppCrfKY9H4wThUc1E6IDIDrEMC6rQNxlxu+IGQychjN4MWmhRBpz7sJZ
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-MS-Office365-Filtering-Correlation-Id: 8822707f-7158-4a34-0f46-08d332445604
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;20:P5IUqLgGkEmPFE+jkQdLiOeexNiyNOG31mFTmfo636etwm8iDJPyr/ZvQdxPwrkO0EJizhR/yDMGxVadLbnsi5xt73IR/L8+wDviH8oFwKVncmpJ0oZCvYS7iS7TTeYci7wZ311LukkcIIuNt0vtbdCRk6cFL2j9g+6q5TQTbOvpsiJJBF7NSVEzrjPeslD0AE+SotNgtzupsuj456GnNjY0xqKz5LOhYAl2SpmC/pDMvwcp/2ZyH3ulCyWbRYxgqZ37Mv6UXLz2xa4p1h7BIQyWaqF5z1/Zr0Qu10vu9Pe6icV+yKA7XkCIG0kIUNl7ge/DZUh8wCt1ecmYl/RcwaztPPCoW4553YBYFQWMVc1wJ+vE2XYLC5MpfAoXqg73ozvwsuSga51fRZopkRGyUY0SK4k28z5NH8rdaiVvm7NT5nL2pzv8R/hfAeM9AGNAWp9tsmC22KF4/8LqQ97oAysOOuXVIXy4F5nszeQGDBVYdzJht7TMcUf//EXQD5fskxpcy02pREBorHkHnujS5w5OleGjMWPWcd7+mhi1u6u+7296o5PZCLeO4cDk/5/n+dxlyHQpNP8OA68BVTmEgwmFEiuU0M++rxSkvW+bZk4=
X-Microsoft-Antispam-PRVS: <SN1PR07MB2144F6B457BFA32CAADF42289AD70@SN1PR07MB2144.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:SN1PR07MB2144;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;4:gzxv488dV4qD8yVrdpz718gqoLh7zMT0yyLdRXsyxLZVGr3jgZ/G3LrFGU1ubuV7ub+EvwB5Q0rlXVoa1B8k25iWXvjtAeAX90+1K8rHjBVEcLSbS5Sjj/5CXDFduf6ZLz9XwsSIquTmFFW3S2jXfANmg7JzHMcOU4qhfLHshOflrUVL0Zdt7OHgZkI59Qme5RAjk+e1XxzX94PGEF301NQnvotBl3EhIdTen6MlzXcwa6eAJycNyLvsWOYCq9z+Rnhf2h4tapQW5Ihbp758mAiJJY+UcxBXMlHzVyODNAq07SkLMJ8GRjeeJ6UIMjS5wru4tLuNf2/DVQv/9PKj+IoNyGWMLtHr7mEMHZz217wPGJFus7cnNnJHfewZq4Id
X-Forefront-PRVS: 0848C1A6AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(377454003)(479174004)(24454002)(50986999)(76176999)(54356999)(77096005)(33656002)(42186005)(53416004)(65816999)(87976001)(47776003)(83506001)(230700001)(2950100001)(36756003)(15975445007)(4001350100001)(66066001)(92566002)(23756003)(3846002)(19580405001)(19580395003)(586003)(65956001)(40100003)(110136002)(5001960100002)(189998001)(1096002)(5008740100001)(5004730100002)(4326007)(122386002)(2906002)(50466002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2144;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN1PR07MB2144;23:yuY6yV6wjH5EucVkZLZ7NbR2SDe2U58GtKJQbvF?=
 =?iso-8859-1?Q?noxUtOrjy3ZenQqqHBBnwzqsveFchR8/5dCzqtqzLX+5hzO7H47/yNJRnE?=
 =?iso-8859-1?Q?71g5tn4KEURt/NNOCw2U/LY3G5N8Iqv+Hbu0mOgXQmLl+8lWQ3bkzzT+iC?=
 =?iso-8859-1?Q?bQ+TPRbK5VfgQ2Ap16d3eORAUK5VOI4lx6APIjFY10OE78Zb8ZowcCoab2?=
 =?iso-8859-1?Q?607fw3wWffXs6GlzHT+de8p49VGmeSRnQqtn4QxyaNTJALPf/V2BPxhi47?=
 =?iso-8859-1?Q?F4WMO1bj9Z/00W9vh6TXcFKVfclndzyvLD/AflgUOc9p+z3vuCqIOjemlG?=
 =?iso-8859-1?Q?QuVPPZHHjU4j/iAUnhuuNURmb6vcEsns5rVTsKz/MGadTSz8e/QkShdwNh?=
 =?iso-8859-1?Q?Hhm0J1p1GN6puvk1AwmABgTk8fibfRt88KaT62Jsx4gVV93kq++QkMCjXr?=
 =?iso-8859-1?Q?8lrzyjXv9YN1BPHNpj1Z53KZxqRxtGfMd1APzcPPJP31+xLiiLivBFa5aE?=
 =?iso-8859-1?Q?xrlZn3M7cSuArswnm3g9maXolnSJ+qg3ORJEgMPfSJB+7aTqwpaTs5AnT2?=
 =?iso-8859-1?Q?QGvO/ZWsZGnI3+8SnHrTAu31THn9ND9UycR1yMGLLCiPzwbhXtqUCwAxWw?=
 =?iso-8859-1?Q?kCmcGvsTTiH9TZYh4g5PLkffMgoFbmMqjlgV1zcRB0/oAEykrGHUMGkhyz?=
 =?iso-8859-1?Q?FWRQhHYcuPo7UQ0jUYRlXlf3Jn9QJNX9CmDiRgJvvZKOhgD+SdznF0bU1s?=
 =?iso-8859-1?Q?nhm6AEOKbUgSDqg52gfRFealCrJmInBBAIAItwTSvrVdCm28ccti1OtXRJ?=
 =?iso-8859-1?Q?xOkHH1DOV9R1nhfT47GKJyJWpJI9ryXr08hbgFxsg9Atltz6aO2FbB//sl?=
 =?iso-8859-1?Q?KEGRQe+FKkDEyZg94rIp1UY5OWbRTrkftSSXlEE1eDKFWqz6IHkB+tLZjt?=
 =?iso-8859-1?Q?5gQi+ZICs6rCSpUrSREfrNAOkfiuG9Jy/GrlUBBJMHXHUkKJKe5Aya9zic?=
 =?iso-8859-1?Q?HRkIrcMhcTTMENsfKN5kUZOOqGJS9zFDHk5z5fRtfOhtlGOqUhwDmn0X2N?=
 =?iso-8859-1?Q?sbrYaPVXVahZowqV5bkGRnXbxufdcDi4RhUF8ovaCWxM6Vzs29uUAm3Npt?=
 =?iso-8859-1?Q?4+hTR?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;5:duQLO8RDVfGvQTpk7ZqZqYPxlfi9hKQDPAxfj+gw1BXvhvbLY88zK/0z2j1N2UM2rjmLDY7ouLleM0bC0tlXoYLhMKGpCKra16id3vbWNbxoPPm+gVcYm/OheGxsvXRmfNweFo7W0mnss+jJEj6d6A==;24:iXkmzfRlfZ6Lrchi6MSASZneVu1gYVqD5AvWLSIq4Ki5pgp9hg6eLb7QarzmKBU1lsegT3hnF1UzdObxcGZnpcufCshHnspSSk32Y0YKfKU=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2016 18:02:26.1174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2144
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51977
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

On 02/10/2016 09:36 AM, Matt Redfearn wrote:
> From: Aleksey Makarov<aleksey.makarov@caviumnetworks.com>
>
> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
> devices.  Device parameters are configured from device tree data.
>
> eMMC, MMC and SD devices are supported.
>
> Tested-by: Aaro Koskinen<aaro.koskinen@iki.fi>
> Signed-off-by: Chandrakala Chavva<cchavva@caviumnetworks.com>
> Signed-off-by: David Daney<david.daney@cavium.com>
> Signed-off-by: Aleksey Makarov<aleksey.makarov@auriga.com>
> Signed-off-by: Leonid Rosenboim<lrosenboim@caviumnetworks.com>
> Signed-off-by: Peter Swain<pswain@cavium.com>
> Signed-off-by: Aaron Williams<aaron.williams@cavium.com>
> Signed-off-by: Matt Redfearn<matt.redfearn@imgtec.com>
> ---
> v5:
> Incoroprate comments from review
> http://patchwork.linux-mips.org/patch/9558/
> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
> - Use standard <max-frequency> property instead of <spi-max-frequency>.
> - Add octeon_mmc_of_parse_legacy function to deal with the above
>    properties, since many devices have shipped with those properties
>    embedded in firmware.
> - Allow the <vmmc-supply> binding in addition to the legacy
>    <gpios-power>.
> - Remove the secondary driver for each slot.
> - Use core gpio cd/wp handling
>
[...]

> +static int octeon_mmc_of_copy_legacy_u32(struct device_node *node,
> +					  const char *legacy_name,
> +					  const char *new_name)
> +{
> +	u32 value;
> +	int ret;
> +
> +	ret = of_property_read_u32(node, legacy_name, &value);
> +	if (!ret) {
> +		/* Found legacy - set generic property */
> +		struct property *new_p;
> +		u32 *new_v;
> +
> +		pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
> +			node->full_name, legacy_name);
> +

I don't like this warning message.

The vast majority of people that see it will not be able to change their 
firmware.  So it will be forever cluttering up their boot logs.

We are not ever planning on removing support for legacy firmware 
properties, so alarming people is really all this message does.

If you insist on a message then make it something like pr_info("This is 
working properly, but please consider using modern device tree 
properties...")

> +		new_p = kzalloc(sizeof(*new_p), GFP_KERNEL);
> +		new_v = kzalloc(sizeof(u32), GFP_KERNEL);
> +		if (!new_p || !new_v)
> +			return -ENOMEM;
> +
> +		*new_v = value;
> +		new_p->name = kstrdup(new_name, GFP_KERNEL);
> +		new_p->length = sizeof(u32);
> +		new_p->value = new_v;
> +
> +		of_update_property(node, new_p);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * This function parses the legacy device tree that may be found in devices
> + * shipped before the driver was upstreamed. Future devices should not require
> + * it as standard bindings should be used
> + */
> +static int octeon_mmc_of_parse_legacy(struct device *dev,
> +				      struct device_node *node,
> +				      struct octeon_mmc_slot *slot)
> +{
> +	int ret;
> +
> +	ret = octeon_mmc_of_copy_legacy_u32(node, "cavium,bus-max-width",
> +					    "bus-width");
> +	if (ret)
> +		return ret;
> +
> +	ret = octeon_mmc_of_copy_legacy_u32(node, "spi-max-frequency",
> +					    "max-frequency");
> +	if (ret)
> +		return ret;
> +
> +	slot->pwr_gpiod = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> +	if (!IS_ERR(slot->pwr_gpiod)) {
> +		pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
> +			node->full_name, "gpios-power");
> +	}
> +
> +	return 0;
> +}
> +
