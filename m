Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 01:33:00 +0100 (CET)
Received: from mail-bl2on0090.outbound.protection.outlook.com ([65.55.169.90]:7060
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010896AbcBKAc6gdYyE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2016 01:32:58 +0100
Authentication-Results: iki.fi; dkim=none (message not signed)
 header.d=none;iki.fi; dmarc=none action=none header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR07MB2134.namprd07.prod.outlook.com (10.164.112.12) with Microsoft SMTP
 Server (TLS) id 15.1.403.16; Thu, 11 Feb 2016 00:32:48 +0000
Message-ID: <56BBD6AD.2090902@caviumnetworks.com>
Date:   Wed, 10 Feb 2016 16:32:45 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mmc@vger.kernel.org>, <david.daney@cavium.com>,
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
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com> <56BB7B2F.60307@caviumnetworks.com> <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
In-Reply-To: <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA008.namprd07.prod.outlook.com (10.255.174.25) To
 CY1PR07MB2134.namprd07.prod.outlook.com (25.164.112.12)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;2:95tLz8vMxQtuunAnap6WilLHRspRC9Ydo/fJ9IySBBa+3idzZKGxmJ6wfwWJcerfCZjr0wQYO/3ax2lGzzC1hPRiNrqNJxv5/vlC0mVSGvgtZu775bWrETXNJ8ayEkndrcKJz1xb2hqO+Sz4mrz/Fg==;3:cSnvLC/ZLWoP5+FoZKjJ3RGVJ7/3BP2p3s68e52lyvE7hbTBQzWLFfJiASnvCBViuqgdmI+F3u1Nn2vK9nbIDU7Vpg5sUHz6shkmnaBBsXjtZx1nOFRb6noI7dUQ8MFu;25:G5cPk+iqJTPGFTCc7kOKy6KecWd2Onz9NDau3I8xVIbkUh/AVe3yrQwHLWMdBdQ1L1QOiyzfyB1NZ72ul1kAQ07MElCIKHBl+FV3HXPuqajKjoJ4XHZPBu+VKLukQtx6GoCtT/mIpr2wMQYKg+IqZJURl2rVM+vOy29rm33ihGn+78ocRw4BL6R56HS2tOu6jRSXcl8B7xIC4HLdR/D0X/ylekGWaDCN7hGZvdcTjrGGhviK29LyWGPuL/uQ0KK3IKdJICCwK8ZzdrtqWa1LtxnRUCtUieGshQ6peZzH7YMSftWnjK7/qW+K0Wvdp1Ek
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2134;
X-MS-Office365-Filtering-Correlation-Id: a39936a0-b0f3-475b-d01a-08d3327adf25
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;20:p2dznq2ErIa+je1GiN1viUV/gyzysCl7PgmEWncfQcZmUf3F4J6KmoTHWiiAQ5Avrh6Q6UgmvoJOb/A8TXy/FoqyypY4cV7CR1FPPC4WCtlJNmfxWq9Vdxb74MIklxwq/HqlQWcx6iFcSlHzTxR6/Pzouf0HoKxDHOHcbvBfMCzkRhFk9DFBjeGAG0TCcgjP2PF+noJXwdlUEx/GLHFbQ5Kh1A7ppNFE7J0KxggJeFmDeGpKECHXzwPRFzHhTVw7S1qqE4sJa4MEMmU2b/eit1TJEuBL8BeIbudEe5scLFUSzhG91MBHyPznHckVtAYnHa8uA+V3bIz6735HTmyEzH7KpL1Dz5lPYsPH1QLSt9iAUD10LH1aD+SkjxySSNxd14UfXJc1lyR7F5AwCX1Rf5MddEOqFoip0/HTASz9wIgQ0FboMxjAxN2NkDegAgserll/EzMeXvzcbT/C8CIxkd0iHqWjWItTEIU8136YKhXs9YvRdFoPrCAb5A42iuCQ6FKt1TfXgJYqBit67rYqCH81PD/TaSaeVSEg8HJwMlFjofXjTBjFQxGgqnCl9NyEGKEfO2/NERnyXxjIa33vZ7ZegSM3xYkctbObU8d6zlA=
X-Microsoft-Antispam-PRVS: <CY1PR07MB21340762533F8DAB7990A8B99AA80@CY1PR07MB2134.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR07MB2134;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2134;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;4:mN0n1To9yQtRdF5Gx3gqLwLb64/2ysHqSm4/gyjXRD95pPplfqh+ursLHS8sgiL/jvvJko35m29kwJHRTrKJQ+xjLYZUwcpxOJAQfo3+llcdG9wioHXsBuOOZM10f75rpJKm5lw3WCZD6bDJdTNuviujx+tT32mqEaN81nD28SELbt8noVyAlE8CfBAv8BQyxTZ1IoNXec2SVQopsPfb36GuiwZ4SNRpwAWplba2SGN9SQx/ZnK3LE8ojQATYIX/dRQzQJ8E6BwVBhd4kSk4EkYAqlkhQcUw6dNj9pIxFfEA58AzKHJ06Wb47H16qKtBYAU92hiAtBgyGnKlHEHKVEn5HKxmqRwROdYLP/kTsKUUnZQbjM1T/YCi8+tqwWBm
X-Forefront-PRVS: 08497C3D99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(479174004)(377454003)(53416004)(23756003)(4001350100001)(33656002)(92566002)(3846002)(77096005)(4326007)(110136002)(2950100001)(189998001)(36756003)(1096002)(40100003)(87976001)(64126003)(5001960100002)(65806001)(5004730100002)(230700001)(5008740100001)(586003)(122386002)(50986999)(83506001)(2906002)(76176999)(47776003)(66066001)(6116002)(65956001)(65816999)(87266999)(42186005)(54356999)(59896002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2134;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR07MB2134;23:Luw8BEjFFpJySNtHEFcVJokwuNB1v1be8EaLUEe?=
 =?iso-8859-1?Q?KEVaPep//OFIIC7vji7WazPwzqtPuPuPUztcxNtXWXDKL9CpH4MwVpE2RF?=
 =?iso-8859-1?Q?D49kTPAT9YlqcV2AR2Y8Dod6KBE9ks5701Lh8Ua8pUrxu8it8Z1me7Fe/R?=
 =?iso-8859-1?Q?LaT2QIW6MLm7u0soJsHUX0oRkOybaqF4qzQMbgcJxHmQ0nGHFoizJW8CJz?=
 =?iso-8859-1?Q?STRQqiybnIsNR8fc7lji4QTBmOnpMEh6oTS32mB3iVK287jGW5yPhJAyhq?=
 =?iso-8859-1?Q?xlr4OE04/6ap1bBolPIRHBA5G3W4QM5wFK4VbTOJSS8o290VOYTXPUYEtH?=
 =?iso-8859-1?Q?bvWXjaDM5DUNjrrsuut7pDXy7eNTB3SVv0kAPlHioaSie+yrxUZv4bJ2Z5?=
 =?iso-8859-1?Q?hCx71cMS7+EAJ/G9A6ob1iJBUtgE33GHa+8JxBAnjBLdbctUpTb+1OoPIC?=
 =?iso-8859-1?Q?DhIjp9EelqABrBFmjrGP9GWJhP1kE+OzB8B0OTVH3C0ws7EtXL6uHOQR3v?=
 =?iso-8859-1?Q?2Q5rfnVULOKBasF6F2Mpc5Ng8y36Ex6ZS1FAZvvKXk49Qi2QiHYSSCcpzA?=
 =?iso-8859-1?Q?gSH3otxksGwWXJjrvb5OSI3q4P/KrOOhCLiU9RwAyEJk54HVGzjVu2LyIr?=
 =?iso-8859-1?Q?RKnENJkG4+V6ePNqmutJFTbY2NeJTBvKZdBJtn+AyqdtxBhmdrNeYiunc8?=
 =?iso-8859-1?Q?R6H4EW5bqL/3uVkABXDzg7ksz1fHBAaibTqUQTsCLsFVEVW6Bvn5N4ZDTZ?=
 =?iso-8859-1?Q?TmF7iHt6ZcOykNn2nN9yqLsa4yPKZWgihhkphvAoLrjgXiQXqfo5ByzymO?=
 =?iso-8859-1?Q?K7Sz9uNfoPShmiRWTXpnPyFytFd0VA4yH8DrJOc1LNlySCVc99O3gZ6rOe?=
 =?iso-8859-1?Q?EDxk2gNUiMZak1tYj3iAkeYZYl0iFjGMWqzf5B49ywexULVKaJ6XeOIgCJ?=
 =?iso-8859-1?Q?/FcMpWANsXd1Z4VzGqmM8h8+aLrycb+BKe/auU2QAOhUVT11qf9sPjc1+L?=
 =?iso-8859-1?Q?hyTd4yJ0LnfOF1fT2ov/3qIPWEKUQytu5SChM31XEdDlbq+LPLZ/Bg1AbP?=
 =?iso-8859-1?Q?KdsTecrAIv5AdIgaM0Uycv8kjyVrMgPsN+5JA9g9Qs0yXRfbHjU9mJLzRt?=
 =?iso-8859-1?Q?QePkb?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2134;5:4nWLZmVFu6D1keIzfbwtnasKQK+LsEvrUmTEd8XqYt8FTH/xU6tVhbcsLENQAtS1/i1E8E2b1AqZW6gH71Z//vWsv9g0Olhe+KkRO+mkbcQ6QJ1/GLqOjusWxwzCTWz9yx3LtBJrJ3s6W9ih+mLCMw==;24:/zd9V3WapwiSGZVRJTCyLUjGWYVAFNwdUJo5qR8xzhBHuBd4Ip+rJoy8YjlNNcY6HUaHOPasm5df1BMH+Oq/x6AJCtLQ/tJf4bOtmhbT/7E=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2016 00:32:48.8380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2134
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51983
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

On 02/10/2016 03:49 PM, Aaro Koskinen wrote:
> Hi,
>
> On Wed, Feb 10, 2016 at 10:02:23AM -0800, David Daney wrote:
>> On 02/10/2016 09:36 AM, Matt Redfearn wrote:
>>> +		pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
>>> +			node->full_name, legacy_name);
>>
>> I don't like this warning message.
>>
>> The vast majority of people that see it will not be able to change their
>> firmware.  So it will be forever cluttering up their boot logs.
>
> Until they switch to use APPENDED_DTB. :-)
>

I am philosophically opposed to making the DTB an internal kernel 
implementation detail.

For OCTEON boards, it is an ABI between the boot firmware and the 
kernel, and is impractical to change.

One could argue that many years ago, when the decision was made (by me), 
that we should have opted to carry in the kernel source code tree the 
DTS files for all OCTEON boards ever made, but we did not do that.  Due 
to the non-reversibility of time, the decision is hard to reverse.

In the case of this MMC driver, the only real difference is that two 
properties have legacy names that later had differing "official" names. 
  The overhead of carrying the legacy bindings is very low.

David.
