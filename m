Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:47:29 +0200 (CEST)
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:30302
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995045AbdH2PnRdp051 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Lp7O0sjAZBF84k2P76Jt/fkWRqC2M++D0YUBX+TfS/g=;
 b=DnH+C6mtePLYczFPO6/4TpU6u0qacTfKoRdQHkS/IHqzcg0JA+wAKE0X/H3LiXuzjCg9pC7KnoyfbyE5x7E1gYbMosc3xMteic028Auzsbf+pNXo09NIhCtjt80mteo11Q5jwDPt9rKXwXFRrJKuGxhPHOw/Bot+ExBd9shDSA8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:43:01 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 7/8] watchdog: octeon-wdt: Add support for cn68XX SOCs.
Date:   Tue, 29 Aug 2017 10:40:37 -0500
Message-Id: <1504021238-3184-8-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b23935ac-6409-491a-f76f-08d4eef4a1fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:rl2//QhxofpgvuSoecQmpjJzsBfvYrhCloJcZ2a5bqrHvmN90xl+m+wLSXTkEXGRL0CvEV6TNAG8/Fg5GFBfg0Wfl3oOSl6sGmTcIx6pKb1Jp1qmmOIleEjEC65sIY7VyfsCIPHSBwk0SvsjwTDJXiQwLlMV+mI/jFunivPMj8RQULliKQS2jIWTFlE4EaW093mh7yJtvnD2eQexMwkNNLjUgxklmagsizt08fRh+sIR0LcFw3S6J6c4kV8YMAM7;25:+SDZG8arviJquoGR4dAYTCrcapazv52jUqlvBON1qjEfIQxe040TMV6IbLeLO8JmzSqxe+ASxEgBQN6Qh9Cf4ON62UqXACE8GrpCOiDLX/+g1Sd8WjBTap7gBcl35PdyRA6DtXYsJKmK29lzPz0M53rxxgPqehkg8PXChRggmlH8eyK5Wv20Q7uux4BlAQvNJ8mxGOkZvjPOJElWL2y1FOtGOOOpyfYM492s2v790rqHUcOPHk3FPDhr6cY+o6IkYchbgk5htMVV0+YsBWwZr14Fk4fIJrU1JqwRXUhSewZpM9zyOZ+YHPVu+RuAL/Y4MUIFlRmCbazBNIeEHTsjvQ==;31:aT7iabplZ9o2DiuxGbAo/dj7JmLlk0LBzD8mwGILcKBvXJ+ahAMRZNLxqXOb4eAZDrj9zLTPBh0i334h9qdXzOKhNiVXh7Xlu+Sh3zCk1u7f61kw6zAddme2KWWL38jZDJwnpJc6hpGSS2P7b/SokRmOef0yHhvZoTtsW2CX3sGin7z7F1dSvNPzFrxSw4jtMfg1rvpXhm+sBAiofPw5ymbX/9H0wbD2l3nZ2PVqprw=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:LWbp3EFe3lv7Fr6TjGpsjWEhiBojLzQhkSDSbX0e4+sziby3i6im4vM1n3j7Z/0tmWHgIt/Msz9IPGt5C0HFWQTTxi+LfytXO2OLO6CGiq3ORGS72YJuHtpMhrHPaE3rX4lvcmH/32N24uX1gfXgWOhlJgsQRAjO6SZuQRURg39QHDxD+aZN+yqFMd2LlD8+/VpuovPI9Z9lU2PdD3sqcIKZe+HaLAWKWTpcKsvkFcmVI32a1yYiJ8Y9WKi6WBxH1Sk/duBTSirR/u2Aje4PK2dZcPjyMx8CU21PlmiW6vizdIEDc9Ye5dp7HBz7atW6ehFVrexS/Xvx+heYpY12ZEQqV1Qrg/imw1VaoKSouZ7br2I1Wq5FccfwlBfPLWdJCj6I0lTAJ68NyYM+MMoA2aGzbkbBCRCv7Nnblv9L7K0EeC9frEypKRcDCRicj+IEJ9E8WmwxcAohI77xngFoqQEXRWpC2b4z33Phqf49AK9+4DO/th1qEf5KfmfedfHS;4:BOxUfrGSrKyfYEEYUCxYRlakLy75ndfz8Zxp9vCsQQhIPwalYecYD6UkZmL2YnA8MjyQO7HFE2CsDF4TaW1UviYnZLULR9CO1wxL8jUCupTiELaXIJ5o1PPVOGCe6lKwJm3YQ60Lf8g00xDcPUFZkuux3B0ln/ZarBl54XLIBN54NP0c4idfdASKJvnckqRHOW7su88HMNyAVcIuCpRvM9pYLrAYEjZCnHYwd6wr16uFDo5d8Um2asT2m++FINyE
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB38035CC1B253CFC375EA2382809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(575784001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:ptkWK3aZw5VRSqG8KB7mNhc0O3njujx0f6CIQcO?=
 =?us-ascii?Q?6qWL84gBvsR1RwgFrHNqMd0FIwSbL1itqVaDkXbkxrVJzOZ5EGwDt7uOnWZQ?=
 =?us-ascii?Q?k5TUMJ573jPR2Lbz4WJcH1y3+EbVwHt2egTSz0epV8v09xyTCjx095hqL/2R?=
 =?us-ascii?Q?73mtm6xMeD597JJyBVrQuzX3JoSbZ4VD5aWxG2dyfOBBIXrSylk0UblpNaEz?=
 =?us-ascii?Q?PfLcWNF33W4akbXl9UV4BRLMWI83GfSUgtfVgXlzHSezW4dl/WjIo1abek+M?=
 =?us-ascii?Q?wPsukQcI5pNZIc4qEOrFUZS3RWdkKBOBBwcuO54sz8L6wVvOn4e2KPuHF9Hq?=
 =?us-ascii?Q?R4kORRexl1CXKkIVD32Z6gQ4QHZ8+q/mdzj3DQc+uyNQ0S8xdI0NuhE/AsFm?=
 =?us-ascii?Q?H/MJtFKF+Z1NkTNuA7JEKZY5o0cqjgP96TbUsMpLnvWwUNcguJH07UcY+7h7?=
 =?us-ascii?Q?bTVMRjc1VTQEcmwl6kVWt7oT0fkjRj4kfg0he6zDpUxOL49IjvDOB0TtgUPR?=
 =?us-ascii?Q?6LxzJJCyNee+wr4FwbpIqnXl+1q2m5t3KGlW37elAI6anlWP6d4F2uJbgRok?=
 =?us-ascii?Q?8e1/EKb9NuOVoo26geplnjPQ2EyeyZaKF6lLGxqrUp47fvJStTl2UDh4GGe5?=
 =?us-ascii?Q?N0AK6Zh5pfxzW++USlwNgnrvdqpzrox01T1qM59O9uu6HiMnOBLybyVFu0U7?=
 =?us-ascii?Q?9pS4jpMR/bRH0+IxeuE/VcU+YyzG9toZ9XhPwvgeXJJJs0mZIjDsy+ak7/VB?=
 =?us-ascii?Q?6GgbVGzCg1K3A4ox8PtHUXolKLh3SFC7VGWgjr1zFo8STMZ43xeRhJNDRk+V?=
 =?us-ascii?Q?1Yzg0rYduXK6og0hbPDi8wAo3gwYoVQ3QPlzjUmpQ5UGvWYNy7pxVUfRf8Dj?=
 =?us-ascii?Q?gVxFurMuoCiwhPxkJZJmFUUmrcMC4sVeQl59Wj6qwdFG1/ddb9GevzG78fKl?=
 =?us-ascii?Q?3bMaCo6YBJYlQ5KOMPXqaNO9RQ+GaVx9apGJ7GNqhOimYA+DWttKhZwe3Gdc?=
 =?us-ascii?Q?xBKXQtxRUpvvr9jqo8zAS1eGPAelQsA49Ew9JGoBrqC+tb0tCcfUz6A37u7Q?=
 =?us-ascii?Q?mu5qYx/SOXgIO9HrlV1Yh7ngw5cqBiOmedj3TpZjXE9EvhKxY5rAxlbAB3tJ?=
 =?us-ascii?Q?apf1Gjn2RYtBl1s9SEryWOzKy+5FBmgMx?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:ovcolZpLF9RnlOoR/Awj83Z7voe3M4TKMtS19Dv7pDoITCsuOb469mVe9e4BXmQJUvoONu92mPLV8gbBsBu40O6r32yF7JEDmCivrKHoBRE1D7n/j5+0RItzzF3gj4CTEyPJ+iYiKBia6DU73VeZws5GzgTIhI5frdYW7bg/IJYws0XqZD6rLgj3t9I0UXPIq7azBp7yuqPtY9HBp3FH6msU6JiBUffgOeBnOr9nS8G/q/euyMPOo+qTCpMx+OQu+FbhIdDcMY7CPhC0rIGnAnQhF67Q2rOFI8Dtwig9tKY1m2Ze+/qXWzdJHWXyTEq6qnVlmedf105Ns0qzv2l6TA==;5:OhMj9ReCSPUT7ZFxpA2RNoKMNjQa7djonHbqC9V9nmGvV7jI32+V3MQpL2kvSQcLxYhRu1DuLzxgsIUBpgIAW7BXxx33GwRDSlf0CMlg14GArgKx43z0ABrM52/oTWWgfG2/kCUZXjWIjy6uhtRfOg==;24:sB64uhiFGow56Yg69c0soixAWGDnM8nRuPZgbVk70h3GKtCLZVZhxFkoiN/ssHmrH7KUhBeSpH5+YNi4lJ4RE0gX6kWVSMgxPbNswIJcbe8=;7:cZXRe/tjPzGVF432/dUl1/azAJDeiOGvoR/8yFenPB7iuopejkb7wy7/TnO96X40/BMBsbnUccfOtwv7wbmKA9mv7ehcVy4yhuqCgwpB5EoHIjktVC0tMGsm2jzPgwhGqKsHyLvdYr24SqZ7RCstadvQLU6kFf4zZPuLNlxssAvyh7RdbqVJ4N0vCHQAuCXvy4D8Ba+pwHcBqmKkP6JZawfKFBAMakarast68Um1huQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:43:01.4448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59875
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
---
 drivers/watchdog/octeon-wdt-main.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 73b5102..410800f 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -69,6 +69,9 @@
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-boot-vector.h>
+#include <asm/octeon/cvmx-ciu2-defs.h>
+
+static int divisor;
 
 /* The count needed to achieve timeout_sec. */
 static unsigned int timeout_cnt;
@@ -227,10 +230,10 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
 	u64 cp0_epc = read_c0_epc();
 
 	/* Delay so output from all cores output is not jumbled together. */
-	__delay(100000000ull * coreid);
+	udelay(85000 * coreid);
 
 	octeon_wdt_write_string("\r\n*** NMI Watchdog interrupt on Core 0x");
-	octeon_wdt_write_hex(coreid, 1);
+	octeon_wdt_write_hex(coreid, 2);
 	octeon_wdt_write_string(" ***\r\n");
 	for (i = 0; i < 32; i++) {
 		octeon_wdt_write_string("\t");
@@ -253,11 +256,28 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
 	octeon_wdt_write_hex(cp0_cause, 16);
 	octeon_wdt_write_string("\r\n");
 
-	octeon_wdt_write_string("\tsum0\t0x");
-	octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_SUM0(coreid * 2)), 16);
-	octeon_wdt_write_string("\ten0\t0x");
-	octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)), 16);
-	octeon_wdt_write_string("\r\n");
+	/* The CIU register is different for each Octeon model. */
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
+		octeon_wdt_write_string("\tsrc_wd\t0x");
+		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SRC_PPX_IP2_WDOG(coreid)), 16);
+		octeon_wdt_write_string("\ten_wd\t0x");
+		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_EN_PPX_IP2_WDOG(coreid)), 16);
+		octeon_wdt_write_string("\r\n");
+		octeon_wdt_write_string("\tsrc_rml\t0x");
+		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SRC_PPX_IP2_RML(coreid)), 16);
+		octeon_wdt_write_string("\ten_rml\t0x");
+		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_EN_PPX_IP2_RML(coreid)), 16);
+		octeon_wdt_write_string("\r\n");
+		octeon_wdt_write_string("\tsum\t0x");
+		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU2_SUM_PPX_IP2(coreid)), 16);
+		octeon_wdt_write_string("\r\n");
+	} else if (!octeon_has_feature(OCTEON_FEATURE_CIU3)) {
+		octeon_wdt_write_string("\tsum0\t0x");
+		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_SUM0(coreid * 2)), 16);
+		octeon_wdt_write_string("\ten0\t0x");
+		octeon_wdt_write_hex(cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2)), 16);
+		octeon_wdt_write_string("\r\n");
+	}
 
 	octeon_wdt_write_string("*** Chip soft reset soon ***\r\n");
 }
