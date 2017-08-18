Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2017 01:41:45 +0200 (CEST)
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:18432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994945AbdHRXktEsqfS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Aug 2017 01:40:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5rwsq1ddcXxavUhILQvowFAmMXjRRUiKZECa+Bhlsto=;
 b=ShvUO8J88C/v6ceNbxPRDwlmrAhJ50Ji0DXLB+q51eC9fUXshaNhTbFqUQCqPjhJdn5kpI5WMUjFg6FUZsCQWnkLQ+vzh5RAAAFxgY4/mdwsk4SWMFUeXQJJWKOsI8TeN9rjx36jgHfVjLY/+azggRjqAaV5uG1lftDWtxy9mwU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1362.18; Fri, 18 Aug 2017 23:40:40 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/3] MIPS,bpf: Implement JLT, JLE, JSLT and JSLE ops in the eBPF JIT.
Date:   Fri, 18 Aug 2017 16:40:32 -0700
Message-Id: <20170818234033.5990-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20170818234033.5990-1-david.daney@cavium.com>
References: <20170818234033.5990-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0082.namprd07.prod.outlook.com (10.163.126.50)
 To CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d702e7e-bca3-492a-6f13-08d4e6928987
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:msh2L3mzJh+lTh80THE7HEZDslb7KCR5pDxCa8+2Q4tenmppIhX8vS5iOZBNXIGiP1vpGCdXDJIoL48jQaCQc5TBN13371S6VP5oSjdYTTjqR8kkK911l3hp+ZtBl3H66oFLXAFlqI+6Su3jpaytVYd+G47FaCxFGKq5HoccyTQJJPkWF751WpNYtmwbIq9URw7lR2U7fQ/NRjFRotKaXlnAh0jVaWwQ71jGwQSltZqVsY/ssX84FHWVSqwlTpP5;25:kLUvGuSlBFFwO1rB+TfjhUdVjShr/ev009maoLZzslxX603VeDKxgfp3NsdR3bHheq5mPWPbqyFfjJD1HlkiCty0qYFGN0GrdF7U6l4PzH4C4Gfn+mdmRJhH9kubv/UHVAYtTUVe8UvK8ewDpemzNqsB44BB3gAHARzwRJPW2fepxlRgc1MSResIb7s9p1y8r/yGtz1ToWyZyGfcCspjKsz/B0pHt8IZeZ0uyBCRhxtCVQur2Ad2l6nQ6YycrNU/z497TpryJe11US/wAUDN8cGyEuVOwVl4G16Z+jpHtRID3apM/5sPkPjJ7pQx1ET9bG+MPGq8I6PUkvdUhVLY5w==;31:aemUpeNUexxcpFCMRAulmIDhboxcGrKxU+0icBccFoeCWsR6gnYkpsaeOdPit/jxRmC2PbQ3/xsAAsdZT/cUpcAh86GZqI9cw18t9wXoekXz6+opgWasJfIrIyiQhz1BCNEoJwb99b6Mc3SQ2aHciMEfwukjwqKpOBg8Nb0Vx3KAoPMxwMXCfViVBKj+keETxb1gPY1k1EuJ7EuljQiSyW6tB5aHQzIozDcuuOWJnyc=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:49MNYCwmMYMRbBhhPQdlsJ+sQWlisv4Zdqt3SU4lzupfBLUz+DwersakGGpGv+Ugc7I/K7EyUE2a5m/VaBWeNxb9XG2WsXOw4hQc3a6jCmTc50MyTzmStFzkuz9GYb1n5anPWF6r5BmO2QSi5UnvFNtgAW1c2But16NZQUDeqdR6ep/FFr+2sBEDqNYjzwwYN0p1xRR2qbydjnqXXEkA+dyVUBRA08x8+AeCXt6QsuDUlthGn9f6U+jIO5hjRq5hsui/u087b3SYtgWHMN9YlmEQg7rCftcCoSZdYfmUAK2blWOmK0Z+f3du41SZW7bs1lquwrLkBBg7NSoOhJ9A0dNM67PbbVkK26RU8MvM42Uqw4FeNtI5ZBFj25VrBzE3Bk5zwZu0ahmmHbKTa7dxXiyx5/5LQF+5ZwEUr9MpIWsqQtdFtHpDWacQ/xDUTd3ubQSHYADs93pXWkN2N8Mhe0IF+OS6ihejujdYmL96QM7hw0p/8HFqh01vUO77Fcs8;4:ndvp8zl7sMCzrl1S9+N0jBzBlDaoQjMP7fDU5fjNXeUWQQpzFksYbtXutzcNNuDp1tQJGsAxfX52j9K5Da5kD2qXDPSimGxV2n7MwoI8dYtg330fNaWC4OnybNshaNrJLvwFZ+xVDz6PFSH9KErxA9INc7cPRE+rHwHjpq2B11/N6pvVWTVyguiIqtRYJ6mPv3A31JvYM5jCvYMUbySHyNIi2i+DDxahE5bC5RHEMXXSW/t4Czr+gDm5or/E2BUT
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494319338A39DB722AF528B97800@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6041248)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 040359335D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(199003)(189002)(69596002)(76176999)(50986999)(68736007)(6666003)(47776003)(66066001)(81166006)(101416001)(81156014)(50226002)(8676002)(2950100002)(305945005)(105586002)(106356001)(36756003)(33646002)(53936002)(1076002)(6116002)(7736002)(53416004)(3846002)(2906002)(107886003)(6512007)(42186005)(189998001)(6506006)(6486002)(48376002)(4326008)(50466002)(5660300001)(72206003)(97736004)(7350300001)(86362001)(478600001)(25786009)(5003940100001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3494;23:Bzp1VpJFsTC1ubs6aby9XlOhvRXTuY1I9rJtaNy+T?=
 =?us-ascii?Q?oKg3y5UG8lQe54Byg1pdgzZYM0bY7uKUQ+gvR9etBaQJ8c7bMXOThrpvK6AK?=
 =?us-ascii?Q?I4SL+L9y4xPn/n/7MkGBPNUzlI17j1FZ8RijgpF5+FWuRuR+Jo5J6eOsQWCC?=
 =?us-ascii?Q?bqNLCR5T3YJ8TPWkew5sJe52TrVFvdQURdjG67DUI5m0VoVguTXuGyOWN6Xp?=
 =?us-ascii?Q?Ie/KteZI7a5qkXd7DLhRRb5rvtMSFBGvAv+CEVy4nx066RetjtQwTmckJWsB?=
 =?us-ascii?Q?QIjwzRA1aeAfjYXMLdpcaa7NFgw61bhh/idb0MIv9W9Rjt01vhHMBXcdJG00?=
 =?us-ascii?Q?FVSEEZMf8g6slVaUuncReYVhgEktHpWyziVuUulicNrJyL4dvVsndWrPpSJl?=
 =?us-ascii?Q?xy3TQHFXlNu0YN/0qVoyI6NKr3vxFozE+ttuO4VPnYj2UovtsS/UZVa0h4Gt?=
 =?us-ascii?Q?s5+uOBsct7pdo+1mDxnayaJdfUqyPDtBDFeOBkb9yGK6Fa1UePEMdVCbFMvv?=
 =?us-ascii?Q?kRZOh6RnqXMpDX4LLqtmTK35JLfelWLe2Li3qgl9r8RIUCOKwIU8/fTubwkm?=
 =?us-ascii?Q?zqXrBK6WzW3Q9ctwPcNV4EoXeUFGnFbHhHvu0ZbnyxmOG6gmiYLO/5SuDWqr?=
 =?us-ascii?Q?ZHJPBuhxXlXTJPwJsEn/83sOBOfTrdUNhFnsKqLrSmbXG31V8L/qRe2WeqUI?=
 =?us-ascii?Q?9DpA0eWeLmTWGiosFwHL6P7n+mu1iNlSjLEw/lsY2fcvbnFR63uzqixyFSze?=
 =?us-ascii?Q?IwC5lZjtLSaW+XBGhG0GGzfvKf19zd2dld3fr9omRgXvnlay1lvQE2svWgNZ?=
 =?us-ascii?Q?ale+kz/dDiGAMW3SPXWNNJaMOuU1QLPCa7OeyoCqGLRX/CDYMIgyZZp2XXWD?=
 =?us-ascii?Q?7w6FyHyGODH2hq4/JWLmypoCxD8hM3aPFtrLHmZjiJZOlM6P6c+wlNd2LSX1?=
 =?us-ascii?Q?kAfHQNhBSm7hMQBtBKNAJTSeCD7PLLMhjmkQ6ILP3s9tLqYxkLQXSSS2c0rc?=
 =?us-ascii?Q?MUE3ksB25uE9sjK/303r9T7Oe8MwR3raOhuHpS+obl0GI1CNdYPyFIE/hskh?=
 =?us-ascii?Q?yQaOmJo9a+zBNVIEIgw6whMFh2bB9Fbju2SnxmViPFTjDfRJ1QirYCu038RM?=
 =?us-ascii?Q?1EhCr2ryczxuYINCVEf1fl8v1yM4R55dQhJSnfM5SrEKqTH/Isy9A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:HrZouBuVkIQFtMKWrXEFHBQZYvjvKkB36W7KVCKXCIfnQD67sAI7GFPYT98+fc7/IXU1N6iijU72zu08seC4kapuqMrI5fN/bW5vy9aDBbACWqCpRvKyOndayZvZtE2IsndfTQABDFuFO8VI4zih1FD3ndKyiFXXqkHL4+G9rdmvA5VUiVB9bNZySKnWUiSd/G2y0xI/UVDJEAxLMb7vfTRQTnkB4gInTM/TpUxi6O9JSlyXCr9Aaz1ThGlGVsBO24cAAvSiPlToVT2TXGi6Az0dx+9XWB/0MC80ksyKozXEJgGH/TidGWPfAiOqTJy4YIuOU9nq1CTNgLJLZR9ltQ==;5:UMbiZLOgmDmU28feJeEJqV+DeDU7eyRsVJvTo/00wUW15VNjE3uv1HoYZ4Iu+qmGahoMYuLns/f/hUZUAMvLivZyufxeGamnhdLgi0Zt2SfN2ByrL5a/iXtFRta8ERoTDLKUVTsvfU+pui2iejMxyA==;24:t9Jj6GHppIAYm7KKpVqN8hqZLArajU2hNY4OOv8FzTXlCUyjW2wregFAXHmiAM/jkZbjEAPZhFCbbrRohXKNvVRZ1cE09VwGsqTn5Z9D+1o=;7:BB1EYaBbeTeu+VEUAOznY/eeGwRVoWtvu4lOcuQSeiG0JD1uLfTXwD4YKiC3km06LZGLThMNsukFmbQYdwNsJGb6boIli6o00CPZaDKKNnuCHqwMtGgpcS4ep9pQmeCXyEC1JFuxnwJeu5yBFj4i2RtfsTgGbZx6/+4fH9T+KE/6anOtQSLb0ZF3zFERQTb8OjSKAjmrhJAV079Ky5QPY1AYUTesdReCkRTEgJn/lXQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2017 23:40:40.6395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59696
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/ebpf_jit.c | 101 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 29 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 721216b..c1e21cb 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -990,8 +990,12 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		goto jeq_common;
 	case BPF_JMP | BPF_JEQ | BPF_X: /* JMP_REG */
 	case BPF_JMP | BPF_JNE | BPF_X:
+	case BPF_JMP | BPF_JSLT | BPF_X:
+	case BPF_JMP | BPF_JSLE | BPF_X:
 	case BPF_JMP | BPF_JSGT | BPF_X:
 	case BPF_JMP | BPF_JSGE | BPF_X:
+	case BPF_JMP | BPF_JLT | BPF_X:
+	case BPF_JMP | BPF_JLE | BPF_X:
 	case BPF_JMP | BPF_JGT | BPF_X:
 	case BPF_JMP | BPF_JGE | BPF_X:
 	case BPF_JMP | BPF_JSET | BPF_X:
@@ -1013,28 +1017,34 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			cmp_eq = false;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
-		} else if (BPF_OP(insn->code) == BPF_JSGT) {
+		} else if (BPF_OP(insn->code) == BPF_JSGT || BPF_OP(insn->code) == BPF_JSLE) {
 			emit_instr(ctx, dsubu, MIPS_R_AT, dst, src);
 			if ((insn + 1)->code == (BPF_JMP | BPF_EXIT) && insn->off == 1) {
 				b_off = b_imm(exit_idx, ctx);
 				if (is_bad_offset(b_off))
 					return -E2BIG;
-				emit_instr(ctx, blez, MIPS_R_AT, b_off);
+				if (BPF_OP(insn->code) == BPF_JSGT)
+					emit_instr(ctx, blez, MIPS_R_AT, b_off);
+				else
+					emit_instr(ctx, bgtz, MIPS_R_AT, b_off);
 				emit_instr(ctx, nop);
 				return 2; /* We consumed the exit. */
 			}
 			b_off = b_imm(this_idx + insn->off + 1, ctx);
 			if (is_bad_offset(b_off))
 				return -E2BIG;
-			emit_instr(ctx, bgtz, MIPS_R_AT, b_off);
+			if (BPF_OP(insn->code) == BPF_JSGT)
+				emit_instr(ctx, bgtz, MIPS_R_AT, b_off);
+			else
+				emit_instr(ctx, blez, MIPS_R_AT, b_off);
 			emit_instr(ctx, nop);
 			break;
-		} else if (BPF_OP(insn->code) == BPF_JSGE) {
+		} else if (BPF_OP(insn->code) == BPF_JSGE || BPF_OP(insn->code) == BPF_JSLT) {
 			emit_instr(ctx, slt, MIPS_R_AT, dst, src);
-			cmp_eq = true;
+			cmp_eq = BPF_OP(insn->code) == BPF_JSGE;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
-		} else if (BPF_OP(insn->code) == BPF_JGT) {
+		} else if (BPF_OP(insn->code) == BPF_JGT || BPF_OP(insn->code) == BPF_JLE) {
 			/* dst or src could be AT */
 			emit_instr(ctx, dsubu, MIPS_R_T8, dst, src);
 			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
@@ -1042,12 +1052,12 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, movz, MIPS_R_T9, MIPS_R_SP, MIPS_R_T8);
 			emit_instr(ctx, movn, MIPS_R_T9, MIPS_R_ZERO, MIPS_R_T8);
 			emit_instr(ctx, or, MIPS_R_AT, MIPS_R_T9, MIPS_R_AT);
