Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 22:22:51 +0100 (CET)
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:38383
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992126AbdCNVV6Oc1YP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 22:21:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=svA6RirY5AeSj5yurFPAGVEyaes0Fp+JNZjMZiiT3Io=;
 b=KZcf2OgbtPgPXZAMIadIWF8J8tCqNjjfxI1AjqkjHKDXJmQ8rgZBZ6NQc5Bwc9vNu8g+eOvAIY9bqSGnOgEkjVb3oq6+BOxyAqua+2AfGMyrLJBH0BiUAjPsP3b4+65C8HlLGfz0sxMNxtAtHeDsL/tFf3vsna9yyGu6J2D3yGg=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Tue, 14 Mar 2017 21:21:51 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/5] MIPS: BPF: Add JIT support for SKF_AD_HATYPE.
Date:   Tue, 14 Mar 2017 14:21:41 -0700
Message-Id: <20170314212144.29988-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170314212144.29988-1-david.daney@cavium.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0003.namprd07.prod.outlook.com (10.162.96.13) To
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144)
X-MS-Office365-Filtering-Correlation-Id: 6edfa107-5790-42dd-cc62-08d46b2021ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;3:jixbVfyppxF3zwAEWj3B+i1GdOZZcLqKKu2TTdI5U9inNNFSYidl6RlMMFCl2N8GnV2HlE/pk0455G8eQSrpS1iM+2IPc242AJgmjD5iZC1VO6fmIvRfpPFvq01jT+OBxFDSU0sVZI/4tokexq0bWPvhmJrlTcegI0ai4k0qiBTDexLRB8kZ10OWTctO6vz8sKCUOo3UsUeMiJEPWQuhxM3hQCXpWfzDN8qGIGP3INPfmNjOqdnDZyWpEq8A1/W69KH68zVVF6ZZDMUg79pXtQ==;25:06efpDMsHx5BwnZCKaIyBFlHJsS58NuTWnECjp4uGPgO2vgNW0TOK2yyaLDD3Ha5UXPW1NNoH06EgkmvrPPyaexSh7yro+5oK32zB9q3pYk0vkzPgDh3gLrupT+pcuUtDHCL7b8HNbetTDH2M7yeFm681OQUWdNhhqyIko6wWs7SQqcNxo88FMgIc2oNluF6D7LrQJzJ6IIpc/PX91mZGjzBvdyZzr1IKMaoIhXRQJb98crKJaMna9C+wTY1fDYuQiIHd1Imnuy0FpjJZsDOaADDn8XEutgq1jVNHrqK5yMSghs704CIVJFcNvv9pkmPBtiJxFokz9MuokbaTztByrtrR1utMNwt/bQiomsrwRKUOeB2bla2k/gQ8JPwntlgN1GlBrQ9in1Ef4dRh1lGtPbIgLbfEzEEpXKqB5BcDRTZQblHv2bEAVh04qK2S9maM5eLWmgwSEHx9YJmsurCeQ==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;31:jrdFAvK/EGNmEy4sUpNVL/7b179QNO/CyDlygrWZ4bwcDVD5Oegz9rXb5Ug10pRZP5GmsfK9IXj8mmGvS1lC1GpTebzlG/wrIVUTQzL68SYJJRcUlqlrzhvRKmv+oZqeYoqBSN4B+F9UgGbguGeLwL97qxZiwPiI3htzRth5o/zk1T+0bjs+wjla3sbjl5mkJes0mQaXtNsq+egGESAKVDGqDmTBWb2b+1ojXwzoMVU5IisRN1wCpGdc95HBJ3Fw;20:/Y3/a04Wlocv4jVQlmRBBu3ktiTlgzxu0hY4XyBRvmwzJg5pAuZ3vEn2ClaRcRG/QCA/m9WpTCjUh/P3jPwjptb8bpTBzqT69NZhpprssxyjYmzp+5fmDKv4iGTfG4Jb1RgXhFWK1WU8Qea0rCDwopfp9HMAjP4C/VizEdkPNTUKLSs5OIxVUODZF7917+IaawOYxwo3tiSWT3GMP+h6OamSGCqp1ksIS87Sr0xu6VGMIyj1ZNdCokoLzQQBd9W2nmPH/x9fo6qZJRkzrCtQPHAhCD3i3wuWtE8pXmYa/5f39DtCV0eYn5fXH46RzEMyKQp1OFTSdbHzUEjFLxGRlkAS0Eq3qox6w/WR9Y+WRrOCF7HnM+bw6Cx6gXs0UDQtJibc5VsHSo24ru/BiVks6+g29rpiHQJfOG910jT4ZysTAgltZEGMQuSARDOv/1PLyGsFNuqIWx+ICu0CIpRL96jeZh/UQDbSgMdH8L2A6Wwi7tn85W4uuFHPxQlMvO0m
X-Microsoft-Antispam-PRVS: <BL2PR07MB24208935BF8784748AB2934297240@BL2PR07MB2420.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123558025)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BL2PR07MB2420;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;4:LpY08AjBxVYywlV7OtHwNKEBNR+Y2RODKPYrtnIUlwKIioZm8YOdLlzB4vA6IH3BJgLBxK1+acxILddr8mnISKLBNonVqwiW7RVc5djbWRogGlye8KjrWcOgwSnjj5AQXww44qCCIv94Opl8tS9FDAVN9TzFHlTQw5huEVFPW5Kiws9KErIcPNCNLGJnLd2zyxZZylJSmjqSDf8HYtkmBXLDa2BDEy/0XKbs+IxVhaYM0ytkHsEauBETO8kX6/Hw9G+kjn8DnA6TLjUBtkDEDMjKplym9ZJnXrkzeM3yg1kXZbu/eTqCOygI2fegcUC6eelc5onHDTLWTONLX4yIkyd7y8VgAyULjOrgh1vn0j5N9RJGSPtNZLfz7znQ7lLByHebhjANn0Tvm7yeaQ1sdDhtI4CVq4TgEAumoiT+M4Q0J4c3J+QO0NmEIGC4rz77rDvHOmPPBOBGWSpgd5YuoToRRtJQ+penc1T9ktYwglhIWeIj1OrRIPt8zmKfzCKGoQwFq7VoEbQvuxHCjHXjCHtdzWoStW1X7iSf/JjuDPnMq5ud7YM4Cbb9F/A094bx5gfp2XVtvALMZ9EzDOpSNbvrOHwY4l2/MQ1hGK9RV0Y=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(305945005)(50986999)(4326008)(36756003)(7736002)(6116002)(50226002)(3846002)(8676002)(50466002)(81166006)(5003940100001)(48376002)(54906002)(76176999)(6506006)(42186005)(107886003)(38730400002)(1076002)(86362001)(25786008)(53416004)(6512007)(6486002)(33646002)(47776003)(66066001)(53936002)(2906002)(5660300001)(189998001)(6666003)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2420;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;23:35TYlYupGpHrb/nasgvE/SOLklYo5QdWT/dW3WNL6lveGHETqnA/Jpm3zWOZCHoiQWtWk78UygEsWY3uD8QVpKDMT7IfbrKS9nU6uR0dIAcZ6/ptFUr4x5KyMRYGP04fM2pdIQ+qk0lBt3MqZNsr3dfJsDvpxtwfWdRb1XCz2mePicZG9HZqrLWhtYNnbr3jTCQvzSkzxHwgEuZ7Mmt54pjWRBDhWaE53XhaB3oIrR8b/e/djwnlA+WdBD6zVGx6NglQ7eeal0fPNYsKveWfkzXrdqXEgq3EQXA9SJ1LZIXVrOTDCT6yUmBL1XnvGFll5c7yABt1txWc4f1+bKgWryOAlQbOO1kpxyNxXnf8r3OfXnEP+PWRdRj1ZjsiaEr1a6dASqwynQo0PQe8ZeukTjfx4aSw73GKJBQpxLptReeAdWWhx4EeBea1mkUW+OJXYqO5PKwIIvHYTwUx0toazoyATpMAZtMIe6EGdHi5MXfiirRi2OBKHuxNRm362RNKE9JfW4AXop5ZkeuqC1NNRKdjrZSSXtHVQPL1ePCvCE38XYPvQTFEFuPkvmiLbc2uhaYu+WMiqmU+rKBzc3jIH00xyFd5lJxNMJZ+5aVZr7VptS0ARoq5Qk6gQsYaBrRKNidjiZHXhOKaW8FpiXvFHaN22Ga6RLYsC/PAUEupIG+buGTg2yDtc8a5+zllCHEJWREGVg0/u3IdbVmYCgPcMTBKfT8LTgiiUb4agJ1b+0PGPP0KDk8MoJMpyIKzDitM50VtLVJEEScp5GiTFPX+vgI3d25mazhf5Gruv4/WG+mBGrIUQeBrbWC9m2dwWcTfntQONny12fU7gOOjU3lK2jgsFGv7fBfYNy9NY/nP1MtaZc+84te+reJPsZt0ycOqv8l3qQ4tzYKRR4AKyOnghteLJgOdhIxCcowIhgioegwTgZ8+u5buiGMFuWKvu1HY
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;6:xzJ2FYbHImZILmP7m/gHW0NaSi0/S0JRF84/Y6g5+UETcUdzoi2Tek3Xl77RI/H2Pxe5nEa/jas2JpY+P2tBtztVL/6QOFS2xn8glUtByU33jEMEpZ3rmaQIZfiDOsfe2JexTV3euAnE32eIARRv4/9FYpuEMq62Z7UE1DV/7WRNFyOViqNQ64zz7RcvaMrlQHSCYY+h0YtTn67APghtuEZJGsq7buikKGtqoTP23FxfA3Yn6vorDZlbyqubb121TbPCLjBurM5OJcp5Nlh/AsHb5evhwSl5rn64+FivwQ0vtt6MTgVeOClVV0OvU9YGSni7LIPE8DT6Qrm8fLn5vw+l8Gq9ZeNo2aPHw54uGQR6uczrpdbQLQfsbNrjgL0zx9aFdRa3GiJUOUCSJbPDGw==;5:fnoeRQ1cV6QTIaGc82Rt13bNonRMULD6CMrrVfSAhOcVQLRHIYn98yDcQpIbDtutM+y1bUhZ2BHsdPamw0nCTg9ezYgCPUTD05D29ZPeqJI0yUIIPuSqg6WgUH4NBQ4nYL3zAKpRGDiX2z7eo80RUg==;24:iHZc1ynPv33PiZ0z9Inbi90dXHp42o+pog5lIMG5+OCrQUCJUw6GJDh/MKrE2e9IsrHEDpfCtnpK2CqvGtRh2NaVh+RftqD5kYqc8PUGFCQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;7:ztVKRdVt0Ai+csF77N8H7KGUPoSwbELzkCnqrO2ImfKJL4+qHeAjPP27EFB4VkprOrNasSpm2/LklG+s5iqrr8D62aq2GctHMTKCMp/GYq3MKrqxnrAOq5CAcTjOQNAxEjkni4S5O7N2sbE2KLd6Ew9/vnfEPZkDovojO/93iaNK4584xv3AnSKSfwfguZZS6AaTo26+CedU9+4cU3wa06yqGUYFsDYWAQt5rVuNj9J0+sR3GL1LgXbTQDMr9MGCZ7ROyfHIk1+iET9obMF6PvRY1ssVJzkiIjpVqGxWUlyNkPGVBWqH8ZGo8vyxxGtQW0/ldEFH3Hd6GbOw2fAq4g==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 21:21:51.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2420
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57264
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

