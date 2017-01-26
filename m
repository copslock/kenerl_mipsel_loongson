Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 15:34:52 +0100 (CET)
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com ([104.47.1.97]:58080
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993893AbdAZOeobuL07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jan 2017 15:34:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ltvYyjqvCaWdbcuIhlc90X/AWJgZmZ/F9tNed0ab4zo=;
 b=CvJCWkQqE/jaLRTsX5n1i1ANdLSX1RmFHvODlYlhk3gcxKg4Q14Wa8eimU9Zjc+5QwVkwrKTHTWlrpekI6ll2hY3dL5hQj52yufp3bVR+CTwuwMof7eTEkyGM1FE1ViDsfufMXsKTH9jNLqdPo7vACNhxSgFJsmD2JGXmRNokHQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.9) by
 DB5PR07MB1318.eurprd07.prod.outlook.com (10.164.42.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.874.6; Thu, 26 Jan 2017 14:34:37 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Robert Schiele <rschiele@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH] mips: vdso: Explicitly use -fno-asynchronous-unwind-tables
Date:   Thu, 26 Jan 2017 15:34:08 +0100
Message-ID: <20170126143408.2456-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.9]
X-ClientProxiedBy: HE1PR02CA0057.eurprd02.prod.outlook.com (10.163.170.25) To
 DB5PR07MB1318.eurprd07.prod.outlook.com (10.164.42.12)
