Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 22:23:15 +0100 (CET)
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:38383
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992214AbdCNVV6hv0XP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 22:21:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cwOtxLQiDpAts8X3DhmNPor/o5UBB79v+HWGb1bl9cg=;
 b=QoFUB0H0ZXGZX0kKo4CT0kX7xHB4jALdgKISw0jLaKfYhhF79t5MdKLr3BXL6t66JnUImfVMyXBngn0pMpNke3hDfPCsEhABMtUXCLO4Y29cVB6ZgUsKAjtfT9tI5QTyqdUoCG0KrodvZYU0CzK5KxpfnspGH/7RCp0E6LiYiZo=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Tue, 14 Mar 2017 21:21:53 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/5] MIPS: BPF: Quit clobbering callee saved registers in JIT code.
Date:   Tue, 14 Mar 2017 14:21:43 -0700
Message-Id: <20170314212144.29988-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170314212144.29988-1-david.daney@cavium.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0003.namprd07.prod.outlook.com (10.162.96.13) To
 BL2PR07MB2420.namprd07.prod.outlook.com (10.167.101.144)
X-MS-Office365-Filtering-Correlation-Id: 1ebd8a8d-aabc-4976-3589-08d46b202339
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;3:jJTCW/aIwfQ3R0fysAgo2W2i0/1IEmnNSyw7hwXYAV4/aagYIOqC57iz3gc24wxUBPovEydNqlV/CKSnAwx4KSNvWdUmSh/k7E2FgBdIMqhLsTDH++K8SjwToPIxctJfkEx18Kq1FS8JUkENnsbpgMg7md2GZ95JFNjJ4oqNJ8qwUqKakMK+ENdFzi5+cJ7J54PCbdb+U23CvrzBr1CbsDDHMNIMGBMfL580+EPAgOt0tLYVa8J9GUAokuh64RTajs+jeSllCCyhOMDsFfldWw==;25:TiTZIanBI6jkJhpuBfnW0b72/nlgC/1mgphizuWriAdkTAvfkmYX6HyEyM3oFTfFhHv33FAHuYTpn4oU5ccQfyYVaKalV/Nq0FDBvlm0DOoq+FcKB9Xpktm7zT11Z4pKPSH//my1lpRGLtYXzZnxpxHQ0m6/e1mQYBfGvo7GTBCqYQ0C6Q6lrDF1ezZLkNUpSmq4J0YSZ7YCgciqlZfDXY2doEdf6HHoRHTFTm5w3fqe5f9Cnb9HzIpU/eLRrhrxxvQvbiUPg/A7uIsqNGTi4WIa7Ij46thiIxEfqtmrXBgMotQiFX66HbBl1F9LZZOdVClTgbo4v0PBjebpxNOU+bf/bDtrYDvXMIvvD4QHL/3c5kO+/WQj469C2XW/qveS7KoTFFK4I4adAasOG0LuxtDble828+AKF/HvZlvRdtDQeR3fUHwGHB1qHU14fNL4STwRf2HfBUlXYTDGkSfSfg==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;31:S/Pv3JeODQnVTBQKPUOeReHjTOWCIpfpDht9GlKfxME7rvRToR07lY6CS8JV3LGBKP7K+ZiCcq7aTd1XInyl9t2EKRQWOhTY3iUyB1l7hq1/2cHTICjCDEy4hGeL9Ou0800ZcgEHPugQ9YchZgfxhaU1qi9IWIPNY4DI8Kri8IB3OZjOW/ZJT4+DGACaihAfHYFCsQnV5gAftSVSfIOaT9zsjS9cS4eJ9buplkheHKIIbOqQeogkeFc84WClLBfp;20:zGSj7RBJyQgcYBwlKLgzhS2ETR2UPaQ8kCk+QfMnYZmMOWCCQAMOekBq617r4ub87OUDKenSzdq+M7tvi4qrpYSS4O6pbFhfMlMmxVW6KGHdN9apr0O3waglhfe3AHZoyczCH9FfOM3i/fi1rdKZGguBGy11rs0+zoH1w+G2qTgdsZSbxOdfftDAjkT/zRSLzIBbRy5S+XfO/SdzI7njwKxiG+hVxpdnAvSsaNOEQWmPKUHVnkXf0fQ6ytwk5qtRQ2UGiJBCKTOyOllWdR/SjrVOCb53u2RQYfkxEw6tYP376SzLy3GqaEczRyinwgbpPNJD96OG9O5zesxJjKn4tvA/7/weIT9hLllsTIg9vMsoMSgMCNYJH7Nx011AdVg0j9s9dt6dYClCGAJUMLUXmUXX+LIpoNCifUYUys+RsdFR/D8fPX/mFnWyBkt0s1uuo4U1ynwszqWP/40aucV5QF3c+/yASvuQOZJvocKDHFCM76e5AJSGWTHJaOwl27dc
X-Microsoft-Antispam-PRVS: <BL2PR07MB2420B6C47E7D3CCE435254C897240@BL2PR07MB2420.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123558025)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BL2PR07MB2420;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2420;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;4:vHb3ev+FlubqikLrw4d2ycQ7d8kcOiSAQvvZk05yNmMqYEw8jD9nhf9fZ1UfV+AKFaFMjhtWV0U4N+RjjCanGnxxO22CZmg1LEYWO0vWa/+1sUilvY0VPYsWLcPYol06eWqP0gGWXY+sxby+sT301wP6WVzj9clxyFEZvw6L5Zou8BUu8ay39at3IYIkiiJ00us+dQqKYNo6F2sIzsDGyiicDjUVIyONnnsqutw66ggBiHLU45Dah7DjRMaQobjrcV43lfOLbWoPPMHoKbWEGruxDg1NQiDldfx38sz+56+HOiWrAYtsSohxn8f2iNM6BZ1izLfn1tloe3vZogRRpnEtSW0ZinYoTsemIsX/v4Y34r337xjhyNBuocuYS4lpI2jbB45Tuou0jFYPnf8/SIClR77JoznVBrrxtPlDWcrJ/acQMrEmuRNCvFMBDaHOkZwaSjiEUZvsa+pgtDGtOwjYMYl6fJReJooTiG07jzIuahBLMYvEaWdJmYHqVHi5JwOiTZH30lpLZDJWxK30mRbIw0Fg2HIoS8vX0XO8ouwPHMzrTQljUk3wc/kYdsqFrmC+AA/HgyZAHDNp29wLDrMDirVS8ET86iJHFlG0Vqk=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(305945005)(50986999)(4326008)(36756003)(7736002)(6116002)(50226002)(3846002)(8676002)(50466002)(81166006)(5003940100001)(48376002)(54906002)(76176999)(6506006)(42186005)(107886003)(38730400002)(1076002)(86362001)(25786008)(53416004)(6512007)(6486002)(33646002)(47776003)(66066001)(53936002)(2906002)(5660300001)(189998001)(6666003)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2420;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;23:KXnSIXKU6pjU11tZNIxUJ20+xyl1Tn957FuMcOgNgmwQiL1CGrDL9aJPZGI0fzT8AmvP6NfPgb9X5Oq8fjef1XFRo8AaM+/X2aFAtZPo16zdxVzBJIahIwQO8qmOzny/Pw6YsIR8Aj9WE8FbKGUstlfuold0ModPy5FP5kPJmfgE90y5TKpZMXjtvQMhHYq4tePT6Qtyt6GH6gYEldGz3OTdKc7j+Z4O9zDr9RDwmj8OyzlQVCc3hh2g9UF5ke9n0Xgpe7c/PP/XWAsj90CKNWaNY+wkU7o2TojsdZrU2U52c+EL/hz/ZeRWst6H7L/f05e7mad8bHhaEvhc4LKsDLaIER3WHIe3/xH/tknfFx9ND7hfpz8/1FodMmu2Yc4JoH9TsxzCzOEXi0+v2LiHb+8wDqwqoX66hnLzdy0sIkKtU43hOVl5n+fBr9QKXOyHaCJoFvlL6iT0tAkVZjVstVPGBiuZFP5rb7MmctGr83WRHO6h2H382KyLcZkmiBPf9C909riyuxpHU+ZJPtC8injUO/f2+vqsmvj+4fRy+EkX0yvob7wAUpvsvwY0gpNdMv790WfloBw7UaFV80jB5ltgLqfpvX543PIoBOws+SfLGs/tDdaiEqsT4sl3TA8WZKG5SwuElBZwpG9y/CCaloxCb3sA9EgiT21GEUqZ8aVthTFeX0VkYpgsAaH5tVPKw4xZ4Z8vL5kLBfJypALCBOyXGz9aQGxIQKgi8fq/qg1snGSU62YBtBUMlP4GAOFuYPQLcU3leWxVnul1iDWqFYZ1/rJkOOAq4FZgzspvO/cmDMCtXIlOV99ce5xkMQobItB3ifsNgjs4GWt3tQaT3wHGtBH076iHO3EYwNBczekkT+bbqBFPkqQ7x8pgJ08anbtoHfGseFYym55Pcpr8eTTXot8dlXMripb5wVRxSLEOQ+Ipfg2vsicYCOmAU+GF
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;6:QlpkRDr/LErVVE6KSOk67eOFa6t++In71cY+uRbxb8vpBNPA/GASR4nz40xA1HWx+FIaZpEtqZth0OdVSSgEU0ZS2QxTFFw/qztkFZynLoEiwhiKUasFzJ7poTLfKyPaW/Vu4zGgJ5/0LsqJ3NPVYbmxM7oTktO2rltAsi98sKMp/PB39HV3qJg9sx0BuFJtqISMCbhwltnj4BcMV3A0PeBwYa/3lIsxA15aZhvs071FYlXlBY6yYZb1/0oDPR910fjLKJlFrEREhPeLWCCk1kf6X9D/jVlAWG4A4M2dVWpLFv5HsMRq72PINJF8mqFbGrvM5sHNL+Tkx/FRu8EXJZ1nXLAbnlVIq5Uhz8cTMFEzqdV6FucibnbyUG6rnus7VSt8dkjjE9WHTCykBA7XcA==;5:6tE0ZvStdTnyf3DO2gYsYAuFZqMhB+m7mUGXlgI2mM3gZ4Alc+3eh4r3Ug7y8+FqfGjkT4vu/FXqhxavVzWwgtxS9fkjpbeLQkucs3ZRVT9TqSYWs10Ui/r3t4oekmMwApbhv43/LZKxBCL1KUGm5g==;24:jugDAyRbSSz9w9VQ5YknIfkiF/cDzLFz3Gy4SqIyp8FlKZ+qBOfn++boDehIuPWjE9PaiwycgWfMcSFkpVAA0vdGAIX9Nn1fYroYxuKkpCs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2420;7:XMnLBMY4fcPI2CyZrbO0fETaTYFVI+ub0JnkU8Gtac6RAzl9hUUQ4LCYBd8Nu6meYPw702LTYe7jCA10HbdwUCQtXxLyJnmjolIWO51NHfm8DsVCPwdsOkN2dVwWM/yXYoddXz+YfDsqywHxXdfHnZhotnAa4ywnOiKrp7qWmBQGt8dReWMbZxtIeI2JOHgMmnKAdiRjD/hYByN0GOVAZ1sCFExXZBeMX6T8VxtIEh/ohfilRqNSzhwQQ4vVteqnm0XO/B0ZSg6T1mhFiWdu5ovRkh2Zr4K0+Iui35kqcwDSgdWZxeAaDXkb4uFyRInAM9Zz0kmVW2Gx3l/uudMIbg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 21:21:53.2972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2420
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57265
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

