Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 00:21:17 +0200 (CEST)
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:19728
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992250AbcHYWVImsJuv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Aug 2016 00:21:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NSRf+AbW8VnN0iGEqd53WmbZCJCet+UZTIB2ZNZDIK0=;
 b=o/j1qO+LPcHJgOqkZ/ZZ8sHDJqVu2Nh1e/KDxCvfR1cG8UmFNN3FfA8ltJm9ZL0DEK5V94vsvUg82nbOJzbhIJQKU8GJobhtgN2cJCLbQLJc4QtldH/ULH5YQIFFUXVUAnhxPcI29f/24Y3NgxZfZVjtYYorUCzb2sFPLuCe2mA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 BN4PR07MB2130.namprd07.prod.outlook.com (10.164.63.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Thu, 25 Aug 2016 22:20:58 +0000
Message-ID: <57BF6F47.4030803@caviumnetworks.com>
Date:   Thu, 25 Aug 2016 15:20:55 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <steven.hill@cavium.com>,
        Rob Herring <robh@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Octeon: mark GPIO controller node not populated
 IRQ, init.
References: <422712ab-4b0d-2b6d-4600-b917c2d327a9@cavium.com>
In-Reply-To: <422712ab-4b0d-2b6d-4600-b917c2d327a9@cavium.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM2PR07CA0021.namprd07.prod.outlook.com (10.141.52.149) To
 BN4PR07MB2130.namprd07.prod.outlook.com (10.164.63.12)
X-MS-Office365-Filtering-Correlation-Id: 38eff958-dda6-482f-6afc-08d3cd361735
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;2:FltEYZMtITQbyFMqj2EqnI07UbNQFEvY4Axxs3czl1jKxqoXyxJ/Kv7ClT1Y1RRUD7FswNH0r48Br9tzO2VAwmvN4OF47d2lpAtUsEBng0i/RcKRU52eid3m3i0C0vorO6JH4jjm52YDsvHlIFzX/YB564ojbGTzsKLW3HEm7n9m1Hv44YruVDenXZ9mZkPP;3:NWGekETVneGFl+YKK9h6PQQvHvxgqCZit1dY9fk9xJESY9gunFhGSWfWR7oU7CxFZnWO+mksx1qlX43FDlQoyg7qhtThtWcnc9cKsh/Td04BEGn9ATjQlNW2R94nyi4R
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2130;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;25:jgGoit/Sa4CgdTNrRnaN1umbu6+4ek4HapJ4wcktlR3szT7R3580TxuvYGPJ+jB2sW9YIlL42DFYMW100WLGqRyDHX211PpJpkdDidvu+hXimLoOP3dfYi08ed8ERwxcp0G5lPJWWHyP1rP4rxIMNRovDWfzh/qE9FSa3k3eEfDYsMCg5IB/lkoUCzQdGqXN5/6r8LDoq0pz3mcLMVJLsVNcBKo5I2iAU7j5uwffDbAqcdToc9smDXiRsDISI777cmVRTwoO8DS04kkPoDLYglCcZQUDN+q0ndz3BcztG0hw8srNcLDMYiyJ6v3b+GSlq6xrDAlmP1fkFSwCDyOsZJFO6HrAt7QVc4uu7IxgX9OpntVw3ir17f5gjwHRx6l7k1BawcrFQKXAtJEASnSqmqOV/Ewy+IgYx7c6QLlKOaMCm0cu25O/3qXUw0mxRNOItCclEREKmVzKmRQmfIZaWjZe8l48YnEPf/yJ/o875X+mIxJ0wMxkp/ksbQQW3AmtlKpJ29OBGloKFFGCYtOdwr6FQwOYSt0IHfnOWxKRCd0UlrCpaKndhDe1WKSlSKBow4qPvMFEjXYJbCI2kBTT5YwXJQZTDo1w7y1ouZXD45m1cAlwej7B3EXfgRiPS2U+FGNlrSKnxfPUvSVzPz8JHSzItDORYvfTiAK97t1za5Ott8nkws6kUSeN8CKc8iJdnXIOpYLJp9WXI1o+lsC+/zQ6QX9iK8pcr3R6PZN3mjY=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;31:fpp9MS+NFfEB917vvzHjHxudmGicR5tkrZe1SiM/OIvrmk7QnqWDp46FzGeHrt4P6EoRGyzMpZxPFxpkERm7pme+w6MmlBWyi3kt04aVUGJx3G0/0I3r5Sb672joXfZwEvvE5EblwmeM59ncdIQ1JNz52udTBrV95XpIpbzKbCyP8mv6sd/0iLWEXdTuNC5YIbbiy1iU6PmqAstb0mAGOGQBzXtKpRbhEQFJVmAIVF4=;20:Rlqnrs/phqka9COfrqT+5bTQCGgdu4j9VjN0p8NjOwvi9kx0aw6Ko5ToUOE7gfxpSji9t37PHVz3tUhllljd2BpL2X4JEKxpPvCz1HBGubLjlS784qj445+P9M5iJI/UPC5+2tynH/aZz3nDRZkH6cD3okVyQsT73zE1pR2VEpfbxAHhBNxfPF3YrAPAd66bEmYiU7VMnkNiGD0oXHcb1iHKmWZe6OqYfnYWJnXqcB3CqdDB+phwzJRpHa6D/44x8x5R37uv+2qb2fgLrAKO5LcVEzV4SLju2bqAXAFzhtEsDQTvI9eo6SDueBiUTrBMwoSWXfys2V0mDOM+ffbSqV7iaQZm0VfVn1UXv+/iiP2Flzxwv0TXUqorZeA9WGkOIA/sE2Khf2/wHMBOkTLW3beCf961wFXhQexxdTuuuZA4s7GooqILiwQ6ABoZ81RkaOfL2HxvUrUDKgrIlnxOs1SoqgYZySe1UueHPUFapb5OuyRG9YoijXJ115efC6T3Q0cWfXV4jntiq7zbX83V3keayuhTn2C14cQGOqFZC40EYRKcoQmfk0oTOZNZUmm11GUoeRQeC+DBtDzA3O9ej2xaszLbQ7d8d4PbnCP/cZM=
X-Microsoft-Antispam-PRVS: <BN4PR07MB21303EB86F93BA5AE69AA40397ED0@BN4PR07MB2130.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:BN4PR07MB2130;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2130;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;4:lymwFjp721SdTklsBr0tekreQUc4QNtmfCOHynWzCqRQ42TXSbX4dqdw7Q0AEygCdlY7OGOfJvmytdpZ9eoGooBHBaE3lpVCxb8+2pu/enAH4PFo6CPKCIwyFZCEX8tERH+XJ4loOfOcqfNGPG/2CXwDQ5kWwXH+RUqTgB3j3uoOsFetjmW72k/iUr8h2BrdD+BGXl7sa7dYzInNp+wXY0pLlZHuZDb41kd0eI+qunqk9Job2YRk4Ye5Rf/FJDS03da/7wTYimvIRiV8BdlXA/gojyA4gPiTZf5X37RT9+9IEJssB84EmZZg9QRRWRqjwh+X3ZCJbWz2tSUH03fS6ORnvrdfctRyJcDrubYAkwkT/ah3TM0WnqeIEPsd8GfaDPGptEos7nHlZPth3vLgRQ==
X-Forefront-PRVS: 0045236D47
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(377454003)(24454002)(92566002)(230700001)(305945005)(4326007)(2906002)(47776003)(189998001)(65806001)(7846002)(68736007)(6116002)(3846002)(7736002)(81156014)(5660300001)(4001350100001)(81166006)(106356001)(97736004)(5001770100001)(8676002)(586003)(59896002)(50986999)(76176999)(105586002)(64126003)(87266999)(19580395003)(33656002)(80316001)(83506001)(23676002)(19580405001)(50466002)(54356999)(101416001)(65816999)(77096005)(36756003)(66066001)(65956001)(2950100001)(53416004)(42186005)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2130;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjRQUjA3TUIyMTMwOzIzOlVDeER4aGFyVTVKdWc1ck8waTczWFVucGtW?=
 =?utf-8?B?clJZVE5tWFRGZ3JJZlBrbE95QWNtdGxJRnBCbkgyd24yaVIvZUdQWjVoRG1R?=
 =?utf-8?B?N2xGWXI1YzZ0UXh4Y3pmeEZGK1B5WENvUUJ3NVBTZE1JWnVmRURTRSs4T3A0?=
 =?utf-8?B?MHE4MEJKc3JxRUxsTUx5ekx2bTZmWUhiS2pPajg5Nm1qYWQ5VlZMSlZ3VENr?=
 =?utf-8?B?c3ZmVmIxNXNVVWhtVGdtYTN4R0kwUzdZdEdsUGRDZ1pWSDA4bXRFTmtVRnRh?=
 =?utf-8?B?U0RWNzhJZnlCWG9MT2JKQXU4UkZxWWtFQnVMYXd2NDVmQ3BYalB3N254bTY3?=
 =?utf-8?B?dTNPbjVrV0d1NlZnRWN2T0pJOUlYL1lKL0d5OFY0ODdBWnJZSitLZkF6Y3Qw?=
 =?utf-8?B?WnFteDY4RDUvRGpQY0xEc0dZNmFOUWQ4TVVDUTNKUnVnWVR4N3l3cXo2RXBs?=
 =?utf-8?B?YjN1dkdBSTQ5Z3RXWkN0OGtYaUtyOUlHcGRsV1JuQ3EvRzBzeHRnUlNxU3Ey?=
 =?utf-8?B?ZElNV3NGd3pVR2tXc1VmT01JYzVkS3FlODc2SXFwalplOHo5Z3NtL09ONnFD?=
 =?utf-8?B?Rit2a2ROSTM5YSswOXgvVngyZGtSMFpNU3dCYXAraFpNZXB4OCtGWDB6T1hi?=
 =?utf-8?B?RHdUUTBXVUcvZTZrbkdodXdYWVVNRFdQWFJhS2xjeHluMUJha21qRjN1bmt2?=
 =?utf-8?B?ZVMrclo2MDhzQ2NnVjBDYU41UW9ZNnZpRjVScUpwSWhobWk0ZmFiZnh1MTVE?=
 =?utf-8?B?L0M2S28xSlRndTJBWGg5dm1oZWdidnRVNDNlamNxK0krWW82R2RlRnFlSXlk?=
 =?utf-8?B?UVlxV09QcHhPaUs4a3daak9NbkhZc2IrME5lTGxMQWNONWZQdVpYM0hFb2N4?=
 =?utf-8?B?WUsvN3poTXY2MTdkZ1BqWVpKVnZaamgwZWJJODVpKzdxSnlvRlQ0SHI4ZFls?=
 =?utf-8?B?ODVsVlZYdlNoUFlZaEZsNDhhQ1ROSkI5L0g4UWxld1BQMHdMeHF3cVpwc0kz?=
 =?utf-8?B?NThyOVRsNVNTK1UrczU4dzYxWmpQWUk2QnpHazhhN05ESThXcVY2WjRJa2FV?=
 =?utf-8?B?dFFGdS9DeUIyb2FBUUxKQ3M2d1FWbkptWnBaeFdKTTMvdEhrSWQ4TndjcHVs?=
 =?utf-8?B?NEUrOWs1YUlMMk84ZTNpem51NXB2aDArQ1JMV3ZzSm51QWFuZUp5cTUxaUFy?=
 =?utf-8?B?eWdaNTJlbVFBeW04UnlWNHlvcU1tTThUNDAxTVErQ3BreWJnMEdPTjlKSEIv?=
 =?utf-8?B?SkNLNTl0V2JGYjBROG41UDNpQStGdDdJQThYYWMzUlhNaXExMnFweHlqQlVk?=
 =?utf-8?B?T29wVWQzZExkQUl3SUdxTXo1YkNLTm42eHpuZXZGaEZ2WFJjbzlISms4NXhF?=
 =?utf-8?B?ZzFJUEpXRjNXdkpvZEVtdXJTandnSzJoYUI1S2M2U09oWWdYM2M0eXJiQ0wy?=
 =?utf-8?B?cE1ITndGbng5RC9yeEdGbndwWE5QT1NvQUZSNTJLM2RGWmtTVDFONFRRTnJp?=
 =?utf-8?B?aEdLS2J1djRIdXQrU2pGazBZZEppVXpvOGJtVTc3TUNWRTNOTTZ0QVMrbXg3?=
 =?utf-8?B?a3lNYXlkYzJFSEpaZXdKUVh0T1p4TVVDdHBEMU9CcWJCZG9hN3FNOUhESkFu?=
 =?utf-8?B?SnFKQVNBMkZBUGd4dlVXUUd4QWl0OUI0NVhFME9BZ0R6eWxudmtQMTRWanZ6?=
 =?utf-8?B?cWNiVWw0UWw1SFl2YjNNVk5ZSk95eHVhT2ppZVhkSVlmVm81ZmQ2N2IzK1lm?=
 =?utf-8?B?aGphTmhzK1haRXdibTBSeW45R2M2eXZZZHBhTXBEd0ZNak4yN25aRkNGaDZV?=
 =?utf-8?Q?LBVqPb2tTJovO?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2130;6:o8ugsHbMNmCqqU9nQWJFTDMTRrZsF6w88posYe+IBsdyNI60rKH7kqywsvSVO870lHvlXRN9meNdoqjpxGQKxVD6OtFwYeZyh3BsV7hdXqpe3OoeaRdQEY46UV5BtyowMr922N/eNTRtPPqt3rv1dPePedUDufMsAHr7DMuPgFE8rt8eTVwo2RUhaBwKTclZR0G3tL7PTFe6wfTIzLJMHnqv3Vi1Y/Y0V4a92f+gSlCJbjKQ8UzFQrHwprtqiTeJorjDTXZffD1EcwzK5r2tBRjVDKVPirm9pUdZTY23Kzs=;5:MB7dYYUB4A2aFmqT+/QBCzynNpLJVxdoruxqelL0Ldm4buNGtqWNQKmiYX+/kgZ0u95HQrzJbjMLifrvh60rn9eN7+QXu/bBeMoAMBTfhBYL5YEnrmCz4jAba4iMgmtZ/sMDVV8Ngtu7zeYsSddvRA==;24:KHIrQVJy8nOQvjNDSGDZT5NWrcQrFhYKTctvJr2piLa1we1iS2cQ5Vm/SP6m1OV+XlMOmkJujm6ZfNbWraYqQDDzER1Ts3OchvXkoovxsqU=;7:haKIS4UaC09stec3NEM5HswlHzvF4rOXZg7aK40BXWJCP8odcUU3o8fd8typQ3wWodEe4XdiQRO7GCr0CBxVdHGksFT0aZNHXwGuDdmMuIIawLYzwuVKLWJ2upfsOrTkeWdeqwLONadChEZHSo7Wh/FLn92VIfsxr+VMlyLH9s4J87bHlyfLIwbG5eLRkh3ijD7Mfw+2cg8ledVE+DjfVTAqc4dTEse5RTl8txQpoPqAknWhgWjSFcsLGmqHiKFx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2016 22:20:58.2019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2130
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54758
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

On 08/25/2016 02:22 PM, Steven J. Hill wrote:
> We clear the OF_POPULATED flag for the GPIO controller node, otherwise
> the GPIO lines used by the MMC driver are never probed.
>
> Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>   arch/mips/cavium-octeon/octeon-irq.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 5a9b87b..41d12d4 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1619,6 +1619,13 @@ static int __init octeon_irq_init_gpio(
>   		return -ENOMEM;
>   	}
>
> +	/*
> +	 * Clear the OF_POPULATED flag that was set above for the

Can we s/above/in of_irq_init()/ to be less ambiguous?


> +	 * GPIO controller so that the lines used by the MMC driver

I suspect that it is not just MMC that was broken by commit 
15cc2ed6dcf9.  Can we get a real description of exactly which kernel 
facilities are impacted?  Is it all GPIO, or what?

> +	 * will not be skipped.
> +	 */
> +	of_node_clear_flag(gpio_node, OF_POPULATED);
> +
>   	return 0;
>   }
>   /*
>
