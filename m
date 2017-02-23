Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2017 22:50:19 +0100 (CET)
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:37996
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992111AbdBWVuKGhQtH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2017 22:50:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ij9sFvGb0nla9Ne86RYIUxbi0yWSyxQZNmWOWtNrFqs=;
 b=XTrL01Rh5H5JktI0qo8OppD2K4Hdw145H45fH72Y8Ax7N0HPjhlaw0jk0Np/HHwFiAUXkfK6hJuV7qhTev+bGzPfL0JfatKw5bglqkUHBMrtTV7UCNjCJUA55Z6brZAhyZHvOpSa8lW8R0XPWENx4/PqwUz0KHOQI4SGOQkAVAg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from white.inter.net (173.22.239.243) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.919.13; Thu, 23 Feb 2017 21:50:02 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Cleanup of core PCIe file.
Date:   Thu, 23 Feb 2017 15:49:54 -0600
Message-Id: <1487886594-2161-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BN1PR07CA0047.namprd07.prod.outlook.com (10.255.193.22) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-Office365-Filtering-Correlation-Id: b1ccebc5-de8d-4665-fc1d-08d45c35ec38
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:+N0ryF6mKg4oEl/n8+qrZAtSBRG57GfXtlR7r0ihUsarotCPpU09eFpo0GSIepOa+NDKEWb9G5Sb0psDb2q0UE+iVr0wIKu8+cpREYQDjQRciVIm+iFHqWENQHVomV2xbvw1/SAJNHqVdqjSN67W/KKWMM9VaMfW4Ew30aL3CT8wowcwI7b7BaKpuCpNKSg0Wnh9vHrMmL2ePCrkpoXSgzD7JDwBDPLJLp0m/yVZEXzdp2G4nJYhrgI8xofAKnLlSdvAws0aXOWIiLk/DSQX3A==;25:yVskzKAMQVGEZOzAQ4KVKC4KkCz4uS3NjrahMPEcbuVkrLMtH6KQlyHvchlxeHJe/aJW87aY1nu5YRNQ0KIF2IxLNSb4VJWt93TIDaq7bYJtAeJnyXv3nAUyLbEyflOmvl/crDOJxOJOJgHXj79aPuWJEqHu3pVh2AB6c6Kj8e42Z7JR26EhjnBHA12hCOePOLZi4GTq1X02W7ARAZNvZrPiNg/u4X4R0gtUtrTXl6LSTDCEd/DzMxEtOQk0rJi72iB2VQlGf2/TW/UYztMSkd1fXLALBQ+cdrr64fROCsKyKm3v/UC2YSKwJpkRJ/shnoSVqRWU2O1dAo1O6iscOGDyW+StrWe7VAt8yTUQLwnuac80dtjPJPcwLDffrgLt8zk8T9B/rWxJLC2cJo0n3ighWr5qCrM67utAZQYj0BUvOuO5szME8ih5DTUQR1EaVHPXGTdg/MlmBvkgd8zoJQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:6VK3GvwyKy1UL84d09l+5esWazqE2jY4w8NUgIARcToP6cl2GXO/jMaTyytS2I3FBF/cCsm38w96wACdGyhlS8hoLpz+cjuNqeVtN9/wz9Ly+7cz8VhkkmPwJewjnvSZSKvYDoKguY6svFddH6JOBLc0csdH4PZZuSnu6E0aQNI2RzlE9xDb8bsF4MGDWeWZIzFigS473aYVDpgtb3goRZAsv+DgfXNkaJCjr6c8pdFpcNfbEJJQdAQWS+bZB/aoOlHTrZxUtmoip8J5daVrOQ==;20:b4Xgzxu1GQzN8k+7HzU4JAAWlmQd7l77rZo6rT2kCGOj1ikv6N8wCkWiCJFK7LxlanR+9IBlK4LqBxJN6c8VLgGHf6WZQLPIDjVU348/FlXjfvUrXEPMSm5UFFvVV1dNTsL3Ts7xP/FzSxofF6uRLxmh/c68D/bRXQbHgCCdZp+s3sl6ZHDXI7ikSiJoWqS7PDSMJmzQplBLAiCMNI73lCET+OC2cA9gZTvDkK8aNG/XQQBl7aYcxg757BEmEEpMneWEKmLoMVspd++AC7+/INevdFA7uwcFoZBghhGSZVBzw1DehnxSoOu1N5TjWZV4zne2DpTEOTzepxGA09BI/MjdSOsI5nXjvvetagFOtjH33PxxmTExIRd8Bz0l1y+E22G5E/F+xqMRguGgl7YP7l4zU7u5SNfdhkN+TdiVfahqlmmoiV7GuoDigGlyhj2WA6MfYPbnpJjtjFg2lIc6KfEX1vagZVXQhSy/I3WS0vH62M4McmtayOKwQdi5g2Bg
X-Microsoft-Antispam-PRVS: <CY4PR07MB3206B7C434631A68D9566C7780530@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:4CcLCKRfRL6AZxMeL0fz03I6jIaJejUGfZ+MhwUnfJQFOSJwDHepWNw28aEcBLMNvVabDOwiREB1yRkL7KNjIN6SV5cLxCcKkPJYKp44QG9rv7sJenHUe7Xjh7MRmCiwl36s/ri+CMGZidGV2r0BoMyfwnD11hZrvIiO6ktJDQ/Pai8xXJRID1531iU4e/LjOj7JTHx3SYr+A/xOHMu0w0JuoQP6x/H8qPZywBTaz0lImTVsV5ZaeGQK5ZMU8HMxsfi2M5Tw718sNuJO5lTBNC68eOCAocsuw1INL2koPVY1TQ/wU+rwXo8SQiiL/Thrq/REq6c5x+zENdQZh7FovAOdhqqrawMiMNn3cw7pPGhw1zFsh3nu0hPSknkhgRIysaPi6DcgJjNbIbaMWmmUYSvWzzDDlUlE6z0PWICmssnu8N22jjGqD+56W8t+4hGlqoXVAkTjdhBPTYYQf5LYZ5ABuuOoVX2KOgSYl2gDKK9AMjRdPzBsEe7LVx5pbh2CFrvsC3/5pDFBXs3lAuR/zmRkHuDCMm3SQn2GFXFmc40XvSj+lGaUfuXefMJxiE1WBff6iXnr/r/zm4eGJOHgSU71t8IulnOSRVwNOg7zgY8=
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(199003)(189002)(6116002)(66066001)(33646002)(7736002)(53416004)(105586002)(3846002)(50986999)(6506006)(2361001)(6512007)(450100001)(47776003)(6486002)(106356001)(86362001)(92566002)(2906002)(25786008)(2351001)(101416001)(189998001)(42186005)(68736007)(48376002)(97736004)(305945005)(36756003)(50466002)(38730400002)(5003940100001)(6666003)(6916009)(8676002)(110136004)(81156014)(50226002)(5660300001)(53936002)(69596002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:white.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;23:458UWAr1kbXYRta+6+L9WclExdhVbOwPJar00kP1p?=
 =?us-ascii?Q?S/H0GCWkG4MqtpdREO/2hcYU+j3ZboSwWsELVBvz0/CT6A8gz1ySbcn810Y7?=
 =?us-ascii?Q?IGtcJRezb0KesHAAO9aAbR7Q4k+vT1Ehyg4xKFbahs0CulMn89YNqY+RZSsC?=
 =?us-ascii?Q?0HgLH87nWHvrFTmqyrX4W3cXLmSeJX2AV2NxH+z8vEU5zJeKtf5ndgtfWOvW?=
 =?us-ascii?Q?aInIsbHfHJEjFBJpc2iKh3thxIn3z7oIOzcKxqMvUakroMJL+ko78z4jmp2M?=
 =?us-ascii?Q?lhaTClTq6ob/SkzChPFz+CqkpYRCtUckXN0u0oVpOzzVS0NGBfTvkrBObmCj?=
 =?us-ascii?Q?iSCb+8HuNWsTn4DcgWTR9PiuQKzdvwGM7yCcv7GJ7KbV3qYLYj7Xeqe+25ra?=
 =?us-ascii?Q?wUEqIJUubWb3Dkxc0kwwnCOiopQtXR69A7PUuYFHxcu2CFFzi5l8F8jqscCY?=
 =?us-ascii?Q?N9P3NeXRuhuB7C9NL6FSk41T5UDwBC8xEKb4+tz8kDVCzKvJ/68P+8z+/++H?=
 =?us-ascii?Q?ywENBBdVRxd+MrLoepkVoMRSI2vq3gh1yA+PRdnIm9uxUXLOzANaBYi6URdn?=
 =?us-ascii?Q?ZN/xGw4125y7ePEPmdsn3X1bMUEnltbZIS4dJc9NsP8lZdTVjdsVHfyxgFIL?=
 =?us-ascii?Q?wxU304lTQrSsUNBMzaWP9vmJBchnrXPJG0lIhdDLj3lwUH/Mx3HYx9sbH9Tp?=
 =?us-ascii?Q?dKE3/giAHkWJZrjoIi7f1jYUxdnPm7GyBYfMKXa5pmfIfOp0pJq5wuO/uXAk?=
 =?us-ascii?Q?vQb8L3ER1j7KVLTHSiH8fKInHlH5KCk5sT9FB9aWIiAC2Lnh8YOHLwQvhALx?=
 =?us-ascii?Q?BNAoIQpJOqLtPZYx4PI9kRGguhq0Qib7orEH3RjAd9kFAvZ09qf2D+JWfu6u?=
 =?us-ascii?Q?Vr+CPg7o0qca8sb7N2zv5iwNagsONDsEvKDgmpf1dT++Lyy8FC2jebo/3b7A?=
 =?us-ascii?Q?g/66a09JNdEtZ+q7701F8NJjONqDoDXO8a8m0DTPoJhzxGOB4w9MEPqmOut1?=
 =?us-ascii?Q?YUVuMPQI3sPvtso1A/SFzyu0rMLBnxb3Jk5wnt2GJImu2J5c/WcyCFyhdHN/?=
 =?us-ascii?Q?LaA7yhqPDJAavbam/Dk+0FTv9sISGUj59g8iZQ/Y2drM0Hxgzz1RaiiJUqXZ?=
 =?us-ascii?Q?28IArRMxAWbNQ8/Cz8DrAZTBapZ1G/6?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:FBudjzXrCg7Tt0kXz45qbutnIyBkYCh9buRW30S4PeXE5uqh7x20krFPYzhUS5AgqmLGBG6VpbzR0Fk9qA5AcWIe4c+OgbR/ClelcPGlRU6uVmG2NdVtl0WldnHeJlq+CPxVVWVMLxuQwMtfg9860+aQxonYm4Q+eaaK6bXrnAtDJFuERQKpz0GxO1ldcj0IFAD2WLQnTNRF9UUbgC/8vYteC5hrVHNVV+LVMNYasqvfyEACgma7IKjkhYnGK6vz9G+4GjfAGlE/k5b2ES3cdFE/HyqH3h6EO7vE8areCB5wMiueI7PT6i5Rw7oJdfIJ0HG4DDCsEiktMN/4z16S5v8RVfDb079yZ+MiEuAW+m/BVUE8Ob7stVhg6RGCBwj/ynbJNiHffBS2NI+rsEbvAg==;5:Q+OTTiQ140TGl8LpxZNiiKP9vTSVRepj7vZoorCEj4CksiOiitFcW/wtbDrTfgeevL7NmvcM7wOy8CkcsZgfF19reLBj4dQJCkfEKl94wMLoQkMemhogtSSyUJfidEMEPuQ0qfevuCqbrTMrt9LKAw==;24:NVLWg/66QqX1w5E2XJTtUjH8dZmNiQrSgR9RUsuglADsDGD3MP2WX9zH0V5MYflbejMM40HRSecW/+kqQR8B4eHyLL0rnOIVxdlr+JgRSHc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:mZ1H4ciddD++9cZhdQzuoor/cj75i51I3TzAn6cIllXCI4IpqvqtGs0dOB9UhM/nNBG/vy5z+OwcXyCtSnP/QxywRLZ/G+8EM6hcLKgNuIh2I/twuJk0bHA2Pzth3rt4YorsEwXkSKqh2FLeQxQEL0SaolEpcRZaXOUoM6i5uA2EQktmuSwem/eDtsjUTl7xuKcMbNeV0HiD/B1wxPNpYU7Dmg+oVmdDcvXa/nR2oPeu84NPdZxP5XXx51fGzLBeg6NGufi7JYcFsxJO9ggHvwmJrnzlgfIsp1uyEGB4nkupof6/s4c6Aq62fMn6ez1rajTqcFQN+YkBczhXfaJ9zQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2017 21:50:02.7878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56893
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

 * Remove unused header files and sort them by filename.
 * Convert 'union cvmx_pcie_address' to a bitfield.
 * Update copyright date.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/pci/pcie-octeon.c | 84 ++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 9f672ce..8f267bf 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -3,27 +3,24 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2007, 2008, 2009, 2010, 2011 Cavium Networks
+ * Copyright (C) 2007, 2008, 2009, 2010, 2017 Cavium Networks
  */
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <linux/time.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/pci-octeon.h>
+#include <asm/octeon/cvmx-dpi-defs.h>
+#include <asm/octeon/cvmx-helper-errata.h>
 #include <asm/octeon/cvmx-npei-defs.h>
 #include <asm/octeon/cvmx-pciercx-defs.h>
+#include <asm/octeon/cvmx-pemx-defs.h>
 #include <asm/octeon/cvmx-pescx-defs.h>
 #include <asm/octeon/cvmx-pexp-defs.h>
-#include <asm/octeon/cvmx-pemx-defs.h>
-#include <asm/octeon/cvmx-dpi-defs.h>
 #include <asm/octeon/cvmx-sli-defs.h>
 #include <asm/octeon/cvmx-sriox-defs.h>
-#include <asm/octeon/cvmx-helper-errata.h>
-#include <asm/octeon/pci-octeon.h>
 
 #define MRRS_CN5XXX 0 /* 128 byte Max Read Request Size */
 #define MPS_CN5XXX  0 /* 128 byte Max Packet Size (Limit of most PCs) */
@@ -40,55 +37,62 @@
 union cvmx_pcie_address {
 	uint64_t u64;
 	struct {
-		uint64_t upper:2;	/* Normally 2 for XKPHYS */
-		uint64_t reserved_49_61:13;	/* Must be zero */
-		uint64_t io:1;	/* 1 for IO space access */
-		uint64_t did:5; /* PCIe DID = 3 */
-		uint64_t subdid:3;	/* PCIe SubDID = 1 */
-		uint64_t reserved_36_39:4;	/* Must be zero */
-		uint64_t es:2;	/* Endian swap = 1 */
-		uint64_t port:2;	/* PCIe port 0,1 */
-		uint64_t reserved_29_31:3;	/* Must be zero */
+		__BITFIELD_FIELD(uint64_t upper:2,  /* Normally 2 for XKPHYS */
+		__BITFIELD_FIELD(uint64_t reserved_49_61:13,  /* Must be zero */
+		__BITFIELD_FIELD(uint64_t io:1, /* 1 for IO space access */
+		__BITFIELD_FIELD(uint64_t did:5,  /* PCIe DID = 3 */
+		__BITFIELD_FIELD(uint64_t subdid:3,  /* PCIe SubDID = 1 */
+		__BITFIELD_FIELD(uint64_t reserved_36_39:4,  /* Must be zero */
+		__BITFIELD_FIELD(uint64_t es:2,  /* Endian swap = 1 */
+		__BITFIELD_FIELD(uint64_t port:2,  /* PCIe port 0,1 */
+		__BITFIELD_FIELD(uint64_t reserved_29_31:3,  /* Must be zero */
 		/*
 		 * Selects the type of the configuration request (0 = type 0,
 		 * 1 = type 1).
 		 */
-		uint64_t ty:1;
-		/* Target bus number sent in the ID in the request. */
-		uint64_t bus:8;
+		__BITFIELD_FIELD(uint64_t ty:1,
+		/*
+		 * Target bus number sent in the ID in the request.
+		 */
+		__BITFIELD_FIELD(uint64_t bus:8,
 		/*
 		 * Target device number sent in the ID in the
 		 * request. Note that Dev must be zero for type 0
 		 * configuration requests.
 		 */
-		uint64_t dev:5;
-		/* Target function number sent in the ID in the request. */
-		uint64_t func:3;
+		__BITFIELD_FIELD(uint64_t dev:5,
+		/*
+		 * Target function number sent in the ID in the request.
+		 */
+		__BITFIELD_FIELD(uint64_t func:3,
 		/*
 		 * Selects a register in the configuration space of
 		 * the target.
 		 */
-		uint64_t reg:12;
+		__BITFIELD_FIELD(uint64_t reg:12,
+		;))))))))))))))
 	} config;
 	struct {
-		uint64_t upper:2;	/* Normally 2 for XKPHYS */
-		uint64_t reserved_49_61:13;	/* Must be zero */
-		uint64_t io:1;	/* 1 for IO space access */
-		uint64_t did:5; /* PCIe DID = 3 */
-		uint64_t subdid:3;	/* PCIe SubDID = 2 */
-		uint64_t reserved_36_39:4;	/* Must be zero */
-		uint64_t es:2;	/* Endian swap = 1 */
-		uint64_t port:2;	/* PCIe port 0,1 */
-		uint64_t address:32;	/* PCIe IO address */
+		__BITFIELD_FIELD(uint64_t upper:2,  /* Normally 2 for XKPHYS */
+		__BITFIELD_FIELD(uint64_t reserved_49_61:13,  /* Must be zero */
+		__BITFIELD_FIELD(uint64_t io:1,  /* 1 for IO space access */
+		__BITFIELD_FIELD(uint64_t did:5,  /* PCIe DID = 3 */
+		__BITFIELD_FIELD(uint64_t subdid:3,  /* PCIe SubDID = 2 */
+		__BITFIELD_FIELD(uint64_t reserved_36_39:4,  /* Must be zero */
+		__BITFIELD_FIELD(uint64_t es:2,  /* Endian swap = 1 */
+		__BITFIELD_FIELD(uint64_t port:2,  /* PCIe port 0,1 */
+		__BITFIELD_FIELD(uint64_t address:32,  /* PCIe IO address */
+		;)))))))))
 	} io;
 	struct {
-		uint64_t upper:2;	/* Normally 2 for XKPHYS */
-		uint64_t reserved_49_61:13;	/* Must be zero */
-		uint64_t io:1;	/* 1 for IO space access */
-		uint64_t did:5; /* PCIe DID = 3 */
-		uint64_t subdid:3;	/* PCIe SubDID = 3-6 */
-		uint64_t reserved_36_39:4;	/* Must be zero */
-		uint64_t address:36;	/* PCIe Mem address */
+		__BITFIELD_FIELD(uint64_t upper:2,  /* Normally 2 for XKPHYS */
+		__BITFIELD_FIELD(uint64_t reserved_49_61:13,  /* Must be zero */
+		__BITFIELD_FIELD(uint64_t io:1,  /* 1 for IO space access */
+		__BITFIELD_FIELD(uint64_t did:5,  /* PCIe DID = 3 */
+		__BITFIELD_FIELD(uint64_t subdid:3,  /* PCIe SubDID = 3-6 */
+		__BITFIELD_FIELD(uint64_t reserved_36_39:4,  /* Must be zero */
+		__BITFIELD_FIELD(uint64_t address:36,  /* PCIe Mem address */
+		;)))))))
 	} mem;
 };
 
-- 
1.9.1
