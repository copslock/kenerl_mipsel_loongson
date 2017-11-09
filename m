Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:32:31 +0100 (CET)
Received: from mail-sn1nam01on0067.outbound.protection.outlook.com ([104.47.32.67]:13737
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992211AbdKITaBXJAOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:30:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DxS2ktRUCSQyEsVW1fSMwbd2aBsMyZ+0V7gDfl8Z3Lc=;
 b=b4T2yHwukia21FamAmWdkghmYAEgUZnKCWUnsovuqvLK2EEypaCPF8jU30J/QWrV0+9QWTFl6i8oe66S+LeYReyULjiFyRbZ4Pu7JZH6m8sqfdYe6YvoyZVY9p0lHuygDR4hshvilBlvGhkpt4MZo95juIa5BTihj/NN4B1QBEs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:29:51 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 6/8] staging: octeon: Remove USE_ASYNC_IOBDMA macro.
Date:   Thu,  9 Nov 2017 11:29:13 -0800
Message-Id: <20171109192915.11912-7-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109192915.11912-1-david.daney@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db5bf648-9799-4614-7fcb-08d527a84014
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:o/yweXfP92+hlYn/UJZl9aaStkjwoXtaZNnpet7TV9Ah58hlLhQujq64N8zdGwoUYNhdG/1DREFlXql5NxSWEeo3wNsgpBWIeVgxlZRkLKx4JU8RkPtkUM5sUrjq/Ku4/VBwIjHC6jKI8JGDfVFMLwVmg415qOiUjDES/aali/sYVIP5umxYdT+DoHEhtQ3XiAtDppxLFg2qXHpACT3XBAeu9OlgvXiiKsBGTInLDwsVpgjfWv7aNr1kyhIENQcU;25:JM5HAEpeiQnkXAr/FYWg9RJ57Bl9LY0TQqgkHTpUhg3JOyo/ixfg2HdX3maRJXZ5TN2Bjdi5bpxjuOf+dDuwJan6CzOVUqBTbe5BvW2V+OnJAbb+a7QCXRbJvnw8EEPyHDPRK3WzrCHKjXjllP7GGLqM5XJcHi6WIR7my4of/9VqcXXqgWRxv1D4II6N0kK8qpBsp90U/yw8ksQ6tTH6Ter+bf6SgKqE/FcxTYD3GdOF38/Wht5j5w0ZwUO7DLp9ZEgbs7OdiU6zjXn37eOGWM4n5Ky/mjlRyJapkds21TPAWKkhFBUyUydWC1G6XmJTdDi2/8UeubkPewh/2jjCew==;31:v2au+q7NljxcFY0euj7fky2IAKXYHo1M+PNbcYNwCMeZh50GcOPLOa9doD/krMXH0ssXO6tUUxvu6WbT+6pzX0ETALV56tIMVjrOFrk91mu0VQO3ZbaIA5pHpEU8EbLxMtgpxkPSqUNVRD9s8sfWynk6PfkBzkJuzdICEEZzeTvWfJXO2CBQDA8JyNJbGEDfSpi0HZqH8XqO69lFTOMpSxIrIxZfqhC/X1UQFgr3Viw=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:8veI8trEFqjn6skub+xj3x0e3uso8OgTEAAyqiKV7D4H9f1F50St1h25MbIXVRIRsWEvefh6tSD9inoER+uja+PQgy8GZsqSf8va2haeqeLvrsmQ3Fkd0nDvehaGJtm7i3oG06pbrHxG7e7+BETCWUlc/TuMYx2dD67cjLDAX3cp5UlV71736J8XSUiWQKvyf7Sl5JwqEuP93Z5bkWQrUUlnJ9OWjCw5eX9IFhTWy2/WaDlz15XVYHLgKpYJuZLPa3vV2zhAF3DIXv4DOjFWDWdE1Goj4NMvN1xf7zdJRe8X/6VdM1p4+YGI6ESea04Xs4acf0jZhhUVs86N2lTsOCR2Ftu6fDiKTyCuEakxfJTAXwDF2hISuE8GBHfC1eZDLl2X+WbYz292BDX7NxL6xBirTSqX2e8l3zatI3ZC+Sv5xzQ5TZoWzO7+0D9CArF1uCoS++0dAIgrtcicOJFXvpLBrH9FeK3TBxw8TfnmVVethmAC6dCAwm50bS/OOSes;4:3xvpDfRn26EcFhFJHfoalvZRLmVy0HKZvUcBK8mfbldFk68O229PhGLb85ajRwtMYX0qBiHDGtnSFZDUaxf8r7RLPcPFsqJJY8mLyGkQfhnvWlTkyFDI3qkAbpoVHGurMLectO7BBBeAxfcd9f3JmV88QgERca13Nl6X6ZBftU3IK1S0frSwq1ooOu9Tq4yu6uR+KUpUzyMbvJfi5YuNbRTR3jhczs44r+6wT46EuxtMAEJv9sDAb39vwdOWEeoz5YufbSOtXO8FfVMMrajzEw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34961C038F021A6E280943DD97570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(2950100002)(69596002)(110136005)(189998001)(86362001)(97736004)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(76176999)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(5660300001)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:akiIfIbd8WOpl81sQjYzCCheZhODEhkthOuUcCWJS?=
 =?us-ascii?Q?NHXaaHpYYsfJg5Ttdo5a55cTcvTFQ+fu3j0qESP7lU20Z8KGf7c2zwJai1Cm?=
 =?us-ascii?Q?Orc/xUM78QaNlV/r8hSMO3PG9Tb0GTVEErjjSiqco7UZAAZ+Ar6uxGWFe8y9?=
 =?us-ascii?Q?UXwwDBTLGrf7UqaUxXMOr3xatwP48X3htvzFCXPIKZ5YVc6TC0Ydpi8e+RJZ?=
 =?us-ascii?Q?R2MzZoyDUfG7JS0X2pYTBgJzlMa95Wx/5DfJm6Q7/f4uvSbaw68QoX/f8Mbb?=
 =?us-ascii?Q?lgELJnkE78vy6o3sWcIKFcbt3wug1iRnOx3JBtGbD2lua4D6Kv+y/XeomLV4?=
 =?us-ascii?Q?eh+Ygw8x4wzSzztWD37dxPofI/KLoac0tfm3f+uPMu5kZaJnVmPYRyAfr0lF?=
 =?us-ascii?Q?jnsN8dcPIMjNRLFFhYtR891dYEDF5t7RjMIhGtHjb6Gh61CDsx5jze21049b?=
 =?us-ascii?Q?rFXNwVcrfBd218kNbL6Am+qtbCwdpYo6JlzivZ2y3GtnK1IFKc7UIogouL5M?=
 =?us-ascii?Q?gUolUYNL6GEwZ5ohiiQHZBGf6BujlUpeCNWHB69NTx+ar7IICTvUmVGyEhKp?=
 =?us-ascii?Q?fpHxCFCnkEtisYKFA2r8kXfLJsE4vF02m81mLUIlPm9O9R+0f7a1N7k1Ao20?=
 =?us-ascii?Q?vx6/U9AAseQW8hM3Px6E5NGMKbE/puouN5RsZvnr95GJah2eS+f8tFGNruuI?=
 =?us-ascii?Q?GtJEHfihEZcPH7VB+AmSXd9bBhnpVxoKKLDbVJy9mTiRL04JcQlyA0L2hE2m?=
 =?us-ascii?Q?mAYVfu6KjIWt2zDs7pQH92vu5DniH61mkp/rL9KJd/+boc8Jsi+RBQnJMHI5?=
 =?us-ascii?Q?jhRxb9TPWSs1Q9s7faM7HDPi1cCZzEo9l07M9uJGM+8b08evU3gal4e01TcB?=
 =?us-ascii?Q?h+YTI5fwErCgqBlgWoO4UR8DFtHQ3R+fQ9bBgyPEdoB76Oy+ldQuDIXZtg8o?=
 =?us-ascii?Q?5FgUigxjhW+L+fhb5R95z/IP3DYpmXJ212ao/WJ4NE5odCXYRacN1P+atDFY?=
 =?us-ascii?Q?pQ/QQt9Azcm0NS0vcx7u+4n/WeGd5P+PzPvDK2D9sgX0+nA4TCgInl21Jq3P?=
 =?us-ascii?Q?PMAc0J/fgqAUoP2VgT2SkoyRdm5o73Yu6YkRf1sCCASFxoDC3B1aTgn2gNWb?=
 =?us-ascii?Q?INxtXUikjqTs0m4qP3DiIWvLU6PBUbiK5o5lP3Hwifae9K9yksDLe05BsnXa?=
 =?us-ascii?Q?SDCXthCwnUpWrRMyQCCYFhpqF4d9YesDsYoXPmqxjPwQlbqmCOdz89/6A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:jH2llxZrznICmkINlIynAgDnKN6PlDwpRM/ZBcEY5tbI6cm4dFWgaKGjyGzWKE/6PrUp4+U1wdyIid0ECC2Y17ToN0EXxluXh+3t+HRwmi+gZselmH+DuzMmWEodelPIak3K5T7ZhlkicNwMKHWKE+7r6H5/UO0VHfnyTDfxhe8GXcpOvFNcQIqVeLKYHA9lcB9+xSDZzR6ZCmNxF764tcnOVDcwqZq96ACSLFSl+CroX6kAoNx4o6nkuYPOVoXgWURQwGmO0Q6LJCtjC8tap5NtdabUVqSD+AXajMSdwG10I5S3+qrSTt5BL3VBXjGBcgf5KymANMxcQPg9k6pOFWdcJXOFqe05DB1gaUvVnbE=;5:HLJYmUMOEXoRoivLnqHxBjyVTaWyPeQ3kAU5VKBv7C2tsJroWl4MFpB6IGH/XYFeZg3M/bIArTdKtQjDpDqMfjL8K1iDzvkn9PHUBYRnBWI5LabFQzaQWR38oczc4zm+hTtSghsWJ+KO4gjBJj94VMagIbUBXMXU8DrIGMCJ3Q4=;24:i/sLJiQZUlKkZGSIB9RtVpwMIt4ivkrRagqfxzC/pd8OFZRmzuLsSJBLfyvWsRm4KIf8a7+5l3cwZG0u/CWI/ZD/UKmylfwTd4T1Cwq9mNY=;7:VaaHGcupY5pGQ1xm/ZSWcsqnDOSeQXq2VEGe9IUrwG+ra8c97QjmQ7vXraLIqxpBu3szNly0vyTs4oUBf9mu7HkGutfKxozoFKn/T2xXjSdDaji3faXrByCP7ZYWRRYwHgzNCNRmM4ZzJfD6wpRXM74hwr6Ofu87/smQtlRWJcghOsguwQaopxmJ15kBaskDVvpNKuuvpTACqWcij4x3KQHAFzdfQRyC59PFVytjp6yBZRLKxcC4+/zIWTLT+TQW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:29:51.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db5bf648-9799-4614-7fcb-08d527a84014
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60821
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

