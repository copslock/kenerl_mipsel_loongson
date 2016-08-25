Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 18:50:34 +0200 (CEST)
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:6112
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991965AbcHYQu1FblfY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Aug 2016 18:50:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LAZQuvnEw/YCKir9AVbw6uPigEnaBb+k+GSY2wMhQW4=;
 b=MIEVLlf0YK0y5BIhc7/WdG9VBrPXcqyjooCUJEqGtiW/KrbtansV0h8t2MQ/OgOc0ba9LA6iqefJJkryrIgz0/S2Bp+Iv6Ra4EGv5Sc13uPzMg5ryni/bL/F0ZTq29qxlCIj+kWvYuJnk8mWbp622XIwxmWqKYZ5p+6+WabnMjk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2134.namprd07.prod.outlook.com (10.164.112.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.587.9; Thu, 25 Aug 2016 16:50:17 +0000
Message-ID: <57BF21C7.5070709@caviumnetworks.com>
Date:   Thu, 25 Aug 2016 09:50:15 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ed Swierk <eswierk@skyportsystems.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        driverdev-devel <devel@driverdev.osuosl.org>,
        netdev <netdev@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Improving OCTEON II 10G Ethernet performance
References: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com>
In-Reply-To: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR07CA0006.namprd07.prod.outlook.com (10.162.170.144) To
 CY1PR07MB2134.namprd07.prod.outlook.com (10.164.112.12)
X-MS-Office365-Filtering-Correlation-Id: dc8a24f6-4da8-4f6a-4959-08d3cd07e50f
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;2:QqTM/xhT5mNQRrfHOFY1njyWu29KA10qUZqXXBJ+8XyHXZ14bdCAKfFqhTwcEKfhNtBfyfBT34a5lCcMOMX/GMdzixSTEDwz3kBDXFINGePadh4UnD6UNgX0RbIroQ8mu8U9539LtyWdGpc6DXZJDndUO6BCOMrOutrgmxdIxHuUGFt3QIuzPmnFaa1oLtd5;3:DsV+vHjvRmhJyRdrINlw6bBVPqzWV3FVlYZB3XZaxFBkJVKNbJ66kH0uGhLZW+AQFN9BrIy+H45W61LyGpfd45wP1Knr6EnZVihdOFwkRumD42cV+3lHSkgQIYpTx0qf;25:GizQd0QDIASUsqQm8Lvd71h6IgeYweaTPhSC2SFiV0Hvw8MJoa+no9brPo9f4ivmE3jlyy2s22qrB/izUO6uHE5vvsona7PYmhH/L4G4gn2tHou3iJ/nF+t3HQek3Vn66WEmP3GiJwSWnR48QweXDtMiqKUbAVqZBzfTPB8v7FQw1N+ClqBmLKqDQIWEOcdFWSTpnHcBnnrTZZV91YUGs8Xq9atwAy+gETXvzaDTvl31li6gY/9jlHYDOyI3jA9+P8iskmTugd5fSOLLBL5p9+w2/eGsDADreGbdLwUEWikRtE0P9np7yMr2wHOLutZruL6wWrqf+NFPIdXzqFN70glTTjdQclKUNi1aNv4cgCZiPaUSlLMgw3dwGHJH0ACP0JjouOVAVdlFEpE007Vtyx0gu8+VkK0FuQC175kAswg=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2134;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;31:2GG847WDkiiLDgkh0YL1+3AVsEXbzC8RprEeTARdtFqU77i0tbfioEDac24pq1GMaG+vSNUejDj1UQQseFmzmH8T2IYvVNP8QLp5nm4bxhrwGrbZweoz3wIH9FRx/Donh6otqjGUOB9P8OiHg/EQ25QbGRE2Wa+oybfLmhWXhpSlc7gNxzHAchYl/uBPBte+1lTaZ2h8XTAGr1Ip3BTXdi84kfCBIxYIvSSB2/lt8n8=;20:o/N447I2OBn9zYLEEsrePibcz40mwjx8xdckxbjpBiwYb7+cxrDyQAEtPdAF05oHP8y3KDLj+aludoaQCV/02XokDyskomttyk2WlIfzjehg3qHrJ/A3K8K9K1DMFFzb6/H6l5wvEJGUTzOGpa77Smj1Q7JHGxoxYhY5cM4XCcO9fjgFRFpRD4VAae+vhmgYVTVfzGXHPB+csEg9W76S6wCkenrkhoIj8WkefjvDe3zrWg/Etl8z5DUqzvXqMreiYFD6GaNlWFyTgyjSRKUDcGc9Ygx851bmM9HU7zVKNMAHN0t4jJgUr3TXMfmpL6BZ3vl814up3Cm13nyYe1NhlhQCJhdvR9KZOEAoE8o84hYbzJRbvsVJ90GcSq2P904R/4LnXjXX04+8qj0bzzhKsrwDZzgpj7MdSdUGMymIX5i/WeM3Siafzpw86ri8l0m8MlhQwcWdEs1bzJTVJdSwBBXWAWNqoKhOOdHTl4ov24qnri5OBVDsJiUWellGweDtnHklylvZOyarh5wX1djwp+MXSUisR6EhPl7XbbLxxy4H38FEDu90Wp/nTum2YLW74d3uugKrH19bAwsMr295njnY98f6xBRXkg02wB9LHMg=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2134528E566ECAEF4C9BAAE897ED0@CY1PR07MB2134.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR07MB2134;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2134;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;4:+pXAarwXV+tpFnvTMciHpD7qbZ7pGnPsTe1vOsMU/3z7md9T2vXMOv1Q60e0CoGz4oER34JLFARtzGOxcUD3G2rFwKuzIZue5KWDct6dWWfptqfDyLZ/8mzlI84fTVmoHtMeg8akLlMg9McJS80gg8l2opouXOYliSTBsIaMREG+9QZW5gpdhYb2oCXqTiEFkSdZUtvD0sk+6RwzbauYETzjhuqY2M94DdOQbIGYx9ILW4cWkwlxQWaGfxnsPi7ZGQGZZNf6Mb4EXJl2ooReS5SR9Nc6+5X/JXeRon26GdBvVG8mGJ4K14XahfPRCogoeFkjJ6IuJLZsPmx9d/rfRSieViuOnRAeedsXmKsIi36EJr3Zkd2RHI0CQOnl861tqMMpH0IWcrNrgLs/8iTXufpM8H8YPh2QkWhjISogxGC+98zg6rhPmsjOwHmRqCt0
X-Forefront-PRVS: 0045236D47
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(24454002)(189002)(199003)(377454003)(23676002)(106356001)(81166006)(53416004)(230700001)(7736002)(81156014)(105586002)(36756003)(50466002)(8676002)(2950100001)(2906002)(69596002)(68736007)(80316001)(77096005)(189998001)(101416001)(54356999)(4326007)(15975445007)(83506001)(5660300001)(47776003)(65806001)(65956001)(92566002)(66066001)(19580395003)(7846002)(110136002)(65816999)(87266999)(305945005)(59896002)(97736004)(4001350100001)(42186005)(50986999)(64126003)(6116002)(586003)(3846002)(33656002)(76176999);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2134;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3TUIyMTM0OzIzOkJ3MW9JNDNGekFRSHkyV3VWUUhUT2NjZ3No?=
 =?utf-8?B?Q2tuWDBFUVdBRmpvL3dIdHJJeVpOUnJURlgvaEQ1dkdQSGQ1QkJwMG1wVUcv?=
 =?utf-8?B?RzRSK1Y4SjdESHdYRjJ3VWNzNEtEbHR2YXlRL1FqSlEwMXc3SGJaMnpDMHE4?=
 =?utf-8?B?Z3d6RnVDYUtVWHhna1JVQ0lrUHRqdFpFR1FxdlV5UXVrdWxVc3dZclJ3Ukts?=
 =?utf-8?B?UU02TGdvZWRBY0hDYkliN080MWl6QWNJb3o5aEVXc0FZSDNsTXQ2UUg3UzY2?=
 =?utf-8?B?eDdoWDN1UWE1emMyd0l1SHRIaElKdUJhWXFYajNQZ3JFeFpzdExoMjlQUEJ2?=
 =?utf-8?B?T095RHc2RW9NY2FKQUxqZDNZYTY1aExxNkRCczNUcXlFMjEzajd3R0hZY2JM?=
 =?utf-8?B?Yk9XandCakZzT0FMcEhvN1RGTHl4T1VsRmEvcXRQZTloZ0JjQmUyUWRiRmxo?=
 =?utf-8?B?d2R4MTN1eVFqSzJ4Y1g4RlVkdUxoTWNHdGVZUTlTdWpEaW0vVld2a0RRRXEz?=
 =?utf-8?B?Y0tjazRuZ1UwSVZGbTdwaFBiamxwdW5qYW51RGltd2NrZ0pXS0xHTWFtYUZk?=
 =?utf-8?B?bGcvNDlvU2JWbUNqZEd3MHFHSExDUzh6dVVNNzA2bDJ4NWV1SGNGcm9tbG1s?=
 =?utf-8?B?OWtqTkQybmxHL2hlS1ZxWWpkdE1BT2ZLK2lJN3dDbXlCTENCdGNBRGpHZWpI?=
 =?utf-8?B?b1Q2VUM2dk56Q0M1TS92RUZsL1VrbEYrajRJOUR5MFVDbVBiOXlKelMrUE5k?=
 =?utf-8?B?Q3BsWjU1eWpXMysrRlpiTGxzNG9XYWFNNk1sc0VuL1NDais3ek5HVHhXL1RT?=
 =?utf-8?B?ZWMxdVBBallBRWMxbmV0YUtTR3pNQmVLZDVjVGtxbTlnUmV5MFNhbnMzMXBN?=
 =?utf-8?B?Y3p4M0NDdEhxK3pBMjBldUZVM0FhM0dOL1JFSzJqNU1tOHNoaXhVTWZESXZI?=
 =?utf-8?B?Q2tOa2EvSTRKS2RCVk5VTk1zQ0dWUHdhTFYyc2ZQRHJ1bkd2UFVmZ0NCbkhX?=
 =?utf-8?B?YlpqSVFDVDZpbTJGT21QZnk1Zk9tYVZsNnhTSFJCTFdFUjdOQ2FyQk5Rbzl2?=
 =?utf-8?B?cmRaMWxwbmU1NUFlTzFRK3BkV0VDZGE3UGl2cWhxSUNLRnJtQXFnUGtnb2M2?=
 =?utf-8?B?OFMzdU5HN1FkSE85U1BvZ0pJQ0ZxM2VaR2dMM2JEMm45cnYraGdCbEtvY2cx?=
 =?utf-8?B?T1pnNGRXZ1Y5cmRQTXJ2QjhpeU1TTTRxRnV2andEbkVHNmdKTkZqTlpob1lT?=
 =?utf-8?B?LzVwcXJwakxuNHk2d3JENThlakdxNmNCYnVmUEIwVUxUeW9EMzR0ZzJYVzZv?=
 =?utf-8?B?M3MvNGlnanNnR2hOUFFWV1R1TTFqbGZGd2pVdThOd3cza3dsa3JWK3gyVFBL?=
 =?utf-8?B?b2MySDR4MCtxNjBnVFVWclpRaE81ZjJLU1BNd0VkM1pBemZ6WnRGWmdEOVFm?=
 =?utf-8?B?dCtFazZmZVlRODFuQ2FURURDUVk2cjFqTGdEeDBCK1J6aDRvZVBaK1FIbi8r?=
 =?utf-8?B?WWwrSXZyNDBvWVpnclJjRW5NbFpIc1dpVC93eWNFZ0FieUVvL3htWk9jYnBP?=
 =?utf-8?B?YlgyUU15UTlRempreW5yYTZvalFpejFMT1dHRUIxQVAwV3dhZFh4a201TmRj?=
 =?utf-8?B?RzJ0NEhTTHhpZXBTYTFNSzFSRWVpaTJEY1hNNWk1Z2dVbFFha3RFcW9pejhk?=
 =?utf-8?B?c2dlUTVUYUxSTmRrU1NYVVlaOC9peE5NRlpIRzNDQVQ4Rkd6bHNGdEdqdVRq?=
 =?utf-8?Q?55wiQD02Fg7agy7SBVOM9P3x2tdv6AZtOmEoo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;6:1JITL6Qo6vO4yvcXOgR1CZU1GDGrc6UXSnYTxnLSIzmZFdDr48AnEwBWQ2eJmVxF73abS3Lg8ttpoMVyCG0Ctzl/5KnguqW1m0JjygjSyYnQ9wHqviT0oqyGAe+2iXpz9aMiMg5jzkrxbrK8/B2o5rbrQFc/sjbPvh0yvWXZvodYlyFeytra8cPNxXVzWCdnOez5MfK70S2PmQ/oKavP4FoQ0CgkqtT47lZmxgf3LVwfCzNlTnyESiy5zZc6bzE9pQX63XfP6e6ZtBLFWD4/L7FC/EwZ39llKTgNAV9vZGo=;5:dYYG0tT267x1AV1MeQd0TstD6lRKUhonoC0s7+ntcpu/3QGFCCuthJGTb4FRkFP5N90QMDvSjzAc9t9/yMgpqQiggF2NzBSzvPtTb9U4MCdoX4CyRi1Vkq5Cw9KbKdSK8cctjlNAtj7GjuumhqpwKA==;24:hUgxN3miLfEku/N6fsQG9dYE9JlOR7mAICjVAT2mf/woRJWbSTKhOvpT0O55LjBQCvdN8q1pywAquby+n2SyS7QQ1B/F9NuljMVMiIbfa9c=;7:JPBrOUCQWE5f9TuQP3QWnQvJ1z3iNvz6aE7tLnUtZWd1oZTaiQq3PHTY9fYNynP/nf7+iqFmLVv8lg1+/YepdjzL7Z12JENsPWkvFuXc9U6+HW/ez9VNbJSC+UF/Z8h+a+S/MZOa43DE9UIqfuS5ZtKBhbmBUD/KfuvNq88Fd3MskSYOKtPHvGnPlE6zvCubzGXnE5KRFEvoTYwnDb4G04g6l39E5bEHHcIAlaUBHDLKWFKHUxL1yk2yPkU9Wcty
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2016 16:50:17.6077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2134
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54750
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

On 08/24/2016 06:29 PM, Ed Swierk wrote:
> I'm trying to migrate from the Octeon SDK to a vanilla Linux 4.4
> kernel for a Cavium OCTEON II (CN6880) board running in 64-bit
> little-endian mode. So far I've gotten most of the hardware features I
> need working, including XAUI/RXAUI, USB, boot bus and I2C, with a
> fairly small set of patches.
> https://github.com/skyportsystems/linux/compare/master...octeon2
>

It is unclear what your motivations for doing this are, so I can think 
of several things you could do:

A) Get v4.4 based SDK from Cavium.

