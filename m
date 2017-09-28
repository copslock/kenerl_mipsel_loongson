Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:43:46 +0200 (CEST)
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:31924
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992388AbdI1RjMRHR5F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=++u5tzSsWN6wJZecDsdx0jcF5HiBFTrQF/wc2jp3WB0=;
 b=aOwgibL1o0tsLQfhr8kCVqIEecnjPmRq9DRsm8j2uPXsHyk1col6RdCKo6EX0NGCH6fU2YI0O9eLSkLLHwz+fcoewDTU8bFY7zuS8YXtc6Esge/5n21Xks/D4yhmsp+A3TrupPq7U1mBlAY+MKQRNzMfg2B54GZChZIdAQ2hN0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:04 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 11/12] MIPS: Add define for number of bits in MMUSizeExt field.
Date:   Thu, 28 Sep 2017 12:34:12 -0500
Message-Id: <1506620053-2557-12-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebe832de-33f4-4175-8364-08d50697d058
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:3Xuv7pJqLVTDnu3WbOga0X3C397rTHNnVZh7PPBNY1jKi9vn0AlMdWvpf0mdG90iCzHrPj5E0wavCG3FeF8rUuyjp7jEZTNyxqeWMUIaWT+aqmV/k98jpenSj0gGWUUKwg0TpjHqxKrwoSjkyg4ro5mcTrxIbIlC0qswBCDb9aLr4qqaQDY9uV+R7maHZc3wSPQf+G7pHQBjiJiIQoIOuEbblgcgjFDtz2i06oWvwNlDHp6N+wGY/QlzIM1ik4jp;25:xdRCo0melfEx7ymChj+4JW4XLyj+KdSp81xun1jmR9MbAvwBa5V69IoTrCyia1vx8FikpqTWEv9mW2tb2d67yFO//A8klVCNHricQ0NtSlJeJSLL73eTfpAoJ/Tq6wRCUhN8b+97ikfqKEv3m5tVMrGsVu+X9PhPg97vm9lYavAJRrgNI7DZz36heVT+Xb9HFtOmxQ3BbdH4RHB6lGS1oCbiBmnwt4ecHRS34EwWfjoouumHwQLiZZ29fFCNQVpeI9LDG3VdOFl8VcS7PNifaYZ1UF+oUCPmXUhdLE7w5TOEbDUDTLkoTx0baixSI2r5nb1k7CMArl5KvJxG2GewGA==;31:D1VY79pezoCCwijUCQI+p85+LqB153Kwjk12FT7gr2eWZayHrQZvzb0s4+4ebUqXeCwrUyQ73AnJsSKg8lJs0pBlfAVEYjEqF9M3B1LsZpuNCTYcV/FzmJSm5aUO4xeq1CDF7UCYnQxTDpyzupfsKSzqCxLi6E/7llAMmRiqt3axlktKcVbVRdRM2fMxUfx1oKyOIj0u7RCFA7QFmrv5WcTO2lqJfNkiKEQy7Aq5sec=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:kBe8d52rvkbpp5m4uqktRAS5S1QnKLgbeaTA1e5Po7kJfzRMK38P4+KXlR40UusHnsj2BksqSZ0IwvYAurLWxbmbP5Ey+lWFlVdttw6R3JnIaCzq2vrKVio/fZF5p32RLoRI0IlDMxXi4QcTsNaeVgfiQTha5qiyKmCrukufzQr7ACdhy12VJk9UK6mzEkpnOsrqFuVva1Ue5bv/z1uppzRRWIkGIaVTyBp2HFpY6X+J1Sb/fR/HHuwA2PqxeJBFKyjf06S+SaDmSdebKzA6tTbn3bA0RChBih5Yit/mLq89cjReNBF9nEpAeQE6GiuSGsDohhLyNZEKef5DdXS8yhu+89OJdf38ATnnSvqmpy2MFyTYFhY2g4kV47x7K+w1ljjyDg8kWHFUaDwG4TARkjqZIRnV1LviPlnbrWkBZnVSyPNo0JJeUlojg6BtNWbc23DD7n5jyvbwgnj9IhCiLmGwh0fTn+wti8ltKeG/vkhA27WETSLbjifRkVl/kgyQ;4:+nihQh8bPg58mojiIi22SXMXn80TDPnNISO0dpXVhJ8wpKIwcZi3vuQ2LunzcB6oESEOwg2xtGroHzzgRSYFEtch9WRA7Lzs1tIpw5yfBmj1ykoRY6ZSKP/Ppvbuw4Vxcxq6KS6Ab2GZ3VHB6jyFc1eeYO2nOqEUuQzYFZOhLgCM8yeJbERGJAkShkggI69YNj7aCU1ssK7uBmBbD/r7m7uwlnljZLrLn537GxLBwLBCxssUxescBlQyf/hh71A+
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB38071D803A9B163020223EAD80790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:EwgbwjUFay1DJauUjDJNd5sqk62m6Atw8XmtT6p?=
 =?us-ascii?Q?mIPJFU8W4CvQCRiXJa9v3d+qaPrwcCDitslJnNCn2OwtKiOynlt/k9mTRYOW?=
 =?us-ascii?Q?eMVcV5NLT0FGEx+onpoiTr+oZ4LoDYlkQK+pfv/WbF7k3HeHQd5S4g72vgOk?=
 =?us-ascii?Q?symiawr8cBZeDGV2AMp33ULD4cSttixJN9HD6G5lGxTJKVfUFhFwNWHvxL10?=
 =?us-ascii?Q?uVr2bi+5WM4RE+Y4UAGX0WB9bR6tD6GjgbxKpT5JnKv4Olfl13MmWkC7DilB?=
 =?us-ascii?Q?3e+lt7kKUtBDw76d8EKYu36jafxA9Cj+gxPXpTOigJi+bIPfqMj3LtPO9FBf?=
 =?us-ascii?Q?eHpbpRZZ+5uUt5ywPlwUfbSypugkqi4h+xFHKrZWuBiHJmtwa06GXDxKv+Xn?=
 =?us-ascii?Q?mrcguTjyH5ce/bV6Os9hTJfDHC+fp6fzCH1bHfXhRsu5bmjIqM7c/oMS220P?=
 =?us-ascii?Q?3hq4vyy2KsQB+DwO8wCjZ19w+qgVjM5ASgnVaROCjSOCeoQYCo0UW/QeicMC?=
 =?us-ascii?Q?5UsnYRD4u3L/D3d6eb2SQUtpRhwv2ZMtM2O4QAl4aYCoafcIb0n+NhLKTs2W?=
 =?us-ascii?Q?++gJrP8VwL0Yk9cFq3kuhTWdwGl7pkBOFfaCjZUfONnMBbQSGdIZqE3qOv1o?=
 =?us-ascii?Q?wnzPPWxRzI8NWY+ulyfbQDPJM7m/ndf1mEQgd5egx57AUqbbNPH9slciqo9e?=
 =?us-ascii?Q?+UQ8PiwOp8Q+jJ6Xc+QIpRZKsUTe/7ccjFI35lbtSi4L7ysjHKxEMSh17JST?=
 =?us-ascii?Q?BhajuGDV9G8H9TR7ogkZdw59wl/+Aez6tpr+SU2GiRR51FWpIED4U/B5G+Jj?=
 =?us-ascii?Q?RMHtIpBHV12pcdjN2nzzs0bZwlAv64+5fJhs6cm3SFTfJxQqChsZ6QIuHsjK?=
 =?us-ascii?Q?ISwRUrwJGchjwdZrdzZaZIKV9Y6PCaLlqrer3/5+7sbnjVvEEKZoMRrmhHPE?=
 =?us-ascii?Q?/9zM7Q60HfNBXIDrTlHhu+VOcJTH3iEYNY66lJ+J8tOG+JlPCff2Z3ZojVkv?=
 =?us-ascii?Q?Brt04Y61wA1OBD503fUprK/ehtANYmajuCQ06OkPOHXitRtjs8frxR56mnfS?=
 =?us-ascii?Q?dk5RvQe7HPH1ZQe4BYPM5Zcc+EyVh7mJSxcPz2I+6ay7K/88Ok/iUDaIXyuT?=
 =?us-ascii?Q?Ot3x8porspxf+1NYT9iZh8Km6BDZAgbzxuZMLHuu1B1ZxAlBo1Lz4vajKWq3?=
 =?us-ascii?Q?G67JfJmHfdCH4gO4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:fvkm9EIqybVP0YaM1oft61gmouV8ZKBccLiQ6oil0P+x72un5pP9B9wsUb6VmmccxqxUzIxC44z1rYUkMMwwcNaduxv0HkUezmPev5B2TPjR0iY1n0g58DwZBtBBHUdIDi9LsPRsyVAhjuGXtBUSIJBAdFCHqk9dIX8b6ob9h3r0gy818iQwlHS2O1OYRt1dDUTIxK+vY6tVJrdDWz0tSOITR21Hq62AdxjVzdLBXtXS6sJF49KJkOuU80NxDzDdZ3Nm6bdGu0ixR95bfsA/lBgyQioCCxEoNCHIVYTWvyX2jTOHe2pGjbrqSA4Xvl78ONxKm35Xx3CEiTjJsmTH9w==;5:16nu8bw3NKsS8OC3DwAbBSsVUjPWBYttFOELfELf0abgIx0yQlACflNaVeL++ZG3jsspBtK1y2Xaj5dR3GewEtoLfHEzGuKQievwIpkjLy6CDCYg/6BoRnFjNPXjUttEjxazTpYqLWfV3CajS0WwgA==;24:42sSJlmAiJi7ZoxQ84IvxD+f5jCxcH1s2xnlARr6Fp8Ne6lQIzYdFxc64OrKHKn9mxGTAg3fJVN2QPZkggcpr7nxFRDQaaNuGfFwGmFeZUQ=;7:HUn/6wZ/lOVvFQaN+VBhPUDRPCW4GiCKAUHFf4w4KFU3aCVbbLZzaHl+bhvVYtc6Z9qHuD4kJRoFv4Mp8wSW/xMoZwgH3L+rNFEAbei8kY35rTVEo8xsx7iwDoSxFpyJEcuv0AfvVyFJINO9iaBxkKH9pzAo/FlzJuQmMP7KlS9xO7mlsdIMQwiohh+hwC1XTSPAGHIZzKVj89PqY5gUTEpBscdodmFL7c1RxqshPxs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:04.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/mipsregs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a681092..3fa2352 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -633,6 +633,7 @@
 
 #define MIPS_CONF4_MMUSIZEEXT_SHIFT	(0)
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
+#define MIPS_CONF4_MMUSIZEEXT_SIZE	(8)
 #define MIPS_CONF4_FTLBSETS_SHIFT	(0)
 #define MIPS_CONF4_FTLBSETS	(_ULCAST_(15) << MIPS_CONF4_FTLBSETS_SHIFT)
 #define MIPS_CONF4_FTLBWAYS_SHIFT	(4)
-- 
2.1.4
