Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 22:24:11 +0100 (CET)
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:38383
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992289AbdCNVV701XcP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 22:21:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r1t038eaQ3dvO9BFkXUC54szlo9vdKN369PiO4aTGgI=;
 b=dBq6k+6ImvjTVahyk/xDwNZQrXO3E406ausZtHVQCyKWPxQ+BonWK6q646em7pHM6XY+IS7Plz7uWT7vesieRFm0C4G19WBZqqa4w5C2+7Nck2bbu4eQdH3mQ6hJ7Ecuq95Wlmm6B3zqev+9LXHc6STmWCxA8hnSMzLpeWnbp7o=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Tue, 14 Mar 2017 21:21:54 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 5/5] MIPS: BPF: Fix multiple problems in JIT skb access helpers.
Date:   Tue, 14 Mar 2017 14:21:44 -0700
Message-Id: <20170314212144.29988-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170314212144.29988-1-david.daney@cavium.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0003.namprd07.prod.outlook.com (10.162.96.13) To
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144)
X-MS-Office365-Filtering-Correlation-Id: 0eb6fa87-7fc9-4640-91d2-08d46b2023d6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;3:4if8awnsixxD7yn5fZjG5K8UcmYLZ4jQw+7ohfImFvpPo10Su3cVkHqgWfxSup74rRif5ZvBuBaS5DpX1fjfzqHS2eENtV/6Y1f/9IcW6VSQh7kTxgfHNgVcc9JjJRF1ERrdKX/cO0bgqjivVpRJTjgnYPjeWQ8xFJOrU1g04otOQ8etPiT5LrLkWGM1QgFypO/HUvAtvUkKwUzpm3pUyyk1i4bYUbunt3oHNxpdrQTaXgsSuWqFfg1qV0Fc1MeDUqwA0vq0NV/bbA/EAQOvxg==;25:tlvh4+DOiMVXx/QCYJ4j3O4svWeV+UiB2xitn0aw47yZj1Cs6gQdS02A7G1sTRsrcxNmuNRKPSVKrZ3r7BinTcZYWKVfazL8y8LJWj+SHET96VfM9ye4xMCUQ9jfY23r5hg7m0i/0bls8y9C36ry/dsiuM9QHfUGp5u28pawa0F4FYrtqC2eSiQ+ZovbdkVhBRO/3Y5YmykSINfuC25BO2mQo6lUzawgdCLgm3ViLQ2n015++YldQVVPUn/15lN0zLiOrNRiZLcpRGJlXmLkW1laRSFoxThu2yf/85Z3co28J2dl0164gv5kHKaSpTiVo38c62eeOEfkNk+50XRH52a4v8g3I7DbzKqUr94WUvEOPQsbipFW34gYnxiUYlD75UnLuXSE9mjWph+k+r489rtHGNxXNWLs7nwOaH/VrSaTBI1u9R0ky+t2AXWGSxjqDutzVYUc5RWdRBxjUIwKJg==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;31:fwIIoz5K5QJ8/pnYQDvJwvDYf40h5cln5+QmjQqi2boFlrLkQxmgwCDoadjTuTghv6iJbNB+JciYLGrffd0lOn7qrLxvhGtPcvLmle4mWERVrIlw+0UFeF+IkxdqOSBe3fDaNqVBuLzTHmrUu+SdLuu2yslYUaVhWYeufosZ42JX+FVBA0o70M3gg+JI1F2U/dzLhAaiIjGl8CTRaMFZdSGnyYB2+0qkAGClmgLvvUM=;20:poHowVynI06YnPjLjCBTpFCIcfnb1uisRm+d/WV/zgq21MdzMdHjGdEg/es/1E8FD5/m1j5K3Y/BZaH8QJ8wulv67g/kY9TbmTzu4PQLDj8TgJeV4V2D4nLNFS/3ma2qAjSLR8Yr7HkkTcQ9Dw48/El6+fbGUiPoNLSo092vLV+b0apdm8Awt2GaT0UGRaunLKURaXNkjXnuQLPJkpJ/Ln1RZgtY1JXCm2Qkxh3HnSiyqwCw+6iTELRhwOsdbjVyfTPctehhAAUmfgUntL8HqqdJPXfyrWUZ2JBYeKybqiOorj/Xchg7CeoufvUyyO76zdP6i7QSxU8ihU9+OUoq2SE/58oY7cOrQ9czmDjc0eciSXK2WWnnm0TmqRIschRELoWAV6Yk6yu5X+luvzfeNtPzGMy2Vrhf4XAwzzCWRV/VqOqQeucN8P1RGdfeOBt1plvfk7EWPPxjEBBGEkcScdLSHQIIZzE/gdwmElHimuV6ECvC/OTxulQf48ONcXi8
X-Microsoft-Antispam-PRVS: <BL2PR07MB2420B3C0F7386E2210FD710497240@BL2PR07MB2420.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123558025)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BL2PR07MB2420;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;4:RQ86ispTd9I8XBojzDAfm6ZeZsXxethhKJFYjZBOjqpVlp7QVThwStgPVGANQDTQSvhLefoolpUrfCJaRjXIYrY42rzBelDfJlbL67RXUxIc7OmuVEHEJ9E28+i28ApO/5mBP2BG+8BLFlXssXmucyk3f6arEmbmIuPzj0lbCrXBId5/7ibxQ3h+do/+5DAnug2BUU+Y2mBquP67F0B9gtQCIXLhFc+jeNPFhjSaounrlZS0umsqdoIg9fispcrArxI8J7wLw8YCfTz6uH78n/4keNZQtBADhW76ziqDQmeujs8ub/BBsy8DhP9a/gPt7elgLwsTl6VXtCAi6/qzm1HzQk7GNlMSwfkL83Dp//2XSxTTIiGuBAXYPPNwtMZv6aeEsVGDjk4UnCgi5IIsVM4yu+3qkVsO5PbXFHLekx7dhNL3FKRBkn8Jdtlo09mV9n6s3iuNlLKF4N2RsDOTBSOApZPJv1+NecRW4qvuL2FW+V6EVcR841gadq27u4V05AsbDrGopOhl7iJyvHv6ikF9WmGQtji2mSLcwyqQYZzHIlmEsxjTSIhPy4AuuOOOVdZ7EaPPMBq+9xVTu8ZusW0ySAGHFQAoriR3SqjuOuk=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(305945005)(50986999)(4326008)(36756003)(7736002)(6116002)(50226002)(3846002)(8676002)(50466002)(81166006)(5003940100001)(48376002)(54906002)(76176999)(6506006)(42186005)(107886003)(38730400002)(1076002)(575784001)(86362001)(25786008)(53416004)(6512007)(6486002)(33646002)(47776003)(66066001)(53936002)(2906002)(5660300001)(189998001)(6666003)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2420;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR07MB2420;23:R8kkhTpoJ1X2tNrXifflDlawOQEdeGbb/QqBxUZ3O?=
 =?us-ascii?Q?1IRM+N2hk9veWLrA6i8fjUWb6Hs8jfU0IAaJN67khVzgWnzpHf/7sHDSbf7J?=
 =?us-ascii?Q?x6m4GWmcNMwYW2zDvqVXegsbf1gy6ktX/Pa4cC1leztTZrZECwJa4VbzuYwJ?=
 =?us-ascii?Q?QXZGDYwJ0YJ03Yh8PKdAK+aL05rKopITsZz+U04coYEl1Gk0tgyQOb1ttXEZ?=
 =?us-ascii?Q?QJzKO09jnkNHyiTP8FCjpxwvhWut5rD1zUD0hmdpqLuzpGw2cgvwbIkt88l7?=
 =?us-ascii?Q?W5ZOEL7yWogOKDoEdpu1r8zSDj0q00KPvV1OMkX4mR/K14OzB+Xpv/I4jYOd?=
 =?us-ascii?Q?7126hNqaHyXnCFSclvILyeKlcocBY57msmrnNGAbgxfmfuq72eVQ9TFRe8LM?=
 =?us-ascii?Q?4jmV5OK4s04dD7n2X+5UwHX3ZWiY2b/izWft1hdum5vDvcyVx1hifC35pyhY?=
 =?us-ascii?Q?LTkAxSHXWuCOQqXKPSYqWXjjIvkr6SIAJUx0CIIn1cEPYvyn6HVigNG2swlt?=
 =?us-ascii?Q?jjS6lOU4yTTXQXZXoV4lGt4Jm2xo2SZlwFC9VgtYxaaSSuI2uBBsAFR0x+0C?=
 =?us-ascii?Q?PGbmQlyZz+UBJNyVCYgPgkw9jv6YRUeZjXjRUVeDZxeBCzKqN6KNXnSUaYGl?=
 =?us-ascii?Q?Vyx3I8Yhosh3bgkelPK9AHBhCpetQtjMlgp6x2sbH7izFU6I6DFrYoz81EPm?=
 =?us-ascii?Q?psUFqScmd7J9epU1xaBW7CGxVtYk1sJPjaUAh07H0N9zBVXoAB32F+1dOMyY?=
 =?us-ascii?Q?D47pnMHQSncpYAlezTFcwLtJo0I1FBPx/Tu95NVZ618ybZWKi4VkXLxqZfSj?=
 =?us-ascii?Q?xeBUhbCeueHMMFDumExzZUNZjqTQC/Pnd9lhzGxvQ5++VnvgZzmNYKFFIsk4?=
 =?us-ascii?Q?SJB/2+vbXq3YU3jaE9KJ56fgRdaJzS67EmY3KU5MGmMADeiKF7pPPoLuGOrF?=
 =?us-ascii?Q?k4bgI3l2xu9bRhSv9O6ZtaANnvECewtBUvEG6CDOg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;6:66GvOctMPapRpbXo6rED1srmSFxHYZ1MYclf+ocNWnGTtvQk7VvfhejL+d6SeM221TiochZO2EGZgB3rq1CqYRqBHnEsCGER03VX65qygdafwUFxWDXd90KdAdC2RHe5tc/bi8AUIwic3IHfKJR4d4ciXstErsfRfjxCwotAq+iSoAIcdSazQqLatkWZI+b27slecsMWCaiFruwWpkEHDWSfO1R3D53zxFBjckhTz+V7BuslaLW5zwVg9iLUT6Zyul3osO//ZKpn620Bdc0aA2wUSMth5Mq7q9/8O7nzl2vzgmvOSl5L3fNBEBx8uryftX2U4Fa3aW9kGExoZGZMIBo5A3NOUCAPKWy0HNUsHewBVbn14KVZSXCb3g2FLEYsSdggG+QbICpGqfvHL5mn1Q==;5:42OoTCfEiuvHFabADNYfQ/Z+zHnnQP8fqAI0fjuXOf5fbplP5m4lolgx2mtcNcEoInuZkqHxmQUCziC1fdEfoIU5SLfxLNFdllUJlZED+wlNKxEqmg2xDVeXCN9JzBWZou+EQA8ByEekJmo8uvWPCA==;24:wHWXEY0t4Gia8/fI/uHBIPl0hEHjxj3LhLBk1Oe+Otds99XY6hWCOMtKSXq6Ryih6BWo/Y37zcoI5NHjBeBj7tv52NPKl/BrN91Ip7y2Si4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;7:EdBS2hXt0GKPbpYG0b/N4h/H+NmSkMTTi5gHftphEdzoIrGDeR3voNolbTZd5wbdemJg/TKYKWmtooM+3WKY6sbE84WI+Ybp8LLBIL4Hp09R7apsBtGVoZjcQXGIv/LrFW7mEZqOOMpIceBp4C6ZquSHZoqegFAwddNQOF14Wz3hi57JhLdwqV2wQqiFXxoc/Plx4cP7nyjAZtTA0L8IguVhQv8svoLWzgfTt38K0BobmcYp3mLXj9UzDTjjIR9+4E9p3gyeca2sdi/J4Hl6bIbc6RvduCfGxO0Vjx6zi0ZO49c5OpH+O50fVa3koDvEvLHmBl3DYEWSgO/C6RL+Zg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 21:21:54.3284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2420
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57267
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

 o Socket data is unsigned, so use unsigned accessors instructions.

 o Fix path result pointer generation arithmetic.

 o Fix half-word byte swapping code for unsigned semantics.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/bpf_jit_asm.S | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
