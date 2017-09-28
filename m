Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:41:40 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992363AbdI1RjIsG7BF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=30Jdfaebi/iXenPtSDaBdNNvdTHoa3osSNDKaHeEClw=;
 b=NlU7alHGHxHu5fv8tdrM5FstGpdVqwTLuTPVuIrFSCwPN1KhD7sC9zhR1xkMfjpT94P6eHdI3D5N4jdcgTae1UJfWlssgTG6zY044G1SG6rmgc3siYtY8at3OXvaIBkTgvyH3RjtAjt9apnwLN/ZgyvlLOteGgzVcnaNVmylZ/o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:01 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 07/12] MIPS: Octeon: Add Octeon III platforms for console output.
Date:   Thu, 28 Sep 2017 12:34:08 -0500
Message-Id: <1506620053-2557-8-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3bf32c-3854-4821-82ea-08d50697ce93
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:YrWWc7PiS8tLx3x19ErCrH9iieyLRkHIFSb6jad0HZ5mYBDCskegIBWgMHKt45RlXwrbeOvnTaF4hTlo5d5Rn3pCHzkcJPMyfcRfA95p0JbcNuSDV/Q34orejSmApv65AJMQ79yHTTGbjD02OUNl8Bzs7ulw4zniB/wViM/NelKj/Y/N4Bi9Vj5RUQ6s/Ojt90p43ayD4dntvy4sJfbcX28y4S00N+InJeeHkLIDlXVs5OFShQ3Ou3lyfepXsEWJ;25:ynXSEL9+D+Dq6Jjzv7Am/cVugVariN5jI+k7XkyoQ9099FD0rroVbMEtgfGtzXeehqeKjgybGoi16n5WHlxRfhT0fW/l0i8gZAWawR5Ky9jul7cVmVR99KxwCrQ746bKRG9JKIpKyJl+RMbVYz0V67/BL1NV5WEr0hX7i1XhIbvzS4liigWSNh93qik0cm4SSFOW8SCpSwpbw+/ThCr+sJM0mEGMhWxZWzzHa3VHDgz13te51v5GjhkgCB6HI+PP1hMY1RQiKUQPaUDEVxtPBNjwQUWl1gwEs+szqcmQeLU021txTR15vYG/a11M/O68ZhW0fdAzG3uUNC2ioBZDew==;31:LF/eL/xiEx0LEd1Fap2fcG7KiDnQKTCBYkqbEQlxuvenzb9a3nlgdtN8h/7NFEjzwjb9YuAIQ/EmNOccLaPvAaa0EWO1/ZFc+5VLMfbqJ8hNaLVqoH5IwE9XJP8DrWmCnLtKnWnCNSaLFWGdQfUfMwh8wmJ8b3Sj4PY6Z1I9/kQBbM67+AyoiJ2Zv9FA4b/tvhRTiUIIIjAnD3RRqO8ZG3jHNueQupEmJ7L6Z8Xcvg8=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:D25g/7YVBTQfHGPAePl39uS3UHh56uFgMqYGxAAptXa+rrOAcSeUs2hi7F4NISHJSNJJYfFDZ6WH1tPP3gYvSlps0rbWVJRwrjR4Pe/ZIRXlvrtNCCPn+G1YaIHsHQ+IfYpfIRnSSK/jTSHgnCWb6Anx+WD7+yiBii5g99oCTgusmKnuEKB73pfb8Q82FcMZne4Dj864Tt+u11ynXRdujen8hXF2yDLTjRr804q2C8xbostqwmQnSjp830SpvUOb3OfiI5mJf7vUuKz55WuwH6FwtCenK1z1fQlvgD7IOm5jBCmcUa6P1N0ovR1zVVZ/3FbSaYWPI9cKU33oGxvXEikjHBZwDUgucBoCJdU+p1J+Z3pP/jTVVzojzJCVhYRMYg4uXCftQj+FsG+bK06NcV6eOz1ghJAxPddQbuyQsF9EXGDIwY5R2i8nV+h2+QfIj7T+Ns4Opsd09Zsam9FdxySdn5OqfjloTvNGHYP6TmYgpTTgSMjrziHBa2g/E1Fs;4:vXxsyDEWTcvFoW4QRRnyhuH/uSc6UAyqR33zmVsxGGH/CBYVo8wGbABeHypjG7eEvAHdiuxUOKr9lDTOt/k9dJcDWOUWLfIGbwJRAeUAwRzdwmRfhRs6lnnKWECQ12qTgyLRDtBtHhQSkt5bdCzk7r24DhT4Cev0ezECetI3b+rjOgNOoNsGADHMQSBCQviS2BfvoVf3Z76xsn8oc1vv2shNEJrf4nq7kf/bT6dV6fAQHmbj+zdqI1nsyawklmWT
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807B2D7F61222890F5E874980790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:Xg47tQobxAbRR29GwwndSr15vEEd//JP7245PiT?=
 =?us-ascii?Q?k90UQWk38GS2Hb9gsidIcGxY2TqrBK9cjj8RgD7wYB9+1tfNxBv6nRBundsL?=
 =?us-ascii?Q?rJF2wSzoj0hpqs6Ybb2IpryaWNRP+46EO3fgLEQZuW26TQUjZ8aOcphW/7+n?=
 =?us-ascii?Q?GwIIEv3D+48fmXYFJZKjpOtk9QpREt7v9YGGg5wK4F2b8IM0wjhOvcAJn2oN?=
 =?us-ascii?Q?M+wM9GMJjmfAmiL8JEuU5MZ/V2jQQjH26dKWtJIfn7BHEDUNMf3x/8G6tP6a?=
 =?us-ascii?Q?2mijohggytH30BNvyrYzU6jiDk8RyDmfwk5QhjZfQPUkH+m0r4QqrmvcsE/Q?=
 =?us-ascii?Q?P30szZGSf5uVlWLzQBTU6zhRv6Vip7BPwaXGti5Rn49K1RNf+Gu6e1lX3kg4?=
 =?us-ascii?Q?MjOO1t0ENDMWdXjFCFH/sqJH+sfvG0v1Pyjk4FsyhG6pYG9j/1Mwuj/XI9Xa?=
 =?us-ascii?Q?y/t6AfaZPdUbWHY86LDiv3qCMy8p3Z7YEfeGDm+/a0nTdMQhkKECoH22/Sta?=
 =?us-ascii?Q?hu4sbyXcJNNZLHxYD8UrGhME8bE/bScNSLb+sLdjR5LPN4XUzQu/oR0k4W7M?=
 =?us-ascii?Q?3eJtxi8twIzuXr+WU4mJ2eKu8JFmpWwDrUs4z/PsMfxCcmRsHVS+xkaVshWb?=
 =?us-ascii?Q?xrLPmN+HsSHYDDt+04fCZhLuecSBpcRCJAknJu9URKU6eVNkz3k+NK4dYUck?=
 =?us-ascii?Q?IsrjIiV/0AjUXnoJU9zPmAH2nqX+ry2FHLyzhuRPsY7QNBYLqf69+DtbcstR?=
 =?us-ascii?Q?TT5sWMgzNplPE3/oRILkgXYz2T5O/0qi7PWSkPSi8SpwluC9fbhMy0+y00hw?=
 =?us-ascii?Q?GxAcprUm6zJdZWuRpwsnwdEH+EUVdi3GEL6JvVGk5JFOebhZMuqXVS0NU36U?=
 =?us-ascii?Q?bEq7VbTg+V0R40TW1P5YlFoi2Io8CpQd/QKcV0dILZAb8p3BpaeIbhRK3iRq?=
 =?us-ascii?Q?o0SM27I5itW/dlOKWAst34U5yy/tNQQU74zONxh1W21el+1YiD3ZMj7F4Tvs?=
 =?us-ascii?Q?NFBmTltmD4HdFdl7txNh0Cju6Cs64K5Y1KsgRYIJ6+dRYByAzJjrIT49peZB?=
 =?us-ascii?Q?GUmdk4hkDevnLdV8cX+YiY2/ubKLABAl587ydST40JTmB/YVfu2CHkURc9aL?=
 =?us-ascii?Q?ajkiSjbYIrop0ELu+4IGWS0WO8A5AzM0u8qDPU4/eEAeBUAnFoVrF9Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:dmYeXypLmyzCYRkH403H2P+nSdrbCY8vgEKFYIFrHIDZf6af4mffAWDIR0/Q83Zmtfi9CXWUTsUTGUSU+vYOYChDs6MoDRp6B6OetNamH89KNH+3vWhSVTHN2u6COzdGwu4PMHiyg0Crbv3zcuZmBOiavgNviZO2PtBCoXVUXECWyilc2IgLIXpuCF+hAfVZrf6y9Hy7BCvQCZtlbXT77Ee+j+R6xHBOoZI/HmqsSEUqMT9GGFOLFK2vcPvET5YU8O/jq/G9beK8BUqtCcBGzXAYKXX/c6DkKpaNf2cDGzeN/65rsbww+q8klirOewQ9/tDgePcNNozWM50aNck+Gg==;5:xW3eo+atbI2f2Eaxt/IPF3uajO7K6iHndV6Zw9700019h0nZ69RMtTZPAIXZAZlHFaAZpA2/Xq27gyIjN/OQeoFh8mHF5SONrMIjQvpY/AAITPvbq/EKI0Q5jzxA+ai1sfqB0TRalFi/8sUu05ZH/A==;24:R6+kKBNXwd3VawG/3r7usx2IOgq1dca3RHDQZaKub4+lQwVsbKQpmFPrOSe7kJdi5kNcxVFRbIiX0mHmkDQxdwIjakKSXJo1fL/n09ByqLI=;7:rciM0vp28yV/MuuUvGFyfCrf541LnPTsDEu09EHZXMBJPN5wOa3duofrhNNE5JG2lSgJHCvcbdGNaGQq3ZhMjzOv8kZphFHAXMkXpY3FRkEFoaWOa/uFk+PH3xYMtCgnlgqJ1zeAKRbZAqW7phkF7hfKIs+1UaImSSsqneorQG9JsHql7B00K4ufqj5XmhJ+5Q1T5ugK0qkjgSTChjfTrFPVOLLfn0h6Y80bFkUiycE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:01.5426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60191
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
