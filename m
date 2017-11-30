Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 00:09:53 +0100 (CET)
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:23572
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990412AbdK3XJqP92-3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Dec 2017 00:09:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Nj0SxAqsR+QviUaQP6CJoht/wA+n9CqDkbZWGevIbkY=;
 b=X3uq5vwSFWj2LuPdHAvDwz6MnI7heAg6qJjZ9QwsTRHnKr6DAWw95/2D9A55fx5/MDFnJ1MhFq0kURxHt5cMQjsq9QrTIuQOXCuyzvgXpRqpwsvrf0Thvc7yOwePP+PmOpAWZRGqymuoZLZuCiMusqEqHatL0XEnbEI50jzJwRo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Thu, 30 Nov 2017 23:09:35 +0000
Subject: Re: [PATCH v4 2/8] MIPS: Octeon: Enable LMTDMA/LMTST operations.
To:     James Hogan <james.hogan@mips.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-3-david.daney@cavium.com>
 <20171130213635.GH27409@jhogan-linux.mipstec.com>
 <54c83e6b-35e2-be38-e4f1-87eb420938cb@caviumnetworks.com>
 <20171130225614.GJ27409@jhogan-linux.mipstec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <c90ac3a5-7230-38ff-691a-3d94a25702cd@caviumnetworks.com>
