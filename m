Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 22:48:30 +0200 (CEST)
Received: from mail-bl2on0069.outbound.protection.outlook.com ([65.55.169.69]:7824
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010960AbbHDUs3Zy0Xi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Aug 2015 22:48:29 +0200
Received: from BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) by
 BN3PR0701MB1735.namprd07.prod.outlook.com (10.163.39.22) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Tue, 4 Aug 2015 20:48:22 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Tue, 4 Aug 2015 20:48:19 +0000
Message-ID: <55C1250B.2090508@caviumnetworks.com>
Date:   Tue, 4 Aug 2015 13:48:11 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
        <stable@vger.kernel.org>
Subject: Re: MIPS: Make set_pte() SMP safe.
References: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com> <55C10F4B.2050003@imgtec.com> <55C11A37.5070509@caviumnetworks.com> <55C1214F.8050208@imgtec.com>
In-Reply-To: <55C1214F.8050208@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0037.namprd07.prod.outlook.com (25.162.96.47) To
 BN3PR0701MB1719.namprd07.prod.outlook.com (25.163.39.18)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;2:IQote5KdgWGmNMW3ityJBY9XtWsDmELqo+ul9kmKkhUQHbHWOmalmmLFRQlIvow7qAoTPC+s9mDdZsyOAIKg7R4hBZ/oldXlHq/5Bwq/bUZ4frny+MuNHHLCfy7BzuuyxROJ8gtJjDsCgCAWed4C2kvGW3DHwEKNQhbNKcLwW4w=;3:ApVsVOQi87lqrHg+u6vLTY1v5rMpQ061MG9KGiwUbrQsorjADqaVMvkTrAeJeLjtTuFB0utq9pMRYztRCKDeqV4O5ZjR4oEg+S3BJyOSt/dEdsmHHM3TntwwygluH48gvOqS22YAQs3CQgCKA78E7Q==;25:XntTApKJo/opBFlAAEiZTRqYkdqWYG7V+9SCKJSUpg+l4uPyMRzCXpQMAdBlnQuCITSPQGjgsOYVZSgU7e09b+NL4inOEDF5JlKd78ZT/Q1Odwt8ukvIa5aGaaPencxoIVUE27t1rP+DgJt/iXUQGd8jHCeQXSp4++1EpwR2R2QJSiwHvbpNImXK60NBumb27XQb90c4yBbVrcxfxecHKrn3y1VZJQRuzQhLjNzafbkoSUWIAx9T0SQs52jO8e5Z
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1735;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;20:VpZckaGxNtqDgKC7pxjgabNyH0w3L7351+ZiAW0wYP4g6lnYU2RXgKx2VNQnNSDGj6h380Oq+d/zv4s1K0WoVuPg1WSEFtnNV0s3+pe3jRRvEAlx7IvEAzTZh0pVyT9b+1JtKWTJskrMdGVXsmTW7URpJe07MpOYPMKzQ52EmaVfM56kzZq3TWM2e6Z71TKzHhFfpNBmjDiJDj5PWwTQ5hna1Uhev8DPxuJdUNm9higTzy/rVJyWJf3PWdXh1vrm8Qwxdq1PBHKCEnfLm8xM67LprWJa2IlUy3OkIVrUNvUetWXGMzbV8nvux2pTtM+w6m1no4T1n4KK2bsYH99MBUn71uPAIhc3HjgNmjwi8T4fsbKS9IeitVP7drgqOkpOqClgLytvQtajHm7sFHm5GIO3f/xK+UAG7qAmwOlyBZ7RXgZjNS41npitKFvrWQLVvdDZEt9akMuMkv+cmUiryYXz6OUfvrM90UL4zfkSwMYaEqTDZZLML2JtGkLA1motTU6JvecXj7oqHH2LexgFXPqUgIcqHggx16IEvx9G2VX9L3CQSPksm/jQfUlSdZtIZ9Y8SE7bQrqNFTht+MmFSel11BYwggf97jlfQ8YnDGY=;4:9l/RWMWLE4Di8TGNesZRD6n2gY4RzyjEsk0Fqw3aRAc3nA1Ta+ngC4z4rDtveMWCno63U1wxpngc11F4f38/Cbc88HZQnipk1KIGOJuwhPc9aFVIVG5VCNcBUjG3wvm+Ue1YixelLB8YbXpj21xxXRMR+xRXxgBiigHtYatBPboktP9IO5KtL1AbJtBk98/6ychHLvOpJ/VMBhm+elx05oM1qUUVMNEnpCVqDArSJKborqs4oQPUJXpGKNABeoTarFaUwk5EP4621P41I33aDhOFyUoSpZeFRkn7bEghnaI=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1719282A320E17A0FDD51AF29A760@BN3PR0701MB1719.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1719;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(24454002)(377454003)(199003)(189002)(77156002)(53416004)(80316001)(92566002)(93886004)(5001830100001)(106356001)(4001350100001)(5001860100001)(110136002)(81156007)(4001540100001)(36756003)(5890100001)(42186005)(97736004)(189998001)(5001960100002)(64126003)(83506001)(40100003)(64706001)(47776003)(65956001)(76176999)(33656002)(69596002)(77096005)(62966003)(65806001)(2950100001)(122386002)(66066001)(105586002)(68736005)(23676002)(50466002)(50986999)(59896002)(46102003)(87976001)(54356999)(87266999)(101416001)(65816999);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1719;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjE3MTk7MjM6cmY2VnNqcjdzZXhFeGh2VlNGWWY5ZnZ4?=
 =?utf-8?B?dHZJQTVtZldGcWpJdHRwMDBLZzh5alkrTjMxRGR5NlJTdWFwcjJ2R1NXeWl0?=
 =?utf-8?B?U0xPa3lmZVJoTSt5cEhtemxvb1h3THRoUThGRmx2UW5VVmt2dUdqejZlUnVO?=
 =?utf-8?B?WlJxQndGa3BubE9Hdm1Fb0huUXU4bnZaYndRZjRIbWQvSFF4WUd3SEltTmZo?=
 =?utf-8?B?THVSZTJ6YStIL3QyeENSQWdSOTZPNlk3NmJjYk9CTTZQbUMwOTZNSWtnUFRX?=
 =?utf-8?B?WENlTWVtQ0VHUTVVbHJxOXVPOStLd29NQ29jUStLVFJ1NU16VDQvUWVDWnN0?=
 =?utf-8?B?Y0Q3L3ZsQ2hzOVJWNG9xZEhoWE9VT2VVZU00UUplVlBFVEZid1Bac3c4TkRZ?=
 =?utf-8?B?bjFlQ29ub1Y5N2c3MTZnejdhMEdGMHdGOTZLZTFhRURBTWY2QzlwSlkyYWRy?=
 =?utf-8?B?bEczckU1NmdsZlJLaHIwcFkvb3ZZMmtEVk54Yk44ZVdIM0dHUlhCcFYxWTVZ?=
 =?utf-8?B?V3VlZ2ZuaEc0NnFTUkdXUXY1ejFuVGhWczZRY0w3VkoxbEwwRXRCbFpqVG8z?=
 =?utf-8?B?WHNMR0VjeElEcFBUNlJEVlFtdEhqMnRseWw0MlgzVVR3R2xMM2JNNmNLSGZU?=
 =?utf-8?B?VHk5RWQ2R0YyeU9FMmZVU3NUQjdVSitGaWl2WmJiREFzcFhiMlVzYXk3Mlp1?=
 =?utf-8?B?aXZLemI1SWhFcTFhYTBqeTIvV09RU0NpZ1crQkwwOXZ5eWxOcFQ3eHJxZDQy?=
 =?utf-8?B?REFiM1lFM0w1dW1VMmVyV3Y2elpROGtSMXdUS2M0UHFub1YwVmlzVVBPNzYr?=
 =?utf-8?B?eFpuYlVVUmU0ZFVqekY3dGxUczR6V0p1OGV0YzFRMmNIeUtmWmJYV2ZKaEx4?=
 =?utf-8?B?MHM4eWw3RzNOajgzTmxkeGl4QkczSnczL1JJWEZnOG9oSUliemhCZUdJV1Y4?=
 =?utf-8?B?RjY5K1NKU1N4b3R3cnRFNHdxRGhHYkl2YUo4eVRVcmlRWWtTaTVxKzBJTG5E?=
 =?utf-8?B?U0VYVFA2WVVObTNiRDNRVWI4R3AvVTE2S2FDbXdUcUdaZXpTc3dUN0dSbkNU?=
 =?utf-8?B?TUFQUlI2dVRoOE5Tdk10L2VXcDFpK042VnlJQXRhY3M4Rkl2WlRtT0xKWmg2?=
 =?utf-8?B?dmFITmNYY1ZFU210YVFVRnp0RUFHcjVuSTJTYmhaR2pQZEJweHRNOE5rUW9H?=
 =?utf-8?B?ampiS3lhVWdnTWREWHdRT3A1K0h4TERwWW81dzlGdEdLR2RyRk1RVUxRUmFw?=
 =?utf-8?B?cFdMbXoyVmI4S0xvOGhKcC9MMTBvSmlUZ2owdVVESTRzY1Z6NFA3VktwVXFI?=
 =?utf-8?B?aUtZSUJLOWVCZ3pQZEswNElDRTZGOWNrYzJkQ1NjTkNZL01LcDNBQ3VwTHk5?=
 =?utf-8?B?M2NzeDZ0ckpmMG1VU0pLak1ZNmtZQVhzcllFZllrWE9WMWFyOWorMldLSnM0?=
 =?utf-8?B?M21mMHFhL3luMHg2SEdLb05TWitmV1ovbDMzVWZPSWhNKytxdlhQL2tBMXVV?=
 =?utf-8?B?M2gzNVQyUkEvREhjeTZMWGdweGVld2NWdjJDM201SXc4L1duaUNvc2ppUlV2?=
 =?utf-8?B?clpmN01IS3NqeEowREV1OVp1TzVDZW5vWUlTWmhnWXJ6bnlUVW1WR2ROZld0?=
 =?utf-8?B?bDdpRHdTQ3JhbFpURytNUEhDVVE4dzlIQ1dIbklPWCtxV3V4WmJ5amk2cXRI?=
 =?utf-8?B?UGtsSElOeG45Skp0d0plR2VOaWxjanEzcERmV211aXBpY2ZramptbngzdFNj?=
 =?utf-8?Q?H9HDM3sMUczrQbbmjobxrhV9ZIw9zQXEb3i1kd0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;5:Iz28dtXOEVXQY4zzf7DAE/bi9luCxCRiQ1fpsFBcaupArdrTsA13OqfJknJ7SaucCsSapoYEvpDW4LddqoetXeFQbZUxRu+MFKyRlJBGAJ/+c1aKZAbJqTMIZVatb+WwBkdmejMYMccqzLCUU7vKeQ==;24:+Bd+i1rmpMYmFn8SE4gODqtyiKtbnzgypp4jl5+eVlA/wE6SjtoiKN9S1kGAXoeO+QDdL02Vc0APllpBBqgjFEQTEF2hipm+vhcjDBE6V1Q=;20:fblAUHDGL1bO3qxq1zUNKBxuvxB4eynnypduLpJmwisXIpVo6hvGYkrneC0vWnMPRoh4dlGEHlsjm5sDfTiEzw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2015 20:48:19.6065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1719
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1735;2:iC0ezM1cGbLK+JjeguYP4th2f1rqhrMVPnV3Wm74S+q96LH0mXl0+p6PXrLWdtLThNbjeFXvw7VQDewouVEgBK/XD6Gtc/IFCH9dDd95T3HzX7SfsFJ+T1MHCgW2bM7u5hYWAOvcnW0idPQ6fzoSd51UQobntG2L5a1wLoia5Wk=;3:x4VvMPwwLCxV5Gr2Wu/288IqmPXlYLHR8SIUSP7t8mssYC6uhKWIZT3h4Na2DTT55Lh61F8Kw/cnrdm/cb4Zm2QTOoAj/nFAIVS8pv5A4eeW9E7LtKlDOFnDpGPra5fNG+erBE5/m+sfi8nnh1F0AA==;25:EMDcsdZVDWtLvutuxeMzSM2F9Os8pAnpleegC1dWtegIvKKSSYpLS5ESZmmLFHcFuYSEIoKZ/8y6L7O1jrWvM7/ESdnjnkmG1hE5YjNFShfQfoPn3czYGxN9nuEikcfpeeF17/kUe8lgQNDg5klV0X4z8zwKWUITlfAlBt/w1c6hnLTcmjRhhPEXnDP+wcrg0qfN5HNepflym1AidVfN4hw0W9VKbBmwB1e2O34Y9m9ou9rh5nvDJc9Iu0drWvvg;23:MFuXMEqRYGvJaUN3qG8t5ComrbkeM4KMG+O5QIeCilU4qlhCvNaWGj0inCw5xg7nrX3vZsFe8hY8zIeVCpGiyZZhV82vEsQOAdbDg2KPO42SJXVvcPDhDoP3pe4W7KK06cF4/iUAlmfOLMHXrhMISXvi/N6tVHumKvR7mYEA4laumt5Cjhyx1LkmAQF8roHSljUG62mPWKoRFIwUshSY9kOQY5EHmPgP4qldfQGE7KX+jhlkKpB1be+oG/wiSynk
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48575
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

