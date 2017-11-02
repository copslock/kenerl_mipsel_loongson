Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 01:37:22 +0100 (CET)
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:17835
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993155AbdKBAgk3w3Om (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 01:36:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H5nBmSZoi7F4q+THjhmGDsxL1SaBD1ybpCKXd/Hxa5g=;
 b=okgNzUO42DFC0F5Up4++1qNXMQVYWmDwUCCuytKWZF/uYuAuqTufwN4WM+JXyuSsCNRzu1MAJnnfSJPio7t7Uzz7b0Wxb1ikMTieo8c7DBSL4CZpYgp+Yl+RsfQroUGWwScMeb3alJ+ZGfSQyS2VYamfeeE0oEd3gSIQfDN83Ww=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 00:36:24 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/7] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date:   Wed,  1 Nov 2017 17:36:01 -0700
Message-Id: <20171102003606.19913-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171102003606.19913-1-david.daney@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (10.174.192.40) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64443c6f-96b6-43a7-e9ab-08d52189c276
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:01BZ9c1neGNAFwefgRcK+KmxYB1h+CwhLScRldSbzFR2Wx2T+m0B0JMm/tCTmfQgC+S2DRRMSWTMpZDVFYpvNnX+4wB6CVwPKYQApf38dxjzpFSkFn83M8YTyMwsqUjOqN6G1qsuzFD1jki3RJHG9Rm4vQhwdsmvk3zdQfpJnKmyMwRBg4nE+6KDbLuvGrT/LfSEu7STTh0ostqdEU7KGQnfpJ2pA8XJamCE4sWSyRCJa4h6XFwn+xPZRAL9u64o;25:e83wnpinb6B0jZR8UJ6DB5zvvonk10ZK6OmtxDkMHgf2ILr4hOQH5erpUuutKFUygPfeoN5A23l9K6NUvpkSmRnCuGhzI5mOY3F5judF9DISCBBl4XUvjksLh2lnZvcuZ6nC8ijILe/yHInbO5nm+8EKzNJI7+zFmdhTBcdWTJfwwX0duzbfhM3LTN/l6+0bSbqAQpB4nUQy1CER2lojnHurafRDZc0PWFiymfo+E5hJcM0o+F3fsjGu9gbinphF9tp5w4B2jDgGhUyo7T/QP0aXBXdBPgK0AUoUpaXphMV6hFknJoK/uagXnXHBb7ub5jQD0vv6rvuD9qslhCw9uw==;31:mUxY54A6N16o2WUKMV67muLbhWtmDCdgL+RBedg8luB0X1OcJfGMQlNVki9a+R1DDZx6VEpxEZIy8s5TD2e4DrOvl5yYoMFSgBOn/FudUwO4LtInY2m6bDeSvymJ/D+jjQt0WIKaVk6p8E+/Fzhtbud/c+0fYuI5hudEHo9WKRhNopOpSbsRNF8B8D/Z9cqqdHT/S4mGbRfeLmxa0I0Ozo4UEQ/ZGETLXXZ2wdobfOw=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:kJm/2SEqJYRzhmcQpirzh7VWEOH7yiDfQ8AMSunvRHbKRUusrNbNazE63nF5gPvpB4e0/iDZy1QJGOF/Nz97D17scYXop5m4zvuIBrfgQ1NhOo/rGW3y6+3UArPAUhxV7Y6v2jMNfpSrllpmzWnUO2pS8TTKAHxIQ2bty3r36/bYEB9RafE3QFsA+NuaYbvtz/UYND1rjr5VSlUHiEUpmERiRWJF0JSCAEAX26H1FmdU7oeBtgLzMYd/DegwakTKYsYt33lsWgrAaect7BPkrjqTzgcJrlzAorNT6dq5TLG0QcB11dPgKPlNDEcd1uRoNr2eS++ptDAvA3M1uZiMWeZxl3todMKRlcVIJBr6JBXm0CqW4KcxECC+Sf54GRJ8aoq+zfO1WkZBe+KXEV1o4SGb6on7yIoJNaqX8SKQbiUxvY2IpChbytLcjooYQQVj5JtFr1w6/dk4QL4mO4mjKpqYS34piqIhzctgIHAj+bfTxXCD56HCeHgo9V01M0kN;4:mHyiy4mbLZ80mV3RQaaRLCmt7PQq2eQP0g75vUWy7JihIhzzMqbCKWXmcoYAdXN5qz2CMY2KXdLrq3TNGjhS59dLtVSULleVS+ipPtGUBH2kAM6oYfB5b8NhQhvXfzNBFLTKCkqiVFwtF2jTnOTQJIj2G1AOPa2KAA8L0SgdVceGOfza2AP5hKhRK5klLYK9DAEVKvWVDsKkn8LEgnEvB5ug1G/9gbUp1RvDoEymQM4BhvzwLRBCwKiu173s2UgldYmFa8QcWi0Pdpz3rIVFoQ==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496B13FC80F20A534A0537B975C0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(3231020)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6009001)(346002)(376002)(189002)(199003)(25786009)(72206003)(16526018)(50226002)(53416004)(7736002)(105586002)(305945005)(101416001)(48376002)(478600001)(50986999)(6506006)(76176999)(50466002)(33646002)(47776003)(5003940100001)(106356001)(107886003)(68736007)(2906002)(4326008)(6666003)(6486002)(2950100002)(6512007)(316002)(110136005)(97736004)(16586007)(54906003)(5660300001)(53936002)(189998001)(3846002)(36756003)(6116002)(8936002)(66066001)(1076002)(8676002)(575784001)(81166006)(81156014)(86362001)(69596002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:LxV2Ad2QMz9bmGR1a/BFUzCwTzMOkGEOTRQJ6mbBk?=
 =?us-ascii?Q?CCUA40epXB7MYABSTh8n6W+0s2aBrmKCU+3/apigS4mQ3V+f1pw2jIzLyKYH?=
 =?us-ascii?Q?UNaMLD8KrPF5oOQ/BtHaCMO2n93O0drX7KxOTe7OGB531VD40gYf4MbXuvPw?=
 =?us-ascii?Q?emwuBdaX3IgXAoSxeoJPAWn7jDUwdhaMpaLmyO78I16CCfkY67geYVqPY5GL?=
 =?us-ascii?Q?yFIP2Cbf3jRLsjAWD0H4KgCc4t+pLjVyKzp8X6XOJ0yvDiUIhqUfNmR7ibtr?=
 =?us-ascii?Q?VQc+IMbHNM7hNrZnm2r6CWVZW7IbRBzVOHDGYOMVc94zgR1oSI0yb2B1Ae8V?=
 =?us-ascii?Q?QZ3XR82DbZEBKUkyHk7CTOZttkkr50/tE96zfbIhk4fTES63LA89AvTF6rrL?=
 =?us-ascii?Q?IK9VstAIzAB1waOT1jRbWQhmQ5bRPDpDFcOuGAZFZJecXB7dy5AzUyW+bR7X?=
 =?us-ascii?Q?ABOtLBsG5FRGgUfI4Nzy2DmbP14edNeJOLclGZ1ZF4gZBFHzWcKlCC+z7p/U?=
 =?us-ascii?Q?W+WBpCSkha5OSGWuiftwS9zqLTaYFNMZu4NXy5XGFkfdD92lawQdLfmJPpnN?=
 =?us-ascii?Q?pznVRchVGHxspcbCBG+uldYIhe88iVfOmUe2U9nkcD4wQCuEzaONe5Hr50AO?=
 =?us-ascii?Q?SZmhFpOS5IM0GNFHlkbjvqe1vmUOGHOanWqomJKZCjMae3ZKwcQxZ+lytt7n?=
 =?us-ascii?Q?d+SehrzsReWQlO4p3BqWDrpDf7Q9zAg87/Gkuw8r6yOqfeVlwFwH09+3ICQ4?=
 =?us-ascii?Q?AazCrNw7WvONInBj55cLmhXlrEYoj373Ztzvc8TqoljsNGsUmcf/oIX5TJwF?=
 =?us-ascii?Q?xgM6C/0qoP5pmg82rFh8JTO/d4gPLcZOUOqGiNFZoNfvo9vv3AgCoMroxJcv?=
 =?us-ascii?Q?ZfZOLPTR083ohsYxhAZCabaYY2yZ1VhvZriwFikw7sZoBdIyeNaE2TnXYl/y?=
 =?us-ascii?Q?aufg5+N6zdooQxqUJxAjIypkHIl8VT29HCPk1cOJ9RGvpK9yYidET91nZize?=
 =?us-ascii?Q?VUgfx5Csaz+U7lhOBEVX2wToL35XYzAo23+K/KatfQ/WlQD1aF8p2hvTOgtB?=
 =?us-ascii?Q?wIfbsCgrKGdZtuFqTVp9CTwwkrI4JvNMctK+6+O3OIidF5FnnKXCsRZGzs0F?=
 =?us-ascii?Q?RSlDBiWjOCjxJKj6xlKF3M9p+9ZdfDsLaPMu0Ast/fBDnNjbn0ZA8802vdfi?=
 =?us-ascii?Q?CPMbl/ukyT/cjurM3kIG6tS6IkTWPlW/7yQoJdqytyopqkqq2xcwGDnDK9sB?=
 =?us-ascii?Q?KSGzEKRBZCSP3gJoNR1a1cXAa19G/LB31lYzldRImuDogKOhfZlwDyji4AOs?=
 =?us-ascii?Q?2DxuMcALWvvb7VGcmxRFtE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:8gckkXw7rqK6KzK1A8sgwRwVehhRHTC6d0/7Bd3Ing+/PTZJ2QsVK60i5BjFaIsPuanahXDbaUVQ8DPmGDLPFqW+kDNnboyyulAaAB5byJHKLDbvJc9LUYqtn8QqlYF8WqSUeg9spp8Sjnl4ungLbjWIJkLoQoICOfpwzmQp1a3KFzGxcAHlmhtZWIK0xWFWmdqVbxaccMD6xlxMJtLX26tbzkn8i808GwSzQcTvzQLznX0xeplAIPTKDqqQbPdDMwPi9sMTrAm6LBJavw7wAaPGIc6bJfWWPYLI0iAw70EJIiIWryy9X9gayjPnuobeNjhTGW8toyJmrSkJBYdzvQSzr8LmPJ0Sf/Q5DKxWDJw=;5:v+4NReFiZnhpQ9PCp9qbe9lLHI8xVtd1kIwFN74G6dCZRPxF4tgiqs3mjhH8FLs6lMpE5e7zw8pzWA5aTGq9hO2vk7yirEMRoyxlF3wXlYq4IsUkUNwnXMOco9Y7RyhBhchNnQvT4gowfmaNzMK82qQ1AnxEIHQAUemB/+Je2sY=;24:spxud+kkR4H0q6NKvSJFreY7EEsSdPAL+CPcqA/9a/RXS9LN1SDM9geu9JUJ5h/PuAAqWVj7tsKrvASC8LNliOb80u12XVxRVoK9zNIdv4k=;7:p9Rl6wYYS+tqmL0mfqwAQst1VbZixMNMpLPKdVNPycKSvcSJjMSd85p2OuUupE/oqUTP+DkdBpjCQLBvFybcVq+ijC0e4z3vnOwvGXEm0FZbXofhj15BCRVLq8cIjnrVzY8N52kXS6Xd0A/TPvnGMdhOJPciy4ayUZdspeihZbL5gZ21zJ0VSfNop77Vk31pVvFO5zZWm3WnplybEnNSOfNjrFdlW7UZBIAp/stL2uVD90Rwo4+w2DOCZr4mhfGS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 00:36:24.0535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64443c6f-96b6-43a7-e9ab-08d52189c276
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

From: Carlos Munoz <cmunoz@cavium.com>

LMTDMA/LMTST operations move data between cores and I/O devices:

* LMTST operations can send an address and a variable length
  (up to 128 bytes) of data to an I/O device.
* LMTDMA operations can send an address and a variable length
  (up to 128) of data to the I/O device and then return a
  variable length (up to 128 bytes) response from the IOI device.

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c       |  6 ++++++
 arch/mips/include/asm/octeon/octeon.h | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..99e6a68bc652 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -609,6 +609,12 @@ void octeon_user_io_init(void)
 #else
 	cvmmemctl.s.cvmsegenak = 0;
 #endif
+	if (OCTEON_IS_OCTEON3()) {
+		/* Enable LMTDMA */
+		cvmmemctl.s.lmtena = 1;
+		/* Scratch line to use for LMT operation */
+		cvmmemctl.s.lmtline = 2;
+	}
 	/* R/W If set, CVMSEG is available for loads/stores in
 	 * supervisor mode. */
 	cvmmemctl.s.cvmsegenas = 0;
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6a79f4..92a17d67c1fa 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -179,7 +179,15 @@ union octeon_cvmemctl {
 		/* RO 1 = BIST fail, 0 = BIST pass */
 		__BITFIELD_FIELD(uint64_t wbfbist:1,
 		/* Reserved */
-		__BITFIELD_FIELD(uint64_t reserved:17,
+		__BITFIELD_FIELD(uint64_t reserved_52_57:6,
+		/* When set, LMTDMA/LMTST operations are permitted */
+		__BITFIELD_FIELD(uint64_t lmtena:1,
+		/* Selects the CVMSEG LM cacheline used by LMTDMA
+		 * LMTST and wide atomic store operations.
+		 */
+		__BITFIELD_FIELD(uint64_t lmtline:6,
+		/* Reserved */
+		__BITFIELD_FIELD(uint64_t reserved_41_44:4,
 		/* OCTEON II - TLB replacement policy: 0 = bitmask LRU; 1 = NLU.
 		 * This field selects between the TLB replacement policies:
 		 * bitmask LRU or NLU. Bitmask LRU maintains a mask of
@@ -275,7 +283,7 @@ union octeon_cvmemctl {
 		/* R/W Size of local memory in cache blocks, 54 (6912
 		 * bytes) is max legal value. */
 		__BITFIELD_FIELD(uint64_t lmemsz:6,
-		;)))))))))))))))))))))))))))))))))
+		;))))))))))))))))))))))))))))))))))))
 	} s;
 };
 
-- 
2.13.6
