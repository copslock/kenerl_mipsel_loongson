Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2017 01:42:12 +0200 (CEST)
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:18432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994947AbdHRXktej5AS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Aug 2017 01:40:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=It4MtMqgtPkGmpmBZCVUBMb7VzpugxfZLd6CE1NshYk=;
 b=c2BLQp9Mwy1NYqeiaat699NmI9Wve94o++glVYDKv4bayxlvDJUwRzLi9p7M8iKhN6gfoaN1ingiiI7RKOPgk23QlhbP5ecZ44MdyGSj6JqtR4HP7/VkFc7YypgYKRO3QpAXseyNUxGIZXeKOh3B+TIC+OXVIqO0JaddPI7+yyg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1362.18; Fri, 18 Aug 2017 23:40:41 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 3/3] MIPS,bpf: Cache value of BPF_OP(insn->code) in eBPF JIT.
Date:   Fri, 18 Aug 2017 16:40:33 -0700
Message-Id: <20170818234033.5990-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20170818234033.5990-1-david.daney@cavium.com>
References: <20170818234033.5990-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0082.namprd07.prod.outlook.com (10.163.126.50)
 To CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc6a4e93-0e32-4b0e-40c1-08d4e6928a24
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:/l7w6EG+Mc9hVcq9MiQbrPFd+xPEATxm3PYVvL0Alj1o2DiuA95F19R480UGOgQJFUv4BATAFJw//Xhg88tKxLB9dB5qJs32T4XkWdI5+shYfbjexLYeSutcE9BVuSJKRoznn01HMZc569ZggD3deKIUfCl5ssSaBp9SeYZ41w84GqflWvvfLVLAxyNBbz1vlyUtCuWXW2HIktXIqpt7SpVDMttib67k/i+arOjvFAhDxtYEdtv9GeV9JsAL0/Xk;25:rw8q08ILX7sGdr07AvDK3XQxHx/zdfbjbOt6VEO1iBuCAQcrBk7rFP3TIjF4ivEaJTrA33RR/JvzzneF32nTMgGL1BQC9iFhIQh8AOQpcAna1H+ENUABfqEZA7r2ORcTfbMOXc3sOx9cXhJeZdA8Imk4UIO0yZ/9+hLj6f3xtb3pAAEqwAWJl/14plHf7xainqx2Rr9193dPV1UJX/8rMf7B1C/z650n9LvqXCIuFiTHtZ1i5QnbpXDFhKn8QjPGI3myAdJKs0KtpOMv4Kby93n0dxJNGA4NWy6FnkDQI0ksOVI8RnT4uzVTdviWQzpgNmGvIKWIB3WFZBoFmd3cDA==;31:OExkud8hSI/DdJ3vjkXcPxqxJWXYp5ZolVJzCXcIGIUn2cJvDdJX9gzxRrK+Y0tS/hCHAvzb/xvfry52dibWFLXEFzSZuUBMtZytG4mmq32VDzE88KAwoYKhyEidzEMglAEl+nXMhmyW06KAdbLeFJMb7wnN1vhtPhl0luz/EoeTPNecjkug/QmL4RceEjrNKSHEnMhfXR4TancgU1n91qQLOGv4cWi+tnC6Tp6Hwrw=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:CVfWg1vmzedqpcH36nfswS7S6bMZ8HTl3otw+qVFMMrZT47gMf6u3By2koXBDblgdS7147gp5/o9ZUK2M6NVNfUwU8AIARABe2lcJ2qKC2uR/c2okYUhwALMoAEm2L/xmgsvxWbHhUkNumZrJJblol72uZv7QhG/q+HiPmwrWfzlZOGQbjNPGDNmizevqPLFggImbHgZ8y60walTnFScEyNqahZcbWvfQJKFkPijO7oBhVU2gGFfy/xuSu4U5V6tTEmhAGqzexxPUs3oC4rbGFo6KX/WAqR70p7meTaO3IhW93Ll6FPR9U4uJIhY8+zXmPvyHgg72COCh5uCZRMozVCWVsRHLX/Ubzr19rI8WltQcRV34qu5Wz93f+q10Fz5BuD4DmbqXUz7m0GAzIQbPr01qWXD/EDieaTq87Ua/aoSAnkMiAiYE4R8BAKBwzYTwp1zDUtple0pMBlurwzcr/gkSZYKa4qA0ggkMfL0Py5TqAm6ULwj0p2bb4ZZEXvn;4:FA+XO6p018Wc23wuN5VV37odDDvGLCkuJQ8GaQyfZvw/WiUeNiIN6V5MxOhMZCNQrLcRhbsQCqz8FW33WSL/XDgHFDEZCYoAK/B165uzodWxXS8k30JCaJGqhWHsBSZ+8ghnWPvJF7vnpi5uwXkg/LL7N8h1zjUMYEziY7ULd6TGDjqV41pvvtoVXFyH6QzMMN0rGQyE5Lo2zELx/PKW90zlKosb/xKQnTY3XY9KdcUqzMWoLrOjtwQ9u+J1/GflGiWOAOgoajMMgCheF/d8dVF/u9y3UB4FBJXfwctCIb0=
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494D7F430034282DA121BAC97800@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6041248)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 040359335D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(199003)(189002)(69596002)(76176999)(50986999)(68736007)(6666003)(47776003)(66066001)(81166006)(101416001)(81156014)(50226002)(8676002)(2950100002)(305945005)(105586002)(106356001)(36756003)(33646002)(53936002)(1076002)(6116002)(7736002)(53416004)(3846002)(2906002)(107886003)(6512007)(42186005)(189998001)(6506006)(6486002)(48376002)(4326008)(50466002)(5660300001)(72206003)(97736004)(7350300001)(86362001)(478600001)(25786009)(5003940100001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3494;23:1z77i8b0zgSc1lnZe27vdqRM5qZdMQg7GFIUPwFym?=
 =?us-ascii?Q?+NTC4ceUsreKhZEHEMZ8xM7F6AFVmW5x7aUjjMAaxUSTGlVP3ulmK+Yt2G46?=
 =?us-ascii?Q?BRUhAbnTM9OrQKetC0DUb/rk7pHKR6wzn4Vb5AkButyYkYmFn8cOWvixGrqK?=
 =?us-ascii?Q?jfAYnr99Z+ibn2pQwt1vgKcbCMAQxOeQ5U4JLMK9CXTlx2sHQClv716DdXAu?=
 =?us-ascii?Q?tqFmtgGyVDBQUvtUKCSSoCz/AC1q3w3mYJZnM50xAkJT3AnZ/FJ2VgfSSlHo?=
 =?us-ascii?Q?8ltjikzmEjYS14d+bGtOBLfVqusyW26H1pYzc8WVUaNwsjD7BwbCNGzUJgs9?=
 =?us-ascii?Q?Jyhe5qVs3PVxnStDHrdVP0JCIpmuK46e+qQWM2mcDouX98JG/WkouhZ8Usbg?=
 =?us-ascii?Q?ow89I09zqFjFkTFB+pVl7/HhYrgIwNhHDGZONSuMseuvoTxUyrwDAYdqnNWk?=
 =?us-ascii?Q?xzsvDBQxwYs0TSazp4FoejON8elJj8Zp967a2bGwJOG4uqrp9xmkssF5d1EY?=
 =?us-ascii?Q?t3kw0nWMNYQGppKGz3NaPrij3Z1lDE/6NpUzlLIHy3R3kYmRdtjbh+1jld4O?=
 =?us-ascii?Q?65gBMbHpa+0Oydk7ElDhGawTVjByqdWuNArBGT23pQBzO+D5ikDNWFuvKM74?=
 =?us-ascii?Q?/HVnq6pcT9Mp43qnYzq6xd652KyPJniDx8JXWlJzPRXDuBhrTPObsIhAS5vl?=
 =?us-ascii?Q?+kWyMufQ3/5jGQvBJaQIuqRKOlJj7IxFnrZjoiE8dxOF1Egj6stHPCmAaCkX?=
 =?us-ascii?Q?8autlr8bnOfdQqYbLxY4JudTt/ktQrtnWKXW5CLaXTHoKbirp1rPEbr25dnV?=
 =?us-ascii?Q?aDSnTJQxWQW17whHjA1ndrY0lzt/rW8bgXBmG9VHK/GoTnU7erOclD3Trplv?=
 =?us-ascii?Q?FA9ZG3QUwmlDVAbU9UaNfaBWTY+UnhVxDQTkb85qFD2I6OpzbIyT+NEvVo5b?=
 =?us-ascii?Q?z+8ePbXVaTC9tO1rKrp9AXkneOG7JOs/wDX/l35rbMIDob1JfFPOphFxZfgL?=
 =?us-ascii?Q?ECsYU5T2lsCAbwT30uzWosuQ1KfsdK+uNDZfr2WoK3kxbmqdON4PZqjIK0jO?=
 =?us-ascii?Q?s8vlRE9HqealBMylByzDXWu6oqkH4At+xlkAPOPj5fgM2zaBcAFOk23Wt48T?=
 =?us-ascii?Q?XanyG+FXk1jPZ176l7hzr09RrIqyQeVJE2Lvgj34lhrr7M7yKe9Cg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:43fE20hFmcYrGXMMRnSFo9D0CcbKq8iq5nLz9zSDHtyoivKzktg4jQ4tg6uVQ3+AG5lDZzgO+HKRU0qGfq+fbGNFFhlcU6/7s1zQcbK/6e80yjiEZ6B5D1YY49R9rBmhSZMeqrJqDCezhPV2eZjhzPR2a6/Exr21WINZgFBjGBYiEFa2HCCeMU+LZIuMOOZe7v6bT94s1P7tVXDtUwCOEbyrPGLjgqivB4ARCGzrP1D7pXf4A0xNVVJZn3ONxAkPCEOCEzwky7h7uVIvZlkm1BSTIAhiCejjVQ2PEd2nxgORCU7UlmNPlcu1ZDytaQr0uoSoGoqIHNLYtWjM9ZOrgA==;5:NS5Sq2yDvlrvELj6VNr35K48rVgKY1nrrljkXZXPXOfS/cx4egxJjpbBAE/hO5SSoEfoQYLtf3YJ5zTYuI6HT3DdqeE7Zy74A1HU2lPq6/tUO1OR2zXj/NfkKOzm3PqDlrq5g67q3Qpe3U6qSCEM1w==;24:uo5mdYXlEsG6EYq1hKFPexy4aKFz4DD7C7r383NWavlz1SD0RJIbEjj3AfshqdBAIa4OMfZUA5mXUwt2ES836tb4E1XLHCaEEXGN5T0OHrg=;7:OinGLl+k9o3pTUULW2AYIIUwZ0q9Be2NZ1rjCVpvN0xDtu/AjbH/lfS8NQaHunQfoo+EX3bSXrga5P8/oSeLO8VKGdo8jNzwJ4qNsg1BZZUa8HXr8+7pTv7jDBxgfSXPr4sZrxQl2vz/QX2cxQye+iL/hdvonYu9qKERi3HIWrrbuaae5G78Dr7p/KBWxl+sKNeX2up0rl2b0KHjYcfqSxWH0/xQO3bGxAlaS8XqVqQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2017 23:40:41.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59697
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

The code looks a little cleaner if we replace BPF_OP(insn->code) with
the local variable bpf_op.  Caching the value this way also saves 300
bytes (about 1%) in the code size of the JIT.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/ebpf_jit.c | 67 ++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index c1e21cb..44ddc12 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -670,6 +670,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	unsigned int target;
 	u64 t64;
 	s64 t64s;
+	int bpf_op = BPF_OP(insn->code);
 
 	switch (insn->code) {
 	case BPF_ALU64 | BPF_ADD | BPF_K: /* ALU64_IMM */
@@ -758,13 +759,13 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, sll, dst, dst, 0);
 		if (insn->imm == 1) {
 			/* div by 1 is a nop, mod by 1 is zero */
-			if (BPF_OP(insn->code) == BPF_MOD)
+			if (bpf_op == BPF_MOD)
 				emit_instr(ctx, addu, dst, MIPS_R_ZERO, MIPS_R_ZERO);
 			break;
 		}
 		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
 		emit_instr(ctx, divu, dst, MIPS_R_AT);
-		if (BPF_OP(insn->code) == BPF_DIV)
+		if (bpf_op == BPF_DIV)
 			emit_instr(ctx, mflo, dst);
 		else
 			emit_instr(ctx, mfhi, dst);
@@ -786,13 +787,13 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 
 		if (insn->imm == 1) {
 			/* div by 1 is a nop, mod by 1 is zero */
-			if (BPF_OP(insn->code) == BPF_MOD)
+			if (bpf_op == BPF_MOD)
 				emit_instr(ctx, addu, dst, MIPS_R_ZERO, MIPS_R_ZERO);
 			break;
 		}
 		gen_imm_to_reg(insn, MIPS_R_AT, ctx);
 		emit_instr(ctx, ddivu, dst, MIPS_R_AT);
-		if (BPF_OP(insn->code) == BPF_DIV)
+		if (bpf_op == BPF_DIV)
 			emit_instr(ctx, mflo, dst);
 		else
 			emit_instr(ctx, mfhi, dst);
@@ -817,7 +818,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
 		did_move = false;
 		if (insn->src_reg == BPF_REG_10) {
-			if (BPF_OP(insn->code) == BPF_MOV) {
+			if (bpf_op == BPF_MOV) {
 				emit_instr(ctx, daddiu, dst, MIPS_R_SP, MAX_BPF_STACK);
 				did_move = true;
 			} else {
@@ -827,7 +828,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		} else if (get_reg_val_type(ctx, this_idx, insn->src_reg) == REG_32BIT) {
 			int tmp_reg = MIPS_R_AT;
 
-			if (BPF_OP(insn->code) == BPF_MOV) {
+			if (bpf_op == BPF_MOV) {
 				tmp_reg = dst;
 				did_move = true;
 			}
@@ -835,7 +836,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, dinsu, tmp_reg, MIPS_R_ZERO, 32, 32);
 			src = MIPS_R_AT;
 		}
-		switch (BPF_OP(insn->code)) {
+		switch (bpf_op) {
 		case BPF_MOV:
 			if (!did_move)
 				emit_instr(ctx, daddu, dst, src, MIPS_R_ZERO);
@@ -867,7 +868,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, beq, src, MIPS_R_ZERO, b_off);
 			emit_instr(ctx, movz, MIPS_R_V0, MIPS_R_ZERO, src);
 			emit_instr(ctx, ddivu, dst, src);
-			if (BPF_OP(insn->code) == BPF_DIV)
+			if (bpf_op == BPF_DIV)
 				emit_instr(ctx, mflo, dst);
 			else
 				emit_instr(ctx, mfhi, dst);
@@ -911,7 +912,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		if (ts == REG_64BIT || ts == REG_32BIT_ZERO_EX) {
 			int tmp_reg = MIPS_R_AT;
 
-			if (BPF_OP(insn->code) == BPF_MOV) {
+			if (bpf_op == BPF_MOV) {
 				tmp_reg = dst;
 				did_move = true;
 			}
@@ -919,7 +920,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, sll, tmp_reg, src, 0);
 			src = MIPS_R_AT;
 		}
-		switch (BPF_OP(insn->code)) {
+		switch (bpf_op) {
 		case BPF_MOV:
 			if (!did_move)
 				emit_instr(ctx, addu, dst, src, MIPS_R_ZERO);
@@ -950,7 +951,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, beq, src, MIPS_R_ZERO, b_off);
 			emit_instr(ctx, movz, MIPS_R_V0, MIPS_R_ZERO, src);
 			emit_instr(ctx, divu, dst, src);
-			if (BPF_OP(insn->code) == BPF_DIV)
+			if (bpf_op == BPF_DIV)
 				emit_instr(ctx, mflo, dst);
 			else
 				emit_instr(ctx, mfhi, dst);
@@ -977,7 +978,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		break;
 	case BPF_JMP | BPF_JEQ | BPF_K: /* JMP_IMM */
 	case BPF_JMP | BPF_JNE | BPF_K: /* JMP_IMM */
-		cmp_eq = (BPF_OP(insn->code) == BPF_JEQ);
+		cmp_eq = (bpf_op == BPF_JEQ);
 		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
 		if (dst < 0)
 			return dst;
@@ -1012,18 +1013,18 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, sll, MIPS_R_AT, dst, 0);
 			dst = MIPS_R_AT;
 		}
-		if (BPF_OP(insn->code) == BPF_JSET) {
+		if (bpf_op == BPF_JSET) {
 			emit_instr(ctx, and, MIPS_R_AT, dst, src);
 			cmp_eq = false;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
-		} else if (BPF_OP(insn->code) == BPF_JSGT || BPF_OP(insn->code) == BPF_JSLE) {
+		} else if (bpf_op == BPF_JSGT || bpf_op == BPF_JSLE) {
 			emit_instr(ctx, dsubu, MIPS_R_AT, dst, src);
 			if ((insn + 1)->code == (BPF_JMP | BPF_EXIT) && insn->off == 1) {
 				b_off = b_imm(exit_idx, ctx);
 				if (is_bad_offset(b_off))
 					return -E2BIG;
-				if (BPF_OP(insn->code) == BPF_JSGT)
+				if (bpf_op == BPF_JSGT)
 					emit_instr(ctx, blez, MIPS_R_AT, b_off);
 				else
 					emit_instr(ctx, bgtz, MIPS_R_AT, b_off);
@@ -1033,18 +1034,18 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			b_off = b_imm(this_idx + insn->off + 1, ctx);
 			if (is_bad_offset(b_off))
 				return -E2BIG;
-			if (BPF_OP(insn->code) == BPF_JSGT)
+			if (bpf_op == BPF_JSGT)
 				emit_instr(ctx, bgtz, MIPS_R_AT, b_off);
 			else
 				emit_instr(ctx, blez, MIPS_R_AT, b_off);
 			emit_instr(ctx, nop);
 			break;
-		} else if (BPF_OP(insn->code) == BPF_JSGE || BPF_OP(insn->code) == BPF_JSLT) {
+		} else if (bpf_op == BPF_JSGE || bpf_op == BPF_JSLT) {
 			emit_instr(ctx, slt, MIPS_R_AT, dst, src);
-			cmp_eq = BPF_OP(insn->code) == BPF_JSGE;
+			cmp_eq = bpf_op == BPF_JSGE;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
-		} else if (BPF_OP(insn->code) == BPF_JGT || BPF_OP(insn->code) == BPF_JLE) {
+		} else if (bpf_op == BPF_JGT || bpf_op == BPF_JLE) {
 			/* dst or src could be AT */
 			emit_instr(ctx, dsubu, MIPS_R_T8, dst, src);
 			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
@@ -1052,16 +1053,16 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit_instr(ctx, movz, MIPS_R_T9, MIPS_R_SP, MIPS_R_T8);
 			emit_instr(ctx, movn, MIPS_R_T9, MIPS_R_ZERO, MIPS_R_T8);
 			emit_instr(ctx, or, MIPS_R_AT, MIPS_R_T9, MIPS_R_AT);
-			cmp_eq = BPF_OP(insn->code) == BPF_JGT;
+			cmp_eq = bpf_op == BPF_JGT;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
-		} else if (BPF_OP(insn->code) == BPF_JGE || BPF_OP(insn->code) == BPF_JLT) {
+		} else if (bpf_op == BPF_JGE || bpf_op == BPF_JLT) {
 			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
-			cmp_eq = BPF_OP(insn->code) == BPF_JGE;
+			cmp_eq = bpf_op == BPF_JGE;
 			dst = MIPS_R_AT;
 			src = MIPS_R_ZERO;
 		} else { /* JNE/JEQ case */
-			cmp_eq = (BPF_OP(insn->code) == BPF_JEQ);
+			cmp_eq = (bpf_op == BPF_JEQ);
 		}
 jeq_common:
 		/*
@@ -1122,7 +1123,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_JMP | BPF_JSGE | BPF_K: /* JMP_IMM */
 	case BPF_JMP | BPF_JSLT | BPF_K: /* JMP_IMM */
 	case BPF_JMP | BPF_JSLE | BPF_K: /* JMP_IMM */
-		cmp_eq = (BPF_OP(insn->code) == BPF_JSGE);
+		cmp_eq = (bpf_op == BPF_JSGE);
 		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
 		if (dst < 0)
 			return dst;
@@ -1132,7 +1133,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 				b_off = b_imm(exit_idx, ctx);
 				if (is_bad_offset(b_off))
 					return -E2BIG;
-				switch (BPF_OP(insn->code)) {
+				switch (bpf_op) {
 				case BPF_JSGT:
 					emit_instr(ctx, blez, dst, b_off);
 					break;
@@ -1152,7 +1153,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			b_off = b_imm(this_idx + insn->off + 1, ctx);
 			if (is_bad_offset(b_off))
 				return -E2BIG;
-			switch (BPF_OP(insn->code)) {
+			switch (bpf_op) {
 			case BPF_JSGT:
 				emit_instr(ctx, bgtz, dst, b_off);
 				break;
@@ -1173,14 +1174,14 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		 * only "LT" compare available, so we must use imm + 1
 		 * to generate "GT" and imm -1 to generate LE
 		 */
-		if (BPF_OP(insn->code) == BPF_JSGT)
+		if (bpf_op == BPF_JSGT)
 			t64s = insn->imm + 1;
-		else if (BPF_OP(insn->code) == BPF_JSLE)
+		else if (bpf_op == BPF_JSLE)
 			t64s = insn->imm + 1;
 		else
 			t64s = insn->imm;
 
-		cmp_eq = BPF_OP(insn->code) == BPF_JSGT || BPF_OP(insn->code) == BPF_JSGE;
+		cmp_eq = bpf_op == BPF_JSGT || bpf_op == BPF_JSGE;
 		if (t64s >= S16_MIN && t64s <= S16_MAX) {
 			emit_instr(ctx, slti, MIPS_R_AT, dst, (int)t64s);
 			src = MIPS_R_AT;
@@ -1197,7 +1198,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_JMP | BPF_JGE | BPF_K:
 	case BPF_JMP | BPF_JLT | BPF_K:
 	case BPF_JMP | BPF_JLE | BPF_K:
-		cmp_eq = (BPF_OP(insn->code) == BPF_JGE);
+		cmp_eq = (bpf_op == BPF_JGE);
 		dst = ebpf_to_mips_reg(ctx, insn, dst_reg_fp_ok);
 		if (dst < 0)
 			return dst;
@@ -1205,14 +1206,14 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		 * only "LT" compare available, so we must use imm + 1
 		 * to generate "GT" and imm -1 to generate LE
 		 */
-		if (BPF_OP(insn->code) == BPF_JGT)
+		if (bpf_op == BPF_JGT)
 			t64s = (u64)(u32)(insn->imm) + 1;
-		else if (BPF_OP(insn->code) == BPF_JLE)
+		else if (bpf_op == BPF_JLE)
 			t64s = (u64)(u32)(insn->imm) + 1;
 		else
 			t64s = (u64)(u32)(insn->imm);
 
-		cmp_eq = BPF_OP(insn->code) == BPF_JGT || BPF_OP(insn->code) == BPF_JGE;
+		cmp_eq = bpf_op == BPF_JGT || bpf_op == BPF_JGE;
 
 		emit_const_to_reg(ctx, MIPS_R_AT, (u64)t64s);
 		emit_instr(ctx, sltu, MIPS_R_AT, dst, MIPS_R_AT);
-- 
2.9.5
