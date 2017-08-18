Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2017 01:40:54 +0200 (CEST)
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:18432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994943AbdHRXkrE--HS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Aug 2017 01:40:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bqI35FnV+RdvZ6dLL6PcoEj07hTHa3AhlaixItKChNI=;
 b=USfb9/EUN/XD/DEaZnycaU20iqfltwFDuhrw9ZUJr74Nxo3dLCzV21Kv1+iP1k/vKE0PQZrBWrOtwUfq/aD1P6I+5XMIfmI/cbDGz8sTloguAjoVBrLDzVvXJjyO0FzP7ga03Xz//6B0FRdY5WLW14MFf3534RYn3Ix5ppvSm8I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1362.18; Fri, 18 Aug 2017 23:40:39 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/3] MIPS,bpf: Fix using smp_processor_id() in preemptible splat.
Date:   Fri, 18 Aug 2017 16:40:31 -0700
Message-Id: <20170818234033.5990-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20170818234033.5990-1-david.daney@cavium.com>
References: <20170818234033.5990-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0082.namprd07.prod.outlook.com (10.163.126.50)
 To CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb663ae-d777-42a7-9be0-08d4e69288f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:2GRIhQgrUj96aecfjWQhW2Ec00F8pzLjNFp8dSYBHUsNBOx5wrnCjin1nvGw8WRsw8ym98gBZSRAJjZFI5lbd3e2m0TZWZiFouF+k/li9tKtRAV/ZuR4H+ZqLtEpzBFB4XqILUJa5yRGHc6ElATeICf515+blceXg8fspsFWU+B4T7qbCiAQ9pq6qw6iOftJdkphwEkWjELtINI3EhdtEWet9C/wB9bDa27xRPfaTJdwkt0bVN+pwGymaIkmicoh;25:zYvGRNoYis4ei2Jz8LPbt0IJ0cuXJCjRFuadfu0vJtmxp1luPoIqOSumrmoZJ1lMhDVUA8R58nrECqnpLEWEly6cdoPXijFfwImtEVIGukyWsWP4RFTYiXqTYm3QdeA8R3KY4P4142ccYJq23NOlULVQmAFYJdblNmE1BrDbOh3OpLXg2GP+MC4qs4V2iCxPBIvPfCfILdXhkzFmHx8meN6ISDBW6UwjcndM1dhlZE/L4opMRa/1b7FlnJv7HZD8LpkWYCGaizpxBTyHbaEpY2c+JoxpGJMBYH2Qx9SCWsATW6asN5WtFUeALL6OdYQlMSb+Qx2OlHp7h3KaOJAgKw==;31:RvgEsnZFEfAKT0hogIRGNY4SGmf4gDy+k51ORdC0gl6PqrL11BUgd4pXrJL62jzM7yVwRo1fFmEnKKjQfellnqsosNhQG8NLIAhlg1Npo1tAAMYsphj6A74Djl8aJXAsvpPIsKhjABLHRitUb8BlSR4XhJ6v+Uhn+ZGy3t6pxNSrca4m0HUVX8n5kNIU1BjsLpM4bVIkGXNu0VcVHd2Ulv45Zkwbis7exjh75ONpcE4=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:XNMkVLhUBw+4GzzL44hNjWDpsf8zfB4vIedm+PdDSdusQcFJgpmiJYrAD6mdbV9WDe/tJ8rpcMjkFiiBqrMobXupg2ylmFc2r+8mBe/qPucG+ZAm/TROBQ7M8d9Y1tcecJiimRl4RGVsTBnphlmT8/IKihiO99M2DaH+XKG6/ElHSc1CMc5eakuESVsKpETKZserX+G9eBGvgHQ8ee3MBzqqWVhlnfFD88cjvQqqoeGJQd79iP79WynBeVLkQ76gDCko0Cp7y+SOyAn9RS7oPc8FermxnoXCR5qNRWZed6RXVwJgmft6EhZfDnmV0j3cReOwrZJJze5q+tmAu/qcA6QgS/v5dPdydI8+4RtyUKb9fVSKqXicTC1eDB4ACPnVY7fTqBYLQeiJjnaV8Zxs3MroYuuQ0fEMj8xyPcheWi2+6ksu/qSh6UCMWWVaKSXXfJ1fjTzoa205OsZnLgTtUSjsT5wi6DroWtttNHGpQAYiq4OlzY+bDw0mCMOwR9hX;4:aPWhicZOfvQV4snIATUhYurMO60m7jnver1mH6yg+yq22vXwfSsO/ob9NdfqidlFi3rBc8c++BAzzNlQg/6vbxC5wdDamOy/EY/NEt6eaRGIXuK1lUwgNxmQpCw6HdZysob62y87Zxy5RJ/eg0j8Q/LTT+NYFTjI2sKsL3HGfzSXPPktj+XG6xuJCSB+pjT8TbmIcnWLhYWCTyT/PYGpkFUKTgbuyMXrcI/fBJqv+kMCMzAMDPrnuD96SplaiEx4
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494463F07349DC1B79439D597800@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6041248)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 040359335D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(979002)(6009001)(199003)(189002)(69596002)(76176999)(50986999)(68736007)(6666003)(47776003)(66066001)(81166006)(101416001)(81156014)(50226002)(8676002)(2950100002)(305945005)(105586002)(106356001)(36756003)(33646002)(53936002)(1076002)(6116002)(7736002)(53416004)(3846002)(2906002)(107886003)(6512007)(42186005)(189998001)(6506006)(6486002)(48376002)(4326008)(50466002)(5660300001)(72206003)(97736004)(7350300001)(86362001)(478600001)(25786009)(5003940100001)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3494;23:yDLA0nbA8k9eY6MEc+QAw5YOZQlGxZ8a/N+yAULSi?=
 =?us-ascii?Q?lnyEoWh5cEB3v+U5jNtwP0z0CM5GwqAQp4LTJDmqHPItPYgHXjATfyueZ+vC?=
 =?us-ascii?Q?Wtfs8lim0XsePyvM97TefglBa6Fec6+ZQuqjvsodrJfVwG2jj8/bOjmiWGs7?=
 =?us-ascii?Q?QiwPlNSSAaCqApCuJ/Q4TEh3KLNArp0Ef7gotyItmxymorHkbURe1ES3RK5D?=
 =?us-ascii?Q?+2utgB6NwCUdYk952ndXeY0yMCpFoHdX90dPZsEruoCBYmtnqQ93mdIJsmmu?=
 =?us-ascii?Q?+Y7EjdrFR0okX+4o8pgi+fiGKhvByoc7KRDy9Ezb5147H875+m/n3udDVtnK?=
 =?us-ascii?Q?C1E0OLApWdMYOV/p7itfKNuv5Dtq4FhgCDWmRwe6aZixHoa0W32qDvX1hPPn?=
 =?us-ascii?Q?ND35CNHnc3xNY7JRWVPW5T3DY2foR6SkXPP1GryOF2lWjgNSnoLqZIXW2QvC?=
 =?us-ascii?Q?6TMO3EB4jVIinKOfAF09XBSEixwRPqfvNlPUZ/Is1NbtdbanWRC7b/N0OyKV?=
 =?us-ascii?Q?pesdnOOTTItt+ofzbcm7UYm3yxBqjZwMhRX7bZfer/O57Gele4iRy3ZF0sRF?=
 =?us-ascii?Q?e0ckCiy0SvyMA6Vl5Qq8I7JsAu80TUvAaFuSnl31/l423yuAXC7GmclYqkAI?=
 =?us-ascii?Q?gG+xoVy28cb1Y7Kjirc3fdSbUac4MJOZA3QDbZDydinxIbN+1weFTzio32CZ?=
 =?us-ascii?Q?6MhNF6LvjRzQMO0yfOE4/cRKe/64BzOgCP+YTRkvOPA4aUdL9wWRc5etz/21?=
 =?us-ascii?Q?RZykDuuiyhvihjTcNKzFbu5hlT+wajkbVaCdXLyTn1lQONQulyJLHJ6dcL2D?=
 =?us-ascii?Q?j6YtQDArZ4QGMKwO7osOZT6ywp5B7fF8vrUmi2vtEE08yJ17V1/ZZCclMGjN?=
 =?us-ascii?Q?sZGuYGt5/qaKVE1e678HJODN3B7HV6dpc/hVlyXZRv73mrSajB6vtdnodtGD?=
 =?us-ascii?Q?3Mwlw51f+CT1JVJ1ObvyjzQtCJDWwrx/3CpAceczc/rhyhGV/7aEVNbtobP3?=
 =?us-ascii?Q?DJV0v0CiAONfpOjmEfnSU4EWGqFPQGmUxCrh284nF/D7kssMWDiKlb0mKq+/?=
 =?us-ascii?Q?wDJ21kaQr0xa0AncGoxs5B8OEa5kjPdawbmuOKfUHnQuGDk/S3crAHJqbHj/?=
 =?us-ascii?Q?+/ah55ywGWUTxWnWIz6tMTSyOLG7tqrZtQYmbPNhNGR9+qd7PtJKyOuogykf?=
 =?us-ascii?Q?XNqaBZ/pMiTHO49tUuVV16sMFxD4jE+EtAv+zlsNcMUdPWbY3z47nFwvvyJi?=
 =?us-ascii?Q?vZX///5wZnkvgrS5B2zjz4L+dsOtSVrQYRraHpl?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:ukCSKshk44Zq1hVC8IYYVz0hSh7xTrbjCi7VTUhmEIX1r54c6cKXNDETJ29UqHNGwqrdJo0ie+EfRCaoDAGi7U/RpcoeEDzwYoctRJYLvnZpz8sUCZYTO5ti1wPuu7Qk7+7M6nMCV4lIkYk7a23u0mQ76Hojmr0xoVHObIBGFijhlcbgmhAxzuKwIT7U/he4Rsbjj6o3BNNrXsO9/A5o8f2RTvDnQIRcVbA+lV7IdpqPvjwf50DU8E2qIXI6L/HvjTvq6Og4ldUlt7fTiFvXeZBvPpve8YIwElVNXUU3/CZhms0HOOXutcWufI051t5BZRAHtqhK/7KWjYBZ3gKUpw==;5:6L7rtVNRdONkEKiHOzx7vA3Kc+AaU1toZM1YAjskKgfA0KhVt0W6MtTZ4O1kmZzvx342lj8nG9apIJ4rPpW7U2BgwQGgQWC9zFGRJd96D5jv6Si4QkHTZAOUALbw6W05aYV/Kd+pHn5QxJ7bddnYtQ==;24:gxRtorxjIyTVbds20r0A3oXCN0WnnIj+s179FyC2tvFV9nhDJ+OFLhBrc9nYxbOr1b8aCT4MSzGbo5ZcY7dbSsHt9hb4v9igYQv5HiTUbKw=;7:ejo5zj/CBCrqd0a0Nt9l6C+2S6PoBaM7uyswXwMcZfhNSP1wVDQhS54dkjsd6zt3IeNsk2KmnCVeEoZVq7TPgVv8zGbBIEQ1rfspDnukIKvyZbgVOJmb2mdUgr6UbU0g7AEBsbjQp5nnmtHE9w6sPUWQIwUKQqYAWXy16N/kHNQkR/ypn/wDQOu7yN67sMYi2WjpNfgly6QrhHnDVnmzGVGw0J9p2XaSQZh6ZzNqD2s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2017 23:40:39.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59694
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