If bpf_needs_clear_a() returns true, only actually clear it if it is
ever used.  If it is not used, we don't save and restore it, so the
clearing has the nasty side effect of clobbering caller state.

Also, don't emit stack pointer adjustment instructions if the
adjustment amount is zero.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/bpf_jit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index a68cd36..44b9250 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -532,7 +532,8 @@ static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
 	u32 sflags, tmp_flags;
 
 	/* Adjust the stack pointer */
-	emit_stack_offset(-align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
 
 	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
 	/* sflags is essentially a bitmap */
@@ -584,7 +585,8 @@ static void restore_bpf_jit_regs(struct jit_ctx *ctx,
 		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
 
 	/* Restore the sp and discard the scrach memory */
-	emit_stack_offset(align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
 }
 
 static unsigned int get_stack_depth(struct jit_ctx *ctx)
@@ -631,8 +633,14 @@ static void build_prologue(struct jit_ctx *ctx)
 	if (ctx->flags & SEEN_X)
 		emit_jit_reg_move(r_X, r_zero, ctx);
 
-	/* Do not leak kernel data to userspace */
-	if (bpf_needs_clear_a(&ctx->skf->insns[0]))
+	/*
+	 * Do not leak kernel data to userspace, we only need to clear
+	 * r_A if it is ever used.  In fact if it is never used, we
+	 * will not save/restore it, so clearing it in this case would
+	 * corrupt the state of the caller.
+	 */
+	if (bpf_needs_clear_a(&ctx->skf->insns[0]) &&
+	    (ctx->flags & SEEN_A))
 		emit_jit_reg_move(r_A, r_zero, ctx);
 }
 
-- 
2.9.3
