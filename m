Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 02:36:11 +0100 (CET)
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:55264
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991985AbdLLBgD0tgSc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Dec 2017 02:36:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Kk2kFqzIMtoYO8xtubwUJUb7MlpFSOQT+lTiK+GPO+o=;
 b=YjlycCAFxkCuB47TzCVCuYkjEYlt48AUvZJI1cHx3QsRj25AFDRyV7k0dEsa36wS/U+SyvqK3ELKUvNATcdGrZUE7Uu9n2GmRyFytR1iuNncOUV7gxOQRuJCRVgKRqnEk/S9mFi+mU/5TXAgQMEq3PS2q56HvO/fjAz2OG7TGTA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Tue, 12 Dec 2017 01:35:52 +0000
Subject: Re: [PATCH v6 net-next,mips 3/7] MIPS: Octeon: Automatically
 provision CVMSEG space.
To:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
 <20171208000934.6554-4-david.daney@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <78511f31-86ad-2905-686c-1e2265e9bc7b@caviumnetworks.com>
Date:   Mon, 11 Dec 2017 17:35:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171208000934.6554-4-david.daney@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0066.namprd07.prod.outlook.com (10.163.126.34)
 To MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c5d04e-d159-4306-b34a-08d54100aeb6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:sfMbhheUXQ6Jy3SL2Nn96gUF9K29ro5dlTvnDZtcRGi2/FcBelscFTElCB4+Inhe44HkQQY3rekcYzpDq70VrdyqTtF1AGPzJArDZa06jTn9OD8v4bsQT74f31p/w0K95ucO2gwWxjff7n3NTWsmjmApgXUZQmxXLtaFSDqP7KfUuiMF/kO8ndjK4tibV7RusDlGx5xhwglQVxKe+qpptxCSTAnw+832Mrc1Jm+XDT5Zkd6q2ngD651D41vVoqi9;25:AX+VTC+8mZ+s7h8pFyGXAQAxUEQ2JF9b6v4HKqW16K5OxuaAt2hPk1efY9MHqi/JDzIjny38Uel/dZvs+0yCgDMr4XmIK7aFhvjL2ogz1OG9oT8ZLOulPbzG6rQkUbvFXibjoBfn76Pxn0P+oZ1L3WbNedEr5CAa5/bCJbcT2UV1Q8hqncGwot9ptLqXJnEcIzTJoEdxiXokQL9lAQ+4WuwswTSI6cT0nPqirkPKobhHh9f5+lesyZUm15xx5+g7ysIOqqa+d2hh87Ya7BQCI0UTJE43ukYd4WyKJnlYPt/koEiIr/Hfyz9mGUvG7MWZcbico7WwJNbVW+P3nMZpAg==;31:hrGDnFhbPTASfmll1Vr6vNreb7DXyDUl3OJKFqOPr547dSROaMMw9ah0TEwWvwPwJkEMgZF5pDmJW3GNg1evx+1aA8J/QajFhZGOXhrlUs3LAdZReVVERyMkcCocy74AFRWx6FK0urdDyIB7/pTWJoGdaPkMEb23CNxEiSn+ur5CuPIS7cHHvhePotY7D3ZChL9NSsO5pHJPtYVj649Bbz6VbV4YOH7s/5bnUsFbA4M=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:0U9Zzdt800/lwMrG3U9zp4bfGXRUeCqeeaGPOkGdAUT7XcEhe1t5zxdqoT7gNR/plJT1TcdoBhrYpamCdxdPXotd7WreYOBjHGtrbmtzY0YJl3lN/nTw50c0bZsBafVOWZWZfSh3OmdZMNLkbsV4btbFG/92u2xjIzUjjU6fJKqRwtD69c51mAGVDpL+gotkznX8/nmneZCnCyqMEvObpd8K0mJrtFaOEEGaA0jx97r/mNg8aSsKrSZZ6hJnXkYHgLnUGpBhAqhsbi4+1fcfEOauaGIBlUKX+7obH9qLCarYtkKNSGOQBEMQI0Q81o7P3yd0EFGCIMUY6mjLWUlrsJuAyARDFm13TK69tTZ1E15Lq699ZevzmKcrH/OLR81YiGq+Rq0Vehm3o6sbrZFqXVWpmYbt1tMfAAFqblfGSDPAF/DvcRzEiLfVY/lVLJcET0AVEmx8aflStIQVKQzTFIznvZMHVHNqyaE4wbE3r3n7sRGMivbBDM2zfVNoNttoBX/xjaqHy4I/f+BMicyHxwWjYjbt5JxWbf5n2g7KQJKsVXvf1uwN/+heFMVtyIXVHS+OIpktWYNSo3DIdoWxOUg7wK5l7eZA7oJ3BJ5kdpg=;4:3VCvyQcqrP0/r0B9vgNzj2H4C3VLLJCG/OTvqL+gzFOSNYV3+napKurQhQZLMjhBQnICIYXlju84ht8ka75vKb2CH6gcd9mxJ0dcdr2BOgwyoIuhl+2ebMydzhxuBYWx+GJhI3fBQP73OkbBiIjGzdyBdtEfOXTX9blHF/DAGsTNh6TJXcI38P6n/vrmpcrxaHLb8buvoLrdYDYXkerZilEZGEVNI3lftbVg5EjCoraLFHZCsSdNYzmBfkZ9wSO53bam7qfA6D7jjFZEZv3+Uw==
