Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 20:46:00 +0100 (CET)
Received: from mail-dm3nam03on0043.outbound.protection.outlook.com ([104.47.41.43]:20224
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993169AbcKVTom6VeOv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 20:44:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kjzsIgGUgRaP/Qa2yPVNNdxXJjbOtEORJfbAQcqfgJ8=;
 b=MOw8O5FAyQ15/+xh7ZcOxWZyEBOJz9i/uRxL3qdylS3MMC5Ry95DnjWO0MLs5IevNtcP2UQXLyk8BUKSWAgGq5+VJr/DqxxSfNyH4lyXFOpnKxS6EHLHSTRwCcm3SE4wm+28A1h7UfiF+izTCNOyImOlIZvyYQpPABz+Q/YDk1Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 BN6PR07MB3201.namprd07.prod.outlook.com (10.172.105.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Tue, 22 Nov 2016 19:44:34 +0000
Subject: [PATCH 5/5] MIPS: OCTEON: Enable KASLR
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <2e360c84-4257-fc07-85cd-4a6bb888635e@cavium.com>
Date:   Tue, 22 Nov 2016 13:44:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: MWHPR13CA0036.namprd13.prod.outlook.com (10.173.117.150) To
 BN6PR07MB3201.namprd07.prod.outlook.com (10.172.105.147)
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;2:YbSohGGSD/dqlpYZ35eOMY+ZvGLYeG9/5QmNqzrrmbtlpTztq/yxh4pUiNl7hcdh4QShA59jl7zkOHjZR4fxK/M+U1uggp0ZQ6UfYUEhf8dKDyQ9kxBaW+ESn7egSavRKcq50rCTW/OclzFu9yEUMj7yjrD/JRlzGV8OSp3ZyCk=;3:QSC57LAPKGTzri7IpMowbpASwS2TtGBJy7vWMwoQRgsVqsOVCikiYLl28hr8eBJXqcgoICCfz8MP8HdfSPyE5erw4Ue5NqVvENPqqY4RHy5YvjTkr7pWs8de01RbjYBlToTORxy7rSHqYJD/49zGrIp56TXLcNygj5y7hr3XDC4=
X-MS-Office365-Filtering-Correlation-Id: 021f1c4a-57a0-4f49-812c-08d4130ffce6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR07MB3201;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;25:hrqET/th6xlXtdI92VO+WPux3u7RfvtMBtWEaDVwwROa/UYjrm0SvP5ItSCiyWx2w26HXAoEFigdwheItNy4l1hKT8LIgMi5AvTeHYJxsBr0h/DMf9q0ABS0eiR5BtRU8kL4DgMsKg+cfK1/88A0LGV+ldxAAFARvkKAdHoPJWGCueFNnvJNAFt2gE5ger33jC9HkvgxZKMp4epFrb/idkmHzDxu8bJfpVraAnkB4VQTi3ZZa/42ZJz8ooKseU7zcoS1c2zZSPhYYAWSJ8csEAUEuRktOhf5xBShK2cu8qg0lYULcaD/p7AiY7bI4M5GUb7Mbk7u0smo/Molr1rvRTS+7hz9EjB3s8L566emNdzKybo4VJ7Fkr96AclMYg8tn6RrB5NuZIMLLcCMMQyM9hrC/JcK52pWCvSST3qGn0GVro5X/LN91VvHmMVYHmJt5FBMrKVkyRF6pzrJz+jHjL/Eu5z+tu+jKlPCIX6yo2gk3zvMOpVj66cJnHobRlfTYKCMXwHPDjhLisQh2Yi9xVy2ULj/zmTB0+QGjhmYiveqpjlds27rXarDCEQt96UzOfN7OqayOr0pao4bt1PIhXU3uvfz/GDTzrWiMXJl+xUA2lAmZMkWd6H0Ys65VouhNrPY3PPofl3CXviwVZR4UE9+JgrJMbOUhkNLn31m/2yROYTaSKtpTnsSxeKJ9aJIi+SUeR7t/0rNAka0I4AaOAbTcU4sBiJQYxcnk7eGUYe5FJjPO+mP2ZMA/96SsiJa
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;31:monucBhHixvBF7fSC+zv0xWSo2E1jHT1qGNZ+xLORu+V/bG0JWFieGmb3xBH5lo/QBlJwmgQaCro1a50BNL97OA5daHiqVbJLcYYJgq+2yKyjJqkgfgt5cza/8kHLz396rEQXuMp4qBPPCqb8XM4uKH0eCsmo46ibZTb1Vw2G0O/knwY8AM3qH55NuhC6Q6HKMpd4e6QhqZD5Vuk+9tOmJUuQA+5ji+yShYWuy3WlQb958MFIjJ877uYDjHQ2NF5kHXpGRKovcvunS2nCIzdaQ==;20:5rkkiaK7zkS+I+tVPXipFXNlgM3ZeVWPUitz3aN2SddobPGWGGer7JnFxDdY6wq9qsWrzgD+gAMJ9dKRic8zDAj3tvNZsWBukYFDZwWksaT27zUcaRK/YDbB1TpVv5l0uDrDl1ASuSYXAGTbiO/L+jwOT8vf6zukPaRELm9/qsYpSvng57A1fi/8LtlmL3LgR7zDujvayUwp5ywm0I/Vpq+Hr3gnErnjYoWxrAQXGKVqb85iXKSuk5YXgwwQPC1p1FKzjaaFhh/Wku7FZJ4vfIt/2LNIqkIdGRJ8HjrPpc5A6eg6OR2nxDq5tUsFbYxoOhGQyc5VNNLB8Ojr4FRzqrI+SiKxLOPOtRIgPfWUQ7tnHphvJ/UWZB4lU/0MED0WqesBV8kg58IMpGJ7yC4TceW+rENYo8svkhzryUN49AI4B2QYDNVYTOn7sFqrva+BGChuGsnHo7Xk5cKX3qIt6Pm7+BFnDIQw783H1M0Y58eUd/EJK1SVOxixJVAUgoFV
X-Microsoft-Antispam-PRVS: <BN6PR07MB320117ED194DF95A97ADD71380B40@BN6PR07MB3201.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6045199)(6040307)(6060326)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(6061324)(6042181)(6072148);SRVR:BN6PR07MB3201;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3201;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;4:LSYr1GLWiKFT6G8F46yhozCajf9gZGMUouya7cr7Hb1zcuS+I/oW/YgsB0jGCB0ynhsIlDqLVdnqwNS84vKH7zj6yCzkvYA7U4M9H7l8c5A216FEKV1jl3O2wmPD9x5R5r/VCsfG1BALSAmTSb1tmg8DfBv3tg5XAhJzpOjQfZZbvQO7AVtAfFUpUQAG2FDmrOvpwmNUMppRe5vQI4EJGcAFcHh9TCe/D+XiMhWC58urMWbWAs/dnOgorbCe1JoMdyoKZIRPPBBBToGNkTPRfzBFYRAI7v5sJd2/k6Gmg/7v1mwPsQjoCF/Zg8BCosCVhvplObjaAd3UfJEApP3dPtf/GwISrfYgwaw7EnvJpMtM31JQxzH/Oc/TWCeqMeeDya+6fztHqmsj8Txwwk5MLXRF6gjqfKqUv0k6Bo6nLfQTQLpE/5vPW1dv7JNv53L0uQOlxjcCumMH6wG1m5LBnVjk+CjwI/OLzxCDZ7tVRz74nIM0HMpNxbgwwThQXSVI
X-Forefront-PRVS: 0134AD334F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(189002)(5660300001)(65826007)(2906002)(33646002)(36756003)(2351001)(7736002)(83506001)(7846002)(86362001)(230700001)(81166006)(92566002)(305945005)(66066001)(65956001)(65806001)(81156014)(47776003)(77096005)(8676002)(6666003)(189998001)(97736004)(4001350100001)(101416001)(106356001)(6916009)(450100001)(31696002)(105586002)(38730400001)(110136003)(50466002)(23676002)(3846002)(50986999)(6116002)(64126003)(68736007)(54356999)(42186005)(31686004)(4326007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3201;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzMjAxOzIzOmJmZ1NmUnc5blJKam1hUWdkYnFjVTFJK2Ix?=
 =?utf-8?B?VmR6S3JzUGxOckRCbXhmcS91NVpvWjVIMk9lUWtyZEh0ZDJFUFF4aEltcmNB?=
 =?utf-8?B?Y3VMYytnZHk5cjl4RUM1Sm1BMS91b1NUa1RsZU9LZjFvVjRyOFczcjkrUEZW?=
 =?utf-8?B?VTA1L1pkZ3dzVHphTXBDRVIyeEI1dVBaOFRVMkdlYjlvUncweUR3Zms3NGJI?=
 =?utf-8?B?ekRRQjQyUGcwcmY3a05zYlhzMGxGbEljUFkydHZEeTdUTHhZb3pzUHl4YXFl?=
 =?utf-8?B?alhET3M0cXhuemgyUG5XcU0zUER5K0RsNnY5aE5iYVdLQ1ZOM05wQ2diRlNr?=
 =?utf-8?B?Vnk2bE4rSGxhSU5XblNrelhiMURpMWJyTjBGMTFEQnZMUFYwSUVZT01iZXZu?=
 =?utf-8?B?bVFLeEtOS1dJTVVLRG1oajB4WThMeitGZlFNYk5YSGVSeXJaZURwQ0pheG9X?=
 =?utf-8?B?M1N5NnBFWjBFMi9VcHFOWWlJNGU4Q2ZpdGJrOStkK3lSdUErSWQxU053V3Ux?=
 =?utf-8?B?S0VjM2p4NzB2K2dRVHZYeHAyWGlHdmlNVmNlTVg0SlZSelloTjRwMUhJb2hU?=
 =?utf-8?B?RXNlcVVHV3NGZkJmcjVJMWdsbnY2b3pVZmZyMnY1SVI1ZlNPbXVpVjBJU21H?=
 =?utf-8?B?amZibEZYOTM0b0NIeS9ONUFUY1JiaVVUa3pYNysyYUc0eWVRZVlhdDg0NjVo?=
 =?utf-8?B?VEEzOHZDZ2tQK2h3emgvWXZ6azJCeEdzcDZWR0NtcUdHQjNtNlhEMEhnMXVa?=
 =?utf-8?B?S2VUdkFiQjRHTTNha0I5ZGRJMFJwczBqbWZkWjhTaVdaVi9zM3Z5akpqN2E1?=
 =?utf-8?B?Vk9xeThReXZ1WEt5ZDkxSnRWbGZURUxpYkxrU2dOVUpLWlVyUUNEOFVJRGVP?=
 =?utf-8?B?T2VBVUNtL3c3bmhGNXlyeG45SXltZkRpRjNpMkpjT0h5bjVrN1RBYXlnVWFL?=
 =?utf-8?B?aDN0QjhQMzhCRkFuVlFqdFdHVUxsZ3FRclJGUnBYaVlDMHVkNnRwUDJBMDVv?=
 =?utf-8?B?cko3cmg0cFE0WXoydXI2VkJ6UWxJU1M5VFdoY3dEYUFTZDNqcXZYQVRGZk83?=
 =?utf-8?B?VFA0VW5KcEQwbU9rYkc5OVlBWE54TkdmTXNHdlA1eGxlQlVBenQ1UkxoNUg2?=
 =?utf-8?B?a0xna1N4WFdhckJkb3ZWaTJYZmNDbE1Md3g5a1krVVFoRUVyeTFPUDgzNjEv?=
 =?utf-8?B?TkRUY2NrM2VuTUdHdGV1VDlqU290eWt5UFVCNjNRd2I3MjNnMXVXWTNqS2xP?=
 =?utf-8?B?WHlqYmRUaC85VUNuWWV6VXE2TnVtb2JWTzFVUFNhTEx0WDBha0hvNnVmSnFt?=
 =?utf-8?B?ZGJZSmJqSVdDNWpVZy9XUkJ4OEpKSFJ0YU1UTFdPSi96UExvNTdNc2lTS2I4?=
 =?utf-8?B?V0l1ZGRHRVc0WFFqbFVwREl4SWF0REhYUm51VXlkd1p5RFpiMHptU29hV2dr?=
 =?utf-8?B?RHBmckZMNlB6TzlpNlBPMDQxbmJXSXNqWFQ4RkNjVWZIMFM3T0lpTlVNYUdy?=
 =?utf-8?B?TElYeHJrZjNzOW1NQS95dk91aXpWOTlXUTlDN3JrMzhWVDUvMGttSW1PSmx4?=
 =?utf-8?B?QmgzdzZHVUhsRnl5MkNyK3VrUkhTWjB3Yy9sSzhyaUhsR3ExM3VleTZtZWJk?=
 =?utf-8?B?R0dDckZMRlBJVm5WSkNHaWJXeXc0ZU9LUkRCaDFrSVZjL1ZoVTBMYVdRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;6:yeUawAsz0nC0ruy7bltwPkw9IIktb6Af422uYouxxey6VHWUsLx1IhZIBP/pnUJITuzzfdq+MZlZ9SPs33LcgvjsSD0Wk9v6AiKTxI8jcBQ9JeSttx4DPBiVrChaRAFaWF0aGGrTLko6J288/ApqH2eVLWGfE1IG4qXgT62d9ZlQdvajeDww5B6WcphW0k3I+93rfADpyxWG+K0hG7Qt+HsAUA22EIG2aUFFHmCHeWqFEWaSblqXLVtujz0r53Oxfpcor57yP7QuzeSa0S6kqQ8EytGG5q03Xum4Ws/b2xPU/ROuWyCML4thzlvzlFKErU1rNzELqXCB5zKHZ8hf2AJZSnvaOvkeZ1XSHyrWhy8=;5:sIxNBFObNs3dpEV4KYGau7gW8octgGYgPcaxEIULnwW7x7/pLEUndeX0eySaQrcjUqFMtfEmXXQ5CmwEvc67nORktppb5VhcLEzt0/icJA14+YW7uayiZ6YkDEc7Gl+sCPTA5q8JqZ6qC9CMI0lmoQ==;24:C9QiLL091jP6sf8OHZq1DNnBvVr5J4ROAOW+kjI59FMg6uZljOi4PJCMX8KfFtBlYwmspHaPfBD3An7uXPbr4vU1bVv0FJaHd319sxB6Ouw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;7:MMNlr+T3GM7cC8mHCtSawbhXgUOO2FjkMJC4NYcD5+XEA1YgTcTbTmsJoYrUYVZxJt0WlBdGXyhOIytSF+XHa427c4XDsxhXBAr0wYm1DcWkvc8snb8YbT+COQ0NCADhCk9j2Bg80sUUlA8e4Eg1Elc22G4vt1z+obvAlF8vPyCgJEqMbTLYqYPuMXevyiuzmXeIM8yCwGac4T1kQMlw9+RzywrgrNic6iVW29gD95w0mWbjQeYgHxsoMtLo4WkQyeKtQ5ptzwc0bdcyZhRp7kbHaFCq9aCfdgAGKrmjFKNWav5ZhtGoHlzjkY1Sbw/xjXue0QZxoCvA2BwiiRlYPVktyCRdCcCG5S+tFaAuBG8=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2016 19:44:34.7718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3201
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55859
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

Add KASLR to be selected on OCTEON systems.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
1.9.1