If the kernel is configured with preemption enabled we were getting
warning stack traces for use of current_cpu_type().

Fix by moving the test between preempt_disable()/preempt_enable() and
caching the results of the CPU type tests for use during code
generation.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/ebpf_jit.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 3f87b96..721216b 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -113,6 +113,7 @@ struct jit_ctx {
 	u64 *reg_val_types;
 	unsigned int long_b_conversion:1;
 	unsigned int gen_b_offsets:1;
+	unsigned int use_bbit_insns:1;
 };
 
 static void set_reg_val_type(u64 *rvt, int reg, enum reg_val_type type)
@@ -655,19 +656,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int this_idx)
 	return build_int_epilogue(ctx, MIPS_R_T9);
 }
 
-static bool use_bbit_insns(void)
-{
-	switch (current_cpu_type()) {
-	case CPU_CAVIUM_OCTEON:
-	case CPU_CAVIUM_OCTEON_PLUS:
-	case CPU_CAVIUM_OCTEON2:
-	case CPU_CAVIUM_OCTEON3:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static bool is_bad_offset(int b_off)
 {
 	return b_off > 0x1ffff || b_off < -0x20000;
@@ -1198,7 +1186,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		if (dst < 0)
 			return dst;
 
-		if (use_bbit_insns() && hweight32((u32)insn->imm) == 1) {
+		if (ctx->use_bbit_insns && hweight32((u32)insn->imm) == 1) {
 			if ((insn + 1)->code == (BPF_JMP | BPF_EXIT) && insn->off == 1) {
 				b_off = b_imm(exit_idx, ctx);
 				if (is_bad_offset(b_off))
@@ -1853,6 +1841,18 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	memset(&ctx, 0, sizeof(ctx));
 
+	preempt_disable();
+	switch (current_cpu_type()) {
+	case CPU_CAVIUM_OCTEON:
+	case CPU_CAVIUM_OCTEON_PLUS:
+	case CPU_CAVIUM_OCTEON2:
+	case CPU_CAVIUM_OCTEON3:
+		ctx.use_bbit_insns = 1;
+	default:
+		ctx.use_bbit_insns = 0;
+	}
+	preempt_enable();
+
 	ctx.offsets = kcalloc(prog->len + 1, sizeof(*ctx.offsets), GFP_KERNEL);
 	if (ctx.offsets == NULL)
 		goto out_err;
-- 
2.9.5
