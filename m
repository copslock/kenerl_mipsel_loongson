Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 17:36:24 +0200 (CEST)
Received: from mail-bn1bon0097.outbound.protection.outlook.com ([157.56.111.97]:9602
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012073AbbHLPgWxf0Gh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Aug 2015 17:36:22 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from localhost.caveonetworks.com (64.2.3.194) by
 BY1PR0701MB1724.namprd07.prod.outlook.com (10.162.111.143) with Microsoft
 SMTP Server (TLS) id 15.1.225.19; Wed, 12 Aug 2015 15:36:07 +0000
Subject: Re: [PATCH v2 0/2] net: thunder: Add ACPI support.
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
 <20150811.114908.1384923604512568161.davem@davemloft.net>
 <55CA5567.9010002@caviumnetworks.com>
 <20150812152337.GB5393@e104818-lin.cambridge.arm.com>
CC:     David Miller <davem@davemloft.net>, <mark.rutland@arm.com>,
        <linux-mips@linux-mips.org>, <rafael@kernel.org>,
        <netdev@vger.kernel.org>, <david.daney@cavium.com>,
        <linux-kernel@vger.kernel.org>, <tomasz.nowicki@linaro.org>,
        <rrichter@cavium.com>, <linux-acpi@vger.kernel.org>,
        <ddaney.cavm@gmail.com>, <sgoutham@cavium.com>,
        <linux-arm-kernel@lists.infradead.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <55CB67E4.8030001@caviumnetworks.com>
Date:   Wed, 12 Aug 2015 08:36:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20150812152337.GB5393@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BY2PR07CA059.namprd07.prod.outlook.com (10.141.251.34) To
 BY1PR0701MB1724.namprd07.prod.outlook.com (25.162.111.143)
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1724;2:/DABLtV/mgpxNG6cXCN0yVGQhVPybC2i0HBcpWrCW+VOKqkiiwEXN1psvrF0Kj0XzxhFkPM5WrBCGjFGpS2BVBwUtPfiMAMbSctv0kEAW0/wFBLIPqtV0oKkebHsfBcGsxwED+/h0kCDVkkqwkuqh2dlwNKyMzz3oEcbfqok7yc=;3:Wk1l3/PUS5HaNUYHffqsRLPAQ9V8kfiRsb8chgDeUSoIHg2IZ4ZPb5DMazkuEIqMgD90uzUx9rhS4NBOphPypyOjVYsoGffJGGsSLiQ+QlLJvCsE7HXVRxMmuSQU93Fe+ohRDmGWBN2ygogbXmrHnw==;25:c9Q9L9q0R6Hrrj2CXWYZXDh2r4wfUjCDLA9NptQ1LL1Iaj3H8F6WLTiB8SUkCs++6dDnYFIaOmAY74fKHdEv5oRpjwo3KB4+EkakSt3V/5IutyXpgaXgC+Vqd6qzWp0NtYHUUU3uu0MTDlwScAnnr7dZw224HA+d1rKkgejQOR0QeNbpeKeUQnDcwgy0NymF1YhP809qmink6mXKOZV39LEKh0gJZwT/+so/KmTrjr/dtLsQxYVzJr0YAHVs9uVg46jmrOCadjc2XAQQMl+vKw==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1724;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1724;20:Ecvbc2g7jnmzIde6iSPwPOEC4HvsTfMn64X+PMYrKKFwUBFWcBEdKPjw+CoOTudb7eManvnLBNrT5P1YpFenIbf8orYW/TtCp/586kVVp+WHJwob7xqp/8PwDJqp0cyU3E2PYclhOvVuq92T9D7cm58GPc8Vz8YIQEv3UlV+kbrvjGM3vNurgWz+FB2X1UF59wKfylG5JdvWVJdT7Hig66KgLaqzr7NL8T9i2LGMn3ZGgJi2TFdRH6aqCVBz3QIbA+JXCD1edfebEmc1IEc3+7xVYfoKwcr8Wkxz1nAjavv66kxr1IdONwblTl486AnZrPVj2v3Ql6vfgMXEplQO0zuNtzAEaqSNVz5ZyZSG5Ot4aAeqNhxgoVPqQU3oBoyFETY2Xs4H1KsJ2xjyVOUv4WqKYLBzTUO6qKJjc+EdbcMJ8T3zy8kKfSbwikMcLI+WglpSPLDtlUsI/1F5oWnEkqSZNjENFJ4AMrVxCz+GOev9es5T2G0N0lLUVhw5/gYeC/dGZILyXIeUy2KnkWCVVN3vUi3LuPgBKH32h3xIf5YKzngipjT3bfB3ub1jaqjuw3qDAok9nEu71CfVZ0BDkHcypBEBuKF8MIyZ1kAYYZ0=;4:hA08BtCI2RHCvL+GnFxLbEv+rGps4bLxdf22234C3s5/oiZdhJcCb/6RS8mvto+xN6hMX8KvgwTc55sh3Eg8E865Bvj9UXk+TVn2NmI2wBjwwbhCUaKUV+UgNrnpG/Mt1y7I5y47paiwpGXzPnFOXPkUX3TxY8q2vLqP9vjMstI0PJc+Iy9oQ+2Ol1D2ACbnGnHBT1JWDnfcLEFyjs1QNHAmCA4ybiY6B30JhQ03bjrvu6OC1eN9VWJHXCWw2sPpoB20N2ztMHpZZxwEM875+V9s7PoSOlsD1QdIlmB4D7s=
X-Microsoft-Antispam-PRVS: <BY1PR0701MB172422CB8C5A71FDD720267A9A7E0@BY1PR0701MB1724.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BY1PR0701MB1724;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1724;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(479174004)(45984002)(24454002)(377454003)(164054003)(199003)(189002)(65806001)(93886004)(64706001)(69596002)(65956001)(66066001)(87976001)(68736005)(106356001)(105586002)(46102003)(36756003)(189998001)(5001830100001)(23746002)(5001860100001)(77096005)(83506001)(81156007)(110136002)(47776003)(97736004)(5001960100002)(4001350100001)(4001540100001)(59896002)(2950100001)(64126003)(101416001)(42186005)(33656002)(40100003)(62966003)(76176999)(122386002)(54356999)(50986999)(65816999)(19580395003)(87266999)(19580405001)(80316001)(76506005)(53416004)(92566002)(77156002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1724;H:localhost.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY1PR0701MB1724;23:EOArI+aPApjS7tCpn8zN2T/V10R0drvzvbA?=
 =?Windows-1252?Q?NCT0OHd4W+WiuCyT9TRz9fxQCq9eGqcnhXc9YFu4B+PYW6fKN+mtrXno?=
 =?Windows-1252?Q?MUVGZqb/8lArN87SKbJBTDUdENmXSqzrLdwhH8CcfhSL7U8fUbWVA3TK?=
 =?Windows-1252?Q?JVImjJhDvT6LAd76wlLC+EwkPQT63KLSwnSsBNTlA5e8c3SI4j0l7+5g?=
 =?Windows-1252?Q?gCIvh566mi/sndZvSlVM8j8IHTCwYsuTYHqhyVS0W8HxXCwc/09iYQDc?=
 =?Windows-1252?Q?rNM3Cyzb1rwU2rwiCtKZi6w6kVGMAorNqB8eWBss6s0g9bqDerSPaRGQ?=
 =?Windows-1252?Q?ipKZVEe6sZd6X9MALk7ZvJjdQZmbgIpsVGpuygBM95sVdI39RbBX2+dt?=
 =?Windows-1252?Q?Ti/OcExH9FUchtBKYz0L6xq0GKehrBhgD/MGPkB8BeBqr2+tTUd65nqu?=
 =?Windows-1252?Q?2rl+ShAqI1L8+NWQ2EjPY+uYcG2jDpV5i2H71RSilzxd2mJJslpNtWNI?=
 =?Windows-1252?Q?d4YrMl3xrzRDFY/0VT/SyD90cmalwySCtWNVa5Lshaw22tlHO1bKQKIG?=
 =?Windows-1252?Q?m1+bi5o2drpXEww3uAnmpSC+rwtd3gcnYtlxU1ahAAykKYT7O9EgzOPF?=
 =?Windows-1252?Q?+TZLlwpLeEP8DOmcety/FjRvU4HjA6LeTpNBRMKDmDuJmHV/1vxfJnST?=
 =?Windows-1252?Q?yiX7TuDOy72Hfeha+i6ATvp9+j6xnx4sjwh2vvMfUVLq5YC1Z+uhkejD?=
 =?Windows-1252?Q?lRPYSpGhcpusXzUt3r+ggCA9/mwXq1V2Ge3g1WdozUw5dgUwo6G5agW1?=
 =?Windows-1252?Q?nKJW0X9r6ckpq8uONcrcD38N/9PegZ6Hw56LfsnmWFdU12EhxNR41EGW?=
 =?Windows-1252?Q?RHfbwYWmvAzhcBA2H0t4m8o0y7AJIm0lwceZVqJA4ogNZs/t3zQrHV7R?=
 =?Windows-1252?Q?VW/qjuOH6sO1I15Tx+lElKF+9HJvudEPrz695N7WOjPByU+zijJIfoeP?=
 =?Windows-1252?Q?eRh3xbL6QJdRHi//Hi48XQd7wYK8MVO5/f/Ves0mLs1W3HdN7mKoMEGR?=
 =?Windows-1252?Q?kioIAgOOzh/B9JFs/ayBCBeq1jKtB8Of/UmstN22YW+bsjtNmRCcHt1a?=
 =?Windows-1252?Q?QkQfvOjeGLxrYYt6IGMy6+FiUkTENJ84m4zgmCgqsWDV79SzJDLd4hPv?=
 =?Windows-1252?Q?r6MhegnAk1lbyrIHKRW9ZFaQXn5/O3w8a3QhhyMgFZ5L0GndxBRK1xgM?=
 =?Windows-1252?Q?7uslYLvb9tROqy0GBl1sPmHZE8cVQWJPENkp3l96jb3WhcyIksezwURs?=
 =?Windows-1252?Q?KCaoyJPs2j4zjDkFw99poxaL1HpL0Pogei3FjgjHyqyClKcdc1OqHh30?=
 =?Windows-1252?Q?EFHNAW6/VvG1Lqh5rl7CtdtCj4p0MhoGdBtTMxdSI1HxlTxqJCJQ0Vl8?=
 =?Windows-1252?Q?PyLlUhSvHK/wVvfIMUWJthBMmzYHY5wlXueXsU8PitfY7ZQaEdOHdkY4?=
 =?Windows-1252?Q?7aR3xbMGcNfxM3In87VP+C2jKrTwWa6afLWZSD9QQYLrDg2vSsg=3D?=
 =?Windows-1252?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1724;5:kettX94pg+NzdWeTuoICxx5gptN5rs+Xb1VKxeHC8nlmQo6RJvt3PjPPSmUOoMYrwILiaJLrsrNjX73ziTYnc9nIjmGL5E3IWgb8I6fqtA1bqssgoR77Cb2TYdhYmQY360cX6L1lBpQ3VUCndg9FHA==;24:sphIFaXTH3pCQ9xVEajMEI5kvXPGIgXWN+VE2H6SkcCcZGJnUrOqu65QCUQFDZ3tFatu2ceb0zvmADej4vRv/+mIKpfje2iMG9JZyBDh2E4=;20:KUBMb3WNppxuPuzS/KKA/0Ekfb8d3cRl5SsP7LgmkP7BG1nmb2MfJD/MDO6fqMqVZY27VWbqMP2ggcdyj9XEzg==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2015 15:36:07.0513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1724
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48820
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

On 08/12/2015 08:23 AM, Catalin Marinas wrote:
> On Tue, Aug 11, 2015 at 01:04:55PM -0700, David Daney wrote:
>> On 08/11/2015 11:49 AM, David Miller wrote:
>>> From: David Daney <ddaney.cavm@gmail.com>
>>> Date: Mon, 10 Aug 2015 17:58:35 -0700
>>>
>>>> Change from v1:  Drop PHY binding part, use fwnode_property* APIs.
>>>>
>>>> The first patch (1/2) rearranges the existing code a little with no
>>>> functional change to get ready for the second.  The second (2/2) does
>>>> the actual work of adding support to extract the needed information
>>> >from the ACPI tables.
>>>
>>> Series applied.
>>
>> Thank you very much.
>>
>>> In the future it might be better structured to try and get the OF
>>> node, and if that fails then try and use the ACPI method to obtain
>>> these values.
>>
>> Our current approach, as you can see in the patch, is the opposite.  If ACPI
>> is being used, prefer that over the OF device tree.
>>
>> You seem to be recommending precedence for OF.  It should be consistent
>> across all drivers/sub-systems, so do you really think that OF before ACPI
>> is the way to go?
>
> On arm64 (unless you use a vendor kernel), DT takes precedence over ACPI
> if both arm provided to the kernel (and it's a fair assumption given
> that ACPI on ARM is still in the early days). You could also force ACPI
> with acpi=force on the kernel cmd line and the arch code will not
> unflatten the DT even if it is provided, therefore is_of_node(fwnode)
> returning false.
>
> I haven't looked at your driver in detail but something like AMD's
> xgbe_probe() uses a single function for both DT and ACPI with
> device_property_read_*() functions getting the information from the
> correct place in either case. The ACPI vs DT precedence is handled by
> the arch boot code, we never mix the two and confuse the drivers.
>

My long term plan is to create something like 
firmware_get_mac_address(), that would encapsulate  of_get_mac_address() 
and the ACPI equivalent.

Same for firmware_phy_find_device().

These would function as you suggest, but lacking this infrastructure, we 
implemented this patch set instead.

Thanks,
David Daney
