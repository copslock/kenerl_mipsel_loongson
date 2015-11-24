Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2015 19:13:41 +0100 (CET)
Received: from mail-bl2on0099.outbound.protection.outlook.com ([65.55.169.99]:47552
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007608AbbKXSNjBHOdB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Nov 2015 19:13:39 +0100
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (TLS) id 15.1.331.20; Tue, 24 Nov 2015 18:13:29 +0000
Message-ID: <5654A8C6.3070306@caviumnetworks.com>
Date:   Tue, 24 Nov 2015 10:13:26 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Aleksey Makarov <aleksey.makarov@auriga.com>,
        <linux-mmc@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4] mmc: OCTEON: Add host driver for OCTEON MMC controller
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com> <20150518210514.GG609@fuloong-minipc.musicnaut.iki.fi> <555A5C5C.9090903@auriga.com> <20151120173233.GH18138@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20151120173233.GH18138@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BY2PR07CA043.namprd07.prod.outlook.com (10.141.251.18) To
 BN4PR07MB2129.namprd07.prod.outlook.com (25.164.63.11)
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:P2fLP5E7j4a2/0zrQ+1Ob5IAw/cBNzkhpNC1T4l4nqGEZr1SmMhekWYsPMcqp0rOBt+WsrLYVycmyeTxXEKaFZunHOEcORgHkU8mlN89Sz4UcMNnIjlH1BDsfoJwNPijNLOHiBTey2y4wn6pFYFkeA==;3:PUoseJex19cCkP7l6RAuKhOxat3SKrknqjhjvffMn1lssYSurRMAqYJF2xEb3aP8eAnpZx19hTs6O7DMV7Vm+Qh23TSEbMbnCVKWUZ+PwfH5eD6OSABEvOfNSkxecpp9;25:R1c+zOMW9dgXPC9yzqouQ2V4tRYFY3Labcr+mDzgrPecTeh/TIDX7RZSn3bs8T1p8STxuAAN2VoocioRHwCTgq/2ReZYrklivjPYEraBc/zT9/+9u75qEs21REmGi0EExqGNpbBi+QlfUy4EAzbIksP13XY/Aor4l/RGqlKKV/4TdxMHO+qTp59QnUro5rsIJAKocW1+Tq+Ey599GTh5+S3Qg9GRh6XfPoC/Ghn/Y6pdTJKtkv4rTRmLA+SF9BiSmgKrwx3RdOjcdn/L20AcQA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;20:5SElNzak7U9zQSz1OOC5qG/lE3sBcc7dJW05FnLvGY6wY7uYYe3oABllmW/1LMkcard+QPOr2dL/HbhnqXSD7b+pM7nJDhAOE2rjcPFtoscSWwt+MKq9oBWfJXhkwH1RMF3dCO6+WYDc8dQfUYTXerkO2VCdFEtZWtcdWdjDSLOa/TTb6GosD8Xww+Lhuap54yIT1MUH1NBAAWU238CVDRMaVyuAX0u50LKOaSGMScu9pxkzVLa8LAiTrbT3/np6nHYH2POiE1L+GrDr7DblxM/RA5L3JdshVWTjX/ueO1hTy5rZVc7e+Ud3/QvOH2/CiH5+PVmGIVfDrSOCtQZYAbHBxUKEzTfSCGrB4mQ6zD0OH7xflELS5B7o4eVLcI/fdZWLolGZb5j9N4vwMZiHC33w6i484R6cfaEKxYBKvw5SesHAolebPgS8SmszG/RQGb6IrU8QHtCklg+rTifd4/Gr2lsUcCI31+S/Tl9mlQxLjjK941vUQijxeCzOVgeDWnd03/vAwjNM7JgY2vUjUTk28SvEZa8/F7w581qExRBOmHzGlhhs1/iRoqzq8hO+6GXkbEmd2gsG0XHz80pQrLrGeZ4bf0S73ZaMgnM7TUo=
X-Microsoft-Antispam-PRVS: <BN4PR07MB21296F660E8B1500FF7FBA829A060@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(236414709691187);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(10201501046)(3002001);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:6M5xTFwmqFkhvAvVYs3YUUoSszQJIz4r4CYob6F98X4vb81tk4tifD1/6o5jnLEdhWcxDC1OVrdsg65AoLkmXpnQOxDmcoFMxJyRQqLv7hMVozQX8Ek9yzvIMmvD+ZDLXArtzNiYYmGa/NhE+EAfkUqRg6LN4hJwLTwvr7hbsonUpC7HNiquJtNuFYf14UY5W7k2RK2bQoCHwfqD7aMm34Lw6/rk4jaUcUpZOFJAwIzPODaTmug1qlERrdwl9mKY7OrNx8cotuXn8BNiou2z8jwm+OQdZJ2hySx056+aVyJgEMcqGpoRDUDfsSYW7J0Q2vu3XbX79aBBqdLrSSe94sezEUnxqKBItR+YdoPlgRLZto4khNwHGPUfUqXOsH4+4savAGixY3/MeuWQ5fT6Gg6+olocTrMQ6oVaSsrlbOpz1CRWdv+JvGuYAcAe/gHV
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(189002)(199003)(24454002)(377454003)(106356001)(230700001)(3846002)(47776003)(65816999)(81156007)(19580405001)(97736004)(80316001)(19580395003)(6116002)(40100003)(50466002)(50986999)(59896002)(42186005)(87976001)(110136002)(93886004)(122386002)(83506001)(69596002)(33656002)(2950100001)(4001350100001)(105586002)(64126003)(5001960100002)(189998001)(36756003)(76176999)(23756003)(54356999)(101416001)(586003)(87266999)(53416004)(92566002)(65956001)(77096005)(5004730100002)(15975445007)(5007970100001)(66066001)(5008740100001)(5001920100001)(65806001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN4PR07MB2129;23:6y0yn7fyG6kEnYiBm1X0q0nMv8wEXVP1npKlyOU?=
 =?iso-8859-1?Q?GI4WN4aZq5DgE3FG6IZrJ4uiuK05BBSfqkLoFFkkV+imD7B2DtwAlrHhGw?=
 =?iso-8859-1?Q?exPhk4gPh4zCAxjYOa36q2lQ0uzlmNBBISel839nKRWity4ZpEuexRWmif?=
 =?iso-8859-1?Q?Ni6V52VlTE79ct88x4FZgv+dJqw1IKHib48ozb27UU5tpw6cvB+Ot0VR1h?=
 =?iso-8859-1?Q?jaqxm8rQiAkNxBy3/N/cc2uDrZ0baRbj1rKTdyp3ILPWJvMATAPsSBhj5S?=
 =?iso-8859-1?Q?xRkP9V33CEJyGNiJZC+3mY2wY20v4rTOzNH28oaRzY54H/m5IJ7yyiOmSD?=
 =?iso-8859-1?Q?SdNGN5QotiYv6yHf5VqEYa2pYyopra3HUIkY75xTCY2bevklcponWs/uE7?=
 =?iso-8859-1?Q?8FxhKHfEHW81QmuXm7AXzFDZAu06Qs0IF5El200zYyEpcAT1p1A8Thv5CI?=
 =?iso-8859-1?Q?qZWwUJ5lGLgspQRmbOGYxFTghl5sj4qFKudSRkb99uNOJoggh/7hMKer58?=
 =?iso-8859-1?Q?HhW4HK1iOcyy9kme01+ChZqLppey5jKEByEcD3IUgx11Bks5XU6PccPfhJ?=
 =?iso-8859-1?Q?AQU7bcRur8cCxPcNBA4sRiPw7h9NCI+vDK3PC0gmojVVBTykOODWabjTh8?=
 =?iso-8859-1?Q?CkmJ73geS8iZbIsTKTjOaNQ9VY3u78BsJwCV4cLKjxffMaMWExHI7MQsUp?=
 =?iso-8859-1?Q?25SV7k/kSXTGsm1rGYEaMf7htDMeAL6FNCKUiAZ6iXUr3h5zN8GkyM39pI?=
 =?iso-8859-1?Q?wx1vEGOOjLMcqDHCJRP3NzUaAdEGWwKMhdBPP7xC0hNfoxA0yscv9AuXyW?=
 =?iso-8859-1?Q?lvyRqnd4mXkx8TruaSeRQ59qyPeMSdj5lcMSvK81TKjolcYttBBz/b4rxd?=
 =?iso-8859-1?Q?F+by5jBAvj15jMVeuyUZvQ6vJduieO7sE6cpwFCGjBjuYGA/LvQT2NPELe?=
 =?iso-8859-1?Q?z5wxs8vknYjT5TkLZo3+yhuXaOymqjg0HytfwgoFFLNQxe0defH8qlQ03S?=
 =?iso-8859-1?Q?/Ijt5UkBQ5Py012vM3gEVn7Orfpq+C9cGce1ZlWOUQwVzmiYV4d6cNYJrH?=
 =?iso-8859-1?Q?4mNNHCsvPFcIs1eUqjufXzzs6YTPo+BKdipZTmmB4Wq6NFi0X8o0aIXub+?=
 =?iso-8859-1?Q?zfKYiE9Io2mqKOyQAjhZBLkrKOkhyhm8UlW4w1K0rh8WBCJPDnpAqUXZEV?=
 =?iso-8859-1?Q?dV1ZM/DjhcRl30+5wS+okk/mkV94Iby6PeEsHegEwpmgYJZ7ZA3y36lNo8?=
 =?iso-8859-1?Q?q0kwDQ8FB9gHgh32S+85t46BWTJHpwY7Cmw0DAxR07MuPRzA2jvkl4ILcx?=
 =?iso-8859-1?Q?sCcVjUkia5m9Qgm+cWY3oSfoytBEekJji9xfcIz46yiXvvcBVWOQGcThQv?=
 =?iso-8859-1?Q?8mSBKYx+7vQIgfWQOi0Ap2DhvgXtgitYlmgbgnyxrQiiMLi6ldJiGIslVO?=
 =?iso-8859-1?Q?5kiJWCWQP8ReBV/xCqQ3ZK6WTMtf0MTLU0A?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;5:+dI0wJi6qDeHUIwXluFrM2PT8rJLY5KiA/cpLxN9c/dDXon3nYKHZs3IxABBNRgF276Aws2JdP5OczeU/9K65mOoDs6AqxvdgeiOEyRZD5qObxO3y9m2vOhFjQgQiLOstAkMQqA+dBwJJBEyeXtT2g==;24:wEacnMTEPzNMm3BIqRMvO0b+l6Nutx1A/pV8vi31SL3afa4fi7+JYNVaHFmhev+2tG2Xed1RJmJImXjR0lvHSQadEhdYvD+RchmE/KU9UMo=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2015 18:13:29.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50068
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

On 11/20/2015 09:32 AM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, May 18, 2015 at 02:40:44PM -0700, Aleksey Makarov wrote:
>> On 05/18/2015 02:05 PM, Aaro Koskinen wrote:
>>> On Mon, Mar 16, 2015 at 06:06:00PM +0300, Aleksey Makarov wrote:
>>>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>>>> devices.  Device parameters are configured from device tree data.
>>>>
>>>> eMMC, MMC and SD devices are supported.
>>>>
>>>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>>>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>>>> Signed-off-by: Peter Swain <pswain@cavium.com>
>>>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>>>> ---
>>>
>>> Any updates on this patch? Are you still working on it for
>>> the mainline kernel inclusion?
>>
>> We are working on it.  It will also be used in ARM ThunderX arch.  So we
>> will send a new version soon.
>
> Any updates?
>
> Also distros are waiting for this patch, MMC is the main medium on
> some boards:
>
> 	https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=800594

I am aware of the need, but haven't been able to find the time to work 
on the MMC patch.

David Daney


>
> A.
>