-			cmp_eq = true;
+			cmp_eq = BPF_OP(insn->code) == BPF_JGT;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
-		} else if (BPF_OP(insn->code) == BPF_JGE) {
+		} else if (BPF_OP(insn->code) == BPF_JGE || BPF_OP(insn->code) == BPF_JLT) {
 			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
-			cmp_eq = true;
+			cmp_eq = BPF_OP(insn->code) == BPF_JGE;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
 		} else { /* JNE/JEQ case */
@@ -1110,6 +1120,8 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		break;
 	case BPF_JMP | BPF_JSGT | BPF_K: /* JMP_IMM */
 	case BPF_JMP | BPF_JSGE | BPF_K: /* JMP_IMM */
+	case BPF_JMP | BPF_JSLT | BPF_K: /* JMP_IMM */
+	case BPF_JMP | BPF_JSLE | BPF_K: /* JMP_IMM */
 		cmp_eq = (BPF_OP(insn->code) == BPF_JSGE);
 		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
 		if (dst < 0)
@@ -1120,65 +1132,92 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 				b_off = b_imm(exit_idx, ctx);
 				if (is_bad_offset(b_off))
 					return -E2BIG;
-				if (cmp_eq)
-					emit_instr(ctx, bltz, dst, b_off);
-				else
+				switch (BPF_OP(insn->code)) {
+				case BPF_JSGT:
 					emit_instr(ctx, blez, dst, b_off);
+					break;
+				case BPF_JSGE:
+					emit_instr(ctx, bltz, dst, b_off);
+					break;
+				case BPF_JSLT:
+					emit_instr(ctx, bgez, dst, b_off);
+					break;
+				case BPF_JSLE:
+					emit_instr(ctx, bgtz, dst, b_off);
+					break;
+				}
 				emit_instr(ctx, nop);
 				return 2; /* We consumed the exit. */
 			}
 			b_off = b_imm(this_idx + insn->off + 1, ctx);
 			if (is_bad_offset(b_off))
 				return -E2BIG;
