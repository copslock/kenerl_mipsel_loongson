Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2016 19:53:00 +0100 (CET)
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:53207
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993005AbcLLSwxI39Ln (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Dec 2016 19:52:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Eoz0cXBXZZlpph2Z2rnQ1CP7tCKzwJAyHXglyc2bKVU=;
 b=XJ67aLkLUPeHcms0287xLp8mY9R6Tm8WmxaTpNXjvhZW4ec6xCt1boS+yjqsVg9cHGexTiICYi380vc8KOsdm70UftXkY7ygrZnIlvvu0lWpm8yg7ETR2CTYrfxiu0IY0/Ejmw3So8Hc+dILev1fXZWc9eokDSKEaJ2RPpayEv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN4PR07MB2130.namprd07.prod.outlook.com (10.164.63.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.771.8; Mon, 12 Dec 2016 18:52:45 +0000
Subject: Re: [PATCH] MIPS: OCTEON: Enable KASLR
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
References: <4bc97883-39b4-1a00-6e06-518c598bbf3c@cavium.com>
 <bb09e7fa-d13d-979d-8496-83006014cedc@caviumnetworks.com>
 <d7c6f6b5-bbe4-2ede-4f68-7543db918bbe@imgtec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <dca26961-ba25-d256-36c0-aa0f8a848439@caviumnetworks.com>
Date:   Mon, 12 Dec 2016 10:52:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <d7c6f6b5-bbe4-2ede-4f68-7543db918bbe@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR07CA0035.namprd07.prod.outlook.com (10.162.170.173) To
 BN4PR07MB2130.namprd07.prod.outlook.com (10.164.63.12)
X-MS-Office365-Filtering-Correlation-Id: 67858fbe-3f64-4c35-e990-08d422c00f9e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN4PR07MB2130;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;3:eTQycHdOhzIoc14GaY/onS2CQtbAbStJncpInPc+jrdLuhHWgWrF7XDbkYO7T7/j0FmPG34GEYCjvM4mtGtsNpXoD6MNr3knbittq/HmCOKggqINsbyGHmiUiiVKy83wl2G5KhVLosSmo4LuHVDK2C+iHPZpKuycp2Tmrr7+W9Y7pcK/MHV1b5v8mK/ggqWZf/kYbUnczzHfO7rNbvXwnisgyues1y1K5pXdaTowFiKMj7tKAljeW3bWeutisy0KVwab54MAYD3hMXQ+Doepyg==;25:vzmAprgsDGtY/sgANvxLBohIEex19/3b4QMhD1CeajQJaQAGNI3xr13dnk1L2vVrtUE+77Getf9tOuMMQJgqu80BDJzn31M/ZUqnwU/AWlgli8MSy857WPyl+aDWHWu9XCA8BhvP3LGi36nzl+GYTlU3H/yR5e4dZN/lfymYZ1FTSdvJxV7W+bONYXoIDYetyxxl5F1tEGR5EVhGmh0XHCzf8ANEIWdwVWm5oA8pBRJQMWW9bkcKwcFkOlaNeXO4zb1GKD/H8EtEJbihd6IFw5NWQawqvgDeNYqY94spXTlwqBxU+KoR8PDdDLn6Vzqc7kP+17W9xHE7LslvpJAsBS+qh6xJOPAQ93djB2WRnql2LN061M1yr05UA04fHey3vWcrN+OpnH4qGOtJdk6WlQxgtn4kMVE5eVqiVSoW1CjCb6bJWJLQwi/zrPCsZoziRvOmL4pvfl7H9uDGfiASQg==
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;31:bEpIEVKXU3JmJp1GkbKAuEvVYxbWr4AtzvL6u8T1vO2VGGGzt98n6iuIBgwTx0dIhP8Hq8GqlBlNiKV3IcPwFgUZDo7vfF3rcMVY5pWHhNrfdxkz2K9hrhsrieVdJsxL24Fpwc5VH7+yy9QKaY7IMDgPPwDIcemLgYcCdLxqqq9LhSNVMHvOTuBSMhheaWbKSEMrO24UEu9c0uX+FSdqYiEYnraiUZQ9N53WqoaomlKDC8j5CtKyOnL2TKmYlbgJnXByz7khBUk8aW5UW6lvvA==;20:bNEGWY7OPUPbcOB795f8ayRDmImOLSIKAnv7rKRZYOi9TIrADujPflW5Z/FvfGTnVj3vl6uPCx5alPo+SzGefIn4AR3/3JGqrpLzQFuz5zP6eqE8b5g45beiBYME0NEpw2RPdonLsacp6zB558fipk/LAVDvkoUcAl5rdC6OISNXP8eKOZOKazHxkK2O0uo0HtFUhDxUqQAwZAmCEZihYqhtH2zbOWp2L4/hT7sJPt7qROJYryZqUvcd00g1UnWEdLByzpFnJmBZvYONaAjD95sHGsIYRVzqTRK/CVg/jSs6UTFlSdMWKEUGSkRUJjrXE2b38eadX6n0nS4x9Kj2bLKbII07HdYHG7JnpeeYDA6rzYHm11z1bcV0ww12T5wIbMSX8rV7v76eEkweQDvcBv9wU5IiY92UVQjQBeIA1kxogwBVyiQ4fCZQdqWI5ogktMYErDlQC+0D/DozIU8cdkheZuzAlaCObA5O8GK6nTyG3qsSmvAyJkA5mLRbuG2lCjLha+02i/7Yb2SZiAmgqx56RVPXqSfXh9PP+d9RqxNPa38Y8Xaurw0J5QlNIWlgZRAL6Z4GrCtsf9AVY3UfhqFH4G1ezqQlFiA2V8TZ3XU=
X-Microsoft-Antispam-PRVS: <BN4PR07MB2130025B0251E2B5753D7BC897980@BN4PR07MB2130.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123555025)(20161123560025)(20161123564025)(20161123562025)(6072148);SRVR:BN4PR07MB2130;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2130;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;4:tba4APUPdYRd1zDG2opHb7zc0pYMEoQwy/xkm6d+fenBWM2kP680jSAkUqIRL/pNFtJfWPKUo/3xKPPu0P0Aw43a7HED7nRQTrsM5hqcklFpk9za4aRgPQ4fFHN6i193pBMjxGPMevHBkgPvc1zzaJyhcuN6A0ov9vNzMpbj6AsbX5vQE6hmFcnM9rPnQASNBbknmTjQFT5d0P9XkG7VphkbQeM5ZDPYMAiLxMwrv1beTXTXgx7vvuibxqIMFxNq9NtAouVwsxRoO6u86w+4kgjmo/9Q8/T0m6l6cIKPon4l+IynUUHN1N3ISYyjlaB7VDVVGOqIGdMuuQ+8zlhvk6C4ZgmdWmXyP/LpMaZqEVtXyuAzPGviJNrn5s2vTAQtyWrP4tpYLVk9xs6rP+EPVZaU6QiKE4tAJyFdoe2DFV0vt59D9njvrJnF3jl+lfK0omUGmCswYCAxeLw/otp+oPI93pL6ZVLjBH+whOb5L7IwqYVcoHtlQbZxJeBisr0rVPRtBh3YL5N8WTSkiodemfHscYYXBCBh75333mb9Pn9uDeqSXrf064HtbRYloHoZ
X-Forefront-PRVS: 0154C61618
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(39850400002)(39410400002)(39840400002)(199003)(24454002)(377454003)(189002)(6486002)(6512006)(6506006)(83506001)(5660300001)(101416001)(305945005)(6116002)(65826007)(3846002)(76176999)(92566002)(54356999)(65806001)(65956001)(66066001)(107886002)(230700001)(47776003)(7736002)(53416004)(50986999)(42186005)(36756003)(106356001)(4001350100001)(81156014)(31686004)(8676002)(33646002)(64126003)(5001770100001)(81166006)(38730400001)(97736004)(105586002)(2201001)(69596002)(2950100002)(6666003)(42882006)(229853002)(31696002)(68736007)(2906002)(50466002)(189998001)(23676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2130;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjRQUjA3TUIyMTMwOzIzOlJOV0JpbVFKUG1CbWFTQVl2dHlWcFBhU2FF?=
 =?utf-8?B?N29Ic1JieWRENW1DRzVtbXh0eXFjTkFuM2FmQmJiZ25WTXR1RExiVG1HZnRJ?=
 =?utf-8?B?OFZoNDRxT3NOSS93Y2tOYWIzZUlnQ3V6WFdZYk5sYzk1ZTBjOWIzNEJNbFFJ?=
 =?utf-8?B?UFpRWkN0QUIyMW1EUTJoU1pDK3B3NnRINGpIU1BNMjhJcGN4ZVEydjFXYUgz?=
 =?utf-8?B?b3lEeTZBRW05OU4yWmFIZjN0OUlZK0x0eHdQZHFsa2NQWkNobTB3SkZkRXdZ?=
 =?utf-8?B?a2Qrb3dIdm1FTGNLdWViUS9OOEFRc1NQbVNDbEU4aEcrV05oeUpBVWhFZHNj?=
 =?utf-8?B?WVRXS0dWcXhlY3JyNE5YaWNMNnRKOHlRbmZqbzFBZXg4U3o2SEdLdVJyYTkx?=
 =?utf-8?B?UjhWQ29Td3pFQjFBU1grOTAwMnZiZkdETTBnWmgxZXV2cjRWVzlsa0JHSllm?=
 =?utf-8?B?QXJQVnVwTXdNMi9yQjJYbjA3ZEtOL24waEpwcXBsZVFYbWZhYzZqWjZSd1o5?=
 =?utf-8?B?K21GUkN0VW1ZM2QxQUlXL2htTlRtb0ZLVTlHTHp1UnorcHRtU2JTN0tEQlJQ?=
 =?utf-8?B?QkxhZEc2YkUvM2RpcHJ0RkRML0h3NnRJYVBUNE5HdTBNRGVocy91aHMvOWJU?=
 =?utf-8?B?VmZPMWVsNkFubklHMFZwOERhaXg1VUIxQ2JqRjlPdEdHVFlBOFA0RHNrUFFy?=
 =?utf-8?B?WTJoVG44WU83ZDVreWlBZkc2ZkhnQVM3SGZ1MGp1dGdDeU01K0dsRFZmUG1q?=
 =?utf-8?B?TnNEVkwrRnllRmFucDE0U0J0TWVETWRZT3FpR3UwbXBYeWhBTXZsRnlrU201?=
 =?utf-8?B?MEJEZ1BuZUNudldXS2o5S0xVUk8xUU11NzJHR2ozbEpib213ZkhHSWt1a3Nw?=
 =?utf-8?B?cXl3eDlmTEVYTGluVm5Ua0NyTHk1eWZxRWZCNG9DRldtc2ROUEowdW1QeDNp?=
 =?utf-8?B?a0ErVkk2dnhpelFRNTdCd2cyN2xEekFyTVlFRG5mcGxWSmVZTmVNY2JrUkZs?=
 =?utf-8?B?VUNKMVJueEJsdGJhQTE2RSs5REJEaHlwTm1VYlRzM2FFNEdRV0xMUk5WS2FH?=
 =?utf-8?B?eUxUTjFOSFREeGVUUGg5U2dkNWlDOUcrVEM0dG1pWUNRejZJTjY5V0p4elI2?=
 =?utf-8?B?YWRPaWwrK0dqMlgvYmlLbUlaelZiUVFYU1AyVVkwaHNjZjRXWG5qNlBNSlhh?=
 =?utf-8?B?aks1VTNzVWVRMFkxaDR6b0NlRXFxMXlLWE9uQlQyK2d2K1VjT0tHZ1VyOTAy?=
 =?utf-8?B?aFRFVHQ3emYwZW5tU055clRGWWh6N3M0UjYwamdiK0Q4MjEwelQ2RU1sQzlv?=
 =?utf-8?B?N0toNUlXMFRnL3NpM090VEd3d3N0K0pWczZHK1VPVllWOEdFeFZFbFZBc011?=
 =?utf-8?B?RlVFWmJWQlI2ZU9hS2NuK0RhdFdFQVJVY3VERmhxci9nT0VIS2hzKytPK2tJ?=
 =?utf-8?B?b0lPazZsWVFzRm5sby9aMWJtK25YQ1lRNko5dWlSajRJaXRwcmt1MkMwQTJG?=
 =?utf-8?B?b1dvRDI3NGoyNEJxNFcvYU9zRHR3RVl1VnZNU3hRZ0Jvc25qbzZ0d1FHaXNP?=
 =?utf-8?B?VFZPcWhCMVZYMzlHWllmTER6WndkdTFDOFVURDdidS9PNUZDQlF2RkxiQlNh?=
 =?utf-8?B?M3FCWlI0V085aVZNLzlrMUNOQXhJMkJDZnl2Q3lpR2JNYjczYTBoK0ZYc2tv?=
 =?utf-8?B?WVBleEx4b203MDBGM1hadjM2RzM1L2tiOW9aZzJsak9RYUhRNlA0SHJDcHhV?=
 =?utf-8?B?MTNGN0wyaUw5czBzZ2xFSFlZalJ5b0EybGp5eU9Mb3AvY0xnV1VCTG5qdVJJ?=
 =?utf-8?B?QXJnUFZRcnQ3YThvSGlneVFJalczdHFjWG5EMStqQVdZeHNJb0tBTXNnS0N3?=
 =?utf-8?B?TjBVUkJhMEttcmFxUXpUZnlOampiK3JUckZrUnQ3SWt6S2U2YmZuVjdoSlB2?=
 =?utf-8?Q?C1zAtgDxhGlkYEL3FabFY6dE1D4exw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;6:2PqBopVrpkPHfGvdnF2fjl89f1B3d+wCAQmUDaDC0gCoYCL9VU4KW2R7sz4WGF7KnBQjg8gexXWz71SuK11LTzWmeYRvmYri3C5RI4xxeAiLc+3sUvmx3kqxp7KRuEuLqHrqjOVzyhzP15imnPCUslhzEmHZlKFbOLP/Nh/ykCyzQZW5zC/rwxbsP6bdgNFEbDGMhYUE0TQ2pV1sszx91+zH6qx1N+xF4WD8dmY1s+f/sHcbBwkDe5nwMMu8M5iQ0J/QE8kF4kqBoNzAzV/nNYKw/XGRdvUsT8jc3QvkBD4SsXMsLgYIi2F3a73cBlleDACYV3VfsWWc0IhBgrULlhaz67i7/cUy4XZXP33M+13ALTi65ooJv6f4Bj0+UsR+HcEsuaQ8FUuBLgHRhslLhk+jMGNh/6hUdWGksWLHF4o=;5:CXTP6x6Pu8Y9eInrf91HVnNt4LXwCgSnZU+nd2vGJhBsK9YAVYe4/lLoxFaxO9maOGaPWIBRQEjS6r5RcQviG72AMZge1pIofAq7ivG8AlW/pYr3RCJRDKhngDRchmqNGSbWfdzlAbNhIueowTlerA==;24:zw3PgtfjWY75LJy0mWrMEzO8/kIdVC6TzR7POpcec8+ZFgO5/gxW26LBCFJvKLbCt0C1bmOhzkErByFsVvahCHVMiCzxEsiAuEbxSwcoa78=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;7:WNn4zGryz5cc/BsH1RDtoL3tw1mPoFbc531jOcUS/tkXeKjonGDlgvYQRUSvD4rWQmXEV2Z2u4SzTYiKBNFg+thPTJs95/hZjXbjbvAsjUz5l9XJw+WPTNkoR+fwhPyebpzrj5M423/pcWP2vfzcS8roWs9DBTlCrAY0wpDqhJl+GxxpDJOi68IX9xZ9Nujh5q0B8XqhQj/MUSgqsQdiAyuRcFFMMlFn1uhl9NLzK4UDtp45leNh48i5DyiGs6mOnc5w1K3Q49vbOWdsPnsGykYmxC4YhyGtLOWwio1jwPNtCehNcLOKeUpQHpuBnM1lJ8X8sYTg24Pblll73hse5v7pLNnnItjen6SOjnRwP0OuzaNJquQ03I1hinS0XDxnOIEHXUZUzMZNKZHwxrL/rScvVLMEHDr8JSBWSXejeJW5s/g2mTthZo7yQ1TNPBP8VJ6JO899MOQUmLFi2fBuzA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2016 18:52:45.2736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2130
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56014
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

On 12/12/2016 01:56 AM, Matt Redfearn wrote:
> Hi David,
>
>
> On 09/12/16 18:46, David Daney wrote:
>> On 12/09/2016 01:35 AM, Steven J. Hill wrote:
>>> This patch enables KASLR for OCTEON systems. The SMP startup code is
>>> such that the secondaries monitor the volatile variable
>>> 'octeon_processor_relocated_kernel_entry' for any non-zero value.
>>> The 'plat_post_relocation hook' is used to set that value to the
>>> kernel entry point of the relocated kernel. The secondary CPUs will
>>> then jumps to the new kernel, perform their initialization again
>>> and begin waiting for the boot CPU to start them via the relocated
>>> loop 'octeon_spin_wait_boot'. Inspired by Steven's code from Cavium.
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>>> ---
>>>  arch/mips/Kconfig                                         |  3 ++-
>>>  arch/mips/cavium-octeon/smp.c                             |  7 +++++--
>>>  .../include/asm/mach-cavium-octeon/kernel-entry-init.h    | 15
>>> ++++++++++++++-
>>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>> index b3c5bde..65d7e20 100644
>>> --- a/arch/mips/Kconfig
>>> +++ b/arch/mips/Kconfig
>>> @@ -909,6 +909,7 @@ config CAVIUM_OCTEON_SOC
>>>      select NR_CPUS_DEFAULT_16
>>>      select BUILTIN_DTB
>>>      select MTD_COMPLEX_MAPPINGS
>>> +    select SYS_SUPPORTS_RELOCATABLE
>>>      help
>>>        This option supports all of the Octeon reference boards from
>>> Cavium
>>>        Networks. It builds a kernel that dynamically determines the
>>> Octeon
>>> @@ -2570,7 +2571,7 @@ config SYS_SUPPORTS_NUMA
>>>
>>>  config RELOCATABLE
>>>      bool "Relocatable kernel"
>>> -    depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 ||
>>> CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
>>> +    depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 ||
>>> CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
>>>      help
>>>        This builds a kernel image that retains relocation information
>>>        so it can be loaded someplace besides the default 1MB.
>>> diff --git a/arch/mips/cavium-octeon/smp.c
>>> b/arch/mips/cavium-octeon/smp.c
>>> index 256fe6f..65c8369 100644
>>> --- a/arch/mips/cavium-octeon/smp.c
>>> +++ b/arch/mips/cavium-octeon/smp.c
>>> @@ -24,12 +24,17 @@
>>>  volatile unsigned long octeon_processor_boot = 0xff;
>>>  volatile unsigned long octeon_processor_sp;
>>>  volatile unsigned long octeon_processor_gp;
>>> +#ifdef CONFIG_RELOCATABLE
>>> +volatile unsigned long octeon_processor_relocated_kernel_entry;
>>> +#endif /* CONFIG_RELOCATABLE */
>>>
>>>  #ifdef CONFIG_HOTPLUG_CPU
>>>  uint64_t octeon_bootloader_entry_addr;
>>>  EXPORT_SYMBOL(octeon_bootloader_entry_addr);
>>>  #endif
>>>
>>> +extern void kernel_entry(unsigned long arg1, ...);
>>> +
>>>  static void octeon_icache_flush(void)
>>>  {
>>>      asm volatile ("synci 0($0)\n");
>>> @@ -333,8 +338,6 @@ void play_dead(void)
>>>          ;
>>>  }
>>>
>>> -extern void kernel_entry(unsigned long arg1, ...);
>>> -
>>>  static void start_after_reset(void)
>>>  {
>>>      kernel_entry(0, 0, 0);    /* set a2 = 0 for secondary core */
>>> diff --git
>>> a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>> b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>> index c4873e8..f69611c 100644
>>> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>> @@ -99,9 +99,22 @@
>>>      # to begin
>>>      #
>>>
>>> +octeon_spin_wait_boot:
>>> +#ifdef CONFIG_RELOCATABLE
>>> +    PTR_LA    t0, octeon_processor_relocated_kernel_entry
>>> +    LONG_L    t0, (t0)
>>> +    beq    zero, t0, 1f
>>> +
>>
>> This doesn't look correct.
>>
>> Please explain how this code implements:
>>
>>    loop here until octeon_processor_relocated_kernel_entry is set.
>
> This part of the loop is checking if
> octeon_processor_relocated_kernel_entry becomes set, in which case don't
> take the branch and jump to the relocated kernel entry point that has
> been stored in octeon_processor_relocated_kernel_entry by the boot CPU
> (that part was missing from Stephens v1 post of this patch). Otherwise
> the semantics of the loop remain the same as before, checking for
> octeon_processor_boot to be non-zero to start a secondary running this
> kernel.
>
> This same loop is executed in the relocated kernel and of course in that
> case octeon_processor_relocated_kernel_entry will not be set, just
> octeon_processor_boot will be set when the boot CPU is starting the
> secondary CPUs.

OK, I now understand what is being done.

Is it ever the case that we will have CONFIG_RELOCATABLE, and not do the 
relocation?

If not, before relocation we never need to poll octeon_processor_boot 
before relocation.  We could branch to a point that polls 
octeon_processor_boot after we leave the loop that waits for the 
relocation to complete.

Maybe it is not that big a deal.

>
>>
>>
>>
>>> +    /* If kernel has been relocated, jump to it's new entry point */
>>> +    move    a0, zero
>>> +    move    a1, zero
>>> +    move    a2, zero
>>
>> Why change the values of a*?  Don't these registers already contain
>> the proper values from the bootloader?
>
> I don't see where the secondaries make use of any arguments passed from
> the bootloader in the entry code.


In the line that says:
    bne	a2, zero, octeon_main_processor


> But this follows the same semantics as
> the CPU hotplug code, which restarts secondaries with their arguments
> set to 0.

Yes, for the secondaries the argument registers are set to zero, but 
that is so that when they pass through the branch shown above that they 
get to the proper place.

In this code, we are coming from the bootloader, and these registers 
already have the proper value.

Adding these three MOVE instructions makes it look like you are taking 
some needed action when in fact it is unneeded code that only serves to 
confuse.

I would really like that removed as it just clutters things up and will 
lead people to think that it is necessary.


David.

>
> Thanks,
> Matt
>
>>
>>> +    jr    t0
>>> +1:
>>> +#endif /* CONFIG_RELOCATABLE */
>>> +
>>>      # This is the variable where the next core to boot os stored
>>>      PTR_LA    t0, octeon_processor_boot
>>> -octeon_spin_wait_boot:
>>>      # Get the core id of the next to be booted
>>>      LONG_L    t1, (t0)
>>>      # Keep looping if it isn't me
>>>
>>
>>
>