Date:   Thu, 30 Nov 2017 15:09:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171130225614.GJ27409@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY1PR07CA0026.namprd07.prod.outlook.com (10.166.202.36) To
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3636857a-0814-4568-24b0-08d538476c76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:+4kDbObYdLK1BPG9sxaHVAp6qxBjldXaTygSBtks8q+bqt441qYtNOm2zsTefANK1MI1byJYLx51IIxR/TDaZuEyMa7fH7g6dvNVLEvAlEYrYN9VTv4yaLutLCjVfAZQcJlqZGdvPJg+C8nD8yC1vkxum54L+o/nAkn/PRMvtD3Gnj9TP+4o9EiiBYr7xU4F09BAUCRsWOpAcwSHxf+xoI67gsWz6YlKU9aKHT17rxaJjC3pQofGfSBQGZ8hUsd+;25:PswogT/3HVJ8oe7b4EdJy80/J1TSpQyjq0YCDsxy2wpHMwAdKxYK0t/wTj3qjir/JO60Y1rgFOXQDtxRPjNxYYAkgrhkLsXd0ONJHQ/xx2uWnFG2EmxkFyx1/29B6ZRLFkVX0Ov6s4Z6hahfkIdflE2EzoBayc6s8VcpLo2lG2WM89J2A24dAy2Zp+TE4nRLlVv6yjU5ubkzdz5LpFE1fwYn8f2wyMofYX/r0U67HDUtmFshVG7pCwkZo3C5b/KVkHNaTCatiSw9tFjaBK/NUJ3oAFf+Pbkfs6EbYOEacwuyBkZrKvYLazR8S43AI3jP3DzqG0nv2PVWpscZzghjCQ==;31:DJQxBa6A3xf/jnPGRm0dj6LrsvdfR4NP2jBON91a9/jmdkMJrXxcE85UlMCgdC7rwiaoT+EncDKmAEn16NlIpwxJctnOMIX8S1ozOy6TnhPcF+tdWMvCIciHHvb4ZHUkifUW0nLOGNOQeJuFqAwGB3LNqEqPmkciMz73kQjKfF1CXAb1ZWTdwNnSznEjuzrYYeF9+tn1EXJ2LVfB7I1DSF+CmN+4QOvOTW+JAgNvET0=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:LirJ2FuqcjnYXjuAAEmXHgy28CNvBR7CUSJkl53rZW99UjhPfnTSlsJ6VaAPqvP8/aWlPW7gpl6FlXUi6me3gJ9St+MZ5w9glsrqJWAA6g1xA+OoVpXycPcAGmE9bOBbvHL19UP+2DGiT/iWET5ns8SEVkNgVNc3dT/ZOQmOQ0R0Wul1QZM4LhmnQlR4rD/gvTJgTPE+QTbZUGgp/WSSkdQh7hNttc+IpR33jlHMPDFC7wgZdIuZr/6Tny1PoE/vjQLrf6G7BWsGA6scmK0Yo1/+9C0VEGTLjfM4hW6vAtTCWIZ0+KO1T4bqA9pFYYqPmp4iaZOS6a+/KymKSXufFNRKjzfO6Vr5M35A4urKVZ4U498ySYVVTOWT918ELoUgVomfecjw5jN728VlhT4DMcaqhkSN5WK+3cOlNoBAeli0SmKwq6OYDNkJuiiAr6sRxoLLQElLaaZVob+gHgcJlunQS1jbfkylxmUpfUGcaC5pypOxdinLFoMEKsk6137O3OqrXmAedgRWeEv1Rf1/GmAf34yk1kaoNASjvc21PYTomtBvSWTR4e5nw5I9nOxaKxofCGzwHMAg2m7TLi9Zs9my63ALFsA/3OWuw/H7d6M=;4:OPczS0v9CxxUVDOdRcuEIeN+PLcFo3r+G8Y6my6ewh0X4Iti4830+PzJn46GDppquXUsuZoMSIAQ7IAUlaOBS5thadHo2W19um3wRQWgWcLYmaWRJPAUxC/OYrjlB0WCGaQrdk2Crzg4n8MgDhg//2Vpir0Bsyg9ZsDf5PT+yKUjuXse3tOwGHgsMIdCuvSvVX/0qt6y2knjCwsbEisaz8rluNej9ru6GVyhdMoThppkzTPx7Tf2wrgCinq+raD41ksO/+2xjPJs7rlHD172GQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494128987A751F9F81F26ED97380@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3002001)(93006095)(10201501046)(3231022)(6041248)(20161123555025)(20161123564025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(366004)(376002)(346002)(24454002)(199003)(54534003)(189002)(8676002)(105586002)(6486002)(6506006)(7736002)(229853002)(6916009)(575784001)(107886003)(6246003)(189998001)(2950100002)(42882006)(5660300001)(305945005)(68736007)(65826007)(8936002)(7416002)(23676004)(6512007)(53416004)(2486003)(53936002)(53546010)(52146003)(101416001)(33646002)(36756003)(69596002)(47776003)(39060400002)(52116002)(4326008)(93886005)(16526018)(106356001)(230700001)(316002)(25786009)(65806001)(66066001)(65956001)(72206003)(64126003)(97736004)(31696002)(31686004)(81156014)(2906002)(81166006)(67846002)(478600001)(50466002)(6116002)(3846002)(58126008)(83506002)(54356011)(76176011)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk0OzIzOnpqRmE3alU4b2NkdEhTK2MrdG9NN2tFUmQv?=
 =?utf-8?B?QWdRNnNjeUJyZTF2RHpvRGlJbUJPQkdIZWFVOXRLc0JzRWlxVkNLZjZUc29y?=
 =?utf-8?B?bXRjbllqOTBHb3hoNjBZTmRMOHM0MlE3TjZsZm1xM1R2d1FjbzFSQnBaUTZG?=
 =?utf-8?B?YUFCN0xaVzh2d21oRWtyMENIdGlKaStpY0IrRFFsekVtdWZhZzFtWmRwYm1O?=
 =?utf-8?B?MSs2ZWE4ME04c1A0NldURTV1VUFUbVpwRDgxbGFYSjkyVUZWWnhrT3g1MWw4?=
 =?utf-8?B?VjN0L3ptTlI2MmwvNE1aeFZrTDVmT29QNW5jdVVaaGZZN2xyUlVvUE1HZHhV?=
 =?utf-8?B?WU03QXEzZWlFUEFKVzJEQmJYVG5HM1paUHJjbWJLTytrbVJobmZxT09oWHQ3?=
 =?utf-8?B?UHh2THFDWWNLaytadXMyaklwcHlLV3NZZjl5UFRNVHRZeWFPNng1MXRBc0Zz?=
 =?utf-8?B?enpnMjhSNzArclYvbHhzUThIT1Z2K2d0dkJyQmZMQ2xxWkhmWnFLZ0hTdkVh?=
 =?utf-8?B?Q2VYUTJ1ZnQ4dm1lV1hSZ3ZyVXlxUzA4ZGg2UVJsVTN3L0xFeWVvYUJCRjBl?=
 =?utf-8?B?L0I5cXBCYVdMTGNCa09NSUtoQkZHSnNMbzhTVitnTklINmpEZlVrOHNVTlFs?=
 =?utf-8?B?VytVYVdVYkNweWpUejdQd0gxK0ZpZExSR05BUFZ1S0ZuMFc1S1dISGpCWGNH?=
 =?utf-8?B?VEplZmlYNVd5b3NsZ1RzaGdTMnVZTjJOeEFtZ0p0dVpwSFRRRFc0bjR5UHBF?=
 =?utf-8?B?QWRKWXZwUUJKSWtOSnQrb2l2azh5TmJDZXEvVTN0V1gyMWJFaG9CM01wZVBE?=
 =?utf-8?B?NE9UbUNLVzBNY01uNGtQRTZINTdQaGc5ZTZsNG1qZHY4dDV2cGZ5cXU0Y0Ni?=
 =?utf-8?B?aFhzNVZOMkM4Y2gzaG9IdDYyZ05OY0MrRG95cmUrVFMzWnJWMlMvNVZqUHZM?=
 =?utf-8?B?Z0ZFQXVPdFlFcmN1QWlDT1gxMlVrQ2NhWEMycW1ZZW5ENUczUnFnOTdrWDhR?=
 =?utf-8?B?ZW9ReHAwV1JTbFhDZldlM0Nta0RLL2lzT3c4bG5XaTl4OHFkM1hQYmdxSTFD?=
 =?utf-8?B?eFdQaHkyM3RXVUZUc3dLbHJTeEZlTTlpMHd2ZnpiVnpsV3FQTUdaUzVLeDZw?=
 =?utf-8?B?NXNoN2R2K1ArYlU4ZnNucE1tZnZxNXlQSWpZeDlaQWhPVlNrWFV4N0h2Y1lu?=
 =?utf-8?B?eEZnL29pMkhwM0pMRU5KYTUwRkpXZGdQdnc2ZXNhdDRSOGxNZEtNWmlUM3N6?=
 =?utf-8?B?WTZSOGFOYzAyYk5JdkFyd1d3SWx6ZzV1YjE5aDNZV0hBZW83eTViSVpHbDlN?=
 =?utf-8?B?anVaNzVZYzhNY09YQnVKVkhPL0J6RVFmaWI2ZEVNZU9CckFWelBmY3RmWk14?=
 =?utf-8?B?dFpHMHp1N3JjeGFMbmFwYTJuZi9yOXk2cHJZK1ZIY3hkbVFEdVVlc2tOOTh3?=
 =?utf-8?B?aXlRS3I1bzhkeEMxVFJYVkdtSTRrVnNoZWhpd3Z4WFBXTnU1TENWdGdFNWhv?=
 =?utf-8?B?TGY3VXhuSW1hVlY5R2Zsb3BIMFJTa2JrbjErSjZqQUtpS0d1bVdvUSt5bWhL?=
 =?utf-8?B?WE5sQmVUb2x1K0xOWnp3aXRqV0Zkd0R5VmRBbm9WVEEvQjVFOStSdk9GWUVK?=
 =?utf-8?B?UEN4Nmg1Y1IrQlZhcEZycDBhNlc1bWRXZ1oydlpIajd5dTJLeGQwYXpyNWJh?=
 =?utf-8?B?eWswZE5pMFNiMVJaaWlhVDVHdUtselUwTjdlRkplSjRZTnQ4clhBdHNmT21Y?=
 =?utf-8?B?NUNBS1g4dTV4M1ZhcitFWnNnV3hyU2FtWlpyay9IR05hODhpZWIvcHBPNjhL?=
 =?utf-8?B?RFVWdXJPZVFxbE50NnFYTDhMN1JHeWVQL3hPNnFvcWFNSGk1NDhUVmw5NTlE?=
 =?utf-8?B?Mm5mR0dyZjhPVyt0b1RJUEpIMkx4ZnU5TlNTUDF6SG5lNlNSN1c1TytUOGJ4?=
 =?utf-8?B?OXNpZ2NsZHd2RWJ2TmZQL0tnRlIxZzJ1NS9aODNNQmFzcGFNMVFVRFYvZVVr?=
 =?utf-8?B?K0pwUEx6R0VQQjJvajUrRXNFWFRzM1Q4aGlBcDBhM3RTRFlzOWVQOE5KVy9z?=
 =?utf-8?B?Ky9IWkI1NEc0aXRKYkFPS0NtK2dadXkzQzI5ZzA2TjJ3cVpmdU4wRVhzakh2?=
 =?utf-8?Q?TnB5I3sM6yGJKZ4B2tq+Jhw=3D?=