-			if (cmp_eq)
-				emit_instr(ctx, bgez, dst, b_off);
-			else
+			switch (BPF_OP(insn->code)) {
+			case BPF_JSGT:
 				emit_instr(ctx, bgtz, dst, b_off);
+				break;
+			case BPF_JSGE:
+				emit_instr(ctx, bgez, dst, b_off);
+				break;
+			case BPF_JSLT:
+				emit_instr(ctx, bltz, dst, b_off);
+				break;
+			case BPF_JSLE:
+				emit_instr(ctx, blez, dst, b_off);
+				break;
+			}
 			emit_instr(ctx, nop);
 			break;
 		}
 		/*
 		 * only "LT" compare available, so we must use imm + 1
-		 * to generate "GT"
+		 * to generate "GT" and imm -1 to generate LE
 		 */
-		t64s = insn->imm + (cmp_eq ? 0 : 1);
+		if (BPF_OP(insn->code) == BPF_JSGT)
+			t64s = insn->imm + 1;
+		else if (BPF_OP(insn->code) == BPF_JSLE)
+			t64s = insn->imm + 1;
+		else
+			t64s = insn->imm;
+
+		cmp_eq = BPF_OP(insn->code) == BPF_JSGT || BPF_OP(insn->code) == BPF_JSGE;
 		if (t64s >= S16_MIN && t64s <= S16_MAX) {
 			emit_instr(ctx, slti, MIPS_R_AT, dst, (int)t64s);
 			src = MIPS_R_AT;
 			dst = MIPS_R_ZERO;
-			cmp_eq = true;
 			goto jeq_common;
 		}
 		emit_const_to_reg(ctx, MIPS_R_AT, (u64)t64s);
 		emit_instr(ctx, slt, MIPS_R_AT, dst, MIPS_R_AT);
 		src = MIPS_R_AT;
 		dst = MIPS_R_ZERO;
