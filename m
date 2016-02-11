Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 18:35:23 +0100 (CET)
Received: from mail-bl2on0085.outbound.protection.outlook.com ([65.55.169.85]:36733
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010888AbcBKRfUsvWsV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2016 18:35:20 +0100
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (TLS) id 15.1.409.15; Thu, 11 Feb 2016 17:35:09 +0000
Message-ID: <56BCC64A.5040902@caviumnetworks.com>
Date:   Thu, 11 Feb 2016 09:35:06 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <david.daney@cavium.com>,
        <aleksey.makarov@caviumnetworks.com>, <ulf.hansson@linaro.org>,
        <robh@kernel.org>, <ralf@linux-mips.org>,
        <linux-mmc@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] MIPS: OCTEON: Rename legacy properties in internal
 device trees.
References: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com> <1455207976-2262-2-git-send-email-matt.redfearn@imgtec.com> <56BCB7AE.2050901@gmail.com> <56BCBC90.6090805@imgtec.com>
In-Reply-To: <56BCBC90.6090805@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA0031.namprd07.prod.outlook.com (10.255.223.144) To
 BN4PR07MB2129.namprd07.prod.outlook.com (25.164.63.11)
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:HUr0BOpaZwK9UGXdkfUua5EQ55w+b8eSp82galXO22EUkZQdodkyPF5DdbB1EH0qBkNsEN3YO3b+oZCxOQp3UPclpkzyNln1kmSBoJvI28Dh5mobVobWXBKs/MfGLMo2r9NkATWHaYcNHnPQfhpCQA==;3:7hGfJINcIFba1VLWi9VF/W2ujP5c2eIedVnhQWuR+s8RyxCHNjGClu/GfEd0DJ/M+uznIuiFuayHMwpPkmzuZu7yHnrTaYhnMOOGl4z5jHKwhJUm4ZzogMa8wD7xFKKM;25:oy4dI7Qxttjd1GqBb9AOrc3bOGybwF8eqllf8jZR2sVX+5A9h6h3o5IoQgsvbSnfFGi5bV78ToBZ3cL8LL7Qtk5uVvQXan+s5vLMzHdrp8tN6SNLytSC45RBpnk6gTNwaiT+XNKU+kerxM2pypUBor5y97OB4zgW+ILUt/p8uKh64SXN0gocFHo+Y2qO6JQiuzV0NuRJJBNjt3rNobKqnks/qibgtBkJQTSfgEuP9foXNxbHZfdrXm9BHf4kzjSL3YCiXqmOjQ2ffZ1al/Ff1nywp98MkHv1tEUmKocXxPtB/kPbKSoymdicF1kEH91B
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-MS-Office365-Filtering-Correlation-Id: 30f82d1e-142f-46ba-1511-08d33309b0d8
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;20:X9k1z1/8rP7ikBAjU0WcrkQhPtr5Y4xnTOvqnNdA0WEssvr0KmM0sDwy6HhQmNDzG0ajZTZatx2Y98B7Onu7gzZiZ/+zIlEGwUISh0Rrynnw+86HwXApR+BGd+yfAemvrBDtBD/7rsdxbfaQLPtebCLeK6IfhljsMqKtbxfWhZiumpsQZUXoqRKRkx7ud2JpqayaZ114fupDCpWJKU9GCUK1o0417DuwzMg5JWrE4YtGuAezhEAcaXMAOupAPOYbGnv1FnGhCxfVgB7ZTv6aq2k00mEOYILtQeu7GWmVBwkC2ymftMJwRp53y1bfgzw2fJrStMSPH/ohXntEPmmjZx2E4txKjKjs77eVAsCEV1NfIVofLqkpoqW9JNrGEGcxD2X9S5YR3OpJuSWejPuS2kZDKr19jfWZMz6iSuHnyci+bflo4xbOXETlx7NJFYCClXjgb6PLxCunciOPKfmjdnqFpwjbvPpJbrY+6rU7V58sD+4fQGZs+/3DZ5L5lOy6fa/hv9OiRP6ozHQDCFWcVyV1QG40qJ06IiITt0l/eRsXnm6RfIZTyLOe+4ZBA8Ues1YeQDI63T6fXNC5l07vvFatdvNn/tUoBRobhcJv40w=
X-Microsoft-Antispam-PRVS: <BN4PR07MB2129CB22DE15CA69FC462D109AA80@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:RPxt6QkzXJ+zpbRcPCP3fHrpdWHI+RoE0EJQYhkWWsnMNFq6YpvEzF/gM3ZPmn5IIcsuHXSJJOekTZMZezn1+LhtQyDroGIA4t1rszNnBt3q1xm3bPB7vUKlCDXokNxuomzrMZnqtZpNhEI0JXMpQW1G7S73j7uC6p8tTqvZ8kzz2rZqeZt16cXLNk+OQpMULr2Z3eSWZeEOWWr6alisaXnO8mgADGHebQxNCefzI0xzhARTUgcIz/KSI55t+yfCkjIgFzGP0fwpMdjmB18gdYQn5b774AsEA5OMJ28KheCEJylLDmBkTNB3TIMER8E6auUXC2VgEIUEUCJeIuY846NjLARdEPul8XzKxNd+VFsCqht+/Oxhiw5nqqwDETUR
X-Forefront-PRVS: 08497C3D99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(377454003)(479174004)(24454002)(50466002)(77096005)(5008740100001)(23746002)(65956001)(65806001)(33656002)(47776003)(66066001)(4326007)(122386002)(93886004)(40100003)(1096002)(230700001)(586003)(6116002)(2906002)(2950100001)(3846002)(4001350100001)(59896002)(5001960100002)(5004730100002)(189998001)(19580405001)(80316001)(19580395003)(53416004)(65816999)(36756003)(54356999)(76176999)(83506001)(64126003)(50986999)(42186005)(92566002)(87266999)(87976001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BN4PR07MB2129;23:2U4pQ7jxIXndcIYykke3fUoUIkHvAx3z+WJO5?=
 =?Windows-1252?Q?VsyCj0vUK/S15IdnOc7P263+orSmGUMs5vl/9nGqRyoYyTZkyu4hWcZN?=
 =?Windows-1252?Q?bQ/LUbNNh67kSCG3YIdnnTkno/giGXTNZmXLms7OUzaM+kI0+7J0dM0+?=
 =?Windows-1252?Q?ynlxUNCeVXf8DszVNjWelK5g3blXcJ29ZXgqiWmP6bIDjBUuFEkG2gDs?=
 =?Windows-1252?Q?oqvMs9YuU/1uakjOm+L/qLICrfTMMgik8rpJl+O4OZdYdlLKWQ2zhmxT?=
 =?Windows-1252?Q?ngn6ovpVgqSmAYVhECgbUKjp3UUTq1dVb5LxIb3cDmdLYBsdtOWcaXa9?=
 =?Windows-1252?Q?f3vP2KQ1GbYzm80H4v5PkkZHaBWow9/nJeTNYa9kSM7w2WXSOi4FCVd5?=
 =?Windows-1252?Q?rOD3p+8eLcgzCKsYqjq4j61y7ydJmD7Gv7IHW4WCIvOp3CInWdDJag3s?=
 =?Windows-1252?Q?FoPL2sxZnssDey2DiK4ewIeRUYbWcOu70RcvRV3DBpfSaMCXfDM1NAwi?=
 =?Windows-1252?Q?tkKPqIdDbcSystWC96t6LLQ3ZjAFHtD9zRXwz6hSA6zJL31sIjfIVTEW?=
 =?Windows-1252?Q?wVaZli+P3jw1sehILyZpJCs09Jr0w/S4MflDaEnjYwS0Cr865Q9V16dB?=
 =?Windows-1252?Q?Ftd3bikBRz/oCI0jfEua6PrbnCK6psdPGvodn1qBljMZFLnIfSFzEdH6?=
 =?Windows-1252?Q?fiXlC0I7fjbzaGXz6gk1rRW8RK4L1q9V468Hzb89wBXctd1dGWm5hcda?=
 =?Windows-1252?Q?ApYSFrNzQp2t0VVrSNABhUbc1W2I8HjXtNleLnEb94Eyqw7AsOQTyFxb?=
 =?Windows-1252?Q?lXezeZlEvxwOg6LR8HaCR9hy8OFWutTZRFmUW+S7TaF1qBIQ42rIL0UK?=
 =?Windows-1252?Q?sTopTRtje+0jn6Jbu0qSFMOu8fSOBYQYhKv5R7/wjl43uLOkJDRJrT12?=
 =?Windows-1252?Q?Ul6Qc0Sw5SgRv9gbAskj2qwr4h8O9XyA7AVjIJehuVo7Xznyz212A/Tz?=
 =?Windows-1252?Q?eGau6giTI1WzV4hzrA4pt2Z9bR+xYdIw3I+1qPXmbIRM00FNbKQSI9Q3?=
 =?Windows-1252?Q?MPD86RytDFWb804BvT1qwzLAZak7qvD1Fxdi6jh48nLuvE65Bie0o19Y?=
 =?Windows-1252?Q?GA3STCUcyGsojUgqxYnuqBar0w5DQaSMianBfZrKIaXPcC9ygoMtO59e?=
 =?Windows-1252?Q?bMqnegdrJCnNaKf2SfL0x/jARuV2A5yFzcuOpP/LUMOIq73QGwNDmZtD?=
 =?Windows-1252?Q?ysZxBPoMHwA49MxVA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;5:Q8xpFrdGGiHKEpGI5hpLOyQ0/LRQjff2WP29i37lmVWbbVEFvqJ4jOmDs9LbFRqzSZhbjbji+QC1lNdTl2jW24SAYdZbNJXr3jI47IOhDkwIimTU2JKYyLMhg2LzdvrB9y3YEjmIcq7UkCZpb2BnJA==;24:dXvciBt91jLZ+vhrt1yYbDMpOT9G+EpAVR0SHeEliJMAB8YjRdsS+VAFTV5mzFl6KjRrX/uEzdqqWKU/CujsMGBolr3LYaJ7wDaGXcONGok=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2016 17:35:09.4044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52018
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

On 02/11/2016 08:53 AM, Matt Redfearn wrote:
> Hi David,
>
> On 11/02/16 16:32, David Daney wrote:
>> On 02/11/2016 08:26 AM, Matt Redfearn wrote:
>>> Many OCTEON devices have been shipped in products with fixed DTBs. These
>>> DTBS contain properties which are not compatible with newer kernels with
>>> upstream drivers.
>>> Therefore some mechanism is necessary to convert legacy naming into
>>> upstream naming. In the first instance this is to support the OCTEON MMC
>>> controller, which is in a later patch of this series.
>>> This patch adds a octeon_handle_legacy_device_tree() function which is
>>> always called from device_tree_init() to fix up the device tree so that
>>> drivers need have no knowledge of the legacy naming or properties.
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>
>> NAK...
>>
>> I already sent e-mail on this, but it crossed in flight.
>
> Yeah, unfortunate timing.
>
>>
>> Basically, this patch is much more complex than the original code
>> which was just a few lines to check the alternate "legacy" names.
>
> This code is functionally equivalent to the previous version, just
> located in platform code rather than the driver itself.

I know, one thing I really don't like about it, is that we are modifying 
the kernel's view of the device that was passed in.  How does that 
effect what is seen in /sys/firmware ?

I would rather see code that calls mmc_of_parse(), and then, if the two 
properties in question (bus-width, and max-frequency) have not been 
filled in, attempt to read them with the legacy names using 
of_property_read_u32()

The implementation of mmc_of_parse() already contains support for 
parsing legacy properties, so we could also add a couple more there, 
which would be the simplest change of all.


> In terms of LOC
> it's not much different. Doing it this was does allow future flexibility
> to change other bindings that are fixed in firmware without having to
> support each set in the individual drivers.

I think the controversy is limited to the MMC driver.  As far as I know, 
we are in good shape with the bindings for the other drivers.


> Leaving this patch out will mean having to get any legacy bindings
> accepted into each driver via their maintainer.
> But for the moment we're just talking about the MMC driver - if this
> patch is not accepted then the only way to support legacy devices is
> with Ulf's signoff of handling both binding versions in the driver.
>
[...]
