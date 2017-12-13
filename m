Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 01:50:27 +0100 (CET)
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:30945
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994627AbdLMAtKcP7wl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Dec 2017 01:49:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fdvPLLqLfpJyNA4u/YMGcnAnRGFLyPaxU0PrV2HKspo=;
 b=j0yDhfqDQ48xcYVX+jDk+9szv7hGbp07e+8tpEfuEolaH3SYJEJJWw0Tlo+s8+50k+nXm7SnxBAxuNezsDUjXEJ9F1LBCE2exlBt6V4LU+hX/2SRFKRI8vGWiYgC9aDTP9I8DNmDXW0i2HThgFIivOG6O+7QBwrBJDFIgE2wkgM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Wed, 13 Dec 2017 00:49:06 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v7 3/4] staging: octeon: Remove USE_ASYNC_IOBDMA macro.
Date:   Tue, 12 Dec 2017 16:48:47 -0800
Message-Id: <20171213004848.15086-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171213004848.15086-1-david.daney@cavium.com>
References: <20171213004848.15086-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0037.namprd07.prod.outlook.com (10.168.109.23) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c3c06e4-7d4c-4608-d7d5-08d541c3506f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:/8zqa70hDdVajM6Zeg6dlQHIUryGKavBnx3sGOiJa0BPmU1PKrYTFFuMtlr9ZCfsTvq8tpB3Je4DXOYzfbVLs7ExygbCpz2vowRM/+/kXzvkc/9DxtK8kmRBoMXaPC1j7C909ggbDIfn6teVdVVvyIMr+RNkD/FKZVi24XBAzGIm7YLuLmxsOggOf5m2HCuYXK3oi4TGhUx+xALCWQ7Cqel/z7uFxKATliYCvkIlWrB/9AZDUudnQa44zPHW9cNB;25:wgLYBh1wICGZx2ECM6djOGm+NQ0Fx0AMAsHPTRoBPPKrKNJgI4dBqc1twSlI4u8ZpWzH8CXr51AcYO/3Xe5dbDQrVCf+hsUXCj28Rhb9yt34pv0FpV7BMvz6M4LcPC8l7SpOh3v2aRUb1HqicGsJpNiSdCUysx1I+D5kgL7IFZEdeqH75/gromb9bd/3U5LY+QS02vpolIN7Whe8MbPE2gr3skXUe/hNOKjKewm9kdHB9e5ngHLy5lEhlT5HyFGBqOw75OenT7YpNpfLnqNsCnXfhaXKwZlQFDALzcR3C15L1Kokk5wF1PULitVqYFuN/kC6PkStjChX5mDgRi3a1g==;31:rMgALfAEAPSL2TRkiYBXF3iz0bGY1Zv0hHPFwxtoNqWY0UxjTjgfhdPMhXBeqx/b54LqQnEzJDygY97MYFYFLc+30xRVJe7xaEQMgAwxy8OfkcScpdQhSOjMzNcvZuDw7HwC+KhGN+s+7bDoXX6E8af8BXAzWxth+mHvQYStyndF1zqUKL8+exNgNRnD/34789w0VuYLUfNaPMo9ddYxCS00hpLlCBFHIopwlXEYBq0=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:RJxUkvk6ntpkjqXHD6AB3WCit7edzJtRV2BQCFtWUi4cTpL/lk9yK1+k+Ezkvguebe2cE5ST+rkJ4LlgC0Zl7wWE8GJgE4kWBtEybRslh6tW1qo2YrfEYSWBH9g6HkUrgcytdWw6UXJiJ295gsTUR0OziFVA6cBQmGRuYn2s6F36wj7Hd+uf3soEd17rrE472pLGczrMmIQz4yTP8YXPwNnX1MokNE+9joGlpiGihWIT9P9HKaDTFK0RE0HiQ/WQfgUQb3lUWxhyMyza/o6i+qwnhNoaGTEawPGW2v6S4Fr73L+kPaf7cwYuF3L2daFpLCrGmJTzHf14UUT32/3/ZfqMsaNQFkB4QWDQUNQd3jK6WjahPhP6ovZ3JuC+sEAODL+0esRlD2I1hrGy41vc4/6bhX7JsYC442wNFr82HI1hX6wcX/RqX6qi0qa41+aukgsgyqP54/ySmUYbl/lTuVgLA/Kb42Qsoy994cMLDJjzfvZTfkQdMoivgkGAWCH1;4:sAXKRWyQWG97fZkTpgbe+skRxXNp/NxjGTGbNRMiznXAIp4iWbObYqIiZpIBqWCmZT0WCvO4OgNRTj1GqRLAzBGkfXNc31CRKFQHwtoIkba2Cd6hdpfAd72rzv2d8rbzAJZCsDPnmmyqTrbOUkC1wvsrT4TvAa+9dXjdWisy4ezFPLKfOaZwjAwvVWE/RCEwNz75zH4kVcqS3fHexQ1piuHd8CorjaA2lTAbQPLPQL13FGnjrZR5JGVLzuzGQiyBXGhEiam/KIjPBohcB6hyyg==
X-Microsoft-Antispam-PRVS: <CY4PR07MB34956BC8276DEDB36F29AECB97350@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3002001)(3231023)(93006095)(93001095)(10201501046)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 052017CAF1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(199004)(189003)(106356001)(52116002)(105586002)(53416004)(16526018)(6512007)(16586007)(107886003)(1076002)(4326008)(53936002)(47776003)(25786009)(6506007)(386003)(54906003)(3846002)(2906002)(6486002)(316002)(66066001)(6116002)(59450400001)(69596002)(68736007)(81166006)(5660300001)(6666003)(72206003)(2950100002)(50226002)(36756003)(305945005)(7736002)(8936002)(6916009)(51416003)(81156014)(8676002)(97736004)(76176011)(86362001)(48376002)(478600001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:fFc+TVKPY6K5RqXXfc5KF19vHPphtXmb86jLcGZvV?=
 =?us-ascii?Q?QP/khxO+Lsrqd9nD3sF8nz7Qu4g1kbASLe82WoStvvA5CMb8myDZANA/FFdr?=
 =?us-ascii?Q?AIiPq4dSYWUWYNuAEZ8JOL+sjG2PuLi2bptDwUzHFRFVd5fPRhh6jWYqGbC4?=
 =?us-ascii?Q?11FncJL9/diws1vV+YYErhL30XbDk1jjYb7oSSJRqdhw5uaxD0FWsKi3FXPC?=
 =?us-ascii?Q?utf2bhmSR32/yFO8Pcg2qUR3HagWzesv0bgXDzZkTFSh44czlv7F2x3c1bnr?=
 =?us-ascii?Q?K5ATi2OQDgRI9ZddpWdQh4vIufq01PLlraZJXBcowEbYTEoQEK2cCPUxQEKY?=
 =?us-ascii?Q?G4SnBizPltdOZ87mvU7V2l0D7am9BXirBDGsfodam0lashPK5HiH7meTPDSa?=
 =?us-ascii?Q?FDtSHvBEUc0Vv1X45vS0MexuqxJ3WOVHsOfSuom3v1RMO02PLEBdEs7hil4t?=
 =?us-ascii?Q?LxECNHRM7CQalYZNP9efXwLPz0WpLIVEBnx87591PiDyd3y2+xYCLec1cW8U?=
 =?us-ascii?Q?OcrrseDBGAdqDFCK1bu9ifk96EIMLbKU48xNJixIWovZ1HqjcdAfwaQMLEpF?=
 =?us-ascii?Q?24fLcq9VBiy3YEh/FVcm0TH9813GwPYOLN5dQ4XwdYE+T38qOwDZ6f6EYPI8?=
 =?us-ascii?Q?1WSzOIWFicDnL+uxyDXtJxmLfZ/C9zZ4sqTE30mt1EXKTbXHEsVe4ZCUSwNX?=
 =?us-ascii?Q?lD3n2etdaX8PjVQ5SS85AjCIp8R72ui5NwyooHIGU1b6uxDZ2t0KmKhERP3C?=
 =?us-ascii?Q?yRT5b7FrWQMH8FbC1njoLEQsUDuR7PheNjNfS6g5bqRj+aBpGfMPczKjc6VW?=
 =?us-ascii?Q?Fd7dHtZzCcbawSf8WxYtXMO+/Wj96pTUCt2jk176LRKHYdS5TF+RxbAim16a?=
 =?us-ascii?Q?d+ROx8i2sn37+V5p5t0o8EUtGZeL4R41YfyFUYA+9y7KBOCDTdPQlc5B7AgE?=
 =?us-ascii?Q?oRhtTK0qM4KvY9GgVOeQ1ABn40/Dg19NOHjcD/xDkvN3khI8+dHwXtKbrDPc?=
 =?us-ascii?Q?CVYhO0S/DoZKhJt0/aOB4U9Lx9KYdrU3g5TJWysPOmWr2IctKwMapCUWT7Os?=
 =?us-ascii?Q?wkwae4hIkpPOBIEzqHHwDdBMmUWWNm3O5DU5I/HgCeNlq/25oAbid9fbGGZS?=
 =?us-ascii?Q?NxIr0B8PcoVOriAASSbzC95IO2KO96RLwPSwL71H/aEQzgJFuBlRg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:7FsdE92PQIYGwylGlROjNxXQXjoXUvYz44rUGcHtwjoN+MUPAr0FoPhjgdGFUJCVBDS4GiGhjGYD6pcRRIrprSOjxc0zP2tYMqWbwruL0V1w/ppiLTuXsVwOY/erOxIuPU3ue1/U0FEw0+appQo2OUULty0dKoPBnD8+AYQvbenpWn0LxPUyDhUh5uOPMQ25rxiNMqoVy0YRm491bQV11gjzXY+PsTCpQ8D4T1VBVnns1266nJMQH1k1eg5c3/UIEV3nyvph8pdRq5bUJESCyurqRPpUYOBxlPBzQiBe4UjIfokoTub6UTQbUxRvi20GJDDPHq0+bjS0iRARA6+OTEBGVY7G/pjt73HZJdL8NNo=;5:Z/72jxryD+jue1mO+x97G8wO6qOKVkCiv8E8flHxko5T/H5uo6TLUKa65Q3+Xr72lP/Yy/+eHZsRDpcIGQ9TLW2ZEWER5PeVzoxnPxhMcUDhCVPXRNURINlQRxV45AM7W7wXucnAbsepE6o2Iu2Tu8+7zuF73pBJyhEAsW2i/28=;24:336WYQR1ar/NgNMspEBy3YAu3d52D2rgQM8fUm3H0PvAuF88oe9xhkSSGjr6ZmPQwvApjTXDTHbEG8nip5Y6gj2gZp7nE0p00y6wRrN70es=;7:GJ1JJdCjZoSk+t+nmFM9Rc9YgNRywZgan/Lm6M1sP8ofckWh9J3LxMHynbrt5RkzdU8uClH45xyyMWDXW6FjQS19TOheqvWKODgjNHMvR/V7goQYAaReKOgNtWlOwMu4vw86lmrdo9fRDD2ASv1TYjHcAIWM0rlz2VLuXV4YM47iamS8uDeespFKKGJ4wpNIgqSfp4WSH2y8w/dCAmMKJoOnWrPb0CIjJ08VGzlvbm75nxvWdWz0CLYl3KxFWYEb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2017 00:49:06.0634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3c06e4-7d4c-4608-d7d5-08d541c3506f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61460
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