X-Microsoft-Antispam-PRVS: <MWHPR07MB35047260FA63FB0C9D25E82B97340@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231023)(10201501046)(3002001)(93006095)(6041248)(20161123555025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 051900244E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(24454002)(51874003)(199004)(189003)(68736007)(47776003)(36756003)(53416004)(230700001)(31686004)(107886003)(8936002)(25786009)(72206003)(305945005)(478600001)(6512007)(83506002)(6246003)(2950100002)(53936002)(6666003)(106356001)(65826007)(42882006)(97736004)(3846002)(7736002)(64126003)(81166006)(31696002)(81156014)(67846002)(6116002)(16526018)(8676002)(5660300001)(4326008)(2906002)(50466002)(105586002)(65956001)(66066001)(53546010)(65806001)(54906003)(76176011)(110136005)(52116002)(316002)(58126008)(59450400001)(6506006)(6486002)(229853002)(69596002)(2486003)(52146003)(23676004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTA0OzIzOmpZd01talpFRVFqY20vakl2SlFYRW90dUZR?=
 =?utf-8?B?bVZJTytvTXpwRFRFWWllcGoyd2ExNmxZUUE1TU9uYTJGSzFiWUMwOEp6N3J3?=
 =?utf-8?B?bmkwTUs1UkZzMkFQK2tkcFEvYW44c0lTSkNxOUh2M0puaUwyUFVtdjFvSzJj?=
 =?utf-8?B?ZnNtT1JXeTRONzVSUHovdDhEWVFnRHkwRmpuMjF0blFKNC9OUHJDWWs5WVd1?=
 =?utf-8?B?VWxGU3NlOGZXekVWdUV5WlZtQlhvdmxBa1ovSkQzcXUrNm95RWVNTWlTd1Rz?=
 =?utf-8?B?YjVreHE0aUVnbnhvWGRMRURFWFJyWUVKNDZNdXhWZFFUM2hSRkFxY2VqWXd2?=
 =?utf-8?B?d2VpajhiRDRaaXpNbDM1Q2VBWjN6eGxOdktOQ3NiSEFtSFBQQmNsOE9JMSsy?=
 =?utf-8?B?V0FmeW9xdklMRUJYYWJTZ0VvUWpyS1Jxdlc5aGtmSjAwQmIwRUtrRklWNHI3?=
 =?utf-8?B?dythQ0hjSDdvR2s0cG5HdWFPeFhWVnk2T1hJSzRHK1JnR0phT1ZzYnh2bVEw?=
 =?utf-8?B?bFNCd3VURnBmZGY5bmFLbHBRYmFEbGZQT0p4SzhzZVRRUlM3RmVLMGxERzlB?=
 =?utf-8?B?cXc4dUkyVlR6NXQxTERsZzRsdytCNjdETEN4b1RiMlZUU04yb1oxMy9tSkVa?=
 =?utf-8?B?VENIQzlYVmpZc3d0dkN5aEdXKzlkdFk0cGVTalVxQ3hXL2R5TkJvQnR3WlRI?=
 =?utf-8?B?UzM0dDR0andCdEp5UUM4VGFsQVk1enppK3NzQlR1aDUrbXZUbUtmUm5UV3B6?=
 =?utf-8?B?REdySkZ0UWJFS0VMcGVmbmR3alMxOFNYc0ZGSmZOQlpjSFdEQ0ZabzdkZXNQ?=
 =?utf-8?B?ZWE0dHFoZWd6dW9VSjVmYTZoRTJUUEpnNkxEQUN2RUJhZFcvM1g5RHc1L09v?=
 =?utf-8?B?MmFNVDFRVjdaQ2I0VU1DUGdZaVlzdWdJcDFVaGtTNktKQjhYOHZRMExzZG5m?=
 =?utf-8?B?VnFRZEcxeUNiS1RKRk55OS9wQ1FJYnR1RWVFam5YSkpkRU9vOEx4NC9pbjFN?=
 =?utf-8?B?QlY1VkM1N3N3eVFYamxKMkpPTGdvT1Q1WG1PZDFHeGhsZitJTEZVcVJJZm1s?=
 =?utf-8?B?RzRkcmo2STZiQzN6K1NMUDZEc2xxa3lsUnhpV29VQ2tmUW0yZFNKam8rRVgr?=
 =?utf-8?B?S3ZOOTdXeStvQ2NNWGNWMnN1dk9NUHNNRnNPazFCN1RrWGFEd0RnZGVNaDRI?=
 =?utf-8?B?SWxINVo0UC9majI3cXRLRUZPWStwTkFQM0tmOEtoRVkvYVp3ZWhlNGNNUllt?=
 =?utf-8?B?aWYyd3Y2TFM5Z3VvZHdRNHFJOGIwa3dOUUZEVW5TMlhzVXhjamp2M1VmaEJm?=
 =?utf-8?B?QW8wTDZZSzJpSEY1WHBhMXUxOGp0a29UN05MM3ZydGRZVHpVOFgxamZiTjJy?=
 =?utf-8?B?cFpxWHBxMCsvaHB0RFVaNnRRdmN1QTZtcStUaGVYMEV6SnU3L2ZGK0V6Q1lC?=
 =?utf-8?B?OW01djBaK2NhU3FSUzZNMWRaVEJPRWh5czJobWtYbHNzMFRGTUEySlBMNkpw?=
 =?utf-8?B?MDdqekxMNjMveVFQdWZ4SHhOOE10QjJOUlRXUTV4YkpjQ1FxUTMwTjVxaElB?=
 =?utf-8?B?bDJ6MnNtWTU3dHRPNmQvVDhvcUovZTlxQ1RNZnNScHY5WjRYSlB0Sjd0VXlV?=
 =?utf-8?B?VzlERHc2M29HRlg5NXpDYTFkc0hDMUI2cDN2Zjh3R3JKZDRobTE0bFMwamRE?=
 =?utf-8?B?M3phUFMyVGMzQ2FEbmNQNFhiKzlya3ZrTGtCOUdwZEZFSzhIdXVsQVZXeTZH?=
 =?utf-8?B?ZytSaWExTWJTTHlhYnNLS1BWZktEaHNaS1NXYnBoRzBkMnhGaFhadWhWT2xo?=
 =?utf-8?B?TG95V1cva21YdjBvMGZpQjNtVWM0T29BK0RMYWMyeWFvRDhjbDlwcVgvS3Jx?=
 =?utf-8?B?UzdqQ3VDQmROQ2JpRmEzbW8wc2V6cFhnMjU2aG8wOWUzaUlvNWFRUEtqTnA3?=
 =?utf-8?Q?FWg8QkdhKKrrKebCF9UVwwnfMcCaVI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:iIwpG2Yg94QP1PCcIrR48JNETzPorV6dPKRXwzOyOm4r7Gd8D3MsreU8IDq6j+gpnx/9DfsIuvgGRo+zdpMCwpZJnJ8ry4A/aKERpiDOdXsnXn7MVJMQk99k8x6OvbyAqk8HJTEUGaBxeh5XlKpDHrUBVc/Zy5QY4itSJbTfDN6VPZxhOGaNxVZkuI6auovUfDwycavbWPW7o9armj2KXv9EWnckNNdmyXDNs9qV9Ps0nbdufSZNpwsNQRv5QMrNfjKKiunDTT9gO+f+h+yZgkdj5jvdJrMUiuuhQjvOsAC+3Rr1/a/bCwyMlEqj8bVKPFu5SudAYvkZN156b4xOOVUmMieQzTle6NvVIevNDC0=;5:RBGcekyfnntlHB+Cfi7XR/37G4vj+BDliWcDJ+iOXo2LFMaq1F2FqfSX5HhRDftFvwsLmsCaFGKMF43WCwF42xSDOplWGosO2p4GLFsl6vRJZ7pL7+NN9Cu0J5ysavQfqAC4rjwY2tykGjuumo7w0xYgkcjDWsNGiuxeOufTvN8=;24:wNnCR5fCCLn6PF+lEan6675kdOxLiE0waGE5di2zWz4AVhjhRMuh9JlfwIuX4ITV9o6jl3Fjs/uz9cOma9fnyP65MFj2uN1vuL+8SuUNR4U=;7:ZHrgF4j4uie3aC1nqjiWFqpSmCZyA5UPdBwRe6fEznixqhFBNauab0yCuix1L1j1jWM/tQ/ikaYijcro0lk+zLNaHLW8uM4eMU+567zBsCRSo+XrY68EeiXPlrteYyQ5IAcB1FiTJ0tkmNNHDHa4plUXfn2ZmxAY5PV/v2Pb1cjmlCLabQAoiybyKsAWEkUkRwNKpnmYxlH5jbJon0KKA+tZZTrbhB4xwch2kYwJ0ltvQW/L9cPjQpXc8I4BZNjd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2017 01:35:52.2620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5d04e-d159-4306-b34a-08d54100aeb6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61429
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

Hi Ralf and James,

I am getting ready to send out v7 of this set.

An Acked-by, and/or Reviewed-by for this 3/7 and also 5/7 might allow 
the whole thing to be merged via net-next.

Thanks in advance,
David Daney


On 12/07/2017 04:09 PM, David Daney wrote:
> Remove CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE and automatically calculate
> the amount of CVMSEG space needed.
> 
> 1st 128-bytes: Use by IOBDMA
> 2nd 128-bytes: Reserved by kernel for scratch/TLS emulation.
> 3rd 128-bytes: OCTEON-III LMTLINE
> 
> New config variable CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG provisions
> additional lines, defaults to zero.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
> ---
>   arch/mips/cavium-octeon/Kconfig                    | 27 ++++++++++++--------
>   arch/mips/cavium-octeon/setup.c                    | 16 ++++++------
>   .../asm/mach-cavium-octeon/kernel-entry-init.h     | 20 +++++++++------
>   arch/mips/include/asm/mipsregs.h                   |  2 ++
>   arch/mips/include/asm/octeon/octeon.h              |  2 ++
>   arch/mips/include/asm/processor.h                  |  2 +-
>   arch/mips/kernel/octeon_switch.S                   |  2 --
>   arch/mips/mm/tlbex.c                               | 29 ++++++----------------
>   drivers/staging/octeon/ethernet-defines.h          |  2 +-
>   9 files changed, 50 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index 204a1670fd9b..a50d1aa5863b 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -11,21 +11,26 @@ config CAVIUM_CN63XXP1
>   	  non-CN63XXP1 hardware, so it is recommended to select "n"
>   	  unless it is known the workarounds are needed.
>   
> -config CAVIUM_OCTEON_CVMSEG_SIZE
> -	int "Number of L1 cache lines reserved for CVMSEG memory"
> -	range 0 54
> -	default 1
> -	help
> -	  CVMSEG LM is a segment that accesses portions of the dcache as a
> -	  local memory; the larger CVMSEG is, the smaller the cache is.
> -	  This selects the size of CVMSEG LM, which is in cache blocks. The
> -	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
> -	  between zero and 6192 bytes).
> -
>   endif # CPU_CAVIUM_OCTEON
>   
>   if CAVIUM_OCTEON_SOC
>   
> +config CAVIUM_OCTEON_EXTRA_CVMSEG
> +	int "Number of extra L1 cache lines reserved for CVMSEG memory"
> +	range 0 50
> +	default 0
> +	help
> +	  CVMSEG LM is a segment that accesses portions of the dcache
> +	  as a local memory; the larger CVMSEG is, the smaller the
> +	  cache is.  The kernel uses two or three blocks (one for TLB
> +	  exception handlers, one for driver IOBDMA operations, and on
> +	  models that need it, one for LMTDMA operations). This
> +	  selects an optional extra number of CVMSEG lines for use by
> +	  other software.
> +
> +	  Normally no extra lines are required, and this parameter
> +	  should be set to zero.
> +
>   config CAVIUM_OCTEON_LOCK_L2
>   	bool "Lock often used kernel code in the L2"
>   	default "y"
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 99e6a68bc652..51c4d3c3cada 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -68,6 +68,12 @@ extern void pci_console_init(const char *arg);
>   static unsigned long long max_memory = ULLONG_MAX;
>   static unsigned long long reserve_low_mem;
>   
> +/*
> + * modified in hernel-entry-init.h, must have an initial value to keep
> + * it from being clobbered when bss is zeroed.
> + */
> +u32 octeon_cvmseg_lines = 2;
> +
>   DEFINE_SEMAPHORE(octeon_bootbus_sem);
>   EXPORT_SYMBOL(octeon_bootbus_sem);
>   
> @@ -604,11 +610,7 @@ void octeon_user_io_init(void)
>   
>   	/* R/W If set, CVMSEG is available for loads/stores in
>   	 * kernel/debug mode. */
> -#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
>   	cvmmemctl.s.cvmsegenak = 1;
> -#else
> -	cvmmemctl.s.cvmsegenak = 0;
> -#endif
>   	if (OCTEON_IS_OCTEON3()) {
>   		/* Enable LMTDMA */
>   		cvmmemctl.s.lmtena = 1;
> @@ -626,9 +628,9 @@ void octeon_user_io_init(void)
>   
>   	/* Setup of CVMSEG is done in kernel-entry-init.h */
>   	if (smp_processor_id() == 0)
> -		pr_notice("CVMSEG size: %d cache lines (%d bytes)\n",
> -			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
> -			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
> +		pr_notice("CVMSEG size: %u cache lines (%u bytes)\n",
> +			  octeon_cvmseg_lines,
> +			  octeon_cvmseg_lines * 128);
>   
>   	if (octeon_has_feature(OCTEON_FEATURE_FAU)) {
>   		union cvmx_iob_fau_timeout fau_timeout;
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index c38b38ce5a3d..cdcca60978a2 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -26,11 +26,18 @@
>   	# a3 = address of boot descriptor block
>   	.set push
>   	.set arch=octeon
> +	mfc0	v1, CP0_PRID_REG
> +	andi	v1, 0xff00
> +	li	v0, 0x9500		# cn78XX or later
> +	subu	v1, v1, v0
> +	li	t2, 2 + CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG
> +	bltz	v1, 1f
> +	addiu	t2, 1			# t2 has cvmseg_size
> +1:
>   	# Read the cavium mem control register
>   	dmfc0	v0, CP0_CVMMEMCTL_REG
>   	# Clear the lower 6 bits, the CVMSEG size
> -	dins	v0, $0, 0, 6
> -	ori	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
> +	dins	v0, t2, 0, 6
>   	dmtc0	v0, CP0_CVMMEMCTL_REG	# Write the cavium mem control register
>   	dmfc0	v0, CP0_CVMCTL_REG	# Read the cavium control register
>   	# Disable unaligned load/store support but leave HW fixup enabled
> @@ -70,7 +77,7 @@
>   	# Flush dcache after config change
>   	cache	9, 0($0)
>   	# Zero all of CVMSEG to make sure parity is correct
> -	dli	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
> +	move	v0, t2
>   	dsll	v0, 7
>   	beqz	v0, 2f
>   1:	dsubu	v0, 8
> @@ -126,12 +133,7 @@
>   	LONG_L	sp, (t0)
>   	# Set the SP global variable to zero so the master knows we've started
>   	LONG_S	zero, (t0)
> -#ifdef __OCTEON__
> -	syncw
> -	syncw
> -#else
>   	sync
> -#endif
>   	# Jump to the normal Linux SMP entry point
>   	j   smp_bootstrap
>   	nop
> @@ -148,6 +150,8 @@
>   
>   #endif /* CONFIG_SMP */
>   octeon_main_processor:
> +	dla	v0, octeon_cvmseg_lines
> +	sw	t2, 0(v0)
>   	.set pop
>   .endm
>   
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 6b1f1ad0542c..0b588640b65a 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -1126,6 +1126,8 @@
>   #define FPU_CSR_RD	0x3	/* towards -Infinity */
>   
>   
> +#define CAVIUM_OCTEON_SCRATCH_OFFSET (2 * 128 - 16 - 32768)
> +
>   #ifndef __ASSEMBLY__
>   
>   /*
> diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
> index 92a17d67c1fa..f01af2469874 100644
> --- a/arch/mips/include/asm/octeon/octeon.h
> +++ b/arch/mips/include/asm/octeon/octeon.h
> @@ -359,6 +359,8 @@ static inline uint32_t octeon_npi_read32(uint64_t address)
>   
>   extern struct cvmx_bootinfo *octeon_bootinfo;
>   
> +extern u32 octeon_cvmseg_lines;
> +
>   extern uint64_t octeon_bootloader_entry_addr;
>   
>   extern void (*octeon_irq_setup_secondary)(void);
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index af34afbc32d9..1a20f9c5509f 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -216,7 +216,7 @@ struct octeon_cop2_state {
>   	.cp2			= {0,},
>   
>   struct octeon_cvmseg_state {
> -	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE]
> +	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG + 3]
>   			    [cpu_dcache_line_size() / sizeof(unsigned long)];
>   };
>   
> diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
> index e42113fe2762..4f56902d5ee7 100644
> --- a/arch/mips/kernel/octeon_switch.S
> +++ b/arch/mips/kernel/octeon_switch.S
> @@ -29,7 +29,6 @@
>   	cpu_save_nonscratch a0
>   	LONG_S	ra, THREAD_REG31(a0)
>   
> -#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
>   	/* Check if we need to store CVMSEG state */
>   	dmfc0	t0, $11,7	/* CvmMemCtl */
>   	bbit0	t0, 6, 3f	/* Is user access enabled? */
> @@ -58,7 +57,6 @@
>   	dmfc0	t0, $11,7	/* CvmMemCtl */
>   	xori	t0, t0, 0x40	/* Bit 6 is CVMSEG user enable */
>   	dmtc0	t0, $11,7	/* CvmMemCtl */
> -#endif
>   3:
>   
>   #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 79b9f2ad3ff5..3d3dfba465ae 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -115,33 +115,17 @@ static int use_lwx_insns(void)
>   		return 0;
>   	}
>   }
> -#if defined(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE) && \
> -    CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
> -static bool scratchpad_available(void)
> -{
> -	return true;
> -}
> -static int scratchpad_offset(int i)
> -{
> -	/*
> -	 * CVMSEG starts at address -32768 and extends for
> -	 * CAVIUM_OCTEON_CVMSEG_SIZE 128 byte cache lines.
> -	 */
> -	i += 1; /* Kernel use starts at the top and works down. */
> -	return CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128 - (8 * i) - 32768;
> -}
> -#else
> -static bool scratchpad_available(void)
> -{
> -	return false;
> -}
> +
>   static int scratchpad_offset(int i)
>   {
> +	if (IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON))
> +		return (CAVIUM_OCTEON_SCRATCH_OFFSET - (8 * i));
> +
>   	BUG();
>   	/* Really unreachable, but evidently some GCC want this. */
>   	return 0;
>   }
> -#endif
> +
>   /*
>    * Found by experiment: At least some revisions of the 4kc throw under
>    * some circumstances a machine check exception, triggered by invalid
> @@ -1302,7 +1286,8 @@ static void build_r4000_tlb_refill_handler(void)
>   	memset(relocs, 0, sizeof(relocs));
>   	memset(final_handler, 0, sizeof(final_handler));
>   
> -	if (IS_ENABLED(CONFIG_64BIT) && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
> +	if (IS_ENABLED(CONFIG_64BIT) && use_bbit_insns() &&
> +	   (scratch_reg >= 0 || IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON))) {
>   		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
>   							  scratch_reg);
>   		vmalloc_mode = refill_scratch;
> diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
> index 07bd2b87f6a0..e898df25b87f 100644
> --- a/drivers/staging/octeon/ethernet-defines.h
> +++ b/drivers/staging/octeon/ethernet-defines.h
> @@ -32,7 +32,7 @@
>   #define REUSE_SKBUFFS_WITHOUT_FREE  1
>   #endif
>   
> -#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
> +#define USE_ASYNC_IOBDMA	1
>   
>   /* Maximum number of SKBs to try to free per xmit packet. */
>   #define MAX_OUT_QUEUE_DEPTH 1000
> 