@@ -366,7 +386,7 @@ static void octeon_wdt_calc_parameters(int t)
 
 	countdown_reset = periods > 2 ? periods - 2 : 0;
 	heartbeat = t;
-	timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * timeout_sec) >> 8;
+	timeout_cnt = ((octeon_get_io_clock_rate() / divisor) * timeout_sec) >> 8;
 }
 
 static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
@@ -437,9 +457,7 @@ static enum cpuhp_state octeon_wdt_online;
  */
 static int __init octeon_wdt_init(void)
 {
-	int i;
 	int ret;
-	u64 *ptr;
 
 	octeon_wdt_bootvector = cvmx_boot_vector_get();
 	if (!octeon_wdt_bootvector) {
@@ -447,10 +465,15 @@ static int __init octeon_wdt_init(void)
 		return -ENOMEM;
 	}
 
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		divisor = 0x200;
+	else
+		divisor = 0x100;
+
 	/*
 	 * Watchdog time expiration length = The 16 bits of LEN
 	 * represent the most significant bits of a 24 bit decrementer
-	 * that decrements every 256 cycles.
+	 * that decrements every divisor cycle.
 	 *
 	 * Try for a timeout of 5 sec, if that fails a smaller number
 	 * of even seconds,
@@ -458,8 +481,7 @@ static int __init octeon_wdt_init(void)
 	max_timeout_sec = 6;
 	do {
 		max_timeout_sec--;
-		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) *
-			      max_timeout_sec) >> 8;
+		timeout_cnt = ((octeon_get_io_clock_rate() / divisor) * max_timeout_sec) >> 8;
 	} while (timeout_cnt > 65535);
 
 	BUG_ON(timeout_cnt == 0);
-- 
2.1.4