X-Microsoft-Antispam-Message-Info: KgCY1Ql4/fi//UdmQ//X9lKXuSlecZPN2OtnDSGEWJXkgrxzb/ZsSI0ECms0jr+4cpIXbZQUd1hlAesR2BnE7Q==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:II7sJOm4RbHpka8YdFypBiiugixHj7Ixz5IdRV/PmBwT+R+Tp6vllK+oMW8vEv4ec82jmaHRa6u4gawihvCG7y66EK6m2t+NvQsBLRne+npEY0MGWwfjKSZ6l0q9ItG08JCzDc4nSNLcKEPrBJkFVwABBKWKmkDPU3hpCEo9yVfbV62MKR9SvBHzzLlc9SQtdjyeBfxMDOHknmVpQVF6406EmRLS+yYJRiocF4j+rfvRCO3S3aP80YhtPBIubOphYf/6CFs+ME3OGXULZcgkobHSvdcEVkiq7mKvPcTwlQTNs1x5LKGlchP1jPjuX+1hyGH4KgEo4h4d2NQuwzKhsUS4SetwzceAwdw9A1rSuyI=;5:zlOJNKLjSj8q4zyO20owuc1zc4X96Q7XpIr5dPYnHAc/tY/89O1WTdSsIx05RxBsV9q4AtlWC/v/E4GEwGEdI0lva5tN0dDnNr1kd7ZT9aVGjRj3x7d1E7KHQah/GxB76/19NKwhFdLQUCMY8chbjHTQmiBzHbGt5GcgG0XBS5c=;24:1+h+6yqmZeJZiUqIpaLVIAFW4K7ocOShkUXFL+nNCQ89+r0a4KEJLhfjavVKfJ9V3gaYikBCBpy3zoNopD6skgkK/X6L+gJvDkjWY5khCzo=;7:Vt0xwYTV58uJRcOtlZ70urHp+TR7slErV6hDBZndHzddHic0ZoOINsXLWoyt4rooUWyHqfB1fPrAFVtXf7XCPQYeBw7/ijL8AKmS0vH8SVEvALbL1n94zmqsNm8pINNCjChP6N8Bgurxsk0C305PcbUgLWrNVCPCbyz2MIJEaULhcfNjcw1+NlEhFN0WEf1Urs+SrU1HyAgkt1U1aEb6q8Ct2rv8oPMtDtRorkLRBkEZBRDa68n19veopj0OOw+2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 23:09:35.0371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3636857a-0814-4568-24b0-08d538476c76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61251
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

