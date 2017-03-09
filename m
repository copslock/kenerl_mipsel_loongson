Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 15:16:39 +0100 (CET)
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:15712
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992123AbdCIOPyYSxgT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Mar 2017 15:15:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CQ5glQnfZ/+iKLSpVm7j10ySw6fsgEgOYsxeQA32JsM=;
 b=NbYVOyAaHrPVUmSFS1PeBW2+ZlxsqvYmN1CdGOvWQYqMXOEv4hSXk1Opj4LjO4UVZj46zs0AfJQ9dyjDnU/odNE2hKQXUQjENBEn7KJEW+FBqY6p1AzQ6ywOSfB6HpYq1J5RKUD746SMSScNe2n7gbJwUQrOfknsTytof9Fsl2w=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from white.inter.net (173.22.239.243) by
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Thu, 9 Mar 2017 14:15:44 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Fix compile error when USB is not enabled.
Date:   Thu,  9 Mar 2017 08:15:38 -0600
Message-Id: <1489068938-9795-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CO2PR07CA0059.namprd07.prod.outlook.com (10.174.192.27) To
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147)
X-MS-Office365-Filtering-Correlation-Id: 631912b2-44be-4698-2992-08d466f6c69b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;3:/7H7aaFunT0JaZGHdL/D1/wVqRoqgWEQkWDb596VcD0DL27k1S+p57z38ZlKNeSSRrmp6Ekocr95hBlgln5byVtYEGbSsJOjYRTdOVxvZVBL+mh6V2/E04co6EyJjs+i1+OLSqwQeqNK52FA/NgN+9Ki77t18DYNUXzG47Y2gGtAjhYj1itGGFNFOQ6p3fYonHm6aa3/iH6LanxtD9lJrVPAvK5ABte6mTf9Fkiui5WmNgBz2/0kMGXXob24qz1jB5ZNAtzFl/GZUYdI3pT2nQ==;25:rBuCkDJDleweoMFQ8fXIyHgLuLJixyGN7Ily/FI2bFa7+4Vg+RwycW5+E+rHauETvA62LMX2Da/4n5r5Tia9dl+0+zz8NPqyp3/NBGzbfraoMzPo0epVp0hcwXbJBaBhjgDt7n093KdtNmKAV8+q2cSHuLr98fjjaj1oyHmMwjQOCN9ylrTV1LP64nYETg0qy2U30UsbOQ9I1OsXYquYwPuzuOAUgj8hv/YnXDA1HJ/sSrRpTe80I1A93D9tKVFczADFlSLBBapzPwK51Vl873G3PwMbuFb73gYRP8P9VnnKvRsI5gITfiwIEZswz46gyD/LR+Buh9vEdGJt0AKxb34W/0xZt1lVAmyHk3mb2bxU5kMVb5kfea/IuPCKQZOo+wikc6ZdQ8jzhFlIP/MLm9kVaRAXiK/F2INGuBEWPdk5JG91yFifSG7tZ/e1bNo+
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;31:e2hba/ZQPmZdIP/3C4no+vCculKFqCxM233zZBIRjxtuFmWtVwBMAn7J2zZPTRVfhvgWmQleiePXncGFwZHYm4dGSwUAQl7zbAnyCvzU4pSHEC8FbR1oMGZuMwmgcwozi7ukQ/RZ/UoSqElR9bs6jyhJIJv+qASSNAGk8DupGlQdI1ZPVX8CV1XJnfIKJ5HwG5R5UJhb3yig8OiEoufeomtP3K+rVgl5+cbvSgRNb1E0ElF6w/9X7YWZcVp4ORUTVdcZS1atf1fzGO4swuHYwP+G6VsONYFqkxCnqxIkswQ=;20:pPZhlBGjuPDcuq8DIY0C4YrJAC5dxiShJA9wMovTibxIgGcWq/mJZ0FIzzSJDtvV8Lyqurm+oURzOjzNTpJdS3GydcqNk/FIl1cEAcTni/aw2Y9roQ62/CeH8cDd1X5NX3JTrW37cPkj7Pey6sOXm1unhfwGss81mLS106oNLNs88DRDp/31apYcA8BeMJD2b8s+/IaNLnxS4Du4v3C8OsEjjyAD8Grd/RiEycgk9AesX4cEanu7Iwce0ciok5gRVy2iZ0Xb3wc/kfEw1J2h6yTp9V+5o14H32dkCXzm9RisbdtQqbuEeUUR+nX8KjP+LIDhm47VBEa0+kbvIGsCyWb349G/F5E9NR2wJ5mGVuJWkIe/rqBI4pogoOzmexAcfeqTDukOLp7pVCepUdnvrWC4oBVnyhShsy/XTf3RBu12+KkoiX+N66h2WZGy6JJmVq0QE7VkkX1wb0xWVwB6WptibDp52kgZOeombYGCPknH77s40F9mKzwjB9K4XIig
X-Microsoft-Antispam-PRVS: <MWHPR07MB3213B0060947872EA4F8AF5E80210@MWHPR07MB3213.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123562025)(20161123558025)(20161123560025)(20161123564025)(20161123555025)(6072148);SRVR:MWHPR07MB3213;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;4:kEjV5e7e0QLP5ivDuvfb+PCY9my9PQhitchdVXLfxhqjPm7gAu8xoR7hVMLPC64G1V2plLMH8tqbs9RUxEY58nT//rvaqfK6xVNg2yS6SJlSRKuPG/2nkFKLilPe+1gP2uqrhRtpOf4y0GJuwzMLNjsHBvC70Y7eL3yMODgCWn2uyPTm1cYZTYjq71ICSbLUcYjG7SIvE69YBJqw7jj+PlkmUXjKdb2ueqffI0+WHzdCAun4TJdZtegc+lfFgP5c2X9pvEXOkUZWZOR3kNUeqBPNFbNRLIVuzybZm6hNa9SQisqWgn5GI5Bu0KSCQ3z5wwPdFE3/EhnRF4YHTRssaZ2RzmyX/X/e7uSS00zgTytcL79YEqGYiSa6vuRwxKMac3Ul2zNrxZbZAVH2iPE18km78i61h1QBQIjJIx7e9XEoduMaJDvQ0ReSGb7BEnDCNjgrr/MJfzbuQFPjivCdWXzdqpqyniitVllFWfTCvE7ghrf4FwRf3SAf/W7InqVXhIu7d/RBV9p0BwxGFzTFdev9KbsyfGWJH8kr+xJ4xXSfJld3UryzXibcg6zs8TEcEf4Gny71hismM+bs+0bjRkxwgBt6+kkK9EqorsfgzSw=
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(4326008)(50466002)(6512007)(6486002)(53416004)(48376002)(2361001)(36756003)(6506006)(50226002)(38730400002)(86362001)(81166006)(110136004)(2351001)(53936002)(25786008)(8676002)(6666003)(189998001)(42186005)(5660300001)(7736002)(66066001)(305945005)(6116002)(3846002)(47776003)(33646002)(450100002)(50986999)(6916009)(5003940100001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3213;H:white.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;23:ZsG4JsJXKmRaVcpP3H1yHQfKDKxfu4iMcrbPr69iEh3ifl6FSCosgTGu4GVM1rW24AyymC0I9rm+3GkdQ37gBAhILlSreNL8vpsboC3LWFGXIBDCZoiyFOEEKn/OHiE3HhlRjxU9Ys8sY6jzNDI3meXYeCvVrU3coLZGiVWRy9xP5pmaJ5GdYobMFNoNYuTu8umyyhl2QtWsprSQN9YX8JWecPbqwtWh03+3bJePWN8ytWDAGChKgiZpryS9h4wAeoC8KGw+vHioTJb+WQayQh1j/7RcUkPwTdA7DbLfZJVqFAkDlEAMatG4FTcFWA+bTNpuKV/gBP7iSAY2Q9Gry4N10gA1ke9vChPsGVg3E/xrqHgcRAmZv71y6j/6jaVyLGEFpiS92LNnzOsctWwB2KNKmW5DYiJAkW8p94iMkooO5IAfFslErHp66ipJOfbjHXO4WjgYryRYdkzz9XV/sBjtwIzkt376/QV1UMXETtZ/UfxUMojp8zqyT0LsPJmA56jXPnHW0RdxxMu58Kc6jMKXQEgOu00V13X7aZ6FmdLbw+X03IuXVITXl51TZyOFn7xpCOFTFyt/OZ13Jxkp/uSCFbZ63AzxzR4hB+ikR6irpfeCkgVPS6+HEKi1IdwGWrs8MPkPY0oHW7IZWJZnu6A9FU391iy66+gaRp4yHFpMze4JyKXXrcGXGRgVWqxzfLHzCyCm4EZfCFLPNsoI8IF+1CgdSvZOac9EY9KXa9adn3h9SvgnIt2juaGrCZrz6M7IlinqlBjs9cEItfsUb0W605a28Lyt69l0/UktEtx4jaOibF7qJK89qPq7ZrR67CTTbnpIQa+e/DasWwKsRxhSuU8tYY8V4o5CuqNL4ijcOnAtq/tR5JqwQc2pr71GF931Du5mCELw2Hz6iVNQSmFqNJWkuRB9WaNmKXYAw9M=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;6:oo4chlkdhwGMK6EpemBH3iGRDAUKLsCpUfrtiUNHhKNO/ERyxRTOC5Pgm+QA/T2zUD92OQc74ztv5ZMQd4kDo61f47T1mdBeOnkiauTLbCIYPfAJaywW2W2zXdUSMS0qOB7BLr0g/PkB+/jKEQliPDV8tg6QX33F9ZOOxxJ2s6n2cwVelznFewQmcZhMjpPxosU4yyLagtPBJtieMySj7wEnbFrgRKkFl3fpXgJGtLbnTyIIOemiDCYP6FDBLL61Riu3Tvrue9cT3UKycmAV5nSHYjg6bWHyHnrmL3eZ7RMZOnogIHM59OOLfxBkugXCRjIPaoBhdEYwJ+XMsjIdwchzY47F5ZaiWEfkOV2SNIHWD0bevSt3oksb7Qx5VREu35amgI9voNi8Aeu79nqNZA==;5:HOnrwPa5Uk/Bd3s65GOk529oaE4Xp74wf3qxCtpUOqL52Ml4hj0m3umX7/GS7NWQXkwHM698xI1ptogj9RIy6+jLJ3xuknjnCi8+Ufdha/s1HUnF0L/7MwF7X1Nv+haRR5OSN3LlllF9GvtbmKOEDg==;24:rB2JL7dhXBx82CTiEB1tauRdBWNm4jb0r5d2XrTrbYlPuIeQLO+bYLmTnCKbAwENsAZqyITjZhsx/fBXOQdQT1YibNdlnFLLN8DAkHdOdos=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;7:/WKka7qSAbCqYCbYQq86V/YwgYUeZepaR9aKyR6Rd+/c5204kzs4QDjuxql9sLlcIr2kFnIb3fClGTxZjZNj3GbKnzsdKhaoY7HWSgdNNUhCcgctDhHXIshkIRSfj7cK1mrih3G7ACVrofHMeJ5m2qJs9k+9aC1KWZCwWdCQpxqPX6e4pyXXE/Gs/WkpceRDyhQcn21cosrEkGaXpoX3irCwD+jNtMBAO6Ba0UaEh9Tu7ifLj8dEji1YCg2FevwKQYb1JduVVQmr/l9dPXV11mvU9GF0Tc8I5z4hru3hQCHExPrvNZ6KVFd4i9kGXq4wcczkwal7y8iJP6QykSUS+A==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2017 14:15:44.2985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3213
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57096
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

Move all USB platform code to one place within the file.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 97 ++++++++++++++++---------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 37a932d..72d2a5e 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2016 Cavium Networks
+ * Copyright (C) 2004-2017 Cavium, Inc.
  * Copyright (C) 2008 Wind River Systems
  */
 
@@ -13,61 +13,19 @@
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
-#include <linux/usb/ehci_def.h>
-#include <linux/usb/ehci_pdriver.h>
-#include <linux/usb/ohci_pdriver.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-helper-board.h>
+
+#ifdef CONFIG_USB
+#include <linux/usb/ehci_def.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 #include <asm/octeon/cvmx-uctlx-defs.h>
 
 #define CVMX_UAHCX_EHCI_USBCMD	(CVMX_ADD_IO_SEG(0x00016F0000000010ull))
 #define CVMX_UAHCX_OHCI_USBCMD	(CVMX_ADD_IO_SEG(0x00016F0000000408ull))
 
-/* Octeon Random Number Generator.  */
-static int __init octeon_rng_device_init(void)
-{
-	struct platform_device *pd;
-	int ret = 0;
-
-	struct resource rng_resources[] = {
-		{
-			.flags	= IORESOURCE_MEM,
-			.start	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS),
-			.end	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS) + 0xf
-		}, {
-			.flags	= IORESOURCE_MEM,
-			.start	= cvmx_build_io_address(8, 0),
-			.end	= cvmx_build_io_address(8, 0) + 0x7
-		}
-	};
-
-	pd = platform_device_alloc("octeon_rng", -1);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = platform_device_add_resources(pd, rng_resources,
-					    ARRAY_SIZE(rng_resources));
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
-
-	return ret;
-fail:
-	platform_device_put(pd);
-
-out:
-	return ret;
-}
-device_initcall(octeon_rng_device_init);
-
-#ifdef CONFIG_USB
-
 static DEFINE_MUTEX(octeon2_usb_clocks_mutex);
 
 static int octeon2_usb_clock_start_cnt;