On 08/04/2015 01:32 PM, Leonid Yegoshin wrote:
> David,
>
> It is interesting, I still don't understand the effect

I think the best way to think about it is to ignore vmap, and consider 
the semantics of set_pte().

When a thread calls set_pte() it must ensure that no other thread will 
crash using VA region covered by the PTE.  That is the contract of 
set_pte().

The MIPS set_pte() does something different.  In addition to setting the 
specified PTE, it has the side effect of clobbering another PTE (called 
the buddy).  There is nothing in the kernel that prevents a another 
thread from using the buddy-PTE, and when that happens in the race 
window, the page tables are corrupted, and the system crashes.

The fix is to not clobber the buddy-PTE.

You can go around in circles all you want trying to indirectly avoid 
using the buddy-PTE from another thread, but I think it is best to make 
set_pte() have easily understood semantics (and semantics that match 
those of other architectures) and not clobber things in unexpected ways.

David Daney.


> - if guard page
> is used then two different VMAP allocations can't use two buddy PTEs.
>
> Yes, only one of buddy PTEs in that case can be allocated and attached
> to VMA but caller doesn't know about additional page and two cases are
> possible. Even map_vm_area has no any info about guard page.
>
> (assume VMA1 has low address range and VMA2 has higher address range):
>
> a.  VMA1 (after adjustment) ends at even PTE ==> caller doesn't use that
> PTE and there is no collision with last pair of buddy PTEs, even if VMA2
> uses odd PTE from that pair.
> b.  VMA1 (after adjustment) ends at odd PTE ==> again, this buddy pair
> is used only VMA1. Next VMA2 start from next pair.
>
> What is wrong here?
>
> Is it possible that access gone bad and touches a page beyond a
> requested size?
> Is it possible that it is not vmap() but some different interface was used?
>
> - Leonid.
>
