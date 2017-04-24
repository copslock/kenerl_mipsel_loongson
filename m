Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 20:44:55 +0200 (CEST)
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:64592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993904AbdDXSo2d0Ctm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Apr 2017 20:44:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TBnd5SuB818tJvLH52H/ufPUwOf5GQJ12VCFGT4VWlI=;
 b=R2WyXsaWm3LWAVIj0HSBTL7g9dNpFQ6skjuV8/m27QfqlokT20HaOz3TzLCDuv/T4bGzXCkTv9k6y2FrTh8VO556YdqmQUHkOmF9fsCynEGz4fb2a/BgQvUyhE+tqwfJaLw0R1vYUfr9iIb3sliZnvI29vX8+CQBcnkh2JHLQ/Y=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (50.82.184.123) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Mon, 24 Apr 2017 18:44:17 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mmc: cavium: Fix detection of block or byte addressing.
Date:   Mon, 24 Apr 2017 13:41:56 -0500
Message-Id: <1493059318-767-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: BY2PR07CA044.namprd07.prod.outlook.com (10.141.251.19) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 386bf3d8-3495-4353-2ff8-08d48b41e9d5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:66PeOSNweyjYOinuSwTqZ7TFCZP+4DxxtSL77il8w55OjOR6K0NhrROxIOUoKii+iIMj85DmuovNli1Lb/uIDNMXu1NPY/j4xUkT0dCGyHJv7zbBSau0l5wXq7BOWmWfAqhyPOeWjCSnfdJRw95++wTMNX7TqX9s+if/qCP3GZrzUpH47ub9ty9Rt8ckFJfvsI08HehyW76ERPYGI4t6ln5F1FP/5w2kl2twrFXwhRrkDwW8jh4cBTJGMo3f4HZovZfeFYE+z7PTA4UO9yp2xi//AuHogcH9x8pn/W2W+1Bx/h+o50HQ+jCuBSoX79bJj/RmOyqwvgNH80xVSHLxuA==;25:4yhuD5emTEsBGUBopukpLP5vSSpMuRODv17+2LgHgHx2vl2+IMv5BtvOeEFJtwVyux6CDHubsNZIFJ1OZvI741xFmBEBx+q4LJezAU3BAzwoPAYoxeKtR5NGsSIF8n1f11o53MKnbUedMIz+ufz5GMAYXn+ewpZpHjMuMjWMFNGBagTPcg3zUALi109m/OT750gYfggxdErLawWihe5EW5zdLqSH0ni/7D5Mpyf4j5bD2AI95JW538Xfx5/KuAXjgnlrzNzYMbpnZqjQFatjB8w1fEONHgBRyUnXEKTMcIa631vRchBIXQ+A7Zxn3DeuL/S3sRolXNiGcEMXxqphxZLEOlMJ7epNznC1g1mKH9+CEkcacLhGkqS+a3gJGFLpB/aiWyj4vN50cTGoKK+pB0bAGE0yz9djlFrZbp5S64W1llthcBJWQU2G5ecBMHzYiAcqTpC9rB+C1p+CBLXZOQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:yolL1bLR28/p2cuLx3PjsFZOOU/oOhCLgiAr30uo6zUVVMCXwIXa+LLJyUA8BDX3OFKIWlQhAJ0emABrU7n7GluYCF4X3u9uM9t1N1YQJl+m9ZbTQmchxFHU3wpCzuPaciS8YFfhLAKIJr+VAQF1O3AR3wg9PChAnOpukWmBbTq2ID6dUGCt6r0a5l+FzF9bmPR+6Pl1bix1iD5LYvAGaWVA9cx5pM5mTEsL1fqXrAw=;20:QzZnHReT7TvuwnT/L0MGYqLOUfi8R88S6KVV8u/y4gemd4Pqr0qQ4wgSmyqLbbQT9AKxSY/ty1+56u2mptzCHDEbxVbiA/mYzBmvcz2y8QeGiXgfHoG9q/byRO4MkSMV7X1OuP/d3/Okb6QD64GP6QHw0EDy6WNN9BFJmVDPuDS2OCaRoOMIWrjkRiK7CRUiQQPH6pKGPKYme8rJ6SnYBdhZUhyWFLpztuZU3a9m4FlLGtpLIoRZgrfscnF2IOaROH4P0eH5e1k4VT1kW9i/mvP+1Yl58kS0rg1/rG71eCDe6Obrazvv+UmV6WBJkRU0iyV0tUovCCw3t6i7Lf0HY6vZ4/qQILa6yUFrksvxHB3xAnIoPMzmFeoLgeqDlIR/zWnuzjbSU6GSYWVK1LTfx85LSdQXYPCCsCIGfEmDiSrafOax0/NzoGBN5q810amv8ALMaJrNadnRpC0a4cD3xDktaMoooBd1TlIZIDWgyiGDGMX6e85J7BUieRYN+47X
X-Microsoft-Antispam-PRVS: <CY4PR07MB3206EBFFB3994349E7BF0D9A801F0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:5ryrVC67WsQFez4trAntI7JDaCflEAxlr7mn6BinMPI6IdQ7z9TIdEvneB/9pUdMGBzbpO/N/qNNb+J4Yqr7MaekqsxWbhjhDCAANpBSDFEAuh/J2rmcyVYa3HnVR+ZQhF1+tUQahYyyusQoRYayuKhdtEZNrF2IazlQY06S3jl9zgnqWd1VD56YMhv+dXQmnnyelsZfPoh0/jv0+y10Y1tel74NsiNQXmKYRhazWey3QIIGUM69TLAOI/akfwZ9tpgsQKTC7V7XgSEorZ39LeLgFJfDFEeJ6GmCCnlJ6l5pUMpL3pUDG7CMaS2JJimS7Iw6h782fkBdzxBSPvtNf64wQYvNATOeBzje8+7KzfZ9qVHaF2jOIwX7nsw4DQ4lyqY5jLY37ehejHEbnmJ0R6R3NbUWBwf0JGoDUwE4cOV3HOUKBw4cANK/Fd+Db6ymCdk/5deD7ux/+LsdVG6jTO3gjjWpjA9YzG2Ok6lclUWrDRVwTCokN/cuWNywjHpxHkx2hzHBQk7v0XwELIhcz/DtBwEfNOwZ42wZpv6wbKhniNpbjfvRBpKUWb5z+EE33Q10TAkxYBaH0E5kYX+9uf52rbwuDINDdqPTdNF2bGUS7MEQu0qR9TOhsDq0tf6EcMnF4Gm2Mjkw7+E60eX+r2L4hPNWqRIcHI0RxhMgmMs0QQdOs25n9XJT7Xnag7d5iV+HBU4Z+Of7EdYHiek3EajAgLgdW91HR4JOdGYOnbw=
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39410400002)(39450400003)(39840400002)(39400400002)(4326008)(110136004)(6116002)(54906002)(2906002)(50986999)(3846002)(6486002)(6506006)(76176999)(189998001)(53416004)(50466002)(66066001)(47776003)(38730400002)(48376002)(42186005)(25786009)(305945005)(5003940100001)(50226002)(7736002)(81166006)(8676002)(5660300001)(6916009)(86362001)(36756003)(53936002)(6512007)(6666003)(33646002)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;23:dNFJwmv8ZMUb2lX6s5YoqTtI3Z2l3rYzbk6JIW5jx?=
 =?us-ascii?Q?f4/jPwfQ1/evHPYVQjF0byyg38JEYlS4CN0cL2LgsJtBpgIXTkHHAVoWBG++?=
 =?us-ascii?Q?fY+IwdC+qCyZWBiOvdr7TyC7X8Ds25MJ9pb89oawK/48TqA32AjDUTon0CVx?=
 =?us-ascii?Q?DDEqkNVr+k8nZ39kDPJSKWctEJWPWy7f/Htghr2smSa6p9+ZAJsT3ByC/hT6?=
 =?us-ascii?Q?CsLKYOZWlCXss/5VTS3r/E0CjArAd0DqHxIvvIVtC8C3r4Nnli0DR9O/HyTJ?=
 =?us-ascii?Q?ep/8TAQuMf/XpmLjcvtrIoOAwvDSEva5/bpG7hsLXizg/HjtBfIRyryBLn9b?=
 =?us-ascii?Q?r3vBeQJOai9myh5jzJ/9VKe43YOCPVXxzkRJMcI+oYtQqcn0x1xwlne6sTp3?=
 =?us-ascii?Q?0EguG2Lr5AsUDLTD1gDerh5uyhnxvoNrw1w6NVlhB6eHu70lKTwb5ZBYloSe?=
 =?us-ascii?Q?CPVTRKF1cmrLEHMPF9DvMMATSyT9VZ3ce5xHY7BagU9SNKUv6L2W5M5vluMb?=
 =?us-ascii?Q?bAmmF7oYstHZXQSMzZT8C5zOn7vM0axk5okExXO8NcqxZeCalFWdJPCeQD8N?=
 =?us-ascii?Q?z23yXnUOCyuMdR9ci1sAmMGHmCeTqwud8/C8lKCrYbxGdCoVLKHwRF/rNEL7?=
 =?us-ascii?Q?gnGtjmc7XKUgEhYIRq378EL1POlEI0YbFoIdLKeiRjLZAsy9oslRecUXSXfr?=
 =?us-ascii?Q?1v4tDt846/453iWaRk/LZzGs6+TLh5GPHZoqOGmYetMYtRuikFwip7t2Himl?=
 =?us-ascii?Q?DQlFY6/75ld/pPsyTs9v/qCy9VcN2IDMHIcxwqtY+TL1M4UKcRbPEDRPHMUh?=
 =?us-ascii?Q?AZSFRav+HLkFtDqubkHubU1cDBaP4HwgsdEayArcK35/wNTfNRMmlshXKb3L?=
 =?us-ascii?Q?sxgwUkD0CNAxI4rfFREypPBwUfSMqBhA20ZD1c11cUMEVMNjtYLaP5aW/awp?=
 =?us-ascii?Q?F0W7QI7b8T75AbDi0XjdgLe7RuKTjz4wrCZ/LAUFwRyg8U3caGC70LDD7c9Z?=
 =?us-ascii?Q?hXozwORElZJZtuZF5KqXQ6YoUG+fukbd19qMIyr0SmcUIGVEpPSryZC/2YMZ?=
 =?us-ascii?Q?IbRJ0c=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:Wy4AP1I0hdhopCUX+hmVucQDmFhxEcyAt383bfLWCu8+f/g0IVYPB0GJnxDBhWk5aCR+ATgr9xtOH8mfXJNkrZenMXIW+RIVCovQ8RXw5iyzjCGdc8r0S5vclWr2NYAVMuqtTsJu6aDKB7V0O/gp5zPb2+05LVU8nxYQl/2rIS/FA8v28sEw20fRh+2XSM6Ts7gvvbsOCgXASUQF5XTm+WtfKzuvhMSEZ2KngqiE6RP/+/kW70hj1NBKTXLCc6v7BmOtAgD3M720wxFCwVgjHbajv3ez1rgJdvc4N4bifhI7ODPVl70y/Eju+ucho1u3/3eTsRBqV8u3zhbcCfkXRSawm+wz1xZoP4BEdTavHzVEaO0R8U1AbyQwlZnVF1YsH/kS3ap3ALRTAdPu1UeUq+U/2z3rLwWL9zqMOTRyee3g6GSed4v36pgTgHwiQtNQSz+/Cr222S/7vn74pYTdYJHrX+8OYL3VZaJ9ivZG0ERJw+6KNuDQ1fFqoK4ujzWTa3s8VQF135d9gPVnWdx1MQ==;5:bDPK8w5tVd7x2A7tTendPtZ7sP2Pd47dCPp7yl9tlo4kKCiN7ewW9AhyGjWuDiDFv7Lphi9poKeEVor34L+DuE+tYqjAWkAAPr7AEOO+OYwg9oYdyutvhYKS9VhKLKp2y8Man4+4iOXSEAOI0Tj19ttj8Vv0m/1VDZzbbjqKG/0=;24:iO/fnhDCWuCvJZ6z7/h/R8JGQAo3fNXoRR1A5sCcP0X0vaHNATRkU+nZFAvEmgiIsO0TuEyB6S60d52M8EQKDUIpzj14F0QpxCA5A7l+2r8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:QUVfdEyztctdpvcfA2O9asOxH65g24ONa6gOlkBxd/kmTVfWtd2EChIPlbYNuTMTlm2qBY4VoQ2B3zQmp0Kta0eGiF6vFskDVJrlGK4rpxgxCq9n94aoCypmTjevaSCOK0k3Yu/AZZU15u7yr9G43JchKFvYUDf3c7m7HkATNPG/jqXkC04veKgcLdkNqNAL6aVP2o2xGuOjWyyeGT7TfnFqI1h8PwuzW5a1uB3TYD0l5oB/qJbY9JS5BQCla8alwTcR5p8iXhUUaoP2KQ0O4eqgFkKVWlGNICbURMrrwh85dP3e+oxXJ3OJ+kFGlLJ/5MFBsq+yDgF8OH++sMrTAw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2017 18:44:17.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57772
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

Use the mmc_card_is_blockaddr() function to properly detect if the
card uses byte or block addressing.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/mmc/host/cavium.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index d842b69..36b25e4 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -629,7 +629,7 @@ static u64 prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	emm_dma = FIELD_PREP(MIO_EMM_DMA_VAL, 1) |
 		  FIELD_PREP(MIO_EMM_DMA_SECTOR,
-			     (mrq->data->blksz == 512) ? 1 : 0) |
+			     mmc_card_is_blockaddr(mmc->card) ? 1 : 0) |
 		  FIELD_PREP(MIO_EMM_DMA_RW,
 			     (mrq->data->flags & MMC_DATA_WRITE) ? 1 : 0) |
 		  FIELD_PREP(MIO_EMM_DMA_BLOCK_CNT, mrq->data->blocks) |
-- 
2.1.4
