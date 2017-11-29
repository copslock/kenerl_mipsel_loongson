Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 01:59:38 +0100 (CET)
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:6176
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990591AbdK2A5jm5sNi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XXw3Wn73OiSzJCior6uDbSb5jtM9npWssffMsZSFw1Y=;
 b=iqhdKAAaKX0OOBMrQq0lRJfaNKl6BePjaRg23qKUYhoae5TU0BW0UzUsjLaapWP7EZaCbPp+JAcDrKOWYw6ne2kDdwjsR/0HmSFvfvb55yu7KdomMQqXamTw063tJIoeRa+bL43Dt5cN2+GRjKvoVSONrpUuOSIsnv5zuR7HYwM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:57:28 +0000
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
Subject: [PATCH v4 6/8] staging: octeon: Remove USE_ASYNC_IOBDMA macro.
Date:   Tue, 28 Nov 2017 16:55:38 -0800
Message-Id: <20171129005540.28829-7-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171129005540.28829-1-david.daney@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68620b76-5184-42b2-ac9c-08d536c42a18
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:/gmCHZTsvrBKyE/etZ5aBut9NfYo8fNzcgSaUmIlfeyaqSH9JInqiB3Bz6lfbGOX+ZaS8ACXs1DEd4FWIXVKtFyuO46WFio7fQn3dBj1IMg/U3wPYBG8h/hD8YE+nYTtZ7k59thKp0Ak/7jGRlWfrm3Lw99NnoFwQQRwAjw223jnwcDvZGfyzSzH/+HK4uWjuFCCW9mcBs8kHIb9wksIqXf+uqggGIHqjheRuxrYjsPoU48Fcc+bZJQIQxN06K2P;25:7SL8Rf5MjBdTbhu4B0YyWiQ7nUjXzbCAvPxhPp29GzP2+hIONtHFukwmM7xVvYnjbsugSSJz7A8MPjL986oKRaHx8DxgS0BnDzBqjBa66SgVtQyTHejgH1EZrn0oG108DqGfaZYrLUt5wJYIt9e/u58yf1KG03ZVH9ViPTEaDTdZp+SNSHjEM8wm/f73egqNMLovwAuVsZEdNmlSttYvRKylic00/uVLmYNBT8+XqzerR7S83cuQwgv6U83SIcDV9DZBabWc4AxAqAyUelKNABinEXeIxdyt7lVjXFhd3A/CncydwhYKhJvxEE33b7MzzGSpcwn6Pb11bLNxu1dpfQ==;31:SIDvsbBmJq7FWifoXw58X1iU8vpxWZFrC8j6nlc7agUtCB3UrzHEj9MnouAk99MmmkOQqWpVDnN88uFknARrHGA5ehVg7BP85Yde+lh+elwqy361pfaN3wWKNzxzSztKiYQac85fIY/8xek6tw86Lk5mAWaFXk/xBGM0kLZtMx9ryk2WnMVwvXOIR4X9zXRXdVFBPa8immreDnloY+m5s+XxsRv7NKnHvPl6vNoOEaE=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:32DNWqeoXjsMNNC1BmaJB8tfIyhVOtwcwRxpCW1IDS8GFzr+J0Tg+l2BCoZkQ0CSNvtFV1SmkmL+ndWblU4Ri7Vno9WDn4HpAGapKm1KiBWWYyOL3YGo1DI4SkFnRbn5pWfoq4k6r6VDd32RU8w3NiMciGstzXmAOXiS0YCkOH9bi+Akcif27czUXQ9qYQ5xi1dCtwPyOaa5YupVsyYFUFZ0AmUAoXWOPhimcPF1VISc4G1ao80ENh2euF1kFHUF3aADwDBTYCBQ9ZgWo3XJu4egrViwioCMvRI35q1Dbmvn6NyKCMDD2Oo15rN6Dd4XXv5R9zNNchmfcaMWq1z1NYKB3wxh3L77fSWqmW7wHJxVU7yxoL+0QusUFwXZRoZGnxKoquoEIVFv17HL4DzGykzOWyfUSKXR8f2uNA9ZlIkJWv90jojCDt4YNtRk8/fylGYuJuzfvrSx4HMxkgy4GCHAbTUSnKQUVi1QMYmg5QbWMMirJhbwUxGr+vvnSULc;4:CUdl0lQbY2LiQCDIBi447V6sshikChqDBgRfCw55KNMHc1myRwG5I6IhHa6yri5AvjMUkyNvccv4iMjT9PASyDw6a5imvkqKFPmWWzV9TnNtViiUM+Pz4MuyJKrjkFr9IQNm2HGckojdd7UBspaH2m73aiNDx1DYT+qoa/BEN+x9lGzUy7DLz+Tl/u+P3nM0eFh44oACexnFEn5JrnW704O1oa+SofKXlHYg+KijwW0ssQPR/HsFP0MZ2lWTg6jjbQ0c8hcW6K5/cBEnoGLdoA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB34950464406BF5320B4CB07C973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(76176999)(101416001)(16526018)(86362001)(53936002)(39060400002)(107886003)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(2950100002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:03Fu895z4oWDHLCTNAxqsy/5RTYGBStQrjJ20GUi0?=
 =?us-ascii?Q?GTCp6bSA4U5mbulmHl5rDLvlySBWkEk04KDCjnxNmkjXZVTBhJWuPs+WjG3Z?=
 =?us-ascii?Q?GxDtNT3UujdCjXU3F+o7dM0Tv+mGrO4QHT0x6ZMnvKZ/WLeyfq76z+tnLRQh?=
 =?us-ascii?Q?438jy62tg3OeQspjEaJgAnl7r1SrPIo5AdWCNhaiwbgBf2Gw92Lbctsfw4tZ?=
 =?us-ascii?Q?U2CXh/uNpEDfU9XEIKDxfGnLLxLQI05aw5b+bNRRZ11KuMZQnrXdCgUTltCP?=
 =?us-ascii?Q?ih8FvJEQUeVGCzoFNnfiCrELWah2z/qHTcWDqeZIxY4X3RRyva5vcpjjXQN4?=
 =?us-ascii?Q?QtUntZDjgqJlnhbK4sEm4uqhaqUkhcqjZEULGEX2NPxl705fp71pqweiBnMN?=
 =?us-ascii?Q?FKEA+ITVW3tJFXbNenllnRYmnhA79fJPrdFmJ1OA3eUkeCA/Iqb4y6NuUhQm?=
 =?us-ascii?Q?qJkHCa1jJyhw9G6rRMBeOiw3AWjwxy9yPx44iW7okk4OgGcm/l65t29m14Zw?=
 =?us-ascii?Q?+jh8jyAjab7hEl20f7OmjIC67EYwCKEk7/IQs/4L/iWg1DCI9+LFnKSp+cRf?=
 =?us-ascii?Q?1NwHiDQXJ5RNuwxGxPtaxT+4+nWZfTfHD51m58s6ecQaSE16R8KrtDRaZ2Oh?=
 =?us-ascii?Q?MWLr1Izqk6DGO/DU7Mfty48UDod/yetHjCl6bAauU8hsuEQW/Q+pYMbQbD6T?=
 =?us-ascii?Q?sT1IlYCQdLNE2JiTxV1VTwdzQhERfwYakMa2t+RzLRSTp/dIc18/K4LG1jIF?=
 =?us-ascii?Q?Onh06oLWqMaptYV2FDxPpDBlWloXxy/KeZIRnytE/1bqGWaxisc2IXD1LtsW?=
 =?us-ascii?Q?q3SNuXf80k9lCuZSIzLPDqfD1KwxU2plLuV3zAJptoOp36H0Lqf51tY+nAGk?=
 =?us-ascii?Q?3yZv6FARPRWhqVSW/pBGqqTPdvnJN1Fmn2JZh2ywgb2UIwgj5dKfq2J+Fsk+?=
 =?us-ascii?Q?KtXybS3wZsqWuDFc9xdfJbAm8Dqaq/yjtmy/k7ESjdNBhPoF2QizRYnow2R/?=
 =?us-ascii?Q?Rdu43uD+YHIMErDga1J5VVLJo2oN70CgZ3y0kSMs5MbiBQu4bePNJ7HZuQdX?=
 =?us-ascii?Q?2BKbjRflidpGWqejVOUmdvqj3ZQBPJk64jRKNY0yrFOWCIRoJxTKDb6pXvsY?=
 =?us-ascii?Q?FKtpeIrwbVJkOOzbnKZg3MDWD5iKf/T463xJ/8MVoluzS53xvWSxE2lV27V8?=
 =?us-ascii?Q?deWAaHjRgKsT1B8mnja4IzdZOknBu/Q+9lyKfVzu/XtJBg08S5TQYPy4MEEk?=
 =?us-ascii?Q?AR2Nxbvm3+NIUZGHXPsVeJtfwWTfku87W8aseJO+y8xuc4+rbMbYv7eraS3P?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:6qjs4gVlcllHXKLdGSMJdChtA1tX0fj+rtUJnfqlPrA4WqvF2ZZXa7SaRLCiMvg6Gc2PUQYoq2UVTzAVFqegQbp173BHHa02ZM5lgJaHyarTaTr+ZmBVdM/OKWomNKxTN4nn4HOfXBh9s7HpZf5VvchuJA0DKouk5G7w0i8K1aHEiJVY9iySyTlefkvNximk4zD3x6dx0PZ1rL8FzBs1RcUH9XAky/dgr0h04w0j0HwW80HvtvMxNxn0piXwQNPqu9yv6iOGAaobNCRoCIOCeYoe4z90KIVJjwFre9iI9BgPV/fa0nFOuoVctWKotDBkVINKsV4GSGHSshtII9ZdiZj1CMgnIimi8TroFFavF7I=;5:glIrllyqkAtZP5VcujPpd7zBikXOngOtw+d2erbtm6I5AXWLVL3ldt389zybnB6cPahrmsBGVtaXXruOAK1K856AjcprJz0/tmcBkZBNPcaJAfQl0dWPNlzdCGFmnfjO5DoUvZ4zIkNMMQa16I0y03tvy5/5QWxryN3tWJ3NbTk=;24:TnlFBc6k50g+kOH2E7mpyT+0GvvJZFSzrxrohLHj5rIQZGPcS9WIXFcbzXZgAMXIKm0BkT/G1KJGaunLgU8MbUE7OxzFMPisZ3/zer4sUeM=;7:qg/zUmB8byjVfR9B4kUd/z3dR6uktvjBkL8FONL8WNqeF5Vy1kk6ask5JEtfUzRm63D6WKOUcoe9bHNkjYTWKw5xydInCzydayOtd3FoBaPWz1xYucSiYJo21WYiVGFu51EMQbyjhZBt1F3Zu0gZaFDRlXqmHqBUv+RRTIkQujB7ZLCprnXEKE2lQ6Wkh71BpqLj9N8V5GfeEaqFCpt/X43mRl+1zzwpRrY9H7G5c73L15674+mrDe2Vr8WWhrMn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:57:28.4979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68620b76-5184-42b2-ac9c-08d536c42a18
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61176
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
2.14.3