X-MS-Office365-Filtering-Correlation-Id: d7b0375b-0dba-4abb-9478-08d445f87515
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DB5PR07MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1318;3:EPL8Z/zt+P+UU6PJKk9FvBqDan0WbGZhHGpjdKlNwOFt0f1GsUCUy0a7ScW5viyTQL9bCweoZ/SyWjKX2wm7i3KyaKteqn46LCsNMMdiDA80F+vEBV354F7F0HMSLfSFPDwW+FR7zW3lQylKsZTMYn7rF308jrsrqR66qFtJyf5AbX6aAmqDDasCx8WdMXyNQgBBKJkK1YGAHrhaG8p6nDkYjZ9pAaCJF3inIV+kQ8aH5cBrRXUaKR7lyrDKZROzhYtp92JpI+4R0sMfBzYcVw==;25:rFgqwUmYCwZnogsWl90S60Zzb3vCxxJNsrM7FE/AEhLV3yz19pBmsT2lyKbNQTin6ZkIJW3FeZMYhfMhyx0IjmgkzpZaxU37pWj1AaIY9jfdcA2eQUd2ItNQ+2CtEP2EYAKww3d8rY3KK4mF6qJBrRwEKkDqi8O8ztegKN/9wvnjQfh7A4TlgdSly7+mm/dYv2ACz8CZTjJbTi9CbQvcPcfGXKex0pjY18dziSicD/aTQeDcD8ZUTypjY4mLI7S5ykXIweZg/Clfe8T9sRm5fTjlRgN2CYFBHxtRS+g3+Qa+VdXLR4nr3eOEHYO8v2KgsHczXirNkarMkxXv07R4LA+5O14iw8gn+4/C5ZlWTzJEMxXmVB0jPtjrcXc/8wYvWoVom9mv0HNqFGfH4fU/QDMIgPX+MHqy/orr+oThYDUt/JloHbk2Q9VGs1GCmO6CiV4huzoZVssXuRf7icgfmA==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1318;31:ZoM8ceP4ilBUP92Y7McoPjXxVGBJhTvaEkOyNwx+Ef9ziLvaN7lo5+ezYGvK8OjWeGY02VhvEB0obAfNf2AUhCzTPW5efiDubtTIh/UwULqxceOjmhpj74CO9IvoHKIn5vcvZhifHzoYonXpNQrfioB/YBJuTMxh9Hmraote3rJKh/JgYtLm34a6y/diZM+777x7I0QHSsLzPN4X/EoGjaJ7+3WyXV+ovnX2PLGCJuRkmz9Pq3c7fY+zCzkUm47khdOoM1jf3x13PetxoGmpJw==;20:xSQqyIshO0OLko4LSO3uqyF2FoXzutKoWclnpzuUjvHF4ch22th4NyzKq3OU1qUwQvD5xfiCHLAG3pSOwOhlPNo15r76XxbGmGT59RRJun1IyJ3rLj6Pf6hWMLDUYLqpoZE43tOZdd2xycgwn3Cjc37vMW7laixrv/nM0ElOjnda2BUfYHysJew7AbRPGo3yaXH04XaXka1+zpmmN6/aB6ib8+hEEPwzsP/jpUb/vTB4CUYYhJC0I7iW5a28U2TaGP8Iqvq/PkcFqdXl5dxpDy77mdr2HSagTwH0qJyleYABCpkiM8TBECkWCeVv9rWlEkUMoOXTAtaYZOoN8VjEYK7sne4VQyqBwV04wDPXaNrnZyamkPoA4z5X+QkfGHwAQW8JSMiXMpDzzGT2cyEu7CHcSTIMfsfxzm+12ba71q2kVUMFEXQF8fds982l2+PTIClni8icSUUDy5Ubsn0k9/IKPhZGy7UTJzM4baNezPnXuWr4wntni4n++l2+Aa7Pmb5teijzAodrcSDfxXI0B3SCz8H8klhOxu+jWYn72pawKn+E8iSCWZkRsaqaM8YGgycPUDNxHYlimt0CeYIvmVoeE6b8Mj/fTkbLvEj8c5M=
X-Microsoft-Antispam-PRVS: <DB5PR07MB1318BD1586CE51D5672770D188770@DB5PR07MB1318.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026)(6041248)(20161123555025)(20161123564025)(20161123562025)(20161123560025)(6072148);SRVR:DB5PR07MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1318;4:/XSFmfKiLYt635WJ/fXBhUyYpqZrL312zoOdwXf+CcVPtcHyCOolFau8PirwFP/DXHNAaCqoF7Zx2JNyaLgS5SfYJG3uHewTYetFh/HMGJT054DrcG23I6V5YKhzxiWis1DvFmeLLG3cBeqyWJ4HHChNhTjyXf5xJsl3Ik8XA3mkRMRFWi1UacRemtV5FvbUj0jfZB823fO/zLDpkDv5CjLyCGOQkbNcrfqN+aU3U1x9bMTsZAIOdwqIKGHlgay94APlZpto4EXAXoItaYiOfEcD3DeN/RXLlwfs2p0nKWMddEHlYKOZ14+Z8aF9IfbH3qg9pj4pGgvME3OEPi8uF3X1albX8a53bnVM/Z2X8MHmPPXUZrXmrWF0C8ManZKoEn6F4/Yy5ML4aNxlxLCf51jcr6z5lqoCtCsZDYc3Y7URIb8mjLijZ8Y2IkAaMNH/zlXDb3tETvexQbF/VE14Xq7HE7Wpvp7KhqUOQSozTMc6ape5toY26f4KzVZalrJZLEmpkQIYOTDrK6tZCg7x81CaTIBJvdMnJ2h/T6BGWUW46VIcjJVtz549pvxlNzFlZ+1c/cPSSRQCAQriWHZ13TBhuwjXQcY07/6x2Avwr69F/mBSji7qph8wOsTwfPLWC44SLIhFJOVXOuunwGYwgw==
X-Forefront-PRVS: 019919A9E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(39860400002)(39840400002)(39450400003)(39850400002)(39410400002)(199003)(189002)(48376002)(1671002)(6512007)(1076002)(97736004)(6116002)(50466002)(4326007)(25786008)(101416001)(68736007)(189998001)(3846002)(54906002)(2906002)(86362001)(6506006)(6486002)(5003940100001)(38730400001)(39060400001)(36756003)(106356001)(7736002)(33646002)(305945005)(81166006)(8676002)(81156014)(105586002)(50226002)(230783001)(92566002)(47776003)(50986999)(66066001)(110136003)(42186005)(5660300001)(109986004)(53936002)(6666003)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1318;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1318;23:QEdyUNl4AYrDj58hRztk23iFqSUUqNQRAdnF4O0s/?=
 =?us-ascii?Q?W5JefjkGcQQqMnlxQExTeNCwBHcsMcJTLJmJUJPXxEPnby+LkMn2t5Zwi/jA?=
 =?us-ascii?Q?LDa98qymlsL7PJqQyC/Oau/8WiKTl3ARdOjiNTFwjjF0sTZAE8SVca+0tpOc?=
 =?us-ascii?Q?TLwDGb7fICmjYTfmUZsEB88Cojb6FOHbLKu7FXiy2N3NCvJzALVay8wuq41q?=
 =?us-ascii?Q?ZxsoPr4XuasdANl+IujVfP07CCRCqJpnfQ5ExJ+Ut18vEH8dZnp3Jmt3OPM+?=
 =?us-ascii?Q?OZWDnTmgJtZP07PfaJkBG2M2u8DaVrURXbr/Zae349H5zQTegHqsurvSck0B?=
 =?us-ascii?Q?TCaIG/Br49HIfupS/JQIBD95mKM9NP/M0aFo2PH2i0lj3ID/UOQzAOgQQ+bh?=
 =?us-ascii?Q?lvwl6X2xZGmZqiHc5k5ijsJ3jRWsHRNNk+H5rbVsPTyQxQfVNVmrG8mKR/Hu?=
 =?us-ascii?Q?zFgmosVnfc24NRRHZq/Wo7XM2DEiG7OwFjX4UwVJAmn7Cn7h/d9XJkyIgQKm?=
 =?us-ascii?Q?HQrnJm8uWmR72VC4xjBJ8GZXRz6ABPes5oQ0zsq3H2QspJvHpRFPg9ewYS/I?=
 =?us-ascii?Q?kJrWOCbvELr22JAoISM07OSBdDeNYkElKe0vOgUAxVL41ZExzPxDHyqttkGo?=
 =?us-ascii?Q?J036fjXXirwxJ813giLT8KnpGFvuOW362mChuJ39itWwVX+ByTbtG2NFBdox?=
 =?us-ascii?Q?6rH+GP1f1eQ7yuO9dlaBag8gHBZNJr43k2fECyhvUT/bhWcXCCqiXI/yvoVo?=
 =?us-ascii?Q?JvSMP6JWHB0G11rYCtR+v9e388SCz3TWenNagzzZdi5teztO83zylEr0Qh2C?=
 =?us-ascii?Q?6hEeQaOHH3u7O9JNZNAPUs5i7VA03LjuqflXrK5kT6vXbm9ywXp3+Le7juAc?=
 =?us-ascii?Q?RBmTxn6X2zR5/gIqRG9CPZDIHQtqy+0erTdTDjr0Bb5dtIzYE8buL2D9WU93?=
 =?us-ascii?Q?3ugr3A0p1oJZbDQnyHCaV5rIJo86CBqWz8Y5y/DsLyobW3erTAznfj/Rpnmx?=
 =?us-ascii?Q?s/l3E1d3Baal1efJrjIcEj8zLqqnKFGprN/fJ09buZxXpN7BJBJQirrxHVBb?=
 =?us-ascii?Q?qiQzh3XGFvZhDgRkT/Ad4EvTF+jO32ZZxP/35n7UR0wGazajY9b5RR05R3HA?=
 =?us-ascii?Q?TuMvRGzWcV9kaAFHvdh0cuXtpdFB3HptMl4e8hX4BivuNBTdBIkxLAHQhFky?=
 =?us-ascii?Q?CW9l06Q/8m5b6LKnojLXwHUDcNQmo985DEUKyFyntT0zDxJfum2PwJlMcW8U?=
 =?us-ascii?Q?YEyX+5Mp3hZ/3Yz85x0ky6j9rCDZLg7ADjcjgdfOuvcFbdEiVTAgTE33noae?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1318;6:5zDn2+kA67yq4OLdT1WSHPcfTpZwPQHB/uQwXFLyn4W+o4hL+UJ0Baa9xg6QEgUYAPUD05RlFC3qNiWj/5xLpOy593Uu02+021/5rnccA1cJN5a656p5MeN6IUWJ5f3GIRVUFyKtFnYPLfAPvP8RWUYS8sRXTlvVAxX9RhrNxqGQYYcgfSkAOqvinQ34ynPLSCt8/3utziTqebxSebPngCHnEOx8VoKDRkawOvm+IqA898TPiNROf9Q/mNSs8uSWChIpTqeNLatydgbCqnOY0XKQGMSSQCNGaYJ989E/b2s0ALhEeAsdqvzWIgI4P7aDRCpL5+aSDm+T51nuPSgDIeoGKRZ1379+WhCqOMuzCH6XzxYhKB227CzM5mXUyH/pdQITTWb059hULccK4DD9bFGcByZ9/ON4ccP2Cq5ARcfykFd+2IZygNnc0AIL123sWHIISei0uaqtFJHJi6qHww==;5:5rBrdvmprSPN7O+RMG7k+3IJ/V0lDRZbTu6SX6LIzLBfT/8U9rXFbkGrb1kZnmcoZ0mJ47Vp53vhuUHuTYKccrA44QGBpB5j6A0NEBR7a9fYypMnHLHX2QHWdueeSvz5i+8VwmiC5nVPZfG9bURlAg==;24:zEZuOf1Ji1Jq4D3n7LHpWdbsIC/V5Nhl4Ax2LucG2VKpL0Asq2g7qNjmuNArOBg3fF+MJZ0MGAHE9YdMDjOwTzuqe26xzc4e5tYgFTOvhc0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1318;7:fh6ckXqPcQu+jvDvtmtkrg1/a1/UokrLj/KU5zt7ol9r3mGaVyGOtIIjihOkp560Lry+JIf9fJenSurgUnp/TWLHSLJY95rCMgLcP3xDNSRQqQ+iV4zKLnWs5jfUtJcJeE3J1wtHp86S6jFzAIzJcYy2kTxJkXussVA9feizEWbLcllO3LNrO/yLjxweKWVWIy6bqAyUjvORpwYwk5P0s5TFzufkDiAMCEhiRpCJs0sl3xa8oMp9RZWX+85LpEeB5d8q55GRr4pU9LlBf4zikWCnAiswbdAQawCu3wMZys8XNne9M7T6FoPW3UiF90uoVhXI1oDIEBasXkdClvSKLNAsGkc4pTweYvX2CDfaWwBBdsBW2FuvpYn2Vpk2tkD1TiHtQuYVjSoLBk4C+oNclXrdp1BwYHhyLnAIRFwGTRND6qaiyrZDZ7+I/PvaG6rjPphsm/wMjyNdq9Ucg3P+Ew==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2017 14:34:37.7981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1318
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

From: Robert Schiele <rschiele@gmail.com>

Not every toolchain has -fno-asynchronous-unwind-tables per default on MIPS.
This patch specifies the necessary option explicitly for VDSO library build.

This prevents the following build failure:
GENVDSO arch/mips/vdso/vdso-image.c
arch/mips/vdso/genvdso: 'arch/mips/vdso/vdso.so.dbg' contains relocation sections
.../arch/mips/vdso/Makefile:84: recipe for target 'arch/mips/vdso/vdso-image.c' failed

Signed-off-by: Robert Schiele <rschiele@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index c3dc12a8b7d9..0512f56685c2 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -10,7 +10,7 @@ ccflags-vdso := \
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
-	-DDISABLE_BRANCH_PROFILING \
+	-DDISABLE_BRANCH_PROFILING -fno-asynchronous-unwind-tables \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
-- 
2.11.0
