Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 23:44:56 +0200 (CEST)
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:55342
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994061AbeGCVoraM189 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 23:44:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnUatq+qMj0QcynGlbGx9C/RwQ8dBqHn+8SEwRnMgaI=;
 b=HbzLsQwNycGjhH+X0i5vLKPSkKjL8jWj+2s0mYijw0BiqqhdexWMfVlXjig04sM+f6dkpQdQCcXQ54tCrGfLXeZdf9ksqelmyG6ZwxAciOZ9EWj9xQrV6NtzqP6ez7UaIzbUAx0klLhF1KGgAxUNBl3Vgc5XCfrtiO8MZMNsi/o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3960.namprd07.prod.outlook.com (2603:10b6:4:b2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 21:44:34 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: [PATCH v7 2/6] MIPS: Octeon: Unify QLM data types in CIU header.
Date:   Tue,  3 Jul 2018 16:44:21 -0500
Message-Id: <1530654265-26949-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
References: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To DM5PR07MB3960.namprd07.prod.outlook.com
 (2603:10b6:4:b2::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2355b5f8-042c-4825-026a-08d5e12e2ada
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3960;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;3:FFCj1LVhn6O7rygKvgNctqzEWjw74gwT5fPxzvQqG03DAV88tD7hcDEw2OiDaTwm5l4E60J98hD6iM5FkMIbrz9Br1sxpXOAYYE3HIV3pSFZK2G2rpiklAzI7C4idk3ufm7nuH3gmzEJggRCKZ6TTXqKosGGpaqxI12/EiGmhVodQMRc7AkVXgTkMTYAtnP5BjTptkiohLDJoi8+cqnQrdSm97HstF3UL8uRJBhZ4YWeyAqI+XId8n4z13a7TrG+;25:SGPIH+2Hd08p1vVhLjH8Y8LGBKixtNf2XoQrMxuXghcOTPS//pqnL+vgm/n7XU/G2p5+6MrP5F1iHbgRLLVxnsjEZ/FTP+WpmY78fJ0R40lSP6LBzDjl9Sc/Y171Jp1T/M/ehdeIk5k86/+D7z8k5nmIrRexNuudKV0JWTBChfnEKQL33HfK+IBoffr16ZmEU75IrDKQiUaURO9SGtFXZud2vCTPoUUv0cpa2BotsF3o6LvLO6TrGPLps1HMKq1rxcM4wEVHl8KMvnpJVdWbWcu3OXQriAOKPAeOPBKFBnlkCBMlvDFlSZvtglVwbpYtVElvq0iSNYwsuJRCrEoa4A==;31:CDAYFJ8nwIqxYcQM2rWK8tsEEA5lwThnzDYq/BWeUC1ZZBQxlO1NlN2DPznifAZ9Qk+VHaGgDdmm1Kf9B2P0AYm87yZKpH2ZkI3D7sg+AmoDLWxPTPwcwTvMV2hkzmlCj0d7o5QVmv59tUcrJ9RJ5BO8Jbamx2YII9zH6DfB2tAgNCEEoaUGrxI+eoi5sGXGbAWJE+rGbMmXEXAx2p4MEBisj0bmjSgaJuXfBfK7QAE=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3960:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;20:ieCPaKPA1RigXy95gOnCnppe9uy5i6IIeCSgi2GSfbx0NK5nupJFMTnJgz8JmfZRX5QNkh24AhJOZEl55KsoVgBUVebfQa1rItOQ3r19P8i18eVjq+dnO95mtRdHsBFLDmGAkeB6oBw/N6Ugi3TcKXSJ9ba/bz+y0fnGu+lorSDpz7C9Bak6qP8znmoa19ZbwCsqqRqADri9TOsYzd+HY9urj6AVdRJmhnh4qMtSSLthNcZAWo8XvHsZxL7cVqa4W8H7imZSes1UVxpCEWCDWC9AI3v4IdGYLjfZO7kgdD3sR8ink/R2iIpwXb+87kx36OsOAaa8S3ZXhERuUCG1jY8Cxr9cDHtK/uMULVK9bgu5KQKRVM2M/AZSkIiXOIaVhzf7I9FeZOhABm3V4r6+2VZRW7iIx/cwMc6ZZA9F4JEAUqPNqV4ykuGQ1ci+rIRt0US2FIAfsOSstinHpdGkeWNcO/1N5F16Q1I/M3W5pvVpWvWXkWDYeTZAZ8KuDgpO;4:ZKAW7azYkkjjFImZ+36xM7yxZ+6SVVEZjS3C5JhetSIvb1PXn6PaE3U5ML+sx9dwtye4/b8w1Df8RszV1miZjXYh6iGR3ebjb1jL1+ho3nODEYIGlzjL5BFqAY7HlUEkwtGTUUyo2rADBlttngzniS3b8bcmZhus4qcJBzHgmKch4VA90QqqkzgwQebc2n/Wuy8siTPkG+E09k0bgWFQ/ITolYaJ5Oi6CV3mr2jAZzLKKbLWDiE/ZHXBrY0aZvJgrER1joVVlUSx517WgHez2g==
X-Microsoft-Antispam-PRVS: <DM5PR07MB396033C9E5F39B5BDDFCCBE980420@DM5PR07MB3960.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3960;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3960;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(316002)(6116002)(5660300001)(3846002)(6916009)(72206003)(97736004)(6666003)(47776003)(66066001)(6486002)(53936002)(68736007)(14444005)(16586007)(107886003)(386003)(36756003)(6506007)(50466002)(2906002)(48376002)(186003)(26005)(8676002)(53416004)(486006)(2351001)(76176011)(2361001)(105586002)(106356001)(476003)(446003)(69596002)(11346002)(25786009)(50226002)(51416003)(52116002)(956004)(4326008)(2616005)(16526019)(86362001)(478600001)(6512007)(305945005)(81166006)(8936002)(81156014)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3960;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3960;23:Ej2oGZcHRL6XuLP6JvQhpXciPQu20ptsqdBTsPU4/?=
 =?us-ascii?Q?rOX0ZTff1qka5fBnfmKQNUinhtqGLSpZT0cWo9nxoNpZyOwSPkqgjrxbnb5F?=
 =?us-ascii?Q?ivOHLFGG97/KuP++1kPck1pDz1gaOYXPaVr79QJNF30FGkY8aQGzrMmiTwQU?=
 =?us-ascii?Q?O6SGTlpmlfqj7rFhe1ZIHhFPjLKTMGcrYgk23a8I3vjvDQHENnJfRl1fBfDe?=
 =?us-ascii?Q?OdEtpRpffKp3F5PpOI3Mf3/Kv9q/xbG5nbAr8OSvX1lOEg9XjQ3CoGPtJ2T4?=
 =?us-ascii?Q?Gsp6LHbGRp09r+76IZRdEj/mAkaPk7lIVJwV/IdPedEt5XOIQ1Lnorv61Sib?=
 =?us-ascii?Q?lPtIi/tT+guGqNoy9Xl730qvS0rIsNFjfMmacO9ab7K6NPSMMKyhhrMGIXca?=
 =?us-ascii?Q?DP2Zn2dN5uzJjZn2I2+imP5DKCwhONz3apLawPNQ/xKABWqXXV0i9ePSD9Yw?=
 =?us-ascii?Q?0THDYLmWZPziSdW2IdJTP4kqofI4e/0HXPgzwThvATK092g0LJ/v0jSvtbxu?=
 =?us-ascii?Q?i3TgR5wfKXfVwkbTZbMw2tfPxUFLW/3oQSadmyZHxgRjpW7NwMbvtnQeKVx7?=
 =?us-ascii?Q?1G4c+85UPtwKB37x0MlI9HrW8sbm6qi84QJEmb+OJ6CIyoJk7Rz3Ei9vFMAT?=
 =?us-ascii?Q?mMDBsm7k59670uDtW5tPeRMEdVquD0dF3G8rU0tg5UlvSixzlvO8lwiX2Nm5?=
 =?us-ascii?Q?iL8N2aiSKnptoVI3eGCBes578JSmutb07T6O/yQ5Qp9PwqTEVJ6sIMlAdhhu?=
 =?us-ascii?Q?YQnUKrsScf6b5HDv/iUz4pTZCATvtNcKRQseIbXP9gu4fQXLaYBHMXXyqXoH?=
 =?us-ascii?Q?EVhZUSXkcwBJ5Uk/FXfQr6KdYhMdBBbsqIIvk5TeybwSUIIU8R0E9NpLL+eH?=
 =?us-ascii?Q?6gcI/jci/1mTEmj9zkQBVRI+2YAxmVzyRDypmzZL9++3c2Zmk+8Yy3CKNAjX?=
 =?us-ascii?Q?aIeb9cE/toiCK1JnssRuMQqXFqO8X/qAmMd5BZOoyu3I6ANEtKU2l7tCHg80?=
 =?us-ascii?Q?n5GUmSgaBgyqyVmDIK8r572C43et6X2IiEAz2vCKTwGafaXXNsWlsn2mzvjs?=
 =?us-ascii?Q?+OrWXLAXgDAjNX9SunwgEf3v1IDD+QrUr2h6BltEln77FUE7+m+FJU/FhlRX?=
 =?us-ascii?Q?lq95gUWezh0NclQO/8Vf3XCT+RsJU9WlYIn8DI80Ej+PDK0nsIWwpfDxU0HH?=
 =?us-ascii?Q?GF3dD0vm6NYbTR9UfUBsUI8xYkDaS6ubmSfDYlKY0L7SptFwC/SWSb4kQOMZ?=
 =?us-ascii?Q?QTb3UGphRVAG8s9P2aRiYoibpzqIidC9NszI4tI9LjHSy58QNi3R/jf0maNm?=
 =?us-ascii?Q?x3n+XX+ov/qDqbQXIA3J1E=3D?=
X-Microsoft-Antispam-Message-Info: m0ma9mhnpoGY3csG78qYFo5X3+/Hqf9I/jMg45t5AFn/hW032EuU9+rct2OxO507rqEcB/FXaI4avxS/yDs5QufeSV6GmXeG6ZiisPCYzrB29jKh1iPp7mevjo0P9K8iXSr2hqTZ339WzFoJmYDWhbb+A1p69jxG5djR9E0fwsBgqjTLnzL3sQPLsHFzOsAUw9us+82TiJdLS9KzC2nSMh0MWwebBeohrGhRNDi4IhIVvK6W67IaoHT/y6GfjFVzU7TaLrafvQbEzW8pQpPzxjPLZ5k4ReD2u06t0PCSl30FD34fz9hmqbDeRHP7l2MS7Sjo7jeC7D4nmOGWb3sZuDizQzRmFMrK6gWlhgrcV3I=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;6:WuTWUdwD2OJ2h+aOmn8RvP7HaWlmC5BaW8+G1khDLS1lvZpS4S7/fQQ7+QOi4BHJhAcyntTC3ir6Mmw7eTS8iki2gxbzKHYLJNr0TBN2cyWY5CPHqklH23xjmyeCbP330I9ZWO7ouIEul5w1HHlZQPGfYnkMrc7Gm1NSLBR8y91BvOYSD+SHQ8mpTkQVqMH02H5lFaLM9LWRB0Z5NbEX+lvWjHP/F35/HOhZI3nTpHW5FGdPqhMRGrWgXyk9t6OiMeM48Y3iyeVWccePKb9LrBj1s+KRgUQXQxqLfGy3URMYAVD+JH9xt667CzROaGg5F58fyAPsdZK8QgNUAcFAsiIkikB5DCzWjwyl14t4m0kHJZ0zNLrjj5joJiOGmqUbDHXB5dyz9j8/ghj6iMzn8BhtGlHeYaTYQ894anlkqmuzNhu4pswMNPE9KlsVxRCYhSEUvk2535nJTfX3QX5K+A==;5:pzdkLCjVvwmzWp59FawoxRJnafPr6uIxMpb5b0iFfpRdXwUaYnI5gP/AUGSIACDIrsWPWbUhU0dnrNrtXjVO1bnmWrgTXPhL9CsZN1ITrnwkqr2xKAuIWpLVki1ogxl5orPuLvturA/uqjWDvfdHzwHzOZFaSzHxslGcbsOGpyY=;24:6Ro3/5FKTnoIofmEgu5kbO2lzoLWpVdeyblGmUOSgl5cf7r4jJwWmjg7FJQVd/Lg5C36xN1PG4D6/BEI0vwNmPDQRYN1pMJZDepTfLZWbLQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;7:Y79t1KORGkL2EPMyfeaLVTc7FGUl7Ah63V9R4o5Fr/7Q6CGod2+VoOLK8ZIXNg0OT+MZ/azZE5u24P1ZVUZXN9dsxJmlHlsmURlsCwiRZPN79d7FFFf9v6sJ6cKdxf41TEstl5d51XrIRM1bzKhUfDbEU9alqIAG2F7rsl1X9Ax0hv+Lhmmxhqw0I9jFnCxxPjKN+piumiUX92p5g0g0eupuwmy0XPq5xkP7O54kQnFKOhq0ec643fmVj0o6dNS1
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:44:34.3066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2355b5f8-042c-4825-026a-08d5e12e2ada
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3960
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64591
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

Data types 'cvmx_ciu_qlm0' and 'cvmx_ciu_qlm1' are identical in
their usage and structure. Combine them and update the PCIe code.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 39 ++--------------------------
 arch/mips/pci/pcie-octeon.c                  |  4 +--
 2 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 7c2168b..f8ca7b7 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -209,44 +209,9 @@ static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
 
-union cvmx_ciu_qlm0 {
+union cvmx_ciu_qlm {
 	uint64_t u64;
-	struct cvmx_ciu_qlm0_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t g2bypass:1;
-		uint64_t reserved_53_62:10;
-		uint64_t g2deemph:5;
-		uint64_t reserved_45_47:3;
-		uint64_t g2margin:5;
-		uint64_t reserved_32_39:8;
-		uint64_t txbypass:1;
-		uint64_t reserved_21_30:10;
-		uint64_t txdeemph:5;
-		uint64_t reserved_13_15:3;
-		uint64_t txmargin:5;
-		uint64_t reserved_4_7:4;
-		uint64_t lane_en:4;
-#else
-		uint64_t lane_en:4;
-		uint64_t reserved_4_7:4;
-		uint64_t txmargin:5;
-		uint64_t reserved_13_15:3;
-		uint64_t txdeemph:5;
-		uint64_t reserved_21_30:10;
-		uint64_t txbypass:1;
-		uint64_t reserved_32_39:8;
-		uint64_t g2margin:5;
-		uint64_t reserved_45_47:3;
-		uint64_t g2deemph:5;
-		uint64_t reserved_53_62:10;
-		uint64_t g2bypass:1;
-#endif
-	} s;
-};
-
-union cvmx_ciu_qlm1 {
-	uint64_t u64;
-	struct cvmx_ciu_qlm1_s {
+	struct cvmx_ciu_qlm_s {
 #ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t g2bypass:1;
 		uint64_t reserved_53_62:10;
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 87ba86b..f199ec7 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1239,14 +1239,14 @@ static int __cvmx_pcie_rc_initialize_gen2(int pcie_port)
 	/* CN63XX Pass 1.0 errata G-14395 requires the QLM De-emphasis be programmed */
 	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_0)) {
 		if (pcie_port) {
-			union cvmx_ciu_qlm1 ciu_qlm;
+			union cvmx_ciu_qlm ciu_qlm;
 			ciu_qlm.u64 = cvmx_read_csr(CVMX_CIU_QLM1);
 			ciu_qlm.s.txbypass = 1;
 			ciu_qlm.s.txdeemph = 5;
 			ciu_qlm.s.txmargin = 0x17;
 			cvmx_write_csr(CVMX_CIU_QLM1, ciu_qlm.u64);
 		} else {
-			union cvmx_ciu_qlm0 ciu_qlm;
+			union cvmx_ciu_qlm ciu_qlm;
 			ciu_qlm.u64 = cvmx_read_csr(CVMX_CIU_QLM0);
 			ciu_qlm.s.txbypass = 1;
 			ciu_qlm.s.txdeemph = 5;
-- 
2.1.4
