Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 18:41:19 +0200 (CEST)
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:37184
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995096AbdHDQlMXxi0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Aug 2017 18:41:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vPT9WFX0tDkxlazMB+MVOreYqtloXBBkD+tyRaA9sc8=;
 b=M36Yuqym0BEdlERnqtArAQ2GPst2zvgyrWdmxGjZbeFJ6b7LqQGFvqKQTVOAJopApvcNmBtqWX6FDnSnCMaFLDy4BBTJfrgGuAzltdYG/hVYtirF01Le/Jl32pz5hp/lzPvMwxNXFsHF0rOfmc0scSKI/ily6aygEI+V32yEoMU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1304.22; Fri, 4 Aug 2017 16:41:04 +0000
Subject: Re: [PATCH] mips: octeon: unselect NR_CPUS_DEFAULT_16
To:     James Hogan <james.hogan@imgtec.com>,
        Yang Shi <yang.shi@windriver.com>
Cc:     "david.daney@cavium.com" <david.daney@cavium.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <1455926968-12779-1-git-send-email-yang.shi@windriver.com>
 <20170804132718.GY31455@jhogan-linux.le.imgtec.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <dde7b389-73c6-b218-914c-0b4d76b34a75@caviumnetworks.com>
Date:   Fri, 4 Aug 2017 09:41:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170804132718.GY31455@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0021.namprd07.prod.outlook.com (10.166.107.16) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd5e479-89a9-49a5-522b-08d4db579931
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:ZjbYEL0W+Y2d1aiP4fn3pu67491EauWOKws8uDafnnxGk6O8c7WF30y+bJGDiQH/Ci+enLUz4ntRiXEiapYCIvB879AQCGoCN5enAtp4eRVtOLJUKO9cqq+Ct6a5ux9+7kys5Bu/Kht9XTTY5gJQnBwRe7AjzsXfToPD2BqP8Knwp7/6QzWEaglWXqvFM+hrK6POn4pxpuUayNO/3CD+HcLiZrYIqq2uvRDvnj0/GYIocXhO/V0jXcAk44PmrAJJ;25:eE4sTkeLkZpax7v+hwyuA53B+4h6dN3hQbZzZTKTjpILK9dtgLsBIdxEbGmYkD8aDJaMG0xLzOaLrJ3ZRKgbCjErxbg1WXodEwjnrsYpMpj/9wOKQWQooque39il0C7aeuG86ROJ9HfucEb2GY2PnCWclzvu2PJOU+U7pivzkpLCRMaSUAA86uVFkf3FJ7I8TeB1etD6lekpcp/79ZP9fp1zMSW9QHHumAH7PZnCB8bQIG5e2ROl8O4kPd0kzwCFqKRRcYe7e1VE9zvk7lJ0NHJopjM1npC8O1URaIdGhaqQ0WxhA1HCpxVN4Na9z1v//VvXD+Dhnb3l3M4rmi9csg==;31:IFth4d3aBxnZZ/YJvJ0n66l84zCybyOoXNv6EHM+o6szNOFuTrsBiYNCtDZy8564Ch56kjCPs7EMge3lIjOu2P+XiOpps+arGuTcfmgFa8Cs5vU+UU5FTlcHo5t0QDQwqfNfGSoDiV//c4wB5xqxuBaHvej0MOTeyT+Og5l27fhRSGliCzVmKR9FjehIz6uc8vzFhEwoHbIJQcZUoYO1fpeu2ohnlTm41KZ3C60NaHo=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:1RiNdWSQAYUTwN0WlOVrrhzBgZEfEDIz/dlT0aTx5roj21/k30+ZK+wnp0iCUhwjWNRanbH8ccGWbnQkSiITYYuOJZIL5Xz1/GhPq33GUdSm5MM5DXftVr9+zSEodnBrjpDGehk47vnBX7JGOQVkmhUmSt5KZmPrfRMTfHCZbPBR3PWUB1lJRMC6MPh79VisdavA1ul/AvpEfky3NHSzSU5ZDR50F18xwHqcr3tv8VZ1yvIgTZ8jf8Nwep9UmIHq9hztoR6JS/v/r/b9coSroD+m4WA6bCrg0pf4r87HxKsB9OMObOv7+Y43x9r0v5vchG6aDnk2b9v8RXzwMCdsGdWp6h6Y3FhRjiIWO8pMLIum9vYHOncE3qOSb1ar4CBj4gsjpAX+NhRetEwPTjBGwuwbB+KA95luZjbkbMCBAjitNIBHw4b3XlqhKiIS8Qs0nInbHzJl+Y6+jkuU45vJLExxkS0xp9h2aZagZp/CDS5O6FAdqwp4Y26LetR5cBuXOtI/sYMmp0pwuAwY7Tqt+IMtuKLziUm1WI82pz7E3HkTa8QrETk8YSdrbh0Hpw8/VTZJ665Cc3miGx3qIuvc37540FejpemqQuwL4uBFBqE=;4:JyrUPxzxrVUm76zZUEFslYT1jbx7BR02zzROOpUUDj7qSIhA9+YT0WgJOgJkaY5BsB5UM2uwkU4C4NAPMsftIv2UrZ4auwC/uFxgrGjyHapBDOXARFcgugTiBsniUs8aXSP8SJdvf616iGok6dmemb7j6OiYLzg9GKXT02DspAJU1OGxURqliNQsHWyHawEpBbpG9iaYNZGCryZf7gX44K9h4Z3/BM0qGVAocpBIpcQZojHBMaI6SMccQwUxMwr1
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB35049E16B81B4E6960AFF9FA97B60@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(100000703101)(100105400095)(6041248)(20161123562025)(20161123555025)(20161123558100)(20161123560025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(39400400002)(39410400002)(39840400002)(39850400002)(39450400003)(199003)(189002)(377454003)(24454002)(50986999)(6246003)(54356999)(54906002)(5660300001)(25786009)(23676002)(33646002)(6512007)(478600001)(50466002)(53416004)(64126003)(69596002)(4001350100001)(3846002)(101416001)(76176999)(65826007)(83506001)(7736002)(53546010)(42186005)(8676002)(81166006)(31686004)(81156014)(4326008)(305945005)(97736004)(31696002)(42882006)(6486002)(6116002)(2950100002)(6506006)(68736007)(2906002)(65956001)(65806001)(66066001)(230700001)(47776003)(189998001)(6666003)(53936002)(105586002)(72206003)(36756003)(7350300001)(106356001)(229853002)(38730400002)(15760500002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTA0OzIzOk1ybVAra1NVcWJQR1ZpSmhsei9adW13Tlgy?=
 =?utf-8?B?MHZhejN6bDU3b1I4R3NHTWFIZ05YYnZGdEd0SDluU2h0VVNtYUFERDNWMStR?=
 =?utf-8?B?RXZWNG91UHV2OG1HeENLV2xzMHV5aVlPaVBiNUUzL2svL21iWXVGZThza1Vp?=
 =?utf-8?B?REpwNzRoVm9JL1hSWk5ldFhBUHlOSjJnQlEwOFNjNEZHd3BDQkFOSXZSYnNh?=
 =?utf-8?B?RERxRDZrTU5kM2VLUER5azA0azFGdDZ4TUJtSlpDV2xWRVh6TisxZ3dmbXBJ?=
 =?utf-8?B?a2t0NUEzWkNSM2FwOWNvUlJreFZDTFB1Znc5ZjhRRGhZT1FVeDE0OHVFMHRN?=
 =?utf-8?B?T3p5RWF6czE5VE5LdWNmV0FVbmhSSjgvSzlRT1F0OHF6YTY1WlhrV3lRMHQ2?=
 =?utf-8?B?UDZKUkxkWHdXRU1jWFlOQXoxc2ppTVlGalBCSSszbmtsajlEL0xzMFR0VXV0?=
 =?utf-8?B?Q2NUVE9uSG11MVdER1doSmhyQlJhT3lIa25mSjVYNThmcHdMeGpzczI0MzFX?=
 =?utf-8?B?eStLa2d2Y3pzM3NsU0RBaEVXaTZSQmJReFZXMEcrRG5xaW5ydU5ZYzlXU3VO?=
 =?utf-8?B?bGgwakRTaDN6UUtqUnNzS1cwUEh0dDNpMHdDNHVlMzEzMHU3ZWs5V0RuUjFC?=
 =?utf-8?B?em5YSFZKcHd4YllMeVJzd2U5U1F1RVRiYUc2RVR4NG0waGUxZGU0c01OV0Iz?=
 =?utf-8?B?K3ZXODZNMGE0Y3lJdG9PcWQrc2hHTUFHOUpLaGlaeWtzUjBhSkxkSVNQMjJj?=
 =?utf-8?B?dUhZYS9kRXhMMHcrdmZvcHpseUtRUTZoTHdZNnJweDZsMTl6UVFTOE44OUZN?=
 =?utf-8?B?RWN6UiswTnpkeThtY0o5dzczOFhsUG1QVDJuNDROZXROUnpwN1ZZN3VJa3B2?=
 =?utf-8?B?eERacWlva240VlZQUEZQNjg0Y2xMdUFKYmYwTjJMekJCZVlXNm0vT3ZGTTJY?=
 =?utf-8?B?UHFIRXhGSWVyd21EdkhBcEdRNHpVZ1F1MXBIcXBRQlh0QVhWTDNTZnJraDVX?=
 =?utf-8?B?SVV1ZzRwcG5xV00wdWpBVDZkQnBsWGdjYTBvaWVxOEFLUXNuYU5icmRRSEdQ?=
 =?utf-8?B?Y2d1UEY3ZE9VNFcvcTBidmZSNHZNeHBhMitLVGNPQ3U1RVRZSks5VDZpZEYy?=
 =?utf-8?B?eDVFZ00vcThSUkRQcTU3OERyd295UkFMKzY1Qk5kY3crMnV2c1BreW9BU2xk?=
 =?utf-8?B?Z1FoRHpWNm5ZUnVzcFM4YmNScFJBRTRaNHM5QVNQYnlhZUZhektPanF1TkRi?=
 =?utf-8?B?b1ZMcmJuYnB1dnRmSEZhTVp6V1VYM3VDVm1BUWpWbUlRMWp5NG5KNXozcldm?=
 =?utf-8?B?dkh1ZElCbzRwMzd4MWVwKzdRNjVpMjVUNjFSZUQ3ZkFnbXVHTTByQUN5aFpF?=
 =?utf-8?B?SnJCZ2hVVUlZU1k5alVaZHgyT0R3Tmd1WkFVbGorMDg2VXBvTisxbXBCbzg3?=
 =?utf-8?B?bjdtK1hkaWR0aG5oT1hUK1VVU0FidTNIek9lTzFEY3ozeDZWSE9PMzlnM09S?=
 =?utf-8?B?S2VkbTZXMjNnamVNU3JXTi82UUtBeFZUTEdFV3ZwdEQ1MVZKNXVLVm9WZ3Ur?=
 =?utf-8?B?L2VWaC9CalBtcXplVG1DL043bStWUW1UUDF1L1loOXZrMnFhUHdnQ09WZFpN?=
 =?utf-8?B?aWNlODZ5QTNJalNPcXJyalRja0dydndqcHY5Ni9mOGpHaStEcmE4MDJqdzZL?=
 =?utf-8?B?UVRHZWdxUG1INGsxa1dqZ3FJVEd5UkdpM1QyYmJIS2txSzcreGFYZTUvclpG?=
 =?utf-8?B?SUJVSkZ0TmpLYXIvZFBUY0xaSXg1TUhxanNnOCtuZTVQTnpZN2JlYlcwRWE2?=
 =?utf-8?B?ei9ibXBvTDlWL0JSZk1ZYWZEZWg3T2t6UXU1aXFGVGs1ZENEMWRuWDNnY2Qw?=
 =?utf-8?B?OTMwSE45UHMvYWlPQjhCMTFNMGZNaDFSRWFIQXNtVm1RT2VJRWU2ZEFvOG95?=
 =?utf-8?B?TnVzcFIzQWhUcGVEaXdqWC9MNDFoWGNOcnFhK1diWXJPRHprRUFDYVc0c1pX?=
 =?utf-8?B?bzZjRkhCQlZDTVhoc1d1ZlpiNlEzS1k4YkhYMmhCZ3I4YU9Sbm5qT1kvYk43?=
 =?utf-8?B?eE5zOUtjYysyeUhwMzNSMndGdm5BK2Rxb3F1S3FaVytiRFBYWVhmK2gyU2FW?=
 =?utf-8?Q?vit1C7UOoI2A8OroIR2t0VhiXW5wJdoa2CUCEKG+llg8?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:ZjMhoZSGsyqI10asyy5hxFeINnUSqn1nEp/9pk0BllqgXWnun0jGUkIlZh2mgjq+DGc9eI54YciRAKDGn/GQsMHCzPWkVsccUi229a13qVHZjuwyXGKJBIi4Rpvf1erapwDUemngBHN/oTALS2E8JhU8pAsQrgsotjk6Ms13Ki5RQyVtbMN7qMC59c12U6K9aLlfWcP/fhF3nglZsQ5FJxzx5DyRSo9Oito5ykRSUozfSoWJYM5COMBA6mcIFPPMX5KJ+jatAMwN8o/pO7TC6512MieOEtfLBkuhnArz13NPEI1ZWuptPGCRiW48ojQXgCFtm2bfit0iKJ6Bm+ootA==;5:Btr4LRw4dqTs0h5FdwHJlEvC7zTdaYndkEJaT+Ltsx5G1E3sDKoihV2IsMPXu9TPmHpqEVcCpn5EgQCNQqt9JUtJksQMjzGDDwk3yWods6sY/Jg8Oix2imx3cGeIgxp8CDRYtpyTdR/jzwG2rIfoGg==;24:NByz4ZV2qP60jwZkbulxBfrmU7Jcy9ZNN3aXVjcENMNC9DHoBNCPsHjdi8NahQokEGqQcNPb5+A5PN70kcVZNsSIxUagGc+HlMY8OM1a8Pw=;7:I9UdrXY7+X4bh+/bN7mBE60WqzqunPlTPB8l/JDPIJH1oKW3aR1fBjvX86epbaB5TxF7v5z/ZgNy2+3e2tCC783aLMNn2CjG/klitCfg0bO2SzVIQsuIkq+yKTRgCoMrx6g7UDunOe2lp7a4uym10sMwjDHVxo0ZKyjkLlm0Ht01tyAQGuWc8TBdb6sAWTMisZxQo5axPoMhSz1Bjw/Ka55ZbhbFhYc24hXs6KRfLvU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2017 16:41:04.0179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59371
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

On 08/04/2017 06:27 AM, James Hogan wrote:
> On Sat, Feb 20, 2016 at 12:09:28AM +0000, Yang Shi wrote:
>> In the octeon defconfig, NR_CPUS is 32. And, some model of OCTEON II do have
>>> 16 cores. Given the typical memory size equipped by Octeon boards, it sounds
>> like not a big deal to set a bigger NR_CPUS value as default.
>>
>> Signed-off-by: Yang Shi <yang.shi@windriver.com>
>> ---
>>   arch/mips/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index ab433d3..a885156 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -885,7 +885,6 @@ config CAVIUM_OCTEON_SOC
>>          select USE_OF
>>          select ARCH_SPARSEMEM_ENABLE
>>          select SYS_SUPPORTS_SMP
>> -       select NR_CPUS_DEFAULT_16
> 
> So should this select NR_CPUS_DEFAULT_32 instead?


There are OCTEON systems today with 96 CPUs, so something 96 or greater 
would let us avoid changing this more than once.

David Daney


> 
> Cheers
> James
> 
>>          select BUILTIN_DTB
>>          select MTD_COMPLEX_MAPPINGS
>>          help
>> --
>> 2.0.2
>>
>>
