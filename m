Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:17:07 +0100 (CET)
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990591AbdK3GQMVofHy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=30Jdfaebi/iXenPtSDaBdNNvdTHoa3osSNDKaHeEClw=;
 b=cj0+MhOen/3Gegb/PfAI8E4Yg78ifc9dL7TcaMWl3ZOs7fDv2WlJeBn5IAVQ2yjGOtzCN3SJpEwbnQRcmPGKnfcdLLTog4XnPnUpn0Q96U9LXOnASn6lViRpYkzhtbSLm2TFwXeBxhR4hs8qSde+QwpOhd5MYh02f/Qbr4LCdsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:03 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v4 3/7] MIPS: Octeon: Add Octeon III platforms for console output.
Date:   Thu, 30 Nov 2017 00:06:17 -0600
Message-Id: <1512021981-15560-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a4cd2bf-6936-4012-4080-08d537b9d5dc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:sa+/IFZrgyjVe+Q9t+CNyrru3bUBkjXhwnYgdnvbgbiP46oTQjbRR2foTSe3vzhzjT0PSzqNwQFZ9xWV0keLBfvwFcp7OSnsnARE36T1T1Q44/SQkqsUIqkBukNK5kdjzobSYX1cv8JOLlDtiYB/gu4Yn1XdVBa8gHsXT2mUW1mLuqeAISXzqRGm7RRmWK16CyThREhqM87TI/rENbW+KE2iipwLoXqyRCnW4yS53SQvrAb21/+1Xn0imtSO4etz;25:RS3AFNKYYWe5VLG/FpUunrRBuem8NxL9aIfSp7iYRuBnizNKXjZ6gWwHm/xoah5A8+o4Stx1zcmjodzrLG8P8xhMGiPjFfgsI/bYv+CgS6zzXOE3f5y97mjHW1lw976Btn2JI1VFCOMNT/PoA1cwfAiV5qopu6KA/58Wpm83NGBxUv9emfbm3HQDeUtzsKQLYTpzsjAl5hP82mpmDjlRdl9EWam6bGnU4XAlytaNxUvF/lrwbzlEuwuRYytZ8ottCb+BwFK+ah/pCuDicL/Hp5LsYgwVlFeCB3RCde82KqVOIhujfG6KgIg8yMQhfOmEGgtkw3udwYTTOUhplpHsFA==;31:TtlHsnh5yLpXM0uDB+foWPD3Q0Iwo40JGVWX4vLkOyeQKMIGAkgn/yCrTHacMiYq1DeLkgqH+bhlknwevTtNb2bM5HV3ekpNm+/CWLp1GpGrIrAHTbBFd4TF/XXZLl7nj+PYbGABob+wnJaEwL8RGty0i0Fh5HXcCi0xu1paJpzm+POQg7luQi2ThJQnez2GfmQTUVXNhQEAVwXhR3FOkki2ySABYdaBapENYdqVENA=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:4p3uUPnM+Q0Oy2bpEGfE4SXS7KTTFM7WZmDxM4mSIr0WPSZ3FnFCFY7Lyuu4no+mfcepXMOpf84eJ/tBiQT797bgiSw5fxQNpwRjAO3qNNxgZ5MB4oEmwYloNuMr8Afozo3dsN0FKFgIcwnMZkPGEYXp1pKaU/Kz7SCnrUwljYjmJGq0NMh1I4t9URUOrpKwYg1jz1MRL1c60aTdGtMwo9YrAXPw9L7fKOfii/vjFfSZ0/BmIuLyIbqEg6/v+0ImtvhiB+zwIbIciSxdSmGstI7fb7BJgssvNw4gBj8cknUAQmtc6LLiBnUwakffxzgDEbI5OSf55JQAJrvsQKU/LW+4Gn22RcSBKp0v5tvPEpxvaX0ZgOosekIO7yO9S5DODPxxvGBQ27QOnjvaCV6n5SJgpsI7YojlHSYSpQW5fVzmYftrA8fjZqToTj1PLADSPMO887rueKsYUSqGQneJVP806UhxNlZGn2/ZZHrInBPeYm933FfHFUMuIUFuOiZ9;4:NqhYSumCHOHfRUEiw/yajkVN8VeMyE8VEX3ZI/wbCD49eRoyxhQ6br1gAgrWV2atA+7qfU21NQJTQ3dwxiGiTFp3YMQJNDSUNlFVEMxQbwTApvbVuyPimIKyOAlynwtABlmyp+NlEyVbZ/j210zKzqhn3KJIzjQ5i/cpPQ15yKvsQdF5Z6cCbG1gJvo/gdXl6SB6svHyL+ywbfy4QiaaVMD2XG2cbc83TPhRB5l4j+ltushu6ZWjeKkGo0fwTqJINUph7cSfuzuXxY9WqFQSUw==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803850C39F0FAA313369F8780380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(76176010)(50226002)(316002)(6116002)(2950100002)(106356001)(68736007)(6666003)(81166006)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(450100002)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:ywG8NCQkMOFrg2rkozRmpsTwqRC4cPvI+mMkvhA?=
 =?us-ascii?Q?p9ojozDz3C+r3p+xbm1y+ZcViyrTiy8z1MpiQrqq9O+WtpbBKiV16dnZRrkA?=
 =?us-ascii?Q?8+XmrKGiR7yQJa618h4z9h9tMpcSrVOC+oOUq65BvkVpqEw/aEKFmt0+WGfs?=
 =?us-ascii?Q?Cla/QcM6mm1dKpTQprwUwvKmbYlhgRio2HZ/8jBgowe34kE8Fpu0b46pRglD?=
 =?us-ascii?Q?Puv/r9geG07BmKvCqpt+0+pvjitDu6c5eq0njku/xZQc4bnJlua61c12Cg0Z?=
 =?us-ascii?Q?n1OlM173vLkgJFJET+uYlQ2sQVFQamN+82sH381h9LU1R4hDvNsqRimz0JQk?=
 =?us-ascii?Q?Sbu+5cvBawBod9v9jpbQPacVkd+RqYN6Dzb0JEDE5uZnn3GYt90v0wwGe6xJ?=
 =?us-ascii?Q?E0pZbaTY70YmC+faDofM1m5eLL/SfPlaP4/xpu+kFkixoiGNWJOPFsS9HnS3?=
 =?us-ascii?Q?OIjrApA2+ooSErgrqkjGOh3mnLeiy74znfviSYw7RkEKPteZEOmhrS7Gm7WD?=
 =?us-ascii?Q?N7YUnsqU+uPHXXYx72pkoskznHwAwDMwN5fu52Vjaci/eQZbdqBze23HVEVM?=
 =?us-ascii?Q?Xd47JxKQouiUb/ljJYkQuJCkSTROwXckIPCRu4vC3U5ni1ilM9LAg6I+91kE?=
 =?us-ascii?Q?aZ9HRVtFQeTeHHfCGAblEt4rXIW28k3Hu7zHmIoHHWysm9Fbu5yTFb1jvPzN?=
 =?us-ascii?Q?Y/6EYfEupp/SVfgfG5RPqu4werPW4XcsmH5cybIARTB/egmjssBLOTYjIzLn?=
 =?us-ascii?Q?WhEQVbObt8bCpDEIIVyHIWFE9ep0bg8RVTeC5lenIuAhJHcWRqSzH8Uv5dXF?=
 =?us-ascii?Q?Tv/3t08KUuuaRWIC+npvKsdFC9JFVwsyTBizEe2+q5j86T4DVUN70gmU0tOQ?=
 =?us-ascii?Q?g5ZO0JvCY0AGpzZMFOF/5DYo0J04RONqY57RHwz3vtYzvQbGrwjqfbVR9CNQ?=
 =?us-ascii?Q?y9ksqAKddXhankvsEPhYd9udd1Bzssu+2DK1WbedMnMIUndS8WQspYiixA3E?=
 =?us-ascii?Q?DcgJlkd4CfVuEHt3BNpLoCBx8TuLadxZqvEOAqHhdnQTjGMhxawywqftad/0?=
 =?us-ascii?Q?x0IHA3bbk3oD9j6UT/yhbdxuwNNEFenHV/ZP16YDN7uyoP5Y6iKHJHP207Bu?=
 =?us-ascii?Q?7jPDduoRAiyYxbywYXc+BaYyfFMy23lBnGa4i4guMKjo8gaOvuiDfx+ApNfJ?=
 =?us-ascii?Q?uIchpvrBb6qn+DSQwABG5dYccQhbt2Nl2wPnw?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:yRDwRrMN/qMoFz8jYVKXVPh9lCI3J53P16l1EvtmU30nzlEWs8K/UBoRXCYPiPdxgQy5S5i53fdr3HEeaSxRzRgPoAiWf9hSvwh80hNXNP0abjKufeR7SGhKaaGHRYfaAwwJOPX+i+mOEc+5VlTnLgSDwUbJMhhgqvNtGgsbddMauGESYljCZdIxU4KsM/7/36wlA8xFE0DNjbKMifniWXpR8hzWah5AIVN6rJHvJN8sU0vN0tiab4ZyBBHxslfKmktwFYZtTs4kG6rTUnuT70BUJMoK+qjJAv/zvFBT2GDwzfPB7ngEHIC5jNNRRsrwNJGxSyfH2qQmAJhSpqPZ1KwjmqcGo+npuyRih0yZAjY=;5:gX2QG126r3xSnHKAaBzBggQj1mG4ckyZM9KL23Jdkz7ZoyJHPEWPHzKlU3xXwGtrQsiNF2gZANA+TgvHprN/XSpMncA/asL8h/I6XcWHL56UPAdr36ofjb4UrSp3m8VxqfWEdwBRxaGi6LLO1LG5KL4KcUzEKUFloHhZI4L2798=;24:9TW89o5Fdpwqk8w8zQZPBkcNf0szGo0PaSlRlQfHO/N4+HgI9VYcJTPiXhofmUOYC0FaVnCnTBVCBTITngalByPrAZY6kH/wuQqOOUK1BoQ=;7:Rj7Potj+xdUqF2sfJuize8sszRjk7bDQfdNNx9R04fkHIY8i3EwcxLEbMh44v9YkK2NcMDFZ77FLRSQrBFGyOTu7jfwYZV6726n07M0J0oFC2FAvWbT04be1Xrif37kPjx/3T3wekSB/H5RJfVYJAwR6B5otri2xtcTodWJFx6X/446TaWKS4WFE2XfWFuUracY1bCRgwocdbr/q69M/v+5bLn2gPuY5PrJv5fs6HFFxd/thZ9RWLT7ojEw0q3xa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:03.0658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4cd2bf-6936-4012-4080-08d537b9d5dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61234
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
