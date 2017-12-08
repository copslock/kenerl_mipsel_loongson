Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 01:11:53 +0100 (CET)
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:35584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990427AbdLHAKCAtbvA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 01:10:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fdvPLLqLfpJyNA4u/YMGcnAnRGFLyPaxU0PrV2HKspo=;
 b=LvV920xxDpOZe6MlHrOv0nanqN4KP7Ox6vXsIVgTRzgs4lUDeXe7Gt76lu7QWqCNDA0GHllFbAkjM/bvU9moh0CYLK+4qz6UiWhwWcpl3Xobx6wWjcarvwzc/6CPBS1GiwaOCkRiSxCbtGaXvx0TXzpCSEATaRtQAZdpiDwbqo4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Fri, 8 Dec 2017 00:09:56 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v6 net-next,mips 4/7] staging: octeon: Remove USE_ASYNC_IOBDMA macro.
Date:   Thu,  7 Dec 2017 16:09:31 -0800
Message-Id: <20171208000934.6554-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171208000934.6554-1-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8360842b-90ba-4c1c-c0bb-08d53dd0040a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:swQ3fq+sWV+nnuOrsytZq2q7pBla51NY0rfxRKSZjiyneHY48NRQ3WYwzdRsZOU+Lgam3A7WZ2FBTa6kL39Txfzcj/+4xl9uQL6acDiWNPDTPM5Xm2aYYrdb3lriSFe1f0CXxIYloSLNNOioS3eP7BFpGjnJI7bXRnU9Ga/rOsz7yr2/iAP39RZtxDC+g8aa68wSYjYe8ADWXmj8teMeAbQHaPGKrJ1VyzB0Y84nZHMnppSfMrbe+hkJ3h35Tj3/;25:spnl6CyTse44Fl5y4Fbisg1/a4cQOhXbFHPfQwiO2NOX67/qjAqN6Qdnk+oR8Vz+4bJMOg5cP3Ch9l/u4dm7cMKBzCDl6hHaDc9TJ1kuwgjsWuwUwB61LCKTpgzvebNDYGuO7jJ4nYKnhHbq7xNFrm/g3QI0A8DdNeZ98CkecpB6PUFc8Zy8J//YHtiEDhbdSVUGkcQm1kEh4OcB/OkXOPCy21/Xb+khmvVFLK1ocwV7kKYCuQdbC7epSeZhso71vBZ9aTPy/uVkRImJ2dUwScZbfQvG8jSH/IeUA/kKYY7ydgsW4S2Xj2rRsvJznq8ZC+XZWmV/v1gCkgieySF+MQ==;31:BgJ4tVOUvb2JIVQAIu2WPV3VTkqzzrUU6rtXi5F8C1dfut2S49pH+s4jDCnHI2NVUWEGryTtR3eZtn8J7bea4WepSkpLHlXWZt55xoxxMuRR5sGTRrcAtAl4HXeR5jQhFhk8fRI/V2YeWLzUi/+AAUqQJRkwDNQVbNIA62GLnxkcP6Sg9LL8TJXbTd4niNdYQVVhQh99i0qqnSXiAXKWNDPEnJgr72rDT2LgJ4opmy8=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:vkgt0L7kfdMRYnnT9x4DS1NKEii5TjVRGJCbCBWt4fB2yRKj5m1r2ngpvO/ul64CO740QBVGa7q78mJUBUcqK6cPPvSPIa5jEG5nNsBW8yZfoLLceJR4aFuqjL+xMw/esqGb53UqRa/rNwO/eL+v4H7pqetmIRQjjW8UQHEbp3K9UONQdexPUV135owV46pe3HlUaLCK26mHTYOCqlOoa0dncOyHQiv5il7CAiajCq29DcbOiBsDHOHijTz+X6DBzz4TOeTSaGn91mhtrRJkzDRjaIpaW3H1+Rr8WcSSgMadL7+94wgdFQqu69Pd+VcMtzUWjH6x72LpUdeNIyxMTAsERSiTS5Zy3oCJI6lnzawT7vV2KzBa0Ab7m8W1VFTEC5ADEfcEVdnMbzWdysoPBLHXCiaKuhCuwXdqSHU88drSoEahb6iAyhGCFywuTe9VEEHcealvjZpdg8KNNv9yP85A2BDKn5JO5A4FpTCIvc8j2rentk0xwoI8TznXPC/i;4:7IQmvLguQ8wp3iKiQDFuvkTt3JVI+s3xLA9BFdFKOvK0MUcClYnHUko2y1Ajzin5t6ODKCtMkEJOCW0gsIzH8Gr39zDOS74AEy/nSezZpj+9XwaR48Yr2QHLtP2G1uZ16KGWEdPkK5cU/qjEj1Gc4f8W/iHfSMWYJePeL6YRxrRJnbA0EePAgfxKRqFLVi/1hkAnoNDVuXaTVuCo1RVHjCQ3RmDRNl+BEoWC5sxrmVt+Ba5lBL9Ycw18+DP40RNzUMKC/xwnHY1HyQaGj5l3lg==
X-Microsoft-Antispam-PRVS: <MWHPR07MB35042DDC67560256BB33384897300@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123555025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0515208626
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(346002)(376002)(199004)(189003)(86362001)(105586002)(106356001)(81166006)(81156014)(8676002)(69596002)(6512007)(47776003)(107886003)(66066001)(48376002)(4326008)(39060400002)(7736002)(50466002)(305945005)(53416004)(53936002)(51416003)(52116002)(68736007)(36756003)(76176011)(6486002)(6506006)(8936002)(50226002)(478600001)(33646002)(72206003)(16526018)(25786009)(3846002)(6116002)(97736004)(16586007)(316002)(2906002)(7416002)(1076002)(54906003)(110136005)(6666003)(5660300001)(2950100002)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3504;23:PHmSJrkyst88t/m3UxUqwbcEoya0VoCmH6lF37SvO?=
 =?us-ascii?Q?/s3GL6j55kX8FjFQQJO+HAV4f0fX0hb+xBAgOZ1LzzqqkCDMA89SA2+VyslP?=
 =?us-ascii?Q?D6tvqj24WhsXnmfc+UeKgxCbNj9BB7XhM5IrZGt64QCWpbFGHHeYJk4Ac+YW?=
 =?us-ascii?Q?DPhv4hPC0r75Ng8B5zMFe3c5pS+C00rG17UY9Cf7V1CubwNpOG9s3rGS94oL?=
 =?us-ascii?Q?amvmsfmy4te7oHGL1dHYW/KLu2fYiRK2GdVtOu4pymRO//5U6GtmTL37w7uY?=
 =?us-ascii?Q?HAxA5iyafIqHTCKUZU3gmnt6yLhUCQ0QXiMg9iHxbkO5ckz0Szr0lK5i7ORC?=
 =?us-ascii?Q?v3n8bZAnCPZkp9BBftiAkNBbyeQZ6VzM1zqVKyjv1zfbJDkWHIfNuWPuRIm3?=
 =?us-ascii?Q?aTtGV+m+hHfwjdHqqZ/3bbO5AysTvZpurLU7kFiya0B1R0m5oafk+IuLj4og?=
 =?us-ascii?Q?w65Vk9+qONPh7HXf6pt7oMAFR8ME5R3JXlI1o+ZpM0CdXq3yNibwizXxCBP4?=
 =?us-ascii?Q?Ph9m5bkKQJAxNIHaFBsqr5zqBR5aGSWHQMd6OFMAQKHEUyq2Hl9lkgiZP1+i?=
 =?us-ascii?Q?MadKq84e6PuafiLEgUxGVRvtZxplou26vT9c4n2yMdtw4TeEPjIYpQbCPvc+?=
 =?us-ascii?Q?AI35iWoxYqY6w7HxFa7GeRKtcZ9bni/b3Zv8s4NR+Z0CdKTKno7uF8mhfOY+?=
 =?us-ascii?Q?jjoES0vT/5zzaIvgxocAorjvYYxTR7xMY2ahQmtglsW+woFk4Ii6qxukPMWP?=
 =?us-ascii?Q?svosLogkTdY/Ve0BwLNy0VUKuiWuwcroHvQZxyW5Bkb1RM/5tTy2Eba7JhAT?=
 =?us-ascii?Q?iWiILjazCsSnhvVdEdmllN2rrrbbsoK/RuXIlFHbstjb0riJrJPzwry5XmcX?=
 =?us-ascii?Q?lg3kSRfrDnrOvu/btjD2GL58QkUzC5tcu4LFhxfgGcR2QmJBYS4v/GHO8NU1?=
 =?us-ascii?Q?8EY/LQeKuwkE6tjJZq1XaSXj3G+6QtFvgVJ2329c+Gf6VCZ7DSu45EBEg/cP?=
 =?us-ascii?Q?YLIVYDjwco6dxWip5o2al13QilomyqKIRcuxWIf3Ue6RR4oaqK+YOLWJjzvf?=
 =?us-ascii?Q?tLg7B1swTs7omk6h3ILELWCvV8BFEqzFCP3kT5bH2sPP2xoGSt22Vg+y2iGY?=
 =?us-ascii?Q?PIgHKHiwDIAmD1YUiFS2d05TDYP2wpP6Jbejjlr/a0TpcuK5Xj27WlrtD5j+?=
 =?us-ascii?Q?6lyU+iTxsDTsVNOpOeYRy7VvwnpdQvs+Cev2bbTOXi6b/scRakkCq+/HLA3c?=
 =?us-ascii?Q?/XpfB6pJrTvXA4oAgq7LX9kT6VJSUIjgHgYNJCX++9EJjKfoIvBDWGB36Lt0?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:+9I5WUwdUzOVDZhqzqJnnW5inS1THGM6Up7MalObPAmMCM30wLUddFPoQb+b7d7Z5xJffoWRE8Q5SclQOKC3rHAfoS5rzm7xMXQxIEa3/Oa3ZRxzVLbb6SOV4tQLlE7vTZBYfK49jL7fzLqioOo14AD75OgKy6WPxKqf3rlYf7NbYBR+J364feltfFPtBzLUzsYu5KoWKs3QAxo71VisqZ2zqlTpQMFhz66uorDwPKgtvG0LaoVbZS/JCFqEy3aUT0Z47s3+INJfnth/na1Tv2olYJvOc7qvNOAQjUhh1u4Gz6fzo5dLE7HAK2ka+ZlMWogPZOSrwg1ARD5d+gqcu+SzQ4lXkfW1WM35Kqy5iD4=;5:WxYiAHQkv+RK4zMSfv0maTJ+K909G2qJ4q9w6MT5dvJo2F5SkpYLnCKm3dc+jOuFKZ8FnITNErQaIsLXgZO9zx4wCY45byXRVCCC14gV8Ht5Z9bI/eoRr0DeLZOCKJUv9dLyNr5ONuevDxo1M1cYm0ChL9arLIJd1cuf2M6rua4=;24:MNNGYgBOoAUAxiP2PlqYEzylYR6GzthhbSeilxhUMNXyUZfSGSKNwXB6lFA3oIGrQwlEZb4h2eErTvIomLINTMYbrV+bblOEDCaWzwuePRY=;7:/0+/NT7LyvYrz7tBVRecR7ZXZIVeEtCaTfMavOlEcLoiDlnaxwuz7eS3Q+oF5dwqOBkcHsIPRJi5CVq4CKPGy8OiUYIMAhVeQAm0nbD1yWIyqDh5S18i1yyzafmKaPti42yYqgQCvXqz/YsRrsBO14TYbhADUsAV5S1eX6sq6M3hpX+MKc+VBVwqnwZdDSd/eG94sQZBsvsT5TMPJYRMIZMcwOZdWPYl+Om8zOdNfGB2UGkznjxMc/E5UKUY9cyX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2017 00:09:56.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8360842b-90ba-4c1c-c0bb-08d53dd0040a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61346
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.14.3
