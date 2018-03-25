Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 08:47:42 +0200 (CEST)
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:59066
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991068AbeCYGrJuJ0pM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Mar 2018 08:47:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=30Jdfaebi/iXenPtSDaBdNNvdTHoa3osSNDKaHeEClw=;
 b=BVvjQDpOkhDsPojO5WZaJhxUasKtbqOchvcsUTJvK9oQdD3q8Pyl7D39AvYdW08VgaEsMDq9rQ+biW13hqb8JkE/92qZiCn36p2swxSioE9SEhOWKOdnmzblTjH8haE21g4cediYkMBc4yimCZc1LjF1cBTn5AyfHD3kBq7UK/4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.609.10; Sun, 25
 Mar 2018 06:46:56 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v6 3/7] MIPS: Octeon: Add Octeon III platforms for console output.
Date:   Sun, 25 Mar 2018 01:28:25 -0500
Message-Id: <1521959309-29335-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
References: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: SN1PR0701CA0055.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::23) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e14b418-7748-4c9e-d6c3-08d5921c33ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:X6bg+x8JbAxneaSvjnGXL7HYM/i1ey/RMtTkxMsGivIObUlv//Yht6b1MU5TGgzOZ1sPnhPsaZr5RekQlNnRVhiEyHsHye2z2ocR6ia83xZSrPuTD/rUULkCKOME8FP7C6DAcpZVXn8wvFZDC3U3oFJKMmMt+K4TzAwNQHzKEuvECXtBdk4F4QO6p9FZFEGfcsQ1ONksdaHitAeTgtFEy2upQBpWcLdtFBInRJAFWOzr6Xb7vb//zrP6BecQKZ7M;25:U5kQu+gk1rXzs1CK25OsxIDBhdNzXEaNUuTtSj8kwqeB8YRuX7q0E13f+RgKgoEEyHYMkKlsVr80nshfpX6iqCECfxQqxZ6bwsZoYcnZFRoz48J0JEP/mpB5dp6MtdCkrvP9yPW5/fzhs0b0DpOEV1gqhEbv4oSL/dYI6AGmvfg7mTUGTnSmBcdChhjt75LMunDene8CKorErpWzu7Sw4CQRjv4yErPMdk7qJK8MmCCyhAPJM39qlKhtnurcCjZyDQd0U9wRlq9oEWfHwcGEew59FiDGxgJxZSglhOc9AkuJ1z36+5h0LfHJD9QILNiYYpPUDz2K6UhBH4pf2cEuQw==;31:m37j+iNMuVnOG/MEGtXXwrfjTaXyxQQmdq0kvHncjkca17Uc3SiZ2BCam4BZS/hd8jGEsG9QRd9Wwom61zLCRH0PdXwij53pFWvmS/bBVU+etdc+hKJF2zFKVtr5/22xSfmpSRFDQj5GSnh8nNlFhBR/HedkTMGdmgkG8R5kHjQCtwasXzD0c+p5ficv0bI6tHQc5tQHCtc9t/e6RK3sAdY2CQqV2C5ctPzz/X14aA8=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:KC57rxngnLy1rxLcFi1gr+2PSGgtdhfIb2SkoZmDY4/tWsgNwDTnp/KP2GbsAwMmJQobeBWLZClfCvfxukdwcf/LoBI5T9NbiR3LYxAtjIH5Rh9qgpgd5m5eHmZMMuYwfCzzAtiXgHcdJeJbtoyZvyYSvy8VsSvBNiGi8GZUiOGiXcTD7SHeNZB+2CVQxwv8TlUPBw7yQ2y53SELsHh4QQKs16mCynDMEgAPRWdl4lOZEvlqrP0g6x3RTW5ujg9VOW8pmRqfjdzi82U0COQHZJS1PO0FiVGjPeB3KMHcD3GRkM/m7bOCbrV9bUaa82hRyMeNylzh7Fw3d7gvV8GGUfEdtt0pjkQCSeWvwEoXSbr3kz9bNux3R3MkOG46UvXDijkG0cUBfe+96CbLL0YdiFobjdFHCFeT+bs+GUyk46ZfjS4MYYVgvBQqRNnIWRiYUiab4CwBEThVjNO1zWI7y3x/2kEUXs2HpzePpyTcmoYdu6roudiNSA7fc2yKXyBC;4:v7lrln6BiaVyL/TlQwvZPhKhCa2AkiwYUcV6D83le23SYyG/fFpeLCtufCl28hL8v5Hvnx8l/SrWT+ZWjnECr3DY8Di7RN04BmFaRqxAHTFqJW7f/KkhsEGlgtau1yHmR+Wz+42InyE5bOP1v3tUNdGUOM+sanziWDsRKHWdVk39tJ4yIdkLq/pIsIW7Rz2Iegv+GSjUPqCyapdbdCujeVVgM47DZ2nCyjxTmEAyO+bA11RZSCoYaSanr8dKdY9MtMYf74c+7tSzwR1CPQsghQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610A81986910A9A410E167780AE0@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(39380400002)(199004)(189003)(97736004)(51416003)(4326008)(8936002)(52116002)(48376002)(478600001)(5660300001)(6512007)(105586002)(76176011)(8676002)(81156014)(81166006)(25786009)(11346002)(53416004)(6486002)(6666003)(2351001)(6916009)(6506007)(2616005)(68736007)(386003)(86362001)(2361001)(956004)(47776003)(446003)(69596002)(6116002)(106356001)(50466002)(305945005)(7736002)(3846002)(72206003)(36756003)(26005)(107886003)(50226002)(66066001)(316002)(16586007)(2906002)(53936002)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:TsEyAjZ5vxXbzeUCGUuD7gYDDVcmuCQR9jLubNQqs?=
 =?us-ascii?Q?p+uQkwpRG1jRC1mKGIhITlrKpzfSBg5hQeMqrQqOYgJAucu3SBTwScJyxDZi?=
 =?us-ascii?Q?sy6kucNlW75AhGoXgcYO6BwuD2Es7dUrKrxLnG59RYSNypBUdD5lfUtjyZEB?=
 =?us-ascii?Q?ca1qaWLJDoDB6T56vAL9+Va6+Smyf8fPZIIFyMJ2tv667Cfe8j1tDh6ar4+h?=
 =?us-ascii?Q?ZhkbN50betbGhb+YNoN/Yl7wFpBJ0/ntoG4I6ezIQk8kLWO6/ycG2fmrq0mo?=
 =?us-ascii?Q?4sQJauy8ignn6TQ0gJ8r6GaNzNlZKH8u1/Wo8DrULDBT5gebkwC39TsWZonL?=
 =?us-ascii?Q?6kQqOmfOQahul331leDYFL3/HalSC38frDfRHDrdPTeWHie4wgeR8mIAsMeK?=
 =?us-ascii?Q?lBLG211gy+uKu9UZ78Nn0gk8l+bKqEtYbmGCb/Hd2g0SeeM+vrxn4TWzTPVe?=
 =?us-ascii?Q?0Jdlhf5sPGX2/SyDC3Kym6Et+9ZVXFLUU1qqqy5VDFdYbBAHxub2+h1lt6/8?=
 =?us-ascii?Q?cDnLW0bPq6LHU1TL8Rqeqt8TiIUL6Oyq2gSGq7oZGOwfiOEbcyK+5kq+O+gh?=
 =?us-ascii?Q?hi6wOBKMN/6l2Uwdue+Ar+cv+8a2REekvsUKnKMBT/M+VnDzaWmsG6VGho5C?=
 =?us-ascii?Q?hNbxGTm6p3Za3is7JFZ4JG3IA0Dlsu45GhNT76W8Ht4uUBF0YYK8YMNJ2KUr?=
 =?us-ascii?Q?osDFZmD8VOUex8twzyodFyo3GOhMu6EvPCj2HvtWIiyy97rlsU1kbbdxKC8B?=
 =?us-ascii?Q?xlcbj51pfSV3scTyy9OvlHs4IZ8Gdbx56nRyyLFErlg13szdWnuDf7prdCjd?=
 =?us-ascii?Q?HJNMJHNFF4hPGWxh71cDF1ZPUpNxjqjgVNKTMD5u0/5lo9NXuN6Zb1nw/v1C?=
 =?us-ascii?Q?1Sxff+NvLcqNjZO8eNkiXF+4SHolO9BXKRvinTUrIYU2GJpf3wYEpZVrJLPx?=
 =?us-ascii?Q?mNx5vHJw6uDe1fKjY8gsYLcCe7yBRLl48zQKVog8zmPFatJFZwnSE6GEkQQz?=
 =?us-ascii?Q?3IeZaTFtGQmde/Ve0rcazI+tSR4/+0bQhujjYE1u4+JTrUdth1C22AxEJAsX?=
 =?us-ascii?Q?5o+hIXPABrIMe8uEBq8wE0wbQD9S/u9dx4VW5MezXqQpINrEQLeAWeK9I47a?=
 =?us-ascii?Q?PC9V6iMCjuduETiYGvokbWvyRbZvfDJqsgBy7lb2SkMve5N+BwFMcQx/t/dw?=
 =?us-ascii?Q?KaokyrZmTO6I2u1nSYXOjy0gfUpU8MSLRYXFV59d0odj+Qxh8O7E9vL/eI97?=
 =?us-ascii?Q?yL+yZR2zk6JWyEAfapOil/N+GKxsI71fgfRpJKo?=