On 11/30/2017 02:56 PM, James Hogan wrote:
> On Thu, Nov 30, 2017 at 01:49:43PM -0800, David Daney wrote:
>> On 11/30/2017 01:36 PM, James Hogan wrote:
>>> On Tue, Nov 28, 2017 at 04:55:34PM -0800, David Daney wrote:
>>>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>>>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>> ---
>>>>    arch/mips/cavium-octeon/setup.c       |  6 ++++++
>>>>    arch/mips/include/asm/octeon/octeon.h | 12 ++++++++++--
>>>>    2 files changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
>>>> index a8034d0dcade..99e6a68bc652 100644
>>>> --- a/arch/mips/cavium-octeon/setup.c
>>>> +++ b/arch/mips/cavium-octeon/setup.c
>>>> @@ -609,6 +609,12 @@ void octeon_user_io_init(void)
>>>>    #else
>>>>    	cvmmemctl.s.cvmsegenak = 0;
>>>>    #endif
>>>> +	if (OCTEON_IS_OCTEON3()) {
>>>> +		/* Enable LMTDMA */
>>>> +		cvmmemctl.s.lmtena = 1;
>>>> +		/* Scratch line to use for LMT operation */
>>>> +		cvmmemctl.s.lmtline = 2;
>>>
>>> Out of curiosity, is there significance to the value 2 and associated
>>> virtual address 0xffffffffffff8100, or is it pretty arbitrary?
>>
>> Yes, there is significance.
>>
>> CPU local memory starts at 0xffffffffffff8000, each line is 0x80 bytes.
>> so the 2nd line starts at 0xffffffffffff8100
> 
> What I mean is, why is 2 chosen instead of any other value?

That is explained in the change log of patch 5/8:


     1st 128-bytes: Use by IOBDMA
     2nd 128-bytes: Reserved by kernel for scratch/TLS emulation.
     3rd 128-bytes: OCTEON-III LMTLINE

> 
> Cheers
> James
> 