Previous patch sets USE_ASYNC_IOBDMA to 1 unconditionally.  Remove
USE_ASYNC_IOBDMA from all if statements.  Remove dead code caused by
the change.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/staging/octeon/ethernet-defines.h |  6 ---
 drivers/staging/octeon/ethernet-rx.c      | 25 ++++-----
 drivers/staging/octeon/ethernet-tx.c      | 85 ++++++++++---------------------
 3 files changed, 37 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index e898df25b87f..21438c804a43 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -10,10 +10,6 @@
 
 /*
  * A few defines are used to control the operation of this driver:
- *  USE_ASYNC_IOBDMA
- *      Use asynchronous IO access to hardware. This uses Octeon's asynchronous
- *      IOBDMAs to issue IO accesses without stalling. Set this to zero
- *      to disable this. Note that IOBDMAs require CVMSEG.
  *  REUSE_SKBUFFS_WITHOUT_FREE
  *      Allows the TX path to free an skbuff into the FPA hardware pool. This
  *      can significantly improve performance for forwarding and bridging, but
@@ -32,8 +28,6 @@
 #define REUSE_SKBUFFS_WITHOUT_FREE  1
 #endif
 
-#define USE_ASYNC_IOBDMA	1
-
 /* Maximum number of SKBs to try to free per xmit packet. */
 #define MAX_OUT_QUEUE_DEPTH 1000
 
diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 1a44291318ee..dd76c99d5ae0 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -201,11 +201,9 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 	/* Prefetch cvm_oct_device since we know we need it soon */
 	prefetch(cvm_oct_device);
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Save scratch in case userspace is using it */
-		CVMX_SYNCIOBDMA;
-		old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-	}
+	/* Save scratch in case userspace is using it */
+	CVMX_SYNCIOBDMA;
+	old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
 
 	/* Only allow work for our group (and preserve priorities) */
 	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
@@ -220,10 +218,8 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 			       BIT(rx_group->group));
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		cvmx_pow_work_request_async(CVMX_SCR_SCRATCH, CVMX_POW_NO_WAIT);
-		did_work_request = 1;
-	}
+	cvmx_pow_work_request_async(CVMX_SCR_SCRATCH, CVMX_POW_NO_WAIT);
+	did_work_request = 1;
 
 	while (rx_count < budget) {
 		struct sk_buff *skb = NULL;
@@ -232,7 +228,7 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 		cvmx_wqe_t *work;
 		int port;
 
-		if (USE_ASYNC_IOBDMA && did_work_request)
+		if (did_work_request)
 			work = cvmx_pow_work_response_async(CVMX_SCR_SCRATCH);
 		else
 			work = cvmx_pow_work_request_sync(CVMX_POW_NO_WAIT);
@@ -260,7 +256,7 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 			sizeof(void *));
 		prefetch(pskb);
 