index 5d2e0c8..88a2075 100644
--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -90,18 +90,14 @@ FEXPORT(sk_load_half_positive)
 	is_offset_in_header(2, half)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	.set	reorder
-	lh	$r_A, 0(t1)
-	.set	noreorder
+	lhu	$r_A, 0(t1)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 # if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
-	wsbh	t0, $r_A
-	seh	$r_A, t0
+	wsbh	$r_A, $r_A
 # else
-	sll	t0, $r_A, 24
-	andi	t1, $r_A, 0xff00
-	sra	t0, t0, 16
-	srl	t1, t1, 8
+	sll	t0, $r_A, 8
+	srl	t1, $r_A, 8
+	andi	t0, t0, 0xff00
 	or	$r_A, t0, t1
 # endif
 #endif
@@ -115,7 +111,7 @@ FEXPORT(sk_load_byte_positive)
 	is_offset_in_header(1, byte)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	lb	$r_A, 0(t1)
+	lbu	$r_A, 0(t1)
 	jr	$r_ra
 	 move	$r_ret, zero
 	END(sk_load_byte)
@@ -139,6 +135,11 @@ FEXPORT(sk_load_byte_positive)
  * (void *to) is returned in r_s0
  *
  */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define DS_OFFSET(SIZE) (4 * SZREG)
+#else
+#define DS_OFFSET(SIZE) ((4 * SZREG) + (4 - SIZE))
+#endif
 #define bpf_slow_path_common(SIZE)				\
 	/* Quick check. Are we within reasonable boundaries? */ \
 	LONG_ADDIU	$r_s1, $r_skb_len, -SIZE;		\
@@ -150,7 +151,7 @@ FEXPORT(sk_load_byte_positive)
 	PTR_LA		t0, skb_copy_bits;			\
 	PTR_S		$r_ra, (5 * SZREG)($r_sp);		\
 	/* Assign low slot to a2 */				\
-	move		a2, $r_sp;				\
+	PTR_ADDIU	a2, $r_sp, DS_OFFSET(SIZE);		\
 	jalr		t0;					\
 	/* Reset our destination slot (DS but it's ok) */	\
 	 INT_S		zero, (4 * SZREG)($r_sp);		\
-- 
2.9.3
