Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 21:06:04 +0100 (CET)
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:46528
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990644AbcLIUF5PPRBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2016 21:05:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+cj/OktdiKsD6SEAtrgQ3MNgpkdJTn6MEC5kTbf6N6A=;
 b=O5YmQAeAoLy3KEVf80WU3iHkDdKP24nLiPD5UA3Ulw3xnnolKfCkrAlnym57UReQMyIUbVFzNjDOFUf5kJZaJ0+z/ji6s08KnmaeaxnzCxkD/4Cj1r4GvE+gz33UiBfb+Gb3xaNtoBjXj72HdcF6sKJtG5fWM3h3x73qFP8OIiw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3207.namprd07.prod.outlook.com (10.172.115.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.761.9; Fri, 9 Dec 2016 20:05:44 +0000
Subject: [PATCH v2] MIPS: OCTEON: Enable KASLR
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <accb5b67-2a15-21bb-ed81-3bd463b5ff04@cavium.com>
Date:   Fri, 9 Dec 2016 14:05:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CY1PR0201CA0014.namprd02.prod.outlook.com (10.163.30.152)
 To CY4PR07MB3207.namprd07.prod.outlook.com (10.172.115.149)
X-MS-Office365-Filtering-Correlation-Id: 7ef30a91-ef59-4e9b-098e-08d4206ec286
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3207;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;3:HRxN8czugimPw6Vkro8FzOH4w2jmDziFhNIlM6QdHyA8RBwHkhJnRhdLeBH2Qf+RNHTOkxQRP89mH8cBqORj7XBATXhczCc7fkCZkr0CWGAl1Wgyu2ggwx6I99gslOm/WcAQapuL9vgh4LIhJmDtxQnyTSdrdQol/5d7gMExX0nxa3ramYQrLccj4gRA6yDeCa3hOMrpjZjdAWfU1XHT5CjqlVp7Gx7lhb8dWLAAipNkKI2IFIM7IbODTOo3148qvn4PM1b497NY58ECULilVA==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;25:9cU8TIgq6NeTFJhfbIPoa1aWPhdO2M2EylLcJkAhHhicOAADXEBQOY8SNv09mORPYS5NeWq8LgdXTQYkGCF4KcUNG6w7xydMmrt5QmTzLk47NnorF7Xb/d7Hjg6LZVvQCml5ew9BVD7+y52QqFjjoNk3e4EpNkJbr79LIEhKRZ9yS856IaSj2jPZVHwMzkNCjkghVZVKwm5YiL1ldUC8I7eW3K1BwphCUy5xrDbfItc3wZ4HdAlK3Q2A5pec6+IWPsY0Py0QuVYUbdpgBOK8WAHu76k17bdphpN88gx0IZSTC7VHlQnciq0zleBEQgc1Az1S08sPRZ/OCl9dKJXFp75bazjIE5rWwaC1UeZ2xyFL4NryuFQMuCW0OvL5alQAvAoxaGWPUncHhl4N7/H2NeqQXmUaH4/bQfyde7Tx+8k4DGLtR9ft3FuF66yvBLOE/Yk7CxIp1+wP613JcWHeTVWE/xn186UDqIHz1O10p+BDMa3UQowjBR7wV/secfm6LYQDM8y3rjZ/HlM4Rw+aq7FTShxrIxt67dwwJxoOfQmbs0mvgutzzEebEecAgqYy3jJgzhJ88zhW4JUk5MYqv5Zf7b65SDzErauTVrabjMhv6jQGAvGHpQdpqSGmTLtFUI72gNqCVbO59QrZwBiheE6Aj00EQ/9VcWTf88VyBJboWJYcAZTvpgde9F3OORaYzM52sbTEC7VaCkF8ktrV0v19oQRe2iQ9AJIcQ53u6L+0xYnR7QX3f3/xtc0K9yUg
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;31:z/tI5zy94916tP8EQM8PTVY44P2ci4eCGHpw/a8lUW4lYim577t2lgH1ZGYpecfnxGaXWxB4MDiic4vEbcSYX7aeVVEJtk5zhOSgVhsFfC3SyRRM4FW8iswY4gF/1GNG0WpX7Ubcz8/IVrSLv7HYug5F7DEnnVtyvdI0jxpgzvrJrUDbaej6nE3L4dkMBq0ndJLNiVkGmZs9fIn+uf8xpL/RB4n/UXh62Im4aZJpWtwD83I1CVrsga6aW7YsmE7thprwahSEb0tTCMyIE+yygA==;20:gthaG/1p3zQpqrW6ojFal+ffuco5W3fICmzqKhMbquIy8iQ+1AU9KWHzKaCUEWJM9iycuuDRWH9osRTpwmail4Hr+lNQefI5mfV/vUps52fSEG217J6zG1kB1jyYmXGpI9k0vF71BfpAGu0knUXD2fM5Yi5f/N5E5C8E6p+d6RvOaoRLDfhTaeArHYRUjC9a1FhkLOSd+XcxRU78A1yw88nENwFdpjH1QZxme96ANyV/eeHmlnwp+/U9HrtNz7CM19SoS3zcUINSlfPbpcFM6slIgB20eFb003oH2/D45Vds/rp2IAjx5b3Nksi/IxXTWT/00ieyD9KYtBOZaeBMlcDgj3IqOPejHsxwfxXWWDLztiX/OohQpVbbOBOQI1EbMrOviqgo/gyN4EeSoANmc8OJ13JBeTzW81sntbn5bZocpnJ6ZsdYPc5e08LG5mhQbtT4DXyAa633I0qo7kAcEig+o2k4N4oeEjjcxBG6sFqBJlfIY+8h9ZMAH87fr+HX
X-Microsoft-Antispam-PRVS: <CY4PR07MB3207A731F80BD136FE3AF61B80870@CY4PR07MB3207.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558021)(6072148);SRVR:CY4PR07MB3207;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3207;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;4:IC1OmwiWAqgGGDjFUEw3gMTvE19T5XLcbHNy6eq/ozYdugPBbfEAgxCHTp38BEmRNMsYCx6r3hxa0DovYSgMWhqkjSeWztk9t+dZ8eq39j3l+WcsP8vz87SJ4eGnlwRyk5c7dFXplM/WzLft1pRvYaVgQ4wZxAV835zyikZbPsyzp9l/Mi7barE8Sf2TzVm47kqH0KNe6XPbfJzVUrJN+g3BgjULhBShfJanMgGDhmLMXApc14+lPmWKXHGIwcdMP54lAO8g+6g56+3DDFuT9oT4GCvzfhKekvUIihxG6Iwo72ZFR/CUXuCLjXjNWUVsX8/yfcuf8Q1Lsv3P3mEd0DepTgfdmlYOD9LUzqQEWv8AfAgajMuVn/Ad4lK95SWIeXGAk6bKE9oOwZU/8l9HNC3c6QsQNPmen0VEFb5Umb7CccXZiXdPTVos+o6oOGVSxWsTZvsw/mhHRbfI9LFl8PuuVc75AP8lQfflhpkY1Simc1PrdC9BeSM0ddE7Sg4pHHuiEZ8/jPex/8dwuo6t1bAOThqpFMSahp6inyP+OvwnwYBviw6ZqpoATlwBWVGDCUwgE5qPYeamN8AyIB97WqJEDpoH6te6aCXZ1qH/T8s=
X-Forefront-PRVS: 015114592F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(39450400003)(39850400002)(39410400002)(39840400002)(189002)(199003)(110136003)(6916009)(90366009)(6666003)(92566002)(97736004)(66066001)(6486002)(65826007)(83506001)(189998001)(230700001)(31686004)(38730400001)(42186005)(77096006)(31696002)(33646002)(4001350100001)(86362001)(5660300001)(23676002)(36756003)(81156014)(81166006)(4326007)(68736007)(3846002)(54356999)(64126003)(101416001)(8676002)(2906002)(65806001)(2351001)(50466002)(105586002)(450100001)(106356001)(305945005)(65956001)(7736002)(50986999)(6116002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3207;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA3OzIzOjVkSFplUWpZZzVHbUExSWJMWTA5MEozRzR1?=
 =?utf-8?B?L1FwVVU2b2wrdXozdnNVWW5qWUI3SUpDNDJ3STZHSDE0UmErWUdXc2tQeDU2?=
 =?utf-8?B?aWV5SXRzVVB1S25kZG9IdjZFdzFabzZJS1ZrR215UmoyaTc1UEpycXRmR25O?=
 =?utf-8?B?d3pXUFIrbWRSalBJS1hQVGRiTHVCR1cxdW1TeFVJVHF5TEJ0dGdncDdDT3NQ?=
 =?utf-8?B?b3g2cVR4M3pTVTFFVDJUQlIxWTJ5VVJXTzNTb2tIV0wrYTF3bkRyRHgvQ2t3?=
 =?utf-8?B?SkNQNndoNjYvTUErR01lSWVxa3Iyb3NSZ2s3K0hPb0pKSGt2c240MnF6VnVU?=
 =?utf-8?B?VHpWTmtzcENndWxVZWs2c2kzQzdkQkw0bVUzNkkzZ2hBMVF0ald2akdqc2JT?=
 =?utf-8?B?N2NkeFpjWFNHK1NPajRKbXdtd0dKNmhIZ0hNNE9BbzB1c2dTOFBYcGtBK2w4?=
 =?utf-8?B?LzYxbUsyM0ZDVVNlcXNDdklRY1lNWCtBT2xXUkNBYzZhQmNwWXVlbElLUWtB?=
 =?utf-8?B?S1p2WCtraEtpWWpRUFJlYWk1dXpwemZsSXlVVmFObnJxS3ljVW5Ibnl5RW5K?=
 =?utf-8?B?TDRSWEdnZmswaXhsdWNsMFBlWktxamk3ODI1Y3RsbmYzM0RCTVRuaURlaEhC?=
 =?utf-8?B?RzFvYlJSNThXaGZra2RMeWNxem1RZng5R1htR1J0aDRFUXYrSlBuWE5BMjlZ?=
 =?utf-8?B?L016bUJNYm1kVG9pNWc4cE5ZZlgrNkF5bjFZSDNVblVYcXhJdzJub2NLS1pw?=
 =?utf-8?B?a3N2VTRoNCswRGd0T2MrNUM0dlJwVkpuRFJFRWU2SzhCVlhUODhRWVpaZmQ4?=
 =?utf-8?B?MjlNczBPb25CQzNlQlFQTEhqbTF4cXJvRHpHM1FwdG5VSWFGcmxnY2ZIeWtR?=
 =?utf-8?B?aXozaUNJYnZINkZsbFFOT0pnaWFyT1E3V0pld1RYc0RiWitvK1BjUGlCcEU0?=
 =?utf-8?B?eTdrVGMvRXRzcHcwU1lDd3FlY2FaNUQ5MGJ6S0gvYk5STWluQ1dGQ1A2ZEtB?=
 =?utf-8?B?anl2TDFKczh4WHNIYlhjcm0rMDdMUkl5a3dua3JuLy9iUE5mcVhwMS9qdVJB?=
 =?utf-8?B?VXBiMWtFNW5QV3NSR3ZrM1V6MnNlNHIrbytqTlVCdUpNMytaOE1WQ2hQTEg3?=
 =?utf-8?B?RnhVUlZicGU1dkQrb3ZHbUhhY2wwM285K1dtNm9wTU81cVkvUU9TRVdQempL?=
 =?utf-8?B?OWJCUGdkTCt3RnVXQmxxNWJocmk3MHg4N1B3QmRGcElOVkZ2MGtaaHRvKzVM?=
 =?utf-8?B?U09nWUp3WmR1MW9hSHZ4WE5qVDlLVzk4Qlc3VVFmTnkzRWJCc1dPdE53NHVW?=
 =?utf-8?B?cTBNTHlJeXFzTWkwRUFnRVBCT3VUV3FqVXR1YituVjNLTXJ0Zko1WDYwa1JG?=
 =?utf-8?B?L1RvUnRld3hCWmp1RDlxZHIyYkpDZkNZOXJwS2FNbTlMZDByMytBTFRNeGth?=
 =?utf-8?B?Y3ovT0xPMFlEVnFXSm5DaC9haWtoRnB0RDQrWW45ajRZdHZYL1Nyb0tUcFJu?=
 =?utf-8?B?dzJMV3M2RzdreFppUWNkTWM5Uzc0cGNnT2p1UnVMQkRoQlVvTCtHd3B1OFBm?=
 =?utf-8?B?ZGpKVUJPdTZkaGljdk5tUWpaOTBQYWFZTkVaalNpZ1RZbW5LUzE4eUdyc0Zx?=
 =?utf-8?B?WllsRXBscURTZWFsVXZkc29MOHNwOE16TGNWNWZZN0JtRVZ4cTVnS0VtcHpM?=
 =?utf-8?B?Rko2SVpHSDMyZURPbG5TNWRBb3EwVGRmTHRranQxSFpROW1YL0tnaEZpZFZT?=
 =?utf-8?B?T2RTOENWYlJyMzl2Q2p2ci9naHVhN1ZyY01pTU13SVloa09FRmFoTm0xLzRu?=
 =?utf-8?Q?Me8bAts0CuUFg?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;6:MgOcWPW72HhdXexgkvqPm8CnrVuGfBK9GqZckP6q354xIJCrWt+zV+KahhbdLZk1LAe0FbpQrjJV0G0F+iJKUhu996JOaNGjqKG+snGwQnpWiQiR6fGuc9X+OHE0IrF57kRlB7kVagGg/bfTTBuOFUzY9Ub0521DYI52uf5Y8FI11k2rNiHWCh5/bMx5Gqsec05kXrF1aWuLoiX/pnd2dHZGzMEgugUhWmq+x2EZxNliwM8GW2/bhdWldDxMfSZC8P3MvVg2tXKcLEd5eed8SX9qfP6oAA6le9gg5QvzR1pFHxMUpDsy6w9wI8a6oWk4c9CwNbi/Y/k/QKdNQJY7OrSSLCMIjtpBjbAxPDRCDhcYlUFtSwY8weksaPE43UpIR6lRPfluYBcUo3BzXgei+0njRs3of8GCHh0qDaQHb04=;5:J2qBD3l6FzWOIkbZmCKAEmOAX4rTCceMi6wkT7NTFr9CTXZzTJAOmUINbGVqeAYVvGo4gQoS+AS9unWS1WgdbP3WKf7at4C7jEaolA2eSo7aKlKuPTUj6htjQnTqeLw3ansAC0raxu9CAINIJ9hMm8rfvRl3dYQ1T4cbNFo1Ggc=;24:4E+Hk3HDpUmWmJbA8ANF3m0+Wxxpwtkp8Gw6z4HkHCV1XyeaIkXkeCdjIHKTw0rL+W9kCTdyUoht9VYQwtL0RmAcZoV0IVUJFXgISc0yuA4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;7:5F9n0pQhEzRBIGcb5y2PKsnuBM+h8MurmgmNGAh0idDW9SQhONKeQkweFgbVreCz8oS0u7lZ55JkIqWLoT8NJqCskRKaJnczb0H+IK3/EcwU7CQKrHkptE0y301ZHp5sFWE0gEj8s9JkKxv75pyBjJ2cjklqIJuTzZA7NJwU91OdPV0hUxuktCutpq0txK6ayGiOaliuuCEZA2vfjI+NRC53vd9LY+lNhGxjJX1jSAT7sYkCkVkgyBbrr26/qkyWR8yevhc4QmxJWy+6XxEgNTTtyrjqhWe5o5cGurKweQtzi7S+A7EBi7wou24yZ84N1m03ilf4Opqzjeyokjn/CaAF3iAwcMPJmF8nsH3CNyruX1Ji+VYEf8WyeLSj5MAtG+Mwen6MEWBurjrAqfavhHssHSuIz2lRkVgJUSDnABcVVbO+WuenM43fqmYK+AmFUie3Up9BH9Dv2XGQZMqevg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2016 20:05:44.5125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3207
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

This patch enables KASLR for OCTEON systems. The SMP startup code is
such that the secondaries monitor the volatile variable
'octeon_processor_relocated_kernel_entry' for any non-zero value.
The 'plat_post_relocation hook' is used to set that value to the
kernel entry point of the relocated kernel. The secondary CPUs will
then jusmp to the new kernel, perform their initialization again
and begin waiting for the boot CPU to start them via the relocated
loop 'octeon_spin_wait_boot'. Inspired by Steven's code from Cavium.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
Changes in v2:
  - Add missing code to set 'octeon_processor_relocated_kernel_entry'
    which was forgotten. Mental note, don't submit patches at 3a.m.
---
 arch/mips/Kconfig                                    |  3 ++-
 arch/mips/cavium-octeon/smp.c                        | 20 ++++++++++++++++++--
 .../asm/mach-cavium-octeon/kernel-entry-init.h       | 15 ++++++++++++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..65d7e20 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -909,6 +909,7 @@ config CAVIUM_OCTEON_SOC
 	select NR_CPUS_DEFAULT_16
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
+	select SYS_SUPPORTS_RELOCATABLE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
@@ -2570,7 +2571,7 @@ config SYS_SUPPORTS_NUMA

 config RELOCATABLE
 	bool "Relocatable kernel"
-	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
+	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded someplace besides the default 1MB.
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 256fe6f..889c3f4 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -24,12 +24,17 @@
 volatile unsigned long octeon_processor_boot = 0xff;
 volatile unsigned long octeon_processor_sp;
 volatile unsigned long octeon_processor_gp;
+#ifdef CONFIG_RELOCATABLE
+volatile unsigned long octeon_processor_relocated_kernel_entry;
+#endif /* CONFIG_RELOCATABLE */

 #ifdef CONFIG_HOTPLUG_CPU
 uint64_t octeon_bootloader_entry_addr;
 EXPORT_SYMBOL(octeon_bootloader_entry_addr);
 #endif

+extern void kernel_entry(unsigned long arg1, ...);
+
 static void octeon_icache_flush(void)
 {
 	asm volatile ("synci 0($0)\n");
@@ -180,6 +185,19 @@ static void __init octeon_smp_setup(void)
 	octeon_smp_hotplug_setup();
 }

+
+#ifdef CONFIG_RELOCATABLE
+int plat_post_relocation(long offset)
+{
+	unsigned long entry = (unsigned long)kernel_entry;
+
+	/* Send secondaries into relocated kernel */
+	octeon_processor_relocated_kernel_entry = entry + offset;
+
+	return 0;
+}
+#endif /* CONFIG_RELOCATABLE */
+
 /**
  * Firmware CPU startup hook
  *
@@ -333,8 +351,6 @@ void play_dead(void)
 		;
 }

-extern void kernel_entry(unsigned long arg1, ...);
-
 static void start_after_reset(void)
 {
 	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c4873e8..f69611c 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -99,9 +99,22 @@
 	# to begin
 	#

+octeon_spin_wait_boot:
+#ifdef CONFIG_RELOCATABLE
+	PTR_LA	t0, octeon_processor_relocated_kernel_entry
+	LONG_L	t0, (t0)
+	beq	zero, t0, 1f
+
+	/* If kernel has been relocated, jump to it's new entry point */
+	move	a0, zero
+	move	a1, zero
+	move	a2, zero
+	jr	t0
+1:
+#endif /* CONFIG_RELOCATABLE */
+
 	# This is the variable where the next core to boot os stored
 	PTR_LA	t0, octeon_processor_boot
-octeon_spin_wait_boot:
 	# Get the core id of the next to be booted
 	LONG_L	t1, (t0)
 	# Keep looping if it isn't me
-- 
1.9.1
