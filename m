Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:54:26 +0100 (CET)
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:17152
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990505AbdKIAwSRIdQQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DxS2ktRUCSQyEsVW1fSMwbd2aBsMyZ+0V7gDfl8Z3Lc=;
 b=evD5V0dplWsM1r7in0I31B+myj+WmW5vHb3nQuZVInbIZNsDj+xF+idH+1OEIN80vVHDmHAPZYJjNUjMVuPjESo+Js+LxBJBrXfjBqObL7VLMs7N5Z8IHejHbv2aQ1lec2cjxgPmNuE/Kf5y2eLOTUgXmMQbsa9K+VE1AnFNyhA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:52:07 +0000
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
Subject: [PATCH v2 6/8] staging: octeon: Remove USE_ASYNC_IOBDMA macro.
Date:   Wed,  8 Nov 2017 16:51:24 -0800
Message-Id: <20171109005126.21341-7-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86b6a193-1fd1-47bb-8a0e-08d5270c1ae2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:GnVOfXQD22izuvQ7J+SmTK2i5mbUw89zem/tVgrQy9lAjP7YfU3r0adm2qzyDLdpmBtDAQ3b2WfZPl2PTLLQcAIrcGbS8zg49pGypkgDX3GTA6l6KSZmCjJ90sxyPGQU58PcCmYCJDu0HzjOEfP+/JL9XY9FK4l9pDiTZUVT78MCl5iL1vUbKy4tcOfUYvTRJekPnvS0jWb3ibecF9KjjY8WrhfWFowd8oi9+NZIjOToH28IuAwxqkCzZVNlZepE;25:2Zfo84UCsMXeJW/A0AODyxmICfj4Fj08dQIlg8EVrAeOlkZUZxn+VdkCnZQpIKYTsxxFaEqhbfSJKHMQwtHJGQ3GGX5e+rsI6YGH6yLxhlJawb2MhrqRnpIONDoWtq52XwTTLU1hE1dYH2XsHJKomsGzmm28Zu7ROMGpD4QwkOVUV463P+AGHzAsTnp+NaUWG/ESUKDQIP0z2QgD37+weFKYP44cqc48rriY7K+wJbVfCGDFN2k5Dgd3rHDUEP3jEM+74itqGQgNAzzt3NlefYbtP+vBtmW4ntnuyzpDfOeZP9S4f9SmUiYz8nG+Yl4LFwF1IfpAinJpRWWPAl75Dg==;31:OFdIr9hWu3+XRsKy7di5g0EJr/uirsVVjR/WyTqFJLBLwi06xreWexMW4SWKNPtTCUKLYQMrlX4VAZK/YeDvWeZwBk/zjK5ZVAE0Y+r8Lu/bIRaDsdQ+D0DAJl5dhwXFOS0temzL5GDbLinqbGrjtt53lS4Lfem2EKyGZby5HLa+DIf1bflyIOGuRMwom7pJ/R4lacx6lbq0thrIccWTjUoHHZer5MGhKYwIrrkQFSQ=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:Ez/rRqGvH9QIuAXytgyOoG6+t/vDeHgpL/R6bitpvDg6OYnuiPbkoxy/5TArDLnpxReRzeNcxQKQh67AGemZ+6ZPaq9OYk6sNy/lW2OtIBeW4fNiFv8LpVW3dxGJt4G5C323KgwD4SLImMveS4wvdEKhNSUQBVBAP2lKg7jEHGypVjMpyww/gzEUbijBJBWJWoThFWX72uNwBhx9+VKfNEBifybGNS65qLwGfHe3+MnXAjLUmldvLi4I22wzdRgWrC4jLU1A6wHqP4EMl2XJcT1YzLpy856hSBdo+Cx3eDQg9DyQY1hxa2ViGLwgD50F++WS3RLvoxUmLirCJg3zgzWB0gBSsyLn2D9THX1Vw0+L/r5zl7Kd4fET60THbxa2sbTR5MWSYx6Ducq/9Yb6t9vFil+EC2Lsq6F+upSsQkfU1HTDjWESMG2MT2FJD9yYAEVsxjFg8FGueLGQs1goEZkxaq7AWqxIZFEinSEI7rZL4gdVXjc9BM67J3NmZErD;4:mM7ZHhQPFGWShV87+0zMW4nnidARWdkrqqRPcNNWuXSr9JriEYWRmu5BTklxOaUIKqbMdCHrIE7kc+cy3KdVAkhXxXNntF/QE4UiMR0wdLAhmFlBD78UK4IdJWMDRANXBuC5w9x+dY+UNALGU9TKEtXzW1G7Bvs0CMzB/OTPVbqyl4qkhdqs1JVaPYbMFHcxc3BrV9yhOvrsfdtZLWlh2FrngJ1wt09Ep71HjgbZFEUKGuRh4mrHSuTS4DzZn1zKCaoReruZRc42Ke7djBZzTA==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB349570434E4414D74BAD42DC97570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(2950100002)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(76176999)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(68736007)(16586007)(39060400002)(86362001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:mBknDyXto/pbGs0wfE444Wt4YlshWf+tYQdcT1hCN?=
 =?us-ascii?Q?oAcDP4YaxoSa8AGf40uhgjYjp5nBTWo+viQUIbwebm3kaTzsxxgi99RCpS8M?=
 =?us-ascii?Q?chmDgzvkMLNYESjv7MGrll0NWSQStwJEqJo22IXZ4l/XHYjimpNc89RjS5Rf?=
 =?us-ascii?Q?1hbYNa2+6/+/fkoJCAIM8Su50dmEFjIFgJDipJKrWNr27plyYRqc64HhMEc1?=
 =?us-ascii?Q?3v5fkOaJ9UBqS1CIKkXKNuIZr8+dFGzvV4DOngHMmNcFBqKgPiF/PpuUM4RC?=
 =?us-ascii?Q?OSs3/KvsQ6sNjG1emBxYABJ4noDAd35XZUD6yCHJvo7mJ6gWGdhU0FfyyL2I?=
 =?us-ascii?Q?ggjiLCZOK3OLq0Kzq0HJsO14N+jonbISV/GqE6utjBU/oiwybS1+PZjrQgcJ?=
 =?us-ascii?Q?0bwbWQB/WOqekHg/rkk99wm3tltuNdsxs2Uk5pVXBlWAasu6x/VrfbqfhS/e?=
 =?us-ascii?Q?uACMi2S6m7Z7ZZBBIx34z984cYXG1LcIz2F2NXgr9sgPtCbHPcyL5RYeuysG?=
 =?us-ascii?Q?4oejxcnRXX8yzDl/XfYr4Cmx3YxNGzweX1Z6dNuSaCaPRL1YYmOU4j+96pGn?=
 =?us-ascii?Q?TnBaXTy/I0z2ejrru2nJ51+a1UC8h8VwSodpuWDuwTECbGBxILRQXXYGUL1J?=
 =?us-ascii?Q?XQVgXaNfqP4Ja0NH0wUMdRiZBbYUNyX2YxQQkmDdKjCxGQlvuXXd9W7v0gIA?=
 =?us-ascii?Q?jgSxyvS6EhEcNTAA+kxMPDyZI2GG/DAgqgOwOFeqD50U/UuYLwFQ80HImCOo?=
 =?us-ascii?Q?JFOl5yG1rDwX9ldW2RxZjvWgZe8vxiCwT9PfI4rCd3Aiirq/2T30OUBv4fti?=
 =?us-ascii?Q?l9KulxdbbegLP6SuspvT0lbfinxMo7vltkTyH3FhuoqLubu4NEzmqDi46uGH?=
 =?us-ascii?Q?gvTrZAdN0yUiD9dp6YGxHiS9pbKF/FuH97QVc3kw4/OHlIhvzERYLpGe8qUl?=
 =?us-ascii?Q?a0WCQepRbH3c4sgJP7masMFRr/lT2nBN/FN/D3b1WdPSv5r+h0PAshq4W5z8?=
 =?us-ascii?Q?FzGa3wAsZ5sjNRIHbq0ToHZL6ujtGfRXefettIjJMXbKjfJ/5WSUZHH1efgz?=
 =?us-ascii?Q?bR6bvVRUy0RfBO5eZ/038bzGi7nIlZxcbujolrb+OER6/rwC0+lHQO0NT8yI?=
 =?us-ascii?Q?VmRV+kOVcS/K95NJegrchM12YZD6CCEVihm/WoypcKdXzvzYbZcAluKiCHrP?=
 =?us-ascii?Q?0mNpS2kircKXIQviQ4nWyLAbklzAlmrRfhKt9Pkhi8v6YhjqQTqS7MGbA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:ttopwE86z+K87d3LtQoLqcd67SQMvNEfEu41nTwl3vGmtM70x3Wtu4+Yt8eQmFMUC56T9dCLnCmK4Eck21MRbYiV15mrT6WG7GTlTjChe0Aniiq2TQHx6wclvvgsQesKmJUMf2l4cfc4EKwS//sVKuJ4b2qi/ITD1+P9EjDGHD7YCzdqvxV8aoAQDxCZK7QSS/WePtAJRiIgx/zz2/+YzJwHjCOPl6zfelSbk1x7YqZn91rTRsBtD8jC2J0Z8I9VTW0Pu53fpvVcfRQT1AukWAalNdFegh1fabWW1QuaNYfCJTGABrUdbKN6cYge3oRHipa7MBEa78K5HLvmQfzaI6IwP97xAIjLijemNkmQs8U=;5:OPME5vAclaVySj4+KRWSHNrRy3EoGD6lb3QIPbEUHBfBO5lYUDbIvD2mBOGhvwMp2jheHJmlZzmYBwP0y6QGoVLMmXkHHG8zdeny67+JqiyryMIM+SKHhVZ+mau/cTiA82w3A9O0OyiQiPPb4zLXmfclhaWZkkmjU74RFTlbC4s=;24:nikYuUv4VjdWwM2HHSubqYryoYrpezFrZJ+nZjfVxs+T3+JVIHl2ouq8oTtDWW4K7ZKltmVKaPUlXAZxf62s3hj5i4cjMxUjKx+EzW/YiIU=;7:MZw9qdNKYWzbeZPci+axdUrpuYK2QcyoIWUXL8AgFS5dKFnbSu2nCM1SdkRj0KwHwoqJn6b+t7rwXyzKsPzV2xvwC9Ia9QY8ikMm7sq1kHCGmBjIPoICC/2rR5Fljv9lALM5MsG5bxiQGWnqOzj9YlyAZ6Wg6Aj53I3jbZZaHwJEKRtIDPoWhx+1z+jMScWkp9dHRSZTYVT4w9Sv3D6MjnBYoX378NOdkdxpIm/yzfc2d9ZFMbHkKidKCxDvMlFS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:52:07.4939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b6a193-1fd1-47bb-8a0e-08d5270c1ae2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60789
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