This let's us pass some additional "modprobe test-bpf" tests with JIT
enabled.

Reuse the code for SKF_AD_IFINDEX, but substitute the offset and size
of the "type" field.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/bpf_jit.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 49a2e22..880e329 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -365,6 +365,12 @@ static inline void emit_half_load(unsigned int reg, unsigned int base,
 	emit_instr(ctx, lh, reg, offset, base);
 }
 
+static inline void emit_half_load_unsigned(unsigned int reg, unsigned int base,
+					   unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lhu, reg, offset, base);
+}
+
 static inline void emit_mul(unsigned int dst, unsigned int src1,
 			    unsigned int src2, struct jit_ctx *ctx)
 {
@@ -1112,6 +1118,8 @@ static int build_body(struct jit_ctx *ctx)
 			break;
 		case BPF_ANC | SKF_AD_IFINDEX:
 			/* A = skb->dev->ifindex */
+		case BPF_ANC | SKF_AD_HATYPE:
+			/* A = skb->dev->type */
 			ctx->flags |= SEEN_SKB | SEEN_A;
 			off = offsetof(struct sk_buff, dev);
 			/* Load *dev pointer */
@@ -1120,10 +1128,15 @@ static int build_body(struct jit_ctx *ctx)
 			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
 				   b_imm(prog->len, ctx), ctx);
 			emit_reg_move(r_ret, r_zero, ctx);
-			BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
-						  ifindex) != 4);
-			off = offsetof(struct net_device, ifindex);
-			emit_load(r_A, r_s0, off, ctx);
+			if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
+				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, ifindex) != 4);
+				off = offsetof(struct net_device, ifindex);
+				emit_load(r_A, r_s0, off, ctx);
+			} else { /* (code == (BPF_ANC | SKF_AD_HATYPE) */
+				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, type) != 2);
+				off = offsetof(struct net_device, type);
+				emit_half_load_unsigned(r_A, r_s0, off, ctx);
+			}
 			break;
 		case BPF_ANC | SKF_AD_MARK:
 			ctx->flags |= SEEN_SKB | SEEN_A;
-- 
2.9.3