-		if (USE_ASYNC_IOBDMA && rx_count < (budget - 1)) {
+		if (rx_count < (budget - 1)) {
 			cvmx_pow_work_request_async_nocheck(CVMX_SCR_SCRATCH,
 							    CVMX_POW_NO_WAIT);
 			did_work_request = 1;
@@ -403,10 +399,9 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 		cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid), old_group_mask);
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Restore the scratch area */
-		cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
-	}
+	/* Restore the scratch area */
+	cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
+
 	cvm_oct_rx_refill_pool(0);
 
 	return rx_count;
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 31f35025d19e..2eede0907924 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -179,23 +179,18 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		qos = 0;
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Save scratch in case userspace is using it */
-		CVMX_SYNCIOBDMA;
-		old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-		old_scratch2 = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
-
-		/*
-		 * Fetch and increment the number of packets to be
-		 * freed.
-		 */
-		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH + 8,
-					       FAU_NUM_PACKET_BUFFERS_TO_FREE,
-					       0);
-		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH,
-					       priv->fau + qos * 4,
-					       MAX_SKB_TO_FREE);
-	}
+	/* Save scratch in case userspace is using it */
+	CVMX_SYNCIOBDMA;
+	old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+	old_scratch2 = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
+
+	/* Fetch and increment the number of packets to be freed. */
+	cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH + 8,
+				       FAU_NUM_PACKET_BUFFERS_TO_FREE,
+				       0);
+	cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH,
+				       priv->fau + qos * 4,
+				       MAX_SKB_TO_FREE);
 
 	/*
 	 * We have space for 6 segment pointers, If there will be more
@@ -204,22 +199,11 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(skb_shinfo(skb)->nr_frags > 5)) {
 		if (unlikely(__skb_linearize(skb))) {
 			queue_type = QUEUE_DROP;
-			if (USE_ASYNC_IOBDMA) {
-				/*
-				 * Get the number of skbuffs in use
-				 * by the hardware
-				 */
-				CVMX_SYNCIOBDMA;
-				skb_to_free =
-					cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-			} else {
-				/*
-				 * Get the number of skbuffs in use
-				 * by the hardware
-				 */
-				skb_to_free = cvmx_fau_fetch_and_add32(
-					priv->fau + qos * 4, MAX_SKB_TO_FREE);
-			}
+			/* Get the number of skbuffs in use by the
+			 * hardware
+			 */
+			CVMX_SYNCIOBDMA;
+			skb_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
 			skb_to_free = cvm_oct_adjust_skb_to_free(skb_to_free,
 								 priv->fau +
 								 qos * 4);
@@ -387,18 +371,10 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		pko_command.s.ipoffp1 = skb_network_offset(skb) + 1;
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Get the number of skbuffs in use by the hardware */
-		CVMX_SYNCIOBDMA;
-		skb_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-		buffers_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
-	} else {
-		/* Get the number of skbuffs in use by the hardware */
-		skb_to_free = cvmx_fau_fetch_and_add32(priv->fau + qos * 4,
-						       MAX_SKB_TO_FREE);
-		buffers_to_free =
-		    cvmx_fau_fetch_and_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE, 0);
-	}
+	/* Get the number of skbuffs in use by the hardware */
+	CVMX_SYNCIOBDMA;
+	skb_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+	buffers_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
 
 	skb_to_free = cvm_oct_adjust_skb_to_free(skb_to_free,
 						 priv->fau + qos * 4);
@@ -416,9 +392,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 		queue_type = QUEUE_HW;
 	}
-	if (USE_ASYNC_IOBDMA)
-		cvmx_fau_async_fetch_and_add32(
-				CVMX_SCR_SCRATCH, FAU_TOTAL_TX_TO_CLEAN, 1);
+	cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH, FAU_TOTAL_TX_TO_CLEAN, 1);
 
 	spin_lock_irqsave(&priv->tx_free_list[qos].lock, flags);
 
@@ -488,16 +462,11 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev_kfree_skb_any(t);
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		CVMX_SYNCIOBDMA;
-		total_to_clean = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-		/* Restore the scratch area */
-		cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
-		cvmx_scratch_write64(CVMX_SCR_SCRATCH + 8, old_scratch2);
-	} else {
-		total_to_clean = cvmx_fau_fetch_and_add32(
-						FAU_TOTAL_TX_TO_CLEAN, 1);
-	}
+	CVMX_SYNCIOBDMA;
+	total_to_clean = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+	/* Restore the scratch area */
+	cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
+	cvmx_scratch_write64(CVMX_SCR_SCRATCH + 8, old_scratch2);
 
 	if (total_to_clean & 0x3ff) {
 		/*
-- 
2.13.6
