Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 19:47:06 +0100 (CET)
Received: from mail-dm3nam03on0086.outbound.protection.outlook.com ([104.47.41.86]:12736
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991957AbcLISq6o3u7u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2016 19:46:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=c1t35L1Ch4rF5+YVgsxaFDWoMblQaA3l3FpE5oaH34c=;
 b=DqPAZzy9UqInLdASDmhgZME29CZVUGpcQ3et5RrkzvBbRQcRC0ASiH1PmrH+0uhS5rG+jE+59JKNvgERv6AHhj6kzAGkCKW6QkV85TIMK4tJq8udto8kdlkGXUQQQ7GtdLRn3SeztXtIQl4QEhrxC+mpzC+rN4lT6kGH5G1mpzw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2135.namprd07.prod.outlook.com (10.164.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.761.9; Fri, 9 Dec 2016 18:46:47 +0000
Subject: Re: [PATCH] MIPS: OCTEON: Enable KASLR
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
References: <4bc97883-39b4-1a00-6e06-518c598bbf3c@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <bb09e7fa-d13d-979d-8496-83006014cedc@caviumnetworks.com>
Date:   Fri, 9 Dec 2016 10:46:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <4bc97883-39b4-1a00-6e06-518c598bbf3c@cavium.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR07CA0007.namprd07.prod.outlook.com (10.162.170.145) To
 CY1PR07MB2135.namprd07.prod.outlook.com (10.164.112.13)
X-MS-Office365-Filtering-Correlation-Id: e33781ba-67f8-4c5a-97df-08d42063bacd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR07MB2135;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;3:iPxF1KQu7RZUxrJ7U41n3NxJQPJMFO+bJpf8T5oNulbwtPqR4cCwMs3sWUQSOzIG7bQjauGx0PBi9fcK816M95B/LpXOHOVDpDS6ivbjp+4uxSTmrI01YJr2LI7VltupP7MddAcHBHMYlBYdwPDSFu/D0itynQi7BlHOC9M5C/dM8b3tQFXY8aZW4xzrQlrPqojz/v9VUun7Sdss64NUT0V4uNBVh0K5sL55Z8kSL6q3gizDLJoQpmxxwu5B+stKtL9a4tZQK2/ZfQDPO5HI5w==;25:4hiYYp0c0W1Nb47bPlL4nQx9GfQfRoFH0i1Z/zIiePS3K4kZ39Z4dwqwSxirLQgPlAT3XuBnzOz6CsX+x75umMYUllHPwtJXy7irVREh7+kbethD/vrsebq1yMA+LHFkL4BUZxCllichRV+bLNW794CxRoffJyekUA7d7fconI2kjW1svASI6nWw0/lymi3KbWQ9g2OFpJYhspHPF3eIMiu8aZUeyE/l3pZmHyM+GruoS1z/stnot86iuLjB/E/cMriuaRj/6jjPsyTfDLnJmDWR5hcWTvEXEi9Z/qwy7vifi8kt7FCkn7k0R1Eeh5BkzHMt5aURT/P6I27B9D8OwySb/cCv0nCr9hbcPxcAQkcQMvUezaG9WCfp36semZyqO9+cWzBad72KxnYOfx8/BouMUQ5Q61TxIjiUQMKVD9zr3aaetyNZwQxyaL4h1L2cS2kxabPNT9zrpO2OR4ETGA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;31:Ze5jzmI78PbL6Rsgp2HBOo+E+oQ9IzaLHsqzlvFhyeMa+Jk9UrT8xz0k0ODlm50THHwXk0YwAJecYWyM2jB9QsVmnbAdoieQXWHDCxTlnXV7+R6a9wobsbj7In3d4+K05ntSEEdsSMLBZKYQPyM0KoZk+Pb9tsAbd8spIFD1ckHhclhimDIsQLZKuJ/L5jZtakuRPb0+b3viM4T+GFRfq//Gz/uZl9m/kgmtzt4l5vIioP8sIzPGkQ9A9/iXGd37;20:nnW9gildyGoPjBFpEcPIt4CmYRwk6rwkITTlDRV9+pnaHchx7uemxtqj64VQzgbQVovEPsKG6pRPSpLaC2O8mMYHUcINYJEOVhAuu0iVYW5jJFe1iOJkP6dU9jW9RVtSxaNHwUV2M64yU+0lmZLfvf0MvaW4SyZscEMrmSAhcf1+KSLU/q4+ItLXlQDI9SYSJT8L2Juk3V1tcqX1DXWYj5iP7mtZ0gdOoUx6vCmjJvFPqNlnJ0Rlg06nJOlDS5zoRmMtqPTGhUICaR7GdqNfgn4KsMC9YRMJXzR7FHh0h8JxjyUNq2gCSkpYnA5Z1AYBDfgJynqwY1S79Bk7XJv+BA4REpNQbIR0c8XwXoe50FjuaR2NYVU2I/rc2uq5J1gIi75y7HzzzJcDtVUwXPBQxU7+IohEjMhSL02QbZxd40jcTIxfQfNFdyloKqdJvKNCiTcKEOFObLpbljM0CqeIQcqzjkHMRK8YkUI0AMz6KOgBkJd/p/cfrgmJIkrkDlT4KjqMr7SyEYmYS7/HlJ44W1eDsNzSKLFoV73Rz3OiU1nrkGBfIfzEL5vJskKeia2g7rnPOWUQfOXUkyNu4D06oB/znOEDD5bH/pb5E/r3PDk=
X-Microsoft-Antispam-PRVS: <CY1PR07MB21354601BE4C31B2ACAB858197870@CY1PR07MB2135.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:CY1PR07MB2135;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2135;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;4:9GgBf4nF17zSQf/psOJ2Yn7CIOX+8BYjvYBK0d8z4NGFLp/PwlOUuS/k17Bm+iUpWq43FwdsjQLy3R8wZ6UxFNXq/2W4UIO1f2R86yF8onnSm6VwWdgite1nNnRrp2IqIWI0RlK6m+NIAvbHwS0qcqmNFw1hhMbHIq1ArqBDSf7+s23IoTyCm60yxpLFFrNXuuFU0yZMTfpx7lcs3zsEjeXEyYSbn80p2Byn+QbjpIxRXMstvvR7cIeIJKvmxF7l90ydTgm0gEYeoVMGLWzINg3Ahz0SMJvmXsEQlR+3o4KtB8G0Zim2H8ngwGkJxuvMqfxHCkoHf9JPUK1WTJtaFzAlEa6VHU5WNw/qMBz39Grca7EnMuXANsJqQtrEG1F5Xlv0JWCBNGq02IaZx3KlpJj2qJ0MiwpBYqlf8NmyMGnGlau7gMKX/QSqJM1CFwzr3FuJJGHnyinHZjFm2Ma1P2cNtwFLUydUxAIFd+vRSg8SeX+1YCeYhpzuCUcwqmhGIkFNPGa/vJxnkDBUP29aaPQqHA17UUBF1vRbe32gB8Q5/7pZ3/SrdBSfJjtUco/F
X-Forefront-PRVS: 015114592F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39850400002)(39410400002)(39840400002)(39450400003)(24454002)(199003)(377454003)(189002)(42186005)(101416001)(33646002)(2950100002)(305945005)(5660300001)(65826007)(36756003)(54356999)(50466002)(7736002)(42882006)(53416004)(8676002)(68736007)(81166006)(6506006)(6486002)(76176999)(229853002)(50986999)(23676002)(31686004)(6512006)(81156014)(64126003)(66066001)(65956001)(107886002)(230700001)(65806001)(105586002)(189998001)(5001770100001)(4001350100001)(97736004)(92566002)(6666003)(2201001)(2906002)(106356001)(3846002)(47776003)(6116002)(69596002)(31696002)(83506001)(38730400001)(450100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2135;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3TUIyMTM1OzIzOmV4YWdTQjdYbnZkWVBvQUM4bUZrL2F4Vjg0?=
 =?utf-8?B?NnhlZGxDRnNucllIUzdKSVVyVmQ3QW96aDIzYXNuaWdUeEZXQ0RFME90aGJu?=
 =?utf-8?B?UjZaWXNHL0R2UzhNb0NkMXZVbGRncHNtRFJuK3VnckQwSlVsQUxvdlRialNk?=
 =?utf-8?B?MEJPc1p4MDdQejcvK3FKVDdHNU5DNlpucW13WmlocnlzOUp0V2VDdEc0UllI?=
 =?utf-8?B?Y2VTSy9ZcGppU0xtM2ZUMm82d3V3Y2NEUjJUYUlhNnZIejdCNWZUSS90Y21C?=
 =?utf-8?B?a2pSOENqRyszVmE4THJydkVpTWZDZUlXd1VkSDJ2N1pNTmtWVVhWZHE0blky?=
 =?utf-8?B?clJyYU95UFRucUptV2xJWHh1emtpS2c2d0tNRUZwb1pRT1IrZXR5TmhVZ2lZ?=
 =?utf-8?B?b1YvL3FodXZBdmtmSFM2TXBlR0trbTIzcS93YSsvcGg0aVUyRldyQlIrUFVE?=
 =?utf-8?B?bWUra01mQW1nRFpmRkkvYlgram1TME0xNnVMNXFiTS9BZ3FqaDYydWdERU42?=
 =?utf-8?B?cm8vTDUzTWdJY1hWNG9tQlFjRlNaK0c4Znp0dzJZaFRsdnJUQngwLzNacXd2?=
 =?utf-8?B?dWIwVUp4c2tTRVl1bjRhekdsQ1NPVlM3SFE4YmVRS1UxRVBPdExYSTlQdHBx?=
 =?utf-8?B?ekdINGhyYjNESXh4TzA5NzNDN1FZS1ZYbW9jMHdHbURuUDZ2Ynh2K2FlQ1JE?=
 =?utf-8?B?ZDNMdzlPaU1Ib1loR2RkRDlraGNYKzcraFZRKy9jeU5hTkpZdE5xbWR5cFBv?=
 =?utf-8?B?bVBkanBtMk9NQ1RKOXVsVWtpNTI2UWJkcHVMVWlNa1QxNUdWbFpmR0lHWncr?=
 =?utf-8?B?M3hYL1FTR0lNZWp1cXhGZXJMN3NnT213OG9FUk5xZjJ4K01VZG1nTVBrRnVl?=
 =?utf-8?B?MjdQbGQ0RmF4dXRkRS9FQllZSy8vcUtxMnJnZFB0czl1UnFVVCs3MlNJUktZ?=
 =?utf-8?B?TDIrM3FRNHJsM2poK1pZQjNFTFJRemNibmxyYnNzRjNPcHQ3bEpQREwrakpi?=
 =?utf-8?B?ZXhOcTQvcHZ2bk9jaStaM1QvcmdyVzdPdWx1YWc3eFE1V0xHUnN0cGVFMjFp?=
 =?utf-8?B?K0l3bUZneXVVRVN3VjVaSmdHaTk2ZGNvYkRoU0hPYkZEbkJKNEpKN0hTT0NB?=
 =?utf-8?B?emFPRHo1WDBJdGJ4T3U5OEZCWnEyVlVQeG1CRTBibVp3MkZWNElLWGdNaFMr?=
 =?utf-8?B?VEJpTHJRQmlvbGxQRlBicWVVMCtHWU9vUVJMNEM2VGV4ZXV2dTFoVWpnR3hw?=
 =?utf-8?B?YTRNaXA3cnJvWjdjT2J1L3RMenFQRkFuRHBTNGVzTE5Ca0Z6QUlDQm9jcm9v?=
 =?utf-8?B?M3hIdWNHZElIRU5sZFM0WHdpbWVtOFAxOVpVdGNJUVlkYWRkYldETXo4cnpH?=
 =?utf-8?B?dHFlRUN6cWxSY2gxQk1PU0RLb0VrM0VzamV4VEhrWkFmRVlaMndEcVJhdVNC?=
 =?utf-8?B?T3pVeHEybUp3RUQvY0paTlorTkl1NzF5Y0U4elRSelBjaDhqaVdmZFZNSjQw?=
 =?utf-8?B?V0FHaEZwRVF2bTd5SUI0MjJLRU9vRXRVclJuUXVBdXQ2bXVlbHFXRDRIOVlH?=
 =?utf-8?B?a3dIWWdRQjk0andCZGdnVk02bDlZQVpETjgxaTRmazBzVjM0Z0s3K29xcURN?=
 =?utf-8?B?UjYzNHY4N2R5TE5TLzdqQXhwb01LTmE5SDZoN1krUThHd0U2OGZ6SlZnWUk1?=
 =?utf-8?B?cDFRbGdqUWFUcjVVQW94ZE5ZZkRZZWdNTmR1WUYzQ3Z5dFlBMlVQc3B1enRJ?=
 =?utf-8?B?L3N0akxxYTZhNkE1UXZScVdMUjN6OFNiVlhhdzV6OVBjSEo4UHRUZ2xDY1NB?=
 =?utf-8?B?MTZYUFZFbG5WQ0NGRzEyZm01ckZEUFFxZS8wOVNKWTZ0cU4rMGI1eDlyUnF0?=
 =?utf-8?B?ZDk0RWdwTXNwVVJ6blVmcSt0Y2FZaklwOWhhK2l5d2c1YlFxQUZaQjhuSnll?=
 =?utf-8?B?NGJrN0NCc0FvNmIzWWtwQ3FUUHlYdE14Q1BoYmZ0eTdKMFpZUUM1R0dsK0pJ?=
 =?utf-8?Q?0mcIgs?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;6:dgFZklNR89B8DYizp36QivtK2EfzR3BBtJ5o25vE3gxXPBfqom35kNOFL5O9rSm6FHqCSi3vj4uHXcEPcwawmbMoQlcMJ2OOkKFgm9Nx/1yyd+XsekIY+A7TIGATZ5KJdztKglJvAUoNpTdehuKv1o7OmRuSFfhKlwUjh8KUv5oYSx77FjulVGfQ5IDthWKxsWityA1DUMcgeGfbcWoWiTLfWIUl3jx6fBTxMbVSXiVsE2nxhWi9WSWy3DWq3fvdfqKActCgkArhOh7HhX+G/c/MbnieDLUrq1jqjcCElihaRZr4Bky/nK8CGoAI3RER0FaLlrdxG3XkAm4oHJPhVP58NL7ZS4cGcO9MTQCfyOe3tdREZBoVdZ8MT02sf036r4oV13Q9drHPOlj4627DvQGc2IiuQAXBF43VfhOGRaA=;5:L8q7Gknfnd4VkpvupLcnHjFIk6dTVJ1PTSsve++v2nM/PkAJQinoeNU17KqZ48hztycE4A6w6FRzPOcrX1AK+Xvp4I9x6GAmEA5pvXoDalQyduHl2LuiAgMXp8/G+oQ6iQRbwcojbv5tC7CZ33RcYg==;24:2aBnPrpE74ucUhe0yUrmFNenocgyTJshvUscvgI6PckSobcPA/vMX28vQ5SpiOaol/bYJJnt35rZ+h5vTBSxquiuPpXGZXTQXreEhBTtDhQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2135;7:sjCrztiZ+JtmA7exeFRteQdoBVklfwydHtOlcQhQ/UsNgJIMLVc99fXcdDtBOX1cw5fipyYtAdnRf5cevqwhLmw0vLZEieEEeYCMw9xXQpY4FW8vLIgjR5NjFfy2daUqn2yJ6tsdIQe+Q5X19jBT3V/pyjOIK4zcVfpk2ev70ZqDl2K/UXpkQWEP+ncbWtk0LJtncFCx4AgSmf/2qrb9YLwRwmsDObQvbpRaTbDJon8Vv54EmamV7L/rze0ZKEzra9x4zj8qlS+CFL/uJkEZFPSFT2WZ/U+iFlfcwFAG8jiWl+z5OLKg14OQn19uC7NOoWxAZLG7fmVvLFX8dvi0o0B68bYSSNWs3R/I8rL+7J2tnDCTxuqBtiyGJjzEHuWJmzyNw+euTYhMPxdwGom/6oZxWp59Tvka0mP4cFvYmdaDI+8SYY3GNrPfUSNShRx4jIgXtN4bBR9P7acrfN/wCQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2016 18:46:47.0576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2135
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55989
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

On 12/09/2016 01:35 AM, Steven J. Hill wrote:
> This patch enables KASLR for OCTEON systems. The SMP startup code is
> such that the secondaries monitor the volatile variable
> 'octeon_processor_relocated_kernel_entry' for any non-zero value.
> The 'plat_post_relocation hook' is used to set that value to the
> kernel entry point of the relocated kernel. The secondary CPUs will
> then jumps to the new kernel, perform their initialization again
> and begin waiting for the boot CPU to start them via the relocated
> loop 'octeon_spin_wait_boot'. Inspired by Steven's code from Cavium.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>  arch/mips/Kconfig                                         |  3 ++-
>  arch/mips/cavium-octeon/smp.c                             |  7 +++++--
>  .../include/asm/mach-cavium-octeon/kernel-entry-init.h    | 15 ++++++++++++++-
>  3 files changed, 21 insertions(+), 4 deletions(-)
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
> index 256fe6f..65c8369 100644
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
> @@ -333,8 +338,6 @@ void play_dead(void)
>  		;
>  }
>
> -extern void kernel_entry(unsigned long arg1, ...);
> -
>  static void start_after_reset(void)
>  {
>  	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> index c4873e8..f69611c 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
> @@ -99,9 +99,22 @@
>  	# to begin
>  	#
>
> +octeon_spin_wait_boot:
> +#ifdef CONFIG_RELOCATABLE
> +	PTR_LA	t0, octeon_processor_relocated_kernel_entry
> +	LONG_L	t0, (t0)
> +	beq	zero, t0, 1f
> +

This doesn't look correct.

Please explain how this code implements:

    loop here until octeon_processor_relocated_kernel_entry is set.



> +	/* If kernel has been relocated, jump to it's new entry point */
> +	move	a0, zero
> +	move	a1, zero
> +	move	a2, zero

Why change the values of a*?  Don't these registers already contain the 
proper values from the bootloader?

> +	jr	t0
> +1:
> +#endif /* CONFIG_RELOCATABLE */
> +
>  	# This is the variable where the next core to boot os stored
>  	PTR_LA	t0, octeon_processor_boot
> -octeon_spin_wait_boot:
>  	# Get the core id of the next to be booted
>  	LONG_L	t1, (t0)
>  	# Keep looping if it isn't me
>