X-Microsoft-Antispam-Message-Info: VFl4Ky8a1jpx5NwWlEq9yoLubMuzFodCmSQyHrD1KUMDNDUgiJfwwsH5DcTbgXP1lU8/rl/qFh+XGMj++4ZP31Icsp6GRJH8UTGeDT0MnXEtYGBJLN5mDA9UscNBZnEcMuSRNl0Mu25wGr9S8wt+12yg6U+iApuf2PtUJSc8Rmm0s8UC9DRCg38Ou/WCwuBw
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:zIFjUY+d+ZG40SyFx4/Qj5AT4Xc0Jf5jBgUYpaNY1l4fpBpp95x6Zo/Lpu38LpH9OOe3ZZNNwlHBR08Aq6TewHiKW+XYLm9rkHE8JNZRGa64zVRYz5wegffgodubekWltXzhr/DnAzK3NFLlPBxISkDWlP1/vs0/2JADBxz573Aro1Ca8PJ607wT0zQdRQBqjR9pjWukVYG+1kgb4oYjZFAWPwmPE416jjvIi7B4/wUyAipK5wVVw07iDaIzq5cEp/f1H+xW5R7UqaUExhLUlc+JjvYTpMS/2l8DmiL622cuxymYQsEIKuSgFhd63ft9XSMwLJFKCEh1FAt4pMXDw6yQisRHZexAoxhXg8zeqXx35Nbjz6nNezXX9pQ9yQpvKf4nCUIrLak0uF35wHaMwMozy2pEmbq0DcBU8m7CQP73D7tvSu7YPXUbEuM+h2LDoJEEe8BTmOpW4YqXY1qzZg==;5:7s6lt8Z2qoHUnkuExE3cecPhHo8NgN25J96ec9MwWflm+9A2D887DV+Qqk3Vn1vDu0dgt/RH90ZZcUeej5YSnOM+APDd8o3eWwqaD6uvmvkBvi6PDY2VZVSsYolNatk17mncxTQvIjSzTRJCAdmHsFjtMs0jJMQAjevXuzo2On8=;24:AjOq2CQoMehPLY/AdzA4VOWBsm/mcXlUau/aeotMgMewVx0/jZ32Q6R0cE0kly+jlhhRohREkxwbQ+ueTvmRDe3n+IewpNLcRc7F5eULoXE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;7:XIe3T/uoNygIARTryE4ZA5irPxfLfvxzQa1+m4esvubSvnTmTSdKSA9JoQ4MzAIVUrQZ7pbSu4UsmfHq3aAg2MhHhaIOqfdW//edYwLDvPkiEj3yg3hzPLYbQBXX3+BbXOenBEz6K9AiCzIFkdLH4UthRuxsdjHf4N62MArWC+m1i4lVMDh5UloP28qSH/yvvvAxedeoHIk2Mm+se9DjOds0UBfWbuM5BuAs33vSV9LTgqMtFqswWyEFi4ebrvrX
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 06:46:56.7556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e14b418-7748-4c9e-d6c3-08d5921c33ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63218
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
