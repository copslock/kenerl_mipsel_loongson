Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:45:51 +0200 (CEST)
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:51904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995043AbdH2PnRHUEi1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Wk/1jbVgPqZbO/QR1z1ODp/dRSzNp3hAsXOcmJYWTrw=;
 b=VEd7pcaaM6NN72GtlsnB8HwcCi2XmLlcojPmCTCBU4RD0zTFSDZ56swEyWRoa0jLZP4ssHaAAIz5C7ivftATXsTqOJtJCVXbO9JFQfHrElvMn6xbHX2Sv4cT2k3eSFXM+3AnVnEVFZBRaYRyzjcYKnRPJCWl/Cs/ws1Upsp3iMc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:42:59 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 5/8] MIPS: Octeon: Allow access to CIU3 IRQ domains.
Date:   Tue, 29 Aug 2017 10:40:35 -0500
Message-Id: <1504021238-3184-6-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 099d8c7c-27d9-42f0-a621-08d4eef4a069
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:VC5qUum99AiZkGdqriQLTnewJQWlBkm7PtHHLuH5dyoDAdD6H+Pzog5uI2+gjRwo+Psu/A6R0H6a16SySNM6dT2cVEYh3zkWTmao33XyQ6yRm3uY8yTX+PLB5qq8GLLr+RuhPV9VR1jprw0GQl5MyEfz+Lw+SXf3W75IxPoOtVyvOnNa9A9pHxnrsakOlh7RfMhSwCi8oo5v3gAwT5C9MTbURd1u9G4/TsmafTgqZ8s6KRGtUNvZXyA2JzI/wrOe;25:7NbIT/If2s5CNIviolo0bM/noWuvgmUg3TfL58O/lY4wzN45LCw4RIBKdgAwjw6NUx1gYRN8HHidIXsrBjJag7L9QWh32GWPzsc8xhArCMS6KutH6u+1ZKWxNV27Mi5CZMCid0ufZyMO1F/bycfPhnltZymDTKdLT+sY4S7dQEf97XcYtTLKoNFch7In9zwly7by19QjUFixMkMietl8wM2f/e2fHWviiCZIBB//H4cC3X4CbQkS4Z2JKgq7TD2hOxdDmVSTiPKixMEILRCTBLyS2aeEs+oOCoG2UNEKl2whFjGt5C/fZKNs+X9w6v78eQThsjCiXf1q9l2xiARmgQ==;31:4pO6N1WORjDIQkp2HA+9qsd0xPHUT8kSAOspnJd0yPkbbUd7uqqHlkwfbUaW37cmfJ3lg3UNaoAON8JgNeG2aI2isWQqZulJk498g0kIpPnSesDKv5jp/uJavglHSJHBxnw8JQLW1xLHEik/4B2yj4QPSg6PvKSYqQMsMnTFx0yxYzMnRuQgEfSVd1HDOO+gpSOeHkMPgYqBQPeyhlxS318DAQDU6SxLrWxSNf6G5A4=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:xAU+degprN1NhnMIjdceUpNOLHggTDl+IKUEj/k+xvoZraKzqNkltDxY1+4YaA0Rah1UndzaQq7qC6bpAT3VysKEN6kUCTYaAqebRGmBM+6PiWgcuRzzil/CuhHLYjVTQZbELu2HCxUmIvBqelo2b/UDEhs2Sw7/s2VcEQJJowwwcNeKsGMI2aTNHYzeSNmBpOTl956hxCkNsHMZpOr/AhMmLrmCf/sQuAc+enedx1575sLbv0ixhrNxL2FGOKcofgQfKPhxyjD+mk0+4azgDqddWYERpyr70heE4u3vhySQie8abMdNegZcG6oezKFcmN6IrJuaLHSAr0v0nQ4AurT2di6ikdGi8FrY+LqRliKdgsEYka/YxqvItdyCBXpauIaAc/+b7ei0xcIfjwjIsl7riyD+uAu6eou+4gaLlephDW1oGy0CzYqAQOS/xGWRi9QlGZ35FtmsV8KEBTPZ991k4vksJlEhCqtsJuxQMtVqO0PH/snF50VkRQaUk/vN;4:TGwE7UoKy8YBtMlwWe1dlZG4KLGtj6lNblDx28MlF2CtfiHPNd5f8DXnh4yCAKHmP66IHAxrXuswXCXYOJkWakCW/eckfMWEJ5eY4nA1dxnVw0DpEGPBxILSOOVj/PqmKUY53M7rWGqTHSIasnpZBFm2K6bnMYtFUNe5ChrzUBBaKB7Xjh8iBKs9IX4jyX9uoCt/4glwQ4lrse6p1tYjGwmWIqRKW97iFl3uZK1Y/NyotmLsWm/mwjH6lwmzKsB5
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803A203A2159631A007C79E809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:HNkbz27I1CGjODGHoGoIqxmCQDx0kL8PkOdD8xM?=
 =?us-ascii?Q?lM0ZDuyPxD9bnnMXPTljOuQoma/5wNx2HHLtpDg02jxp6MN4Lbp4zJJ+DVFK?=
 =?us-ascii?Q?xGVwojin6ozwebF+qq3jvJvDLwZMEmmsknuuGCEBlVkGO6Uj8kHHXc4/egOl?=
 =?us-ascii?Q?LjJQiaqrCwnoxhGlSjNNsLCue0IOsNsmPhe7Qy3UUzSy/iZMMZcGU8Few1ua?=
 =?us-ascii?Q?x/PEoWm5bPWh/XWPXvB/nyuhrk2F2BlvYwl1qDE+0mD5RT7XZ3IE7zHLK6+z?=
 =?us-ascii?Q?f1+Z1/jZppglqISSUQH8dLPGeQQflWfc/ae3ZtWsW4u7ppltESOsYrwrpVGK?=
 =?us-ascii?Q?LpyjITTAKH5S9k8/IhLi2pWA09MzvayRoIk54NQ1H9Ak47CqEMrq/16y3A0N?=
 =?us-ascii?Q?noYXlH7cwfSgoVObKc9xgXiZ+VQTcVBQtlkTR/s86kcHUo9OUfY9EoBa/DHg?=
 =?us-ascii?Q?QSoVlGW3gkTIjztPnPEwSq/96I9UOvgjTt7brbwUFf0GorTah9TT6Xyj7cul?=
 =?us-ascii?Q?+bN9SKLsUDRkDe0oFDFmQDZDRNwTbJgq79HWkOIFpo4KpEgi+Bfc29RTa59v?=
 =?us-ascii?Q?DrbUjTEnus1qlUUi6JUCDqzkUs3x1dWe/LsjHmtNEaql4gnuXiYt86o7pA3t?=
 =?us-ascii?Q?KGk63ogHsRPmF9Kr1w/olOD3QBrZLOySAogSmoRui/AqmkatVBmIuN9mNKwi?=
 =?us-ascii?Q?R5+nA7n8lLgasAzzfJ+3OWfH3/GCMC37edmjSa53jdPyOvSTfAPf/yXv1EUY?=
 =?us-ascii?Q?IPwCYbft0Tb4sM6Y3CMuemnGfRq3ZrWXvrCbbQRSy3hvPJ62TgOatS+A4xCc?=
 =?us-ascii?Q?3vbjnSMh+rfTIJDKBBZjS7QmZtVkWmzWtZCDwxsDxNsdp5kYCFJUiDdYmXAG?=
 =?us-ascii?Q?c5oeEdgJfQjL8yCrDocRkyXOrSbkhAtAyv/ZICzA60CpZI7kHw7UelweqsBM?=
 =?us-ascii?Q?BPvJk3jLH3n1l2ofnmDlSsiFgU68iFXx/405Wp/FefzQgsjuOqGiUYkxckCA?=
 =?us-ascii?Q?o56epFPKUl/qzfKyLhAPvPGSNdg0+oBskB1toRP4J9O51qtVaOB7SUl7hb8/?=
 =?us-ascii?Q?gZLyz4d1kOhiY+cu+TvkkgKXP1qTImPDRgnBpHJM0o842tqH6FA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:gw95+ZL52bxTAdCAHFVIVn5uiw0IaNYCM6sCktO8XtVxC6+am9AUV8oAeI8aLjnWAQwFXPiP7czD1Itw4nerQ/B7ugUDTxdYcUkvfRbYDaYiDeb3wC+gqrQE5948C06iddbjXto0VscJdvluJIlmeTbd9HI+lM96PIJ6WtUFmQjjcC9JNXrpUqXsNuhfslurT438L/XkmLoppBzVyiC4VIdtOQF/bCzUzwBp+9x3uhX9UmBzXS8Ucw2oOuTczE0mmc7tbZk0xgJke0X8xwE1TxEh8cjLczk7n457a7k9eyqi+NVPIlLavr1xIEQPKO/YO/2vXtlyo1R+91SD3Tbl9Q==;5:39Efv+wMTKxH3Y/h04OhqcpFphM+2wG7ttCPCeIgQod4tDwJSaNQKh7X2UAoU5fUS3+SWC6gVH/yOey9mtHGG76MR+vHZ7I/m8tTsNnU/2VAbCZ86r6I1+QJmP2FfGKsIx9Zq7+QLSImplFUSlUNTA==;24:+2AvhT8wawevXIbyczM5DJxo1C1ENbKhXz1y0Ud9kfh/JpvS5iVaGJyah4QzkEGSBuy2/uXiCY/Q1/meQzt/1odhO7LV9qIK6z+tyrxzUDk=;7:9rde2PYlqj0qQgEfdU0V29r0YPiSe4EMFXaG4QZXGgqe3G+OladDdEKDjqEmGb1BBc3KN8JI7WlKELyF2xuyJrhpLo4WB3ILFuamGs3BMSjauxuvPr+evxgP3aylldCA47iY5/oGxg9ozGq/oLrdGmsVc7BOSjVjFK8RifbexyfLMY/OgdBVrmc0Pa+JLDEZ3pv7NiB6FTsw5+kvcWPQ1xxJjmc6JzW4GTEUE2mAaYU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:42:59.1791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59872
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

Add accessor function octeon_irq_get_block_domain() for cores
with a CIU3.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c  | 9 +++++++++
 arch/mips/include/asm/octeon/octeon.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index c1eb1ff..5b3a3f6 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2963,3 +2963,12 @@ void octeon_fixup_irqs(void)
 }
 
 #endif /* CONFIG_HOTPLUG_CPU */
+
+struct irq_domain *octeon_irq_get_block_domain(int node, uint8_t block)
+{
+	struct octeon_ciu3_info *ciu3_info;
+
+	ciu3_info = octeon_ciu3_info_per_node[node & CVMX_NODE_MASK];
+	return ciu3_info->domain[block];
+}
+EXPORT_SYMBOL(octeon_irq_get_block_domain);
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 07c0516..c99c4b6 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -362,4 +362,6 @@ extern void octeon_fixup_irqs(void);
 
 extern struct semaphore octeon_bootbus_sem;
 
+struct irq_domain *octeon_irq_get_block_domain(int node, uint8_t block);
+
 #endif /* __ASM_OCTEON_OCTEON_H */
-- 
2.1.4