B) Major rewrite of octeon-ethernet driver.

C) Live with current staging driver.

> The biggest remaining hurdle is improving 10G Ethernet performance:
> iperf -P 10 on the SDK kernel gets close to 10 Gbit/sec throughput,
> while on my 4.4 kernel, it tops out around 1 Gbit/sec.
>
> Comparing the octeon-ethernet driver in the SDK
> (http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/tree/drivers/net/ethernet/octeon?h=apaliwal/octeon)
> against the one in 4.4, the latter appears to utilize only a single
> CPU core for the rx path. It's not clear to me if there is a similar
> issue on the tx side, or other bottlenecks.

The main limiting factor to performance is single threaded RX 
processing.  The main manner this is handled in the out-of-tree vendor 
driver is to have multiple NAPI processing threads running against the 
same RX queue when there is a queue backlog.  The disadvantage of doing 
this is that packets may be received out of order due to 
non-synchronization across multiple CPUs.

On the TX side, the locks on the queuing discipline can become contended 
leading to cache line bouncing.  In the TX code of the driver itself, 
there should be no impediments to parallel TX operations.

Ideally we would configure the packet classifiers on the RX side to 
create multiple RX queues based on a hash of the TCP 5-tuple, and handle 
each queue with a single NAPI instance.  That should result in better 
performance while maintaining packet ordering.


>
> I started trying to port multi-CPU rx from the SDK octeon-ethernet
> driver, but had trouble teasing out just the necessary bits without
> following a maze of dependencies on unrelated functions. (Dragging
> major parts of the SDK wholesale into 4.4 defeats the purpose of
> switching to a vanilla kernel, and doesn't bring us closer to getting
> octeon-ethernet out of staging.)

Yes, you have identified the main problem with this code.

All the code managing the SerDes and other MAC functions needs a 
complete rewrite.  One main problem is that all the SerDes/MACs in the 
system are configured simultaneously instead of on a per device basis. 
There are also a plethora of different SerDes technologies in use: 
(RGMII, SGMII, QSGMII, XFI, XAUI, RXAUI, SPI-4.1, XLAUI, KR, ...)  The 
code that handles all of these is mixed together with huge case 
statements switching on interface mode all over the place.

There is also code to handle target-mode PCI/PCIe packet engines mixed 
in as well.  This stuff should probably be removed.


>
> Has there been any work on the octeon-ethernet driver since this patch
> set? https://www.linux-mips.org/archives/linux-mips/2015-08/msg00338.html
>
> Any hints on what to pick out of the SDK code to improve 10G
> performance would be appreciated.
>
> --Ed
>
