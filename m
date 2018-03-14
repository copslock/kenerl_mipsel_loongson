Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:42:42 +0100 (CET)
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com ([104.47.38.58]:61227
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992273AbeCNWmHcvI6J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:42:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=30Jdfaebi/iXenPtSDaBdNNvdTHoa3osSNDKaHeEClw=;
 b=dlnMBczct9rl+cDtlM2Pa2I7gwVqP+O78TQ5s6pM3fp6hzrADMKz9m1aX1arqlspsPRRPo+sXQpci8+tmBqQZmzusN5UPHL4cnLcLgUIj5Uyc63Sx4gL67KU4DQ3LpSDogYemAlwGlWijL9tdREVWDu+qvF2/Ro4hWWgqlzhMj0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Wed, 14
 Mar 2018 22:41:59 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v5 3/7] MIPS: Octeon: Add Octeon III platforms for console output.
Date:   Wed, 14 Mar 2018 17:24:14 -0500
Message-Id: <1521066258-11376-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
References: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:4:ad::47) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a218284c-e47b-4d0f-4d7e-08d589fccc2c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:/MtDVfVJuhN0+ZKfH86xklAj4o4MIq34MK0xHcZR50fHp9I4L2N0Y1Uc5SSaNN6gz/LwW8PJB9P2HkwBPSlA7h8YGPiqbXOI4OnD68KeC0Pr7cAMsckGbuqoz1YgEZ/qTGGOndBRblP+TLJ0d4xwEC9bF7Uk6Yy+NfJMNkDkWEj3ZJPNqe+P9i56LvlzbYWlTrzxC7j9dNJxQA+arCx4vVSSAYqwE23fuiPO//8aDszlOWeh7+sShsdYSQ0O68mw;25:79qoKDM1A4mVhhHJmNH24zEmo5cEcqXUj3nJCD3PwC1w3qP/3OGgIbLrgS/F3yAT+5R1+PyRTEgGOTJAILNpL1Ws0t2NMWdih2cGJiZOb83LmV7uDT2W2N6EfOm0JadIjCOBB8DZfmBXpOfYKuTolFFfeRo5QD/9TEb6Dj4HDbwuW9kWM0D+goHWdtxNwuvr1gfE3Pxj7tCyQOg3xk3140ZavM6EyBvxJULl5v0LX+TQXOdhKjU/gfRyBuOc0xv1r54b4meJ4hudqkyOZLoMM/On/W5uKceQxHAN+yk89xdWSVIh1gxXXN+pRPW1fH1dRvrzi5kr0u35jV0ZcySzRg==;31:m5xFwxNLtjkuMEpC54ofkTfhy1BYvk/0hUYGBuP8TdFGyZ0KBKJzRmP0eEcy6yoeSKfvd6is/UlEKJfFZPj1xsqgihJs5BggPDZR9jK9aozijPY0S1kopXrLphqQWWuIeS07vqXgcoSOozwBCU1ucVETLC2mmbcJQ+m74XAx/2pBARcdYg00w0LTL2MOc+4HvtsLpYRHruWU2gExDUjaf3kZT1nuFPPI5ToKTHYsJHk=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:DpZii6/USudF/sSGjzN1Yt0k29KNMsmkw74/eQS14YLhJkk3WSYvwk8rlc4j1fkULmr6Y5Kh5QxSG+n4uFk29GM8YgZUYnQMcXNoGiuiL0adDe7QSk4hVPn/Vpw9RgVXyPxpnVybACk6lZD/l45pt6SkT1ppHBO3E7JODidorAyzPxLvAIKp3vAtdakDOp+Tk5vi9cn/7EH34DSSv7UHQn1JH+yhUYZ2WeNEeSH92qTY8saLmMD2Huwhb7dCeSrVcMRFGCCW/UVtHMR6LPpv9djK9kXAyraGuC0HI+j/87+WgcCNhNd/Rv+IwpHaKxZZIkHq+uK7lbLdL6zKQ51JV+ebl86dtpVamkolEnDi/jVcuND3A/Ea8aCDVLRVkRaGSUnQbL5TN7AU/A4aOXf2OZbVPQcIjRYRzLVgdC/JQa4J1Q4sa4mwF13dykhAqmOlUVIM3LM0bF5V2j+k8aejmAFbv5IT9mLMn9Xz/LWD/MZzCn9KreZMQzKl21oqN6Pv;4:CtmurFeNHl/76wCs4NgcSaYQ7mNablAmVYZq73M/MdAPFVOFZbMTFx9CMAo0Lf/Q7WMVCiWR72Tu6nZJSjb9LJNCl9b7jRMCMIqhS0d73/YSjv1H4paIT28mCXE5+cSJrDeZATVW+hNhZ5XamKNYFh9DnuLz9VQMuZHmlpZWXyQ/J70BSk/XZPQPyr+xP8t1KtL3i+yJiARJ1atpBbvn8MSMXdqnGkd7OebeUBpK6z1oBMdNLlov9RBTwG0ka8Z6pfFzlJUheyVLxS+UfTVMyQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB361024DE6AADA18EE53D654680D10@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(8936002)(305945005)(5660300001)(53936002)(69596002)(53416004)(51416003)(52116002)(50466002)(26005)(7736002)(81166006)(16526019)(186003)(86362001)(8676002)(81156014)(386003)(76176011)(316002)(68736007)(50226002)(48376002)(16586007)(105586002)(6506007)(72206003)(2950100002)(36756003)(3846002)(6916009)(97736004)(478600001)(66066001)(2906002)(107886003)(4326008)(6486002)(47776003)(106356001)(2361001)(2351001)(25786009)(6666003)(6116002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23://RBJUYE8y9e3bEnp8j5ESxwcO6upSioFv5z12o7b?=
 =?us-ascii?Q?Q39ucBx9Gaw/2FZtp8q5xV/6hMsMA/kvOeZA5dS9oOJ5nXf+4IVbpSwrw6B6?=
 =?us-ascii?Q?3YO0JOFRNPYr6CihZeoPZ6mWd6vOwjEjic9zu9f1IQKogM+YnvuAo09owHCD?=
 =?us-ascii?Q?KlbAoqIY4bx0Zcs/Cc4qrS7Q1i/PtbCNur/hEze8eYMi9WcNMrNnXjWWYSb5?=
 =?us-ascii?Q?lfcppOHJx4ot/NpTs+rExHeUwvYx3zNRoo4WD00xfSDteo1Em68wv3fOwTrI?=
 =?us-ascii?Q?fCCCmNh1mqGshyq0ElO0yDOGlLoqOHvz1IQApOt+SjK54dv2TVd0Yx/mNhFd?=
 =?us-ascii?Q?Mo9avOqxQqrOjMfgTEOroeWSgQ2b30w++eI7xD0uD3BQ1XWi+ySxX40Z6S8i?=
 =?us-ascii?Q?1EJIvStur3n4SjeNSIJwbYe0dr3u3DwrmqItzePSkQW9TElPgogD/h3WhMUY?=
 =?us-ascii?Q?3I+atSbzIgUaqXkE2FzSGtQpzRaXdo0Fxs7aWGitBimUxESvYHdWs/pcnI7M?=
 =?us-ascii?Q?fagNnj4Wf86XSHUXYEDj/XiJ5h9Y6pJQIBskmnrKfrxKjuSIOn1ml0QbCB2A?=
 =?us-ascii?Q?gBMnhetgXB06ojBMqok1mSAw5Fgl9i10Kvpyr9/S9yJpS4zba+IxB8l4TCpw?=
 =?us-ascii?Q?N39+5tSso30p7jOOoGbeLoWaot5TP9H4JAP1rBEdeuGrH9wATCDNQr3CHci0?=
 =?us-ascii?Q?es8HrM6y9gQlvQwBKMSn2DjUf06TVWg+RGXhfNBfOQPHDEUmqfiuRBHoqNDC?=
 =?us-ascii?Q?f0MnHbrGryZhID229vivooPr5nVcCXk9Sd/vdLJdRH0oFsf9h/Y7iN/tADME?=
 =?us-ascii?Q?D/EMcT0o+xkOKy3ixi9U3//PThZEAry/ZOGqItfgwuyzXtCsjhmFYsSDuhOk?=
 =?us-ascii?Q?QFje95Qx7dUkcc8/iZdUcoF3CFgrxQFBe5R3kbDLgFI3MzMnIE9Axs+jiv6t?=
 =?us-ascii?Q?C158PqFOMh9zYAsRGugx3gC07YEBNYS8cWtcO1TBTRI2f1BW0PpcMnK7PNGF?=
 =?us-ascii?Q?JNfZo9RLnmFK7lnq14X5niUNIo70pwWfYMKm+cXt2Ou78v13afDK5YcDPILH?=
 =?us-ascii?Q?Nq56MDEt/6qVS6xdd5Neq0Jni/Pcp7D6GIrXp2KzFWRdFBd0KcIwT4gKJAzE?=
 =?us-ascii?Q?c+MFHRVVgS0Gz+6n1GMCVO5MNQ/rv0eoDF0N1bNYd6EBCx3LDAC72oPmEOtK?=
 =?us-ascii?Q?gXsbleKft4tcRuB1ej0R62FP1iQnqA7wncp1YFsW1JRWgWkFIYePROsfw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: qW1kh8DZmJNRFTrx8z3q5fb15PIlIImxxOgrcFltgT3GifttKisAhUny98qJiwP2tynpRnsuWA8UdEoWWokg8M8Uhf2tEGf9USX+cdzKdKLa86T5htWvqKJEE5j4GYhhehimiM8r7ggaRKl6Z3w5az5nDKEgtQxc/XfX6p+f+Zf9JJFEkZ/hnrX+0Ocztj+I
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:YxyWc1TE6LbMwi1ySNYHxDdKxv7d8ZLJ/5qNeOiMGwr94uQAKjdpImYY/z3siNnTtgM8xW3/UAni680xmE7PzSatG4kRTsuBldqTRuwq45f7LyeQNd2yLkzCfCS97Yo3RiAa9YIf4DAD6zGjxgdTr8ndcYH6nOLBCpPfwF5KPRt5BiXbuFhpk3SqGzwAdRbLcvC213S1VNX45jNXuNzGLKy74FLJnvc/2HpEacZu2Z6KRN+vXJWgD7fgSCCdQ1pE3SzU6XvsZj+0JUNLpZmXpZbYSL/CWLIAito6pRo3Rn0VAH9AJFoi/blfbn+lo/KLBvV3YHRuJOLDE7VRqQfZLbdhs5lMtx3hswDFZ2Ga8tY=;5:fM7Ijol3Y0rVcIgmvFi88kG28oV4u9DFdxZHBMZNFO8bN5HSF3w78qrCdfQcWZ1xdDt9lrkOzoAug5ndzAl3w239LEUTEsPru6/oiulTr8zj6IPnBh7cLJGC2Fbbsm4gkXfpV8qhi+ouc8oXYiU9QPPabfggx3AFSDPRmmi20Sg=;24:YAhOsZQvVYfWfr105jaVqhzgzpxH4P7vHElYTOTPkRHajlQErDURJBJAUs9ESZYaqk3HtwB2cZ2HkswDsu1rOMjQOSEVKfm4Tv6LG8VB3AA=;7:RBmBlWlfSi2e8newFOh54TmkhqdTR6kNPUOrC4M5+0OENquyECUnHENrdOnGU1gxSyEGjvRt6g0ck6isN7/m6uDk0fNGwz9Fg9fAMTKTs22PHFNUv9nfERxWCak4rOv1c0rj/0AU1khGi+v+PEK9DTMuaJ9j001ay5udJ1K5McT7o0005RPPHzs18VUfvVr4+W9QC46ISwQJ/qCxJTapPYigKkvHIGvLj05aW1eKbjfAj6LT4ld6LQT7qbvhbSaZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:41:59.0512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a218284c-e47b-4d0f-4d7e-08d589fccc2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62981
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

