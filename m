Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:41:32 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992309AbdKNEjF2hJ-3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=30Jdfaebi/iXenPtSDaBdNNvdTHoa3osSNDKaHeEClw=;
 b=bCKNCXvpS4e3hq+5oQNYxp2V6uHlRRG/NCjBk1AhvZl7vpOglh6PfsjAI1Ebd8DA5qy2gHkiSTGnfr7NEXrFsJkILoxOXIsnyysLnDzxYgHrTGAeDHkxpf3SZChHnGrpnh+WbqMseOug3NXVBN9YwFq8Bo1zSXUY/t2H5qgQPG8=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:58 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v3 07/11] MIPS: Octeon: Add Octeon III platforms for console output.
Date:   Mon, 13 Nov 2017 22:30:23 -0600
Message-Id: <1510633827-23548-8-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751bbd93-56bd-4a29-6255-08d52b199f6b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:ZpZr5R+0ray7ZHIeY3qwRFs6lIMK9hm/EyZDZ2PYA+aEweSQ2igdFKZJpv05JnloeL89kDoF4o6OvhyZYmtWPu0z31jwjr1UUmTqwExweev9/r/SQAZe9ti+mUDOZP6CshCzoRYWoI+LLT2xyYYsqJ6kpxPBUdpgkDf5UmZ6Fkgr4/LhRZr3QZVqbCLOkTL9/xkmBeiSSLPjg6MVFGC6y+PS53JMJNpQbg4ZpAw67Xp0czweWYJVwkB6RBqneg0Q;25:vcJQk4qCBSUjeK6UwDjtbl6fXBFcFoBUVpphNmM8OnStJPMY62wuy3kLRiHChPfLrI9AZYSsJa8H8oiWkFHcpJhBemqhKgyn7ANwkmT1wQHoeBZcA+UXM+2dwCDXyRkFVmK8bEaf2vuPahKhpYk0TDuIN0PV/eH2DqiRiYalUVsrY2iAoEvuf2QxEkefp8jZwaF7X4zySWsI69CENuk8iGtkw0pT2hLdAfVaTzM/BsRh+P3SWHRf/ZFbgjavAQfuCjMUAfS8YM7o6H+co3yzzM1reJguePE8vphNxJAzzS2iuX735QsXBwBxOV55wI61+sz3JcokBmzE8WY1ZieBPg==;31:5AQIniMfuBSvh1NdOAs0ugD/j9kbkjY7YFxXUYeQGaWieNek9x1vM3lJSb6kIEjt3QiJhSkoIPyfn0FvkeRIDpvC8ggbEIpeyU45ZJ83ogvo3kQ+9K1mwfj5sV3ALQe6msuVqk22oXxE/KA1A9bpAhDq0SAVgUAtIm3f/2dT44Fmm4T9Luxw8rQkM2HVeBYKieFTmxgr+tV2zcK9IftxMEb1gSlfhaZYanrtLV8m9z4=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:98tjI1n54AlCUfuRvShduaSVxqt9WlES3HEVzda95Zu4+aK1zM2Qo33/j+ujJdgzOyncoEe2VDv1r5XODbs6qn7s0lR14SzwKg2O9HNsrvTemuQ+WNtwfzq1IRybGYv30KHXEm3tIxiOHKUPVtD+lIBQjP8sFXZrxbu0kNSfG5ITiLEr++uaz9sN9p08kFk4Hj+zO05ARI/mZ3I3SgXWbMT/4wpw79kcQH4/+N8ZgnmqbDxpJrR3RPYdSGpibPBMf5l6ZthIPEEIT36GWQoSQhFv5oLsbuJgGnCVrobNjtyC6+naqu+B/5OU9VjTxPdiGE+J60fcg/Y/HgBnO15rT5zQ6nyWUP7esWMG9JhZL1uGGuGENICLd1mySsHzdGtuluX+3jxlO72Tt+juH3NA2V/UzG6WXcnrocqeUg4Kzh2AQFpmeQiOe+EpE4SY+XyLMWKjVKEcnLF7haWTBis3dUeHKHRiNdijMpdvvX9dEcbSySoiIqNHd4uZSksFCq+r;4:mhqcAh69TelYCT/ovKV7ReSvPZHFgYQhuxh6wLp58KrXCo/5qnKPc0CR265IVF+N7+y2rY5AuKFy8hPw1zHdcRLowveXicnLG3MDQZFxuYhmZB7gevhyPm8Q5qPHWBJEWXQmESxewGFL21LmUseUDDcAkWKhvla5Oc5yzNu3vE7/ppskwuRqwbkhpQHFZW+N+DRVs8PMLn3wCcvpyr5pPSuGPxbqog45la7YO7DAjtWsbzxNSZQ/fQv0sMBLRpR+yIeLbKFi51nbjdQ0Q4BFCw==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806C86963E7B6CA97629DE180280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:2bfSTkXlihAKEHwYDViwap+hfoTCbRNF7mCfbd4?=
 =?us-ascii?Q?27UsmlqisXK3Q7qu7tC84SR6CxH3CXuyzxljioW3UIZ9/MovK45T8xYsFEnV?=
 =?us-ascii?Q?z/tjRJpYLs2uxN3dkRY0P7vQ1g0uvQbR9oCxZs4WaWfpDumT0xPR0D8eyYzK?=
 =?us-ascii?Q?B286hY6B4Bu5qxY2/nlpCMJyhUUBLtw8mRBVYbaPZ+enGCsjFFaKimNc1b7t?=
 =?us-ascii?Q?45wZjuakjQMLAWnZ/58yiyXL1TrcK1ZAk3s9h4Q1pA0k883Mm8pOXwHSBUQ3?=
 =?us-ascii?Q?WsRGWh3M60QK+63IQ3H8y7aHcupzxtJkeq/cIvSwGfNaYJ8h0ydC308Gxv0F?=
 =?us-ascii?Q?4RrEKpdv54LFlcqf2jH8LerOAOygNqz0ibrHHgaoPoE9RNbGptYFcyxzsQ3w?=
 =?us-ascii?Q?T2lV2kWjRpvIMBt/wON976iglrqW0ZvB6Mq+jTNHpfAyXGCvQ5hn+ebI7B4R?=
 =?us-ascii?Q?TWeadqXbyiPa8TVNFB8xIq0N4qT1lqDNKeOmzQd9/eDzdMnYEdmoPDGKkORa?=
 =?us-ascii?Q?3vsVfrUCns5hXEbbBvm5zHsEDnXdFHPvTZUiRyMUAQfHf/Hzh67HfJY6Fjib?=
 =?us-ascii?Q?mmZw5OwggDKipp/IpF0N5h98TaN5l0fIXF+mZFct1dJU1AQvS8JD6w59KiYy?=
 =?us-ascii?Q?DiF7ZpKIudC1emMzOpoeM45ZeG0BAh2KYbp5lrF97hTmcfWhIoEPIjoB3q47?=
 =?us-ascii?Q?gO99ULdiynvE/rX5NvqpdT1jPWIaVOi/1RZsgM1u3XDhL1hregBoFlcnppXc?=
 =?us-ascii?Q?7YJ9+HMvg7T96wr/1Ofj7IwptCHk/6WlVEVMML3iOoUTyVBkMTmkBUAT+J2k?=
 =?us-ascii?Q?tMYh6yJ7g3uf/jr9vBMAkMB3xxA0R0M8Hr69DgjYctIMfIHhnSLtoG+Ek3VR?=
 =?us-ascii?Q?T7Hu94zpPCN2uxmQlZIKRpH9Xcg0znLnGVR8ugS0Z86fC9GfYXUHVW06Pp4T?=
 =?us-ascii?Q?g+uvdCLwHmZbS1pIucVt/b+RLMw/Nlxn6aOcX74d9jQQ8hWAerfT7/08hXbV?=
 =?us-ascii?Q?0XJG8pKCxLQqOiY+R7NiGm+bU8r8AryZ+xH75ZfM0S5DsmmEHcv4xshTETc6?=
 =?us-ascii?Q?qHg/9RlOPGS6TxVKLHvR8o6dnnZJR31+IOTLfj2udPBqj6Tg/lJn2qNTZZcM?=
 =?us-ascii?Q?+FMdoCIljo8QtSvXeJEOhky38IfdGnvsDNa75abn5rXeAYf33E7onSNRwIcf?=
 =?us-ascii?Q?ZR7eZdSTuvvv5SHM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:KLmsbvJxRCeL5FxuEKvtj1wDzIOX7qpOHFTAucdgzA5wJaD1PExgS10FmBVyBG1cBTdME+55WmSINvSeDE7EoDKQVpIEuRIku3XSRj+SXd0RnWL28XN+id+K8htaOikctMfvN0NDinFO00tjkmZFoXPaQ6200xrGsiGcidAjat4lRPbbklEi590Cz0+BYrDLlS+OHUOt5/uQLKbZKHEJehT9Ok9DRlTHon+W+7b4AJzBNXq5u2FCHJRxQuBvgxKSlZYt/po3A623DPDMqiByW4GELAA5PrDel41osycWHns/b0JJvd0HU0rhjLnWKt5eMeRM+VOjGkVTK6FuSh++0L3fkxrtJyVLju/V412NVO0=;5:aB1Nbp4mj1I42MBBh/qpO+5bEh+X6y1KFmNTesSEq3h2TSuFyJ+xKug1KZzuzJN7lO+gtcWNWFS3EzxHHCJDyUy6suIVAcshVWsop3cefw3Agrqb46jWC4ADE70jatvczgE9LyyEh0sLCUdw/EtOANLSW01qFOlbYxEtyZriwS8=;24:1YMz3T6TYUDZuoUXoqRj64IWmbFyjFVmiBXlNAvq2Cl5MEBIC9A7T3y5n6OPBAtf28qEQ7NQzAWNf4Dy8cGxZ4s/2eID/ZFeSJHETmwvd4U=;7:8MxJUf48h7atHn/ROUEHUNAACl+K4q+JdEwy6YUQkGOoAp3UEhXP/DdDTlQ8Kq0A5O05JNTsAk47mS7KOQJ7WY5XcKckEfVDC6GzBGcsExUtQzn7upkwXdxkA7VovvNtQOMGtrxzWc/uzUN7y3QYuMXYfKoQsUmN5Kwcr40LcPEuYsDKG2j4KAds4kXkjPaSXd2rqrj7/XLfv7rrAuwny0JLrEMCyo1ietXuHopu6ZsSsLzj2pJfV9oSuozaaY0E
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:58.5647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751bbd93-56bd-4a29-6255-08d52b199f6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60898
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
