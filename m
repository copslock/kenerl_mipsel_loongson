Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 01:33:18 +0100 (CET)
Received: from mail-bn3nam01on0082.outbound.protection.outlook.com ([104.47.33.82]:15890
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993115AbcLNAdIDcjkV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Dec 2016 01:33:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MNjCbu503nswSsRpJ1wGkBaFnVQAJlKSeyVe8jmBTSc=;
 b=VT4D9kXgGJVwif2Ws8Z8a/7le+DDrpuodCLjFZDneDc64BweC0Dp34C1GJQCojSohkDr4bxCYDSC0aT4clT+IgOzXe2mpEpipQjbF25w4H9aQg5hULIunEQD9V+a0zGF/IqiSr5Wxb0df2Vr9KLXSfDtMDiTUi0sBF1l0GO13gE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2143.namprd07.prod.outlook.com (10.164.47.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.771.8; Wed, 14 Dec 2016 00:33:00 +0000
Subject: Re: [PATCH v3] MIPS: OCTEON: Enable KASLR
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>
References: <086dba14-cbbf-5fb8-ae39-bfb2f725d91a@cavium.com>
CC:     <ralf@linux-mips.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <26895953-3108-260e-498a-c6dc7f4ccd43@caviumnetworks.com>
Date:   Tue, 13 Dec 2016 16:32:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <086dba14-cbbf-5fb8-ae39-bfb2f725d91a@cavium.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA0053.namprd07.prod.outlook.com (10.255.223.166) To
 SN1PR07MB2143.namprd07.prod.outlook.com (10.164.47.13)
X-MS-Office365-Filtering-Correlation-Id: 3375a6db-eba3-4aef-66a7-08d423b8c232
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN1PR07MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;3:Rt5wwbuwGVcG84vvzr6OL1IztGOw3LDOH2RuOB673CUF70HXkLhAas8dRj9BsfjkzCOt4xHXMz9y253NUkOxf699YJkXdVgcZFQfPFErsBqo9L7fVWb8BWx9t7LlgwjmC+dj02KLib3qUc7EVwEpwrPpZqgCS+NfBGrtnd8/Yj3QIvhEdSaQhn6xWcX1sMw+DsS6k7HlCaXAnQ9AhlkjpgYf3hF+CshrqHOp6DjmWxlWcWumY9kXv4VE9bvcFqXgpE8rtv1izxXxGWUJXsU+zg==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;25:3yPQQ+wtz4moPcb0YEw4fB52tqyteKN+JVsh9WyvwWtAm13+SDSv6/DqX+WrKv2I6mneZi2Nn6lpu3sHflLfdVg7yilhU3G0vd1NHI+shQLG/bcDeYNfG2GH9nyNCXElvJUEzioz5pxMOW40tmljzmFlKsEQLzkVLAlyS74/LamuxjbD4sGbVnPRXEMo0hpQ/Bkg4iskcwbnz16dOVnakvg/lrUFEqQRKPFAyKF6Ki2iuaM4Za3DhIcpKc2aT19pjY/IhX8KcXdOgBpr7I3HqlZxiz1yda6alHPnWpwVUEKRhEa0WfpSNGPtgw9CnDRwqQDUBC6hvHAtdwZfBteNcP8JPJ3A+1ZGDZllQES8w5lo7n0TT3TrylP/+WZ7pbCB/PWG0PvRrF5SvMgk4wFbrVAoGnAa+vTyoTfBP3qPMA6H+MyzYQiDaEuvJNxLzO/IPw4GO72BXbRQfxMl2IAsq5fmc572zYxdAVvKHaetZpvMAEtTt/tcVUg6dAxzJf1GrGsBX9l8mX22SiJ09WDk7rCpgBOuqWPFf3nLqpBvkuYuAVsInBImIhose+7yTnSQDfkvfh0c2v5iFI08Y3mXBgd9kgByRmKzoZr96QdgQdIuR4D4ocW1udnL1ieOFkQ6kWkb2DEZCF5YMIe7cs/EU5DyV7vUkyXinyEXqbe8dJc33jtTdIhyp6+gcXOpe22Ke8iaiZnQ0+pMRXnwDAOWUqW1fQD39jCk6rP+X6kGuJWB0GAZ0AaQTusz1uLzJ9+OET5hWAjTcGtDH7tcBmqsKg==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;31:Jx80vDs796/4XDm1niHQni3A6eJa14XYYjqtzPLV4cU6FQGrpqETZmmf9yi9zygs7IhKGBkMN8kjipLY34HLHsx0+c1yso7senpHzRCxfIUwk6qVzopWVTjROsdi8mJ6ZVRt5B+hCLtFaSfCr39ZmVz8WqtzskeRzw+VAzI/pN7QLNbIMot+DstflK2UrS6jTy4CR14tXSKJsaP3LNgs7RoYMqNJ75bFM7FjQoguwDT/3tnjVVQCJE5evRITG5Nr7ctlgou7okIrfCZ8IBOtnA==;20:UbuvnafshFNLH4kXNVuz2rnrKzQ/bSFbbaLqYvoMk0r4NPM6kXpFUhxI1B97Tsnr/eKPobWwJTBdpmWgVcZmd9FWDkOhFh2XMSdoSjzqLPil21B9NeM/lTKbIJIKGCtcJTookUm0wxrG2yiONzVUAgvwNe5/1mqOm5/HP/8M9I9KowWeuhLU1m+vOCTiOtv3t1gD24EG8ZWSRB8mpumTR0GNt53GXRoMVc1pOJr4vBl93eL0awe3kcAWukI3WFFlCB+dmYYBhCZbZx94cHjceTbVqNQS+M7amxORD8x/dWN/wT9FZi9uYrMoWMX0J/oB4zEn3ilEmlY6vHbVisPXyRm8SKPV1gplcXTYz8/jrqRd+bl2d4eMBXEs3VkrN2ZWP0WsHo8HzkbLyQCOl3qs9QiypeBLyPehfm76c3jIx6Ue5vlQmsN5u9gyI06ui9xmdzm9ipxjvf7WjjcCi0LjYispOR5aW7rJboi6ZJesUNkcSu9orBWHXJnfuQ2CaAP8QwGJ2IGKonNCxSp0owSGHq6cuJwCutJ2TdtQ6+pqk2LjD2ldv74/omyzyszfmp+ED7eLkX2trU8RaSD0q3cD7TvJGG53kUaA7+Rx+3E6X4w=
X-Microsoft-Antispam-PRVS: <SN1PR07MB21433B4CE38CD16821B89108979A0@SN1PR07MB2143.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123564025)(20161123555025)(20161123562025)(20161123560025)(6072148);SRVR:SN1PR07MB2143;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;4:02UiGSVMrkqSY7Bc6SMMH/Cxbtq6C7zgJZ44kKUCf6WZgtSYveGmeHQl5sQ6dskoL8gfajqk2P6g2Unz3R673BKclAx7vid/oDYlfCpsBCFiAV+L8pPSlfNeRaJ37Y9kZas63H8898TBKBFZb32BMgoWrBhsIJZF6pFNJMENlALwxi5Lqk7UaL/J2oQShtrSHtHj1cjQHBZNnnbyRSlU3VppdDVZK/b7T+VLlU024UJf+qCAFvPm8pDveqUL0absNlyvyQJSg8HQ6D41Or9U4w2ohhw5tO1uQAK2jfuxcU/Ymj+0TxmPpVjFm/txORY0yGP7xPrJd07JnCJwKs3W0+xqGCfaS4cdKjERvVr3NYVev5Q29dG/m14+D72UqnjisTb/U69PeifppacVDYrahEd2cbmXEsfl+JOPbjGdsWXp3wcbSSjnW3CID9j3G66xRadzZGYig0pBOKIZclSPYdmtF1OvrwJFTwP5OeDJfglKgDEQcNrsEKU2eY0vlIZj0jt5Wykd6jU9rvN3v+rFmic/Mf8mbzOfJWyMBPAHLGSHpecEPhjba9nqXlC7ZR8D
X-Forefront-PRVS: 01565FED4C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(39840400002)(39410400002)(24454002)(377454003)(189002)(199003)(53416004)(230700001)(105586002)(229853002)(42186005)(31686004)(54356999)(76176999)(6486002)(50986999)(5001770100001)(38730400001)(450100001)(97736004)(106356001)(42882006)(6666003)(2950100002)(4001350100001)(7736002)(4326007)(3846002)(23676002)(68736007)(101416001)(81166006)(81156014)(6116002)(64126003)(8676002)(305945005)(33646002)(50466002)(69596002)(2906002)(189998001)(36756003)(65806001)(66066001)(65956001)(65826007)(31696002)(92566002)(47776003)(5660300001)(6512006)(83506001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2143;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMTQzOzIzOlptMnZobXNDaGFsRGJJeWYwQ0hqL1ZDWHo4?=
 =?utf-8?B?WFlTb1Z1S0pmZVJyZTJZQ2tia0w0Y1k0OG05ZHluVm84UTNvTkNlWEVCTnhP?=
 =?utf-8?B?OXJnTW0xMWV2RVVWc1RWNWRudHpSVEY3UjhDbVJOelc5Q3dvZXhZRldnZFZM?=
 =?utf-8?B?MjNzZGpDWnNwSnd4c1pOcmNhNmQ4TlhFWi91VzFnc09WSytpdk0wRzJDZ2xn?=
 =?utf-8?B?SWJ4Qml5dnh0aWNJa2x4Unp1TU81RkVGS1orRVh4THgzUTFjbXNocVVwL1Zn?=
 =?utf-8?B?UEgzZkxNcm01YUZMRVp0Yld2dlc4ZEtRZTJrMy9Hd1dFd2MwTXFqSGtlKzVz?=
 =?utf-8?B?eTJEYytPTkJlSkZ5UTVtUDFvSzVBREZLY2dac2RURkllaVM4cWtiWmNQdGE3?=
 =?utf-8?B?dmpudkRlK1JTUnBCUHFFcUlSV0ZUc3Y0WUd3UFZPWHN1bGJOQ0gya0ZnNUty?=
 =?utf-8?B?RjFMTkU2UWRkblBacThOWEV4Nkc2M3drVFhEQ29HOSsvMGd2YkVPS0E2eGxx?=
 =?utf-8?B?WUNBN3dQMnV1cS9JZGYzYjZLWjBVQjM2R2tUTWloKzR4YjJJZXBJMVgzUy84?=
 =?utf-8?B?bFlDN2VuNGtVM1FMKzU5czhFUG1ibHpGOWFmVG9zMU5XaVJQS1oyT2p6NzZU?=
 =?utf-8?B?QzNjUGYwTmxJQlBCc1V6TUdBZHkwNzV1bU5YY0RCVGNGcEV3d0x6bXpxa2tp?=
 =?utf-8?B?cG85MkZZUkhtL0JYb21yaVFyeTVUcVZWT0dmamRlUkp4L0ZSY3M3d1JLdWUw?=
 =?utf-8?B?blBYTnpvSGRlNlBKajFPanJLYWlMOE13elhBYnpJSDNmMjdhbHVOQjVySWRn?=
 =?utf-8?B?MElIRnVCaU9WRnlDcFhUV1RWTWdFSW5WS1V0N2VMWUNrV3hoZDVjV3RPTlJ4?=
 =?utf-8?B?M3NpTEIxZnh3dSsremJXbzhQL0FnaldPK1I0c0FBRDM5K1VXR2YxamhBN3RY?=
 =?utf-8?B?ZEQ2YkVaQ0pSSHByOHRSbDVTcEtpbVUwOUJadkYzQ2kzYksrOUhXckVuYTJZ?=
 =?utf-8?B?ekh5dkRjTTliblpmK1d0VjNPNnA4MTNuLzNTdFd4cDFjRE04dWlJWjNGZVZK?=
 =?utf-8?B?WmdiZDdOYkc0cmkwWms3S3dMbWdvL3BRSVB6K0xhRXF0SXpmbUFhbTFLZ2M0?=
 =?utf-8?B?bGcwamh1eUtxUTRUVGtFbnlqVGpleEhneU9yM3I3TlIxckVjSi8rZDRURFJi?=
 =?utf-8?B?QmZZckpYeTZUcjFPbEluWXJiWnlKY2N3d253Y05adDBhZWg1cytvVHBqTm5L?=
 =?utf-8?B?RzFOZHoyYTFUVlp1Nml5YkRIUW1tT2xrb3FaQkNtcXpKYlhHb2VMYXhKUWdq?=
 =?utf-8?B?a2NjUUpzRW1WS29sUXF3aDdvdmFNU0ZrMkROWEc2T1oyR1AyOFBEQXA4NmpI?=
 =?utf-8?B?SUpSOXJCRE0xeGtSaFQ4b25LWUo3Um1na2cydzlqMzRNUFI2Y0NkRVdwTFlh?=
 =?utf-8?B?YkdSSC9FbnhGellxNDJaaXovK3k4MW5ZVjArMUlEMkVpd25MTE9rNTc3MUFS?=
 =?utf-8?B?UTJYbDdlZlNrcVNrVFhnN1hBekVSU1pZMVBnaWJjRDl2WXEwTlByOXVnRGVU?=
 =?utf-8?B?RGJxZytOZkcwM3BwSm83czJVZjY3ckZzRzdmYTY2ZnZneURkcEdMWHRwbVRh?=
 =?utf-8?B?eTVsRlVjRzVkZWtsRzN5dHVVTXdScXNDS2tPSnVSMDFVbGQ2MjcxSXVOOHNa?=
 =?utf-8?B?ZHVqdVg3dHhrZzZ0MklvZEtoRFJXSFh0YWs2TVU2VE9yS1hNTzMzM1VGbFVS?=
 =?utf-8?B?SnVUTWpwUjZySFlFK2cyaUVMWlRXTmlNOFh6bkF4Z1VSRWFkUkh2MnFhM2xV?=
 =?utf-8?B?V2cxNmFxc25FbjdaNkE1bllLT2w2L1ZlRkZ2cWpLaFFQVkk2WDM0RzVjYnVD?=
 =?utf-8?Q?Gw1WyqFDaBc/l02blUI2CgZTf1rEYW5A?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;6:Rvf9FW6WkLXFE3VUTy/0aKV4+cVRYbbT0DJQdT2vugUagS1ohWYN1OxG5mSTgxZDS4q11Xko2hvXEA31BDmui+296IXVQlcF1/dJS7XqjHMQnOunmn/QDp757jowjR0ifhTOk3+4xA60z6k4uyLhRtLRIAhHOwjs2KwLC4/KVbAFRFuKixXHPGQl8ef5DJpqhUgML+S+RiHp3Rd5FDYmC5oQawOlMNJGe4bmp7B2BR76bJsIgW5pLOZ6OPfaKtTvw2DXzliY+pFf8R313jjTPehMEGE8GaF79wX/FSxWCcrtrwEVinBIw5O53NhDbCnsQjeyipq9IvT3bEEVou9BT0Xszhr8I8mB4qQBdML4zAkKPt0TEC/RidXCDwzFAYyh5CRQ45VvxX5umIPGn9e9EizQPt6j9x3qF083W7nx+YA=;5:XGi+1J/9Q37YsepiAo4f3E5jdv7FBGZOZ1kD4ZlyqAgjGJQMEtSPt+Woc3/RAVTUP6C6v5EKVSm1sjhMbMhGPL9fARML0whFq+d8htB8ZxMllxHBUjludQN+mX2kv7YDHQcdwJJ4eVVdKPp377fzFQ==;24:69wn5H0/sKJSYXhTHWez8GJRotrz30CKobC0h56MdsLLKEYX9BRuc+b2x3FFp5XcgrAFGtvKPKR4W5nf9/qntEXwwDS9Qj1dufay5nFuF2Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;7:NEHY+uAoLv4jJIViZDUkjxEhiTyr9E+yiDJoQuWcoNbkt0JB8+xlbQRY+H5MEs0BWGAIJygPYwSOPQg7sFG3X9m7/ISALVaw51szmsqyp/un3hd/bOYou+zPboqyPnyo0A8FGT/5v34dQ46gangwDw+aT/AWwVORX+F6JpxuCRi0xl+zfBJanLTuIf2GnvDsfVlPDgsuAB/BcTOiT7DhhlAidTiYfqM/JiK9wrxS/nPd5cWiLq1SUEwoFllHHwXO4O2QT2Hx8bF5DZCtGF2y88rb7+pGG4TcdHzc/XIJqaF0XqMK05tG8bgobARhyIo0PIP/AOP2rvo2JyYPx/lDrqdvYSTRs8pVwLGPFITSuYhDEXhB8FKKvJo9UFHNs0Wv3qKaLtJ4431wUF6R5PnZ6DwLjJuSsTbNZDLp/Of4mFnMf3+7p8ZVDe1hjyaJYdzTAwLWpyO0qodFrS9uuYvcqg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2016 00:33:00.0166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2143
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56044
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

On 12/13/2016 12:25 PM, Steven J. Hill wrote:
> This patch enables KASLR for OCTEON systems. The SMP startup code is
> such that the secondaries monitor the volatile variable
> 'octeon_processor_relocated_kernel_entry' for any non-zero value.
> The 'plat_post_relocation hook' is used to set that value to the
> kernel entry point of the relocated kernel. The secondary CPUs will
> then jusmp to the new kernel, perform their initialization again
> and begin waiting for the boot CPU to start them via the relocated
> loop 'octeon_spin_wait_boot'. Inspired by Steven's code from Cavium.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>

This looks better,
Acked-by: David Daney <david.daney@cavium.com>



> ---
> Changes in v3:
>   - Remove unneeded instructions and correct spelling.
>
> Changes in v2:
>   - Add missing code to set 'octeon_processor_relocated_kernel_entry'
>     which was forgotten. Mental note, don't submit patches at 3a.m.
> ---
>  arch/mips/Kconfig                                    |  3 ++-
>  arch/mips/cavium-octeon/smp.c                        | 20 ++++++++++++++++++--
>  .../asm/mach-cavium-octeon/kernel-entry-init.h       | 15 +++++++++++++--
>  3 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde..65d7e20 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -909,6 +909,7 @@ config CAVIUM_OCTEON_SOC
>  	select NR_CPUS_DEFAULT_16
>  	select BUILTIN_DTB
>  	select MTD_COMPLEX_MAPPINGS
> +	select SYS_SUPPORTS_RELOCATABLE
>  	help
>  	  This option supports all of the Octeon reference boards from Cavium
>  	  Networks. It builds a kernel that dynamically determines the Octeon
> @@ -2570,7 +2571,7 @@ config SYS_SUPPORTS_NUMA
>
>  config RELOCATABLE
>  	bool "Relocatable kernel"
> -	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
> +	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
>  	help
>  	  This builds a kernel image that retains relocation information
>  	  so it can be loaded someplace besides the default 1MB.
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 256fe6f..889c3f4 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -24,12 +24,17 @@
>  volatile unsigned long octeon_processor_boot = 0xff;
>  volatile unsigned long octeon_processor_sp;
>  volatile unsigned long octeon_processor_gp;
> +#ifdef CONFIG_RELOCATABLE
> +volatile unsigned long octeon_processor_relocated_kernel_entry;
> +#endif /* CONFIG_RELOCATABLE */
>
>  #ifdef CONFIG_HOTPLUG_CPU
>  uint64_t octeon_bootloader_entry_addr;
>  EXPORT_SYMBOL(octeon_bootloader_entry_addr);
>  #endif
>
> +extern void kernel_entry(unsigned long arg1, ...);
> +
>  static void octeon_icache_flush(void)
>  {
>  	asm volatile ("synci 0($0)\n");
> @@ -180,6 +185,19 @@ static void __init octeon_smp_setup(void)
>  	octeon_smp_hotplug_setup();
>  }
>
> +
> +#ifdef CONFIG_RELOCATABLE
> +int plat_post_relocation(long offset)
> +{
> +	unsigned long entry = (unsigned long)kernel_entry;
> +
> +	/* Send secondaries into relocated kernel */
> +	octeon_processor_relocated_kernel_entry = entry + offset;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_RELOCATABLE */
> +
>  /**
>   * Firmware CPU startup hook
>   *
> @@ -333,8 +351,6 @@ void play_dead(void)
>  		;
>  }
>
> -extern void kernel_entry(unsigned long arg1, ...);
> -
>  static void start_after_reset(void)
>  {
>  	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index c4873e8..c38b38c 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -99,9 +99,20 @@
>  	# to begin
>  	#
>
> -	# This is the variable where the next core to boot os stored
> -	PTR_LA	t0, octeon_processor_boot
>  octeon_spin_wait_boot:
> +#ifdef CONFIG_RELOCATABLE
> +	PTR_LA	t0, octeon_processor_relocated_kernel_entry
> +	LONG_L	t0, (t0)
> +	beq	zero, t0, 1f
> +	nop
> +
> +	jr	t0
> +	nop
> +1:
> +#endif /* CONFIG_RELOCATABLE */
> +
> +	# This is the variable where the next core to boot is stored
> +	PTR_LA	t0, octeon_processor_boot
>  	# Get the core id of the next to be booted
>  	LONG_L	t1, (t0)
>  	# Keep looping if it isn't me
>