Support Octeon III platforms when printing out the model and
SoC information during boot.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/octeon-model.c | 53 ++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index 3410523..069a996 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -67,7 +67,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	union cvmx_mio_fus_dat2 fus_dat2;
 	union cvmx_mio_fus_dat3 fus_dat3;
 	char fuse_model[10];
-	uint32_t fuse_data = 0;
+	uint64_t fuse_data = 0;
 	uint64_t l2d_fus3 = 0;
 
 	if (OCTEON_IS_MODEL(OCTEON_CN3XXX) || OCTEON_IS_MODEL(OCTEON_CN5XXX))
@@ -453,11 +453,13 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	}
 
 	clock_mhz = octeon_get_clock_rate() / 1000000;
-	if (family[0] != '3') {
+	if (family[0] != '3')
+		goto out;
+
+	if (OCTEON_IS_OCTEON1PLUS() || OCTEON_IS_OCTEON2()) {
 		int fuse_base = 384 / 8;
 		if (family[0] == '6')
 			fuse_base = 832 / 8;
-
 		/* Check for model in fuses, overrides normal decode */
 		/* This is _not_ valid for Octeon CN3XXX models */
 		fuse_data |= cvmx_fuse_read_byte(fuse_base + 3);
@@ -486,7 +488,52 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 				family = fuse_model;
 			}
 		}