@@ -440,6 +398,47 @@ static int __init octeon_ohci_device_init(void)
 
 #endif /* CONFIG_USB */
 
+/* Octeon Random Number Generator.  */
+static int __init octeon_rng_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+
+	struct resource rng_resources[] = {
+		{
+			.flags	= IORESOURCE_MEM,
+			.start	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS),
+			.end	= XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS) + 0xf
+		}, {
+			.flags	= IORESOURCE_MEM,
+			.start	= cvmx_build_io_address(8, 0),
+			.end	= cvmx_build_io_address(8, 0) + 0x7
+		}
+	};
+
+	pd = platform_device_alloc("octeon_rng", -1);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = platform_device_add_resources(pd, rng_resources,
+					    ARRAY_SIZE(rng_resources));
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto fail;
+
+	return ret;
+fail:
+	platform_device_put(pd);
+
+out:
+	return ret;
+}
+device_initcall(octeon_rng_device_init);
 
 static struct of_device_id __initdata octeon_ids[] = {
 	{ .compatible = "simple-bus", },
@@ -1003,6 +1002,7 @@ int __init octeon_prune_device_tree(void)
 		;
 	}
 
+#ifdef CONFIG_USB
 	/* OHCI/UHCI USB */
 	alias_prop = fdt_getprop(initial_boot_params, aliases,
 				 "uctl", NULL);
@@ -1051,6 +1051,7 @@ int __init octeon_prune_device_tree(void)
 			}
 		}
 	}
+#endif
 
 	return 0;
 }
-- 
1.9.1
