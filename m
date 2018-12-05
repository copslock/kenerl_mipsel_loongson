Return-Path: <SRS0=vpel=OO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40405C04EB9
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FCF20892
	for <linux-mips@archiver.kernel.org>; Wed,  5 Dec 2018 18:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="baHoF0WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FCF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeLESxT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:53:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55616 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeLESxS (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 5 Dec 2018 13:53:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so14311180wmc.5
        for <linux-mips@vger.kernel.org>; Wed, 05 Dec 2018 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U9Xn2jiRJgBYJ8l+3jmjV5RTQIAXgmf7+uFBKajzb+o=;
        b=baHoF0WNgWbJb3z5SGIssKjMB8jnvAi54vCGduJrcc/BQjGvJgWHTINgLdkT31Z0OO
         7z79KlKIjf8w/cI5rFMc4DVVEPD0pSxZJVJd0V7I101w06Pn06phN/uAD6WOI0QgHiJz
         5lqhdD8Q5Q0shAMnS6ctkTmnB9Q4VW4d9B2ObkB97/ewak3lwhhAvbYFCa2Z/2g7FmqY
         kftCLa2u4fMZGHgHKkURaUgMNs4yIo19HgUlQlnKJCAhImIPXB8+vUSc3u9upyg0Z5uz
         wjVndAosvMskgQ2SDPZQk6QJA79UXlfyHCTJWmwW21Ad59BAmGgf31sywbi13mM6Voqa
         gd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U9Xn2jiRJgBYJ8l+3jmjV5RTQIAXgmf7+uFBKajzb+o=;
        b=h5NoZOJpA8ituEqsIYcisFwR2DNnRgYO+0UNeEcWUiogeA8B05aZtLp9F+vkHsvG+q
         eQWfMTD53yVTgIcO7rvCoPXG+FdfBQ+U0p8TX6B6+Z4CCnqP9ziDjGfW9zlbpUWyBq85
         W4fDApKNafzGLfHl7puTEIiWOVLX9mHM5ynShcnbO02bCNwokqp4hHDHEEKbbDRmt35M
         W6WQi9whgFPc/auKsLY9OV+CTWIPUM0iyMVYMH6NrzuyfL7+39mWtsqgWzEQCRpzP7eJ
         B9eau50U0YKokGsFHtikSEI8ylaRN3DJYElN3TrrL8PLI9KLRcIJzRiFlWG7mbORgpgQ
         kdAg==
X-Gm-Message-State: AA+aEWbdSeeqK22QBVwiYijB9O+F2cpvrk3SSxT0vOk7g9IWA0Iodx9e
        2XYzaoLfZNssC+f/Vdruy1HRLQ==
X-Google-Smtp-Source: AFSGD/XUodfMpRCOUXpNDNABCS5NLscfFJwd6HESu5whDfSmpjZmYaqP/mhSUvzGQYKQfgCkaz30rQ==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr17091939wmb.23.1544035996405;
        Wed, 05 Dec 2018 10:53:16 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id s81sm15803251wmf.14.2018.12.05.10.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 10:53:15 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     netdev@vger.kernel.org, oss-drivers@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/7] mips: bpf: implement jitting of BPF_ALU | BPF_ARSH | BPF_X
Date:   Wed,  5 Dec 2018 13:52:30 -0500
Message-Id: <1544035956-12375-2-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544035956-12375-1-git-send-email-jiong.wang@netronome.com>
References: <1544035956-12375-1-git-send-email-jiong.wang@netronome.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Jitting of BPF_K is supported already, but not BPF_X. This patch complete
the support for the latter on both MIPS and microMIPS.

Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Acked-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/mips/include/asm/uasm.h      | 1 +
 arch/mips/include/uapi/asm/inst.h | 1 +
 arch/mips/mm/uasm-micromips.c     | 1 +
 arch/mips/mm/uasm-mips.c          | 1 +
 arch/mips/mm/uasm.c               | 9 +++++----
 arch/mips/net/ebpf_jit.c          | 4 ++++
 6 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 59dae37..b1990dd 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -157,6 +157,7 @@ Ip_u2u1s3(_slti);
 Ip_u2u1s3(_sltiu);
 Ip_u3u1u2(_sltu);
 Ip_u2u1u3(_sra);
