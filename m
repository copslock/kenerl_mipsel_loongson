Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7459C04EB8
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522B2082B
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 10:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Stzd/LW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7522B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbeLDJ7o (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:59:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33219 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLDJ7n (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 4 Dec 2018 04:59:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so15235764wrr.0
        for <linux-mips@vger.kernel.org>; Tue, 04 Dec 2018 01:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKGrt+KbiuFwPoUgniU9Rs5/SXJYxxQWK2Yv4u4cLIs=;
        b=Stzd/LW69AwogqsnTKAyW+Gs9o1J6+oWnmM3AoMcwyol28k7hxdCzqqm1EdoiXDTBv
         6gx6iI/Zmpx7MQI7OJXC/oTYPmFKr8ilJmZk8mrUONWIrCgspUxtCe3kyGjLgU5Cib1X
         QfONIcUqrjxU/lYuqCibTqk8Dx85hjDrk3NzygZoYSSe1oAvC9zRbMEgAaLCTyCa1obx
         UQzlddO/xRnYtzkG93u5QD+38CDZ1TtJ7lVVx55lKvA+hyXthqwXEPWhnWJ4pfjmzYTk
         j/B8EtDri5ittB7+Y0GFooybAfsux3qi5kd/82RmKwBiIu+t/YOxe98FHikxK5qFDyHD
         +sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKGrt+KbiuFwPoUgniU9Rs5/SXJYxxQWK2Yv4u4cLIs=;
        b=mB0zKCiAVRkXKD7VQc3xUfK2kBJy/AdK3Ypm1KT/nJeeQCXnoZcV8Zb6fDsCkSZ5a4
         vI1oFC8jbiS4mCKX0kl6gqYjd+IoEBxA7rKyeh+nvDgGtmhsDG+InoDeHwoKud3Q9j5s
         I6T4Zk8iewvnPWE2hwxHAqQlAnfSyCKIDmn/0w2fCfRMU5rBZEfKwLQEprysSYTbGrFa
         gGU6k7exRZuNLa8gTYD7W2PA7NFLmXs5cQr2+E/qFk/wkE9buFYXbfetwwYHDXGf1zwM
         cOd4TbGOUaR8gCQPJQFLFptBhSIkMdwVGnYxOSJ9EY8RxgKYWzlYnD91To1ubYZtSpu7
         gLYA==
X-Gm-Message-State: AA+aEWbwPvsBwCFN+E/fgSprnGNS6pYLN0CI/jFxBEihE6JPIcK54f0K
        xskLUrjar3b1W0oEuvbhVCheag==
X-Google-Smtp-Source: AFSGD/W9FNLNfOQt4FmxqZIhYGBSei19AfcZRcVD6VVXgr0p//6iXZNzRmZirgQiKmJrPqtoMUiihw==
X-Received: by 2002:adf:a211:: with SMTP id p17mr13985471wra.179.1543917581173;
        Tue, 04 Dec 2018 01:59:41 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id h2sm10931105wrv.87.2018.12.04.01.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 01:59:40 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     netdev@vger.kernel.org, oss-drivers@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [RFC bpf-next 2/7] mips: bpf: implement jitting of BPF_ALU | BPF_ARSH | BPF_X
Date:   Tue,  4 Dec 2018 04:56:30 -0500
Message-Id: <1543917395-6130-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543917395-6130-1-git-send-email-jiong.wang@netronome.com>
References: <1543917395-6130-1-git-send-email-jiong.wang@netronome.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Jitting of BPF_K is supported already, but not BPF_X. This patch complete
the support for the latter on both MIPS and microMIPS.

Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
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

