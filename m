Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 19:31:27 +0200 (CEST)
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:11090
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991087AbdDTRbUjtv4u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Apr 2017 19:31:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E+QGAF8cR+amvKw/+GbYRzAN9tYqQmvRSzd87GQCKjY=;
 b=EXL4GGmAbcqbpH0dd2022YTugLY481kWR7GRAPeylVjLNQ5UnCofkn6Y/c4JOsIxgB/I0quf42yyWnG2hvrGikZU1JuV7RjjOmaWfpTQyuCthPfc6DQmMqAlIrbyAuxpN/caWI7YF9kn1/JeNcB+xgF0/BGZN6I07DTfOIpAv3U=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Thu, 20 Apr 2017 17:31:11 +0000
Subject: Re: next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10
 warnings (next-20170420)
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <58f869bd.84a0df0a.dc1f9.4547@mx.google.com>
 <CAK8P3a2uZFGXhNq+nwDQmgzNL5WH0VejQmotUZp3=0fKwsU1=w@mail.gmail.com>
 <20170420093348.GD28041@linux-mips.org>
 <421d0b9a-0008-528c-e615-fdc09023d822@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <268280c3-e686-b34b-a815-3a16f9b88f08@caviumnetworks.com>
Date:   Thu, 20 Apr 2017 10:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <421d0b9a-0008-528c-e615-fdc09023d822@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN2PR07CA006.namprd07.prod.outlook.com (10.255.174.23) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a6c4aa2-aebe-4985-429e-08d488130a16
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:+6u3QqJXehVzLbUYiR50HKQRL5lRs4VI+YGKoYloU4Tpk55KIe+p/tt0u+pDeBiBjt52R+IGArwL2tfROMpcIlb1l81mbma5syA2EiS8QUz+lfBLVLZA18l14W1rV23AzhEBkOPjSkYLXIdmw6rLm/OCtFweUgxIlJWyvDkF5GmaCpN5BJjAyLLmCI2A6QBQ/0JhKYkGUERqxnPXujxSMReIOn0HKtBDwpKYEBYZF1/VvWIcfjpkH4hajQbUnqdf6Pi+AQM7i/Dz9pFiEn4Ina+QNqsxoEGdV+351lGAuDubzHE8nP4V83w33UfpPMzUu2XSIHRTJa6Ry0GFgW9AQA==;25:zmFms+mJytsLZmZfIXfb/gGrt33l8Y9XvmMNLAULoRg+r8FaOB6HV+HZcomd3PYx40aBDwDKUQESsirwwjyJFHk4l8tSsrJ73N2RG29VoVZqIkkGl2f+HFfhttpEMvrBv3DGJ21vnf2nMYMYPDFEBFNrYZ/irnaEkCc+6/+Y88aOY9jxqWCMJCU8MZ9GJeKXKJ8WsO1GEJkwumuKp9NNNr6Ju0f8hHE4w2TonDtpvRZ7pNMfqVzEWvgEoGsAW8J9i1gCG5mUY1V+jDDoKbFL/grQeds2D6EBXIuZrB3VHky/5/bj6ZDNn7KHnzNVCL4HObTu9oS2tetOP68CJev9oYLvbkPAldUxScPf32xE+jvfppw376mpyl+FXjWwGuWzq97cSzR84FkD+fO4p+VBLKFlhkB0WpTGuaGrwmd1eMTi4BWUelpSiUgP7vA6b2wbr5xX1b8psHvGzxCu8yDoZA==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;31:P1X5TvQBwQ9PlqF7wQhhEBXbpA5g0QoC1d0ritY7OMvK95JnZTt9CQRg4oiS9AqybYLOIlX4cQS8Rl7mn8ySiqtKsRz2KqIRaf7ht/T515yBIOtOu9Be69JBgSHwswpm7vsSKeNG0h/8SklsYxJ9Gw7hfxTI682ZCeyylivVqlMXV5HSlcokl9OmCOa3XcuQlnpFvFpUwZwSE19dKdj2UZwCZ4W0HYoFOXLwoPGbofmsyqgHBeNhtURYNtgmW5Cl;20:BnMwXqSQuRSXvGNO/ryMlR9Mzkt9Xeia9c3Loa54LzSfo/wgKqfOtKZh+tLvSkCE4uTVdrh0j6fLyKMve2+YUcU4wsAJfJujQCWwSe/S4V5wQpiAOOfAryQS6zzfUgOBeDXgXPstuLToQGnofIMjd6Ch7JBbEDTD+QLWtdBrOq1q0WfcF4JdsHwMhczVyp/tsxAuKQUaN3sFtPjE1JFWaVELbfT8+K3pS4hq7Iwam0vOKWHsi8x6ZGQoJm4OjSZSWKj8BsgfiTHoPte8eH1rReiZHFOt2c6fIX6+O8lMllRw+tguyqjG8Q69afdayddNPpiEr1sXrJ6PEQJjIDfasOHv9iZlRoBCw+yECT5zDR3vFVqIWMseAWabs8oi1PKsMmSNjhdnK0dKDopTlX8ZT+qnMTc5xHmq+npEjLBWlBgF5Aw/5HC/aEn/GlAXEYCnzywu+CQquXDZSVfaOP8RvUlUiHu3MFStpFdQ1MySjuaD/qtpnMxk+L/3/IaS/1JD6VkIKP5HAyZKuMFi7gw4y2tpElpJcWLYD6y8F4HeBLd1P24U0YpoJoS2RhthzanuD+bCX3o3zQ6YzqlGU5zu40dkmX2OMeXUpD1UoXsK0+g=
X-Microsoft-Antispam-PRVS: <DM5PR07MB3499CF6096EAA6A48E08BD20971B0@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(6041248)(20161123564025)(20161123560025)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(6072148);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;4:jPLAgCKsl2SBYcqrq0uOVZN9Qgsre0BI8LLFsM7tBTB/zLUpbfb+LYsY+aNtZ8DZTq3PmQX/1WKzc86HOWI2BTVGUVnxrsUc00l/XtEm6nliO9dWcD0ve56+gQ6WP03hWL6lBSZRo7Ljj/bryZiGtAGsJX7Y9i0UQrzatV22MIrG+IJfiIMIE+BQf/FbqdmkQH3rYYJVNRvAJzAVKJCTOC23I1TQp9A/i0zT7YVNRpbmOLxJgIX/4IrJ0bQMPzaznWbpNMaUlvOy5OMXGm6jdR53lREuWpRAolY9bJixiXqZeheXCInlgrOAmK4S9vq+CbvlJWH8Mbme8Z67MZ+lJ2sq1vyUrOqxhvFGY03Gff26oTH3sDsXNSNB81thcg/3U4xJxy5hb7ajENW9ep2P61/Z0yrZ9G78fybBYnkjXxyrGDdeecPTKnAQLeJYwJsbRfgDlLkCuMUpMZVwlSauO1nMcgp1WiwBh+yMlrAFQ+ScwNjxxAcFAJwK+PafKCwQ8UBoD36tA0mGD5gUIUsdSqTxZCl2FvK21Ax8SqssLoMOlXriFLIMRxp7YBjF7y3goDiMWQw8/atr4Z9J94snJC8SVD3GXARwBuOZEVIs9uejy0S/xq8ubYl+KXGg+uZsZ7JWxHP8ORRMKbOHuqtjmDQZSYgAN3v43D2VS8Ga9kKyFejKLXaao+gmfHcu8agh
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39410400002)(39450400003)(39850400002)(39400400002)(24454002)(377454003)(25786009)(53936002)(31686004)(53416004)(6512007)(50986999)(54906002)(189998001)(42186005)(53546009)(36756003)(6246003)(33646002)(5660300001)(4326008)(65826007)(2906002)(38730400002)(305945005)(7736002)(42882006)(3846002)(76176999)(230700001)(81166006)(8676002)(6116002)(93886004)(6666003)(2950100002)(31696002)(6506006)(229853002)(6486002)(54356999)(66066001)(47776003)(50466002)(23676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk5OzIzOmRmcTNpaEdUNTR4NHdHN3Y3aGh2OUtwbmZO?=
 =?utf-8?B?MW4xSWN6UUJOUEdKdFFndE9LS3hCZkJNVU9uUlN3UGRkWG53bGZtNGdGWitl?=
 =?utf-8?B?OGIyZHBnbGE3U3FrODIyWTh5Q0h0eTVtbCtSOHk1YWhIdzV0WnpRMGtCbmND?=
 =?utf-8?B?K1ZEcDd3RlF2UmZ6SHV6TXdnRmp6aFRKNGJyd1lpdWlqam9hME5jNjJsOWhl?=
 =?utf-8?B?dmpMaXE3K0wwYnU5c0JlQmlUd2FMMGdWa3VMdFo2RmgxWDduVFBUVHUvU2hC?=
 =?utf-8?B?MnpwdTNsTDVmOXdmUUVJbjM4cTloWE5ST2hlT05OaVBMU3M3MzdUbExyb2JU?=
 =?utf-8?B?QnJ1K29LZnpoTHNMV1puS2R6R3FweHN2Y1AzMWpFbTJCTDBYYWNSUllTS2NT?=
 =?utf-8?B?K2pYUU9BRHJpVUhkMnVidEpHY1hSVGd3QURxN1ZZYXJzWU1yYUxtVHhndFUy?=
 =?utf-8?B?Y0dnaFJiTnNJWVhFT0RxVWYrTFBQQlZ6a29lQ3QrZG5IVU1NTlVGRU5iZkZN?=
 =?utf-8?B?d0QwVE5jYjZRRWgrSTYyMnVsQTVwc1BicWs1bDUwR0ZMMlNEUVhYdUFyNSt5?=
 =?utf-8?B?c1BweTVoZTZkdnlpMGRtRlZZMUNBMXd0cUZOUFJoUEtNbGFKcC91V1VPbXdv?=
 =?utf-8?B?Q2pWemhNcHBMbS9La2FaV2RVSkg1M3BaTXBoQU1pN2VtYUZHdTZJU2t0amVL?=
 =?utf-8?B?TUtvaU1nNTc0WjJZVnozTnV5bzV0RFpTc2tZVnNmYjhBLzhsbmdHUWRKUkps?=
 =?utf-8?B?TUR5SWhLUFdoZWtCem1BQlFGVkRQSlBGNXh3Z2pUTEdRbGhLaWY0SHFjYWQx?=
 =?utf-8?B?L2N1dktzeGIyLzBhOEhTN0ljQ2l6RkozWkZkTmtsWlFYMjYzNVAwdldYTHNM?=
 =?utf-8?B?OVZTZkR5SlhrOU1JZ08vb0tmUFVlc1FYUzFUbmRCaitQWUU1ckJpVmowU3Zk?=
 =?utf-8?B?L3RvaFQ2aHF2MU51emdEeGlhN0N0a1RObHpkRTdQRlFpdUl6SDZCbWhMcitq?=
 =?utf-8?B?Tlh0ZTkyVGp4Um15M0l2N1R2M0dHdGJZM052cmdxeGhSMlByZko5d1JKcHdU?=
 =?utf-8?B?YnpTKzZvOEhjWmRLenA4RzQvWTNJVldtOUZSM1Z2eU55QnJNLzFhVkZWQmhE?=
 =?utf-8?B?TXUwSDc4SjN5MDU3TnpUNXFkOHRPaWxMOUUvQUxsTTc2SFpabmxQaVk3RGhl?=
 =?utf-8?B?cGhRRC9FUWdnUTJrc2hwcmFkSUovMmUwUis1KzZjQW85dGg3SzRWZFRsWjV5?=
 =?utf-8?B?UzlXaXZoUVBGdXlGellhZTBHclpmQVhnTHFxV0Y5eStkWEkwbkJiTk5HOFha?=
 =?utf-8?B?dkxacFV0SngwbSt3UFdEVHVJY3BVVUFWakN3elpBSWZCZGRPaVR5UkdJQ0pa?=
 =?utf-8?B?THZ0MHhMMU5pcEtYaFp5YnNlVC83SU1KbmEvcDJpeWNHZFFpUkVKNkFNVjl1?=
 =?utf-8?B?dXpmY3ZMNnFUUmZkVzhjWmZZTHVPamZMQ05UdXVhOUVmak1zVFBHWUJ2cFdO?=
 =?utf-8?B?MEhWcDFCZDhhQjZsU0pxMDVabCs3a0l4RUxodk93ZHdSVTVlZ2Nxd3lHZEhQ?=
 =?utf-8?Q?wK7roap2H6vfEPRYPdr3bSBwYpy22v2hLH2WpVLohZs0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:vgp3DrVSPUvlaQgyrgk6ycaz3Pwz1qClNRh64c4jFE0LFjvjSsr5atKz3fBaGA8wQYqrA5qQlHrULKbPGVsW12pBik/ZlhJqz7CJBYq2WtSR3XABqvyGzbSla2YhCPSFvW66E6ZyxQg80aau+PJHzMDmVo4rlBkaJti++tyCufRnsrIJivodQ+/KjMTTh0THwsIz2k85fx58+FC+EUff2TkngJkLAJmPBHJpI9N4Vr/WP0n2STGeq2B/C/umhhlpM3N64x8CcbdT7wpxjQC8Hoi99bH1r7l3C5glNy5DNG4lWVtOqHNsS0jzsmZfrhSYShZSbx76YHtxBCYJA/EOg6x+jlN9fO05jrcPmmv0Mub3x/it1ovL8lCmaf2Hze+0PRko774wBokSkgZCEhk/1uIhWjI0xOXrzd7+9fjpch7NMx+Ib/Gw8bYpQB7TQ5fDiNBEUzi9KD5X7bpyZEx3WJrtZPpagzgv9Z/oWXMOS9Uq9++EKuLsWvGn6UZUs6E8PFtUbBU7SXpGMY4lfdK4EQ==;5:2biiMPDM/Jgi7U1J8aAkz6h+VMAdv31JDxLT7Jdhq5T+fDDDdK4cLukdHo662WyK/8WdXlQ5Zqc+UAHocLn1OVvuZPdzI9wDjobldOK8svSmVeHw4/Ncw3peul3nKAB6r3djyt7w46DxQCRrKBK66A==;24:LW+Nd9JmxDidBZ5p4i0yTjkNhODz8UVaD1XAt1y4Lh2MzU3TFpJ8egbmykxhtMWNKLrkTYgAAH3g78lBDyvi5CQC3q3cBzcJ/E9lrSTOSkY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;7:rTqf/O56u4j/8X8skmLphaIAHAhclGK+36VLyNloIFY3CiwlYkGkwjeGib1HfAQ0MwDkGsGFfNjt/mftUJ6COSt+QM3MF2CT612I76cC1ewA1TCEJjsQ3jPvD/mB/GSPUokWjowV+SB1bh4tt80NZurW61eqeVChoRTRF/YbkH8DLcIVCDDLq7qY8w2Pohk3o1eNIQqRpRXSZ64I8lRE4fNgFnLgh/j7J9FjkEsN+CiYLazKKbuLKqJQeTsD/yiajGhukXgPKsEnu6gyzDcG95/1t/AMwOlCJ6b8Nd0jh+VJ91Piw6QUky3aWpe6Fa25zTLfMEITnJdaBLRCTTNdug==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2017 17:31:11.0444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57751
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

On 04/20/2017 10:22 AM, Steven J. Hill wrote:
> On 04/20/2017 04:33 AM, Ralf Baechle wrote:
>> On Thu, Apr 20, 2017 at 11:23:03AM +0200, Arnd Bergmann wrote:
>>
>>> On Thu, Apr 20, 2017 at 9:56 AM, kernelci.org bot <bot@kernelci.org> wrote:
>>>> next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10 warnings
>>>
> [...]
>>
>> I've dropped both commits a few minutes ago.
>>
> I have found flaws in my testing methodology that I have now
> corrected, so these type of errors will be avoided going forward.
> Sorry for errors. Cheers.
> 

For a patch that can be proven to touch only one architecture, you must 
do an allyesconfig build for that architecture.

Otherwise, you should also do an allyesconfig build for x86 also.  Bonus 
for both 32-bit and 64-bit coverage

David.