+Ip_u3u2u1(_srav);
 Ip_u2u1u3(_srl);
 Ip_u3u2u1(_srlv);
 Ip_u3u1u2(_subu);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 273ef58..40fbb5d 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -371,6 +371,7 @@ enum mm_32a_minor_op {
 	mm_srl32_op = 0x040,
 	mm_srlv32_op = 0x050,
 	mm_sra_op = 0x080,
+	mm_srav_op = 0x090,
 	mm_rotr_op = 0x0c0,
 	mm_lwxs_op = 0x118,
 	mm_addu32_op = 0x150,
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 24e5b0d..75ef904 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -104,6 +104,7 @@ static const struct insn insn_table_MM[insn_invalid] = {
 	[insn_sltiu]	= {M(mm_sltiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM},
 	[insn_sltu]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sltu_op), RT | RS | RD},
 	[insn_sra]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD},
+	[insn_srav]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_srav_op), RT | RS | RD},
 	[insn_srl]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD},
 	[insn_srlv]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_srlv32_op), RT | RS | RD},
 	[insn_rotr]	= {M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD},
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 60ceb93..6abe40f 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -171,6 +171,7 @@ static const struct insn insn_table[insn_invalid] = {
 	[insn_sltiu]	= {M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_sltu]	= {M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD},
 	[insn_sra]	= {M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE},
+	[insn_srav]	= {M(spec_op, 0, 0, 0, 0, srav_op), RS | RT | RD},
 	[insn_srl]	= {M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE},
 	[insn_srlv]	= {M(spec_op, 0, 0, 0, 0, srlv_op),  RS | RT | RD},
 	[insn_subu]	= {M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 57570c0..45b6264 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -61,10 +61,10 @@ enum opcode {
 	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_nor,
 	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb,
 	insn_sc, insn_scd, insn_sd, insn_sh, insn_sll, insn_sllv,
-	insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra, insn_srl,
-	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
-	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
-	insn_xori, insn_yield,
+	insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra, insn_srav,
+	insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall,
+	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh,
+	insn_xor, insn_xori, insn_yield,
 	insn_invalid /* insn_invalid must be last */
 };
 
@@ -353,6 +353,7 @@ I_u2u1s3(_slti)
 I_u2u1s3(_sltiu)
 I_u3u1u2(_sltu)
 I_u2u1u3(_sra)
+I_u3u2u1(_srav)
 I_u2u1u3(_srl)
 I_u3u2u1(_srlv)
 I_u2u1u3(_rotr)
diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index aeb7b1b..b16710a 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -854,6 +854,7 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ALU | BPF_MOD | BPF_X: /* ALU_REG */
 	case BPF_ALU | BPF_LSH | BPF_X: /* ALU_REG */
 	case BPF_ALU | BPF_RSH | BPF_X: /* ALU_REG */
+	case BPF_ALU | BPF_ARSH | BPF_X: /* ALU_REG */
 		src = ebpf_to_mips_reg(ctx, insn, src_reg_no_fp);
 		dst = ebpf_to_mips_reg(ctx, insn, dst_reg);
 		if (src < 0 || dst < 0)
@@ -913,6 +914,9 @@ static int build_one_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		case BPF_RSH:
 			emit_instr(ctx, srlv, dst, dst, src);
 			break;
+		case BPF_ARSH:
+			emit_instr(ctx, srav, dst, dst, src);
+			break;
 		default:
 			pr_err("ALU_REG NOT HANDLED\n");
 			return -EINVAL;
-- 
2.7.4