-		cmp_eq = true;
 		goto jeq_common;
 
 	case BPF_JMP | BPF_JGT | BPF_K:
 	case BPF_JMP | BPF_JGE | BPF_K:
+	case BPF_JMP | BPF_JLT | BPF_K:
+	case BPF_JMP | BPF_JLE | BPF_K:
 		cmp_eq = (BPF_OP(insn->code) == BPF_JGE);
 		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
 		if (dst < 0)
 			return dst;
 		/*
 		 * only "LT" compare available, so we must use imm + 1
-		 * to generate "GT"
+		 * to generate "GT" and imm -1 to generate LE
 		 */
-		t64s = (u64)(u32)(insn->imm) + (cmp_eq ? 0 : 1);
-		if (t64s >= 0 && t64s <= S16_MAX) {
-			emit_instr(ctx, sltiu, MIPS_R_AT, dst, (int)t64s);
-			src = MIPS_R_AT;
-			dst = MIPS_R_ZERO;
-			cmp_eq = true;
-			goto jeq_common;
-		}
+		if (BPF_OP(insn->code) == BPF_JGT)
+			t64s = (u64)(u32)(insn->imm) + 1;
+		else if (BPF_OP(insn->code) == BPF_JLE)
+			t64s = (u64)(u32)(insn->imm) + 1;
+		else
+			t64s = (u64)(u32)(insn->imm);
+
+		cmp_eq = BPF_OP(insn->code) == BPF_JGT || BPF_OP(insn->code) == BPF_JGE;
+
 		emit_const_to_reg(ctx, MIPS_R_AT, (u64)t64s);
 		emit_instr(ctx, sltu, MIPS_R_AT, dst, MIPS_R_AT);
 		src = MIPS_R_AT;
 		dst = MIPS_R_ZERO;
-		cmp_eq = true;
 		goto jeq_common;
 
 	case BPF_JMP | BPF_JSET | BPF_K: /* JMP_IMM */
@@ -1712,10 +1751,14 @@ static int reg_val_propagate_range(struct jit_ctx *ctx, u64 initial_rvt,
 			case BPF_JEQ:
 			case BPF_JGT:
 			case BPF_JGE:
+			case BPF_JLT:
+			case BPF_JLE:
 			case BPF_JSET:
 			case BPF_JNE:
 			case BPF_JSGT:
 			case BPF_JSGE:
+			case BPF_JSLT:
+			case BPF_JSLE:
 				if (follow_taken) {
 					rvt[idx] |= RVT_BRANCH_TAKEN;
 					idx += insn->off;
-- 
2.9.5