+	} else {
+		/* Format for Octeon 3. */
+		fuse_data = cvmx_read_csr(CVMX_MIO_FUS_PDF);
+		if (fuse_data & ((1ULL << 48) - 1)) {
+			char suffix_str[4] = {0};
+			char fuse_suffix[4] = {0};
+			int i;
+			int model = fuse_data & ((1ULL << 17) - 1);
+			int suf_bits = (fuse_data >> 17) & ((1ULL << 15) - 1);
+			for (i = 0; i < 3; i++) {
+				/* A-Z are encoded 1-26, 27-31 are
+				   reserved values. */
+				if ((suf_bits & 0x1f) && (suf_bits & 0x1f) <= 26)
+					suffix_str[i] = 'A' + (suf_bits & 0x1f) - 1;
+				suf_bits = suf_bits >> 5;
+			}
+			if (strlen(suffix_str) && model) {      /* Have both number and suffix in fuses, so both */
+				sprintf(fuse_model, "%d%s", model, suffix_str);
+				core_model = "";
+				family = fuse_model;
+			} else if (strlen(suffix_str) && !model) {      /* Only have suffix, so add suffix to 'normal' model number */
+				sprintf(fuse_model, "%s%s", core_model, suffix_str);
+				core_model = fuse_model;
+			} else if (model) {    /* Don't have suffix, so just use model from fuses */
+				sprintf(fuse_model, "%d", model);
+				core_model = "";
+				family = fuse_model;
+			}
+			/* in case of invalid model suffix bits
+			   only set, we do nothing. */
+
+			/* Check to see if we have a custom type
+			   suffix. */
+			suf_bits = (fuse_data >> 33) & ((1ULL << 15) - 1);
+			for (i = 0; i < 3; i++) {
+				/* A-Z are encoded 1-26, 27-31 are
+				   reserved values. */
+				if ((suf_bits & 0x1f) && (suf_bits & 0x1f) <= 26)
+					fuse_suffix[i] = 'A' + (suf_bits & 0x1f) - 1;
+				suf_bits = suf_bits >> 5;
+			}
+			if (strlen(fuse_suffix))
+				suffix = fuse_suffix;
+		}
 	}
+out:
 	sprintf(buffer, "CN%s%sp%s-%d-%s", family, core_model, pass, clock_mhz, suffix);
 	return buffer;
 }
-- 
2.1.4
