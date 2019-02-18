Return-Path: <SRS0=NRRR=QZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30097C43381
	for <linux-mips@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F200E2177E
	for <linux-mips@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499490;
	bh=mH2l9aAGj6Ly+flAAVJ26qd6dRAZ8A9DxURwmQYB37A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAx+/re8HdSxVKoSBe4ntzfpCKIIkiuU92IdIK8CuK2hAjtJknGMhUoE6ZGqnF1KS
	 uSwfMeHh7Yj+NsDbYEVP40+0uTKLpdAk8WWhne7S1wPEG2RjDLDqkjo6CjfGutx59R
	 RoL1A+/mSE9mwRptnoekA5fdJ+50c4gDyfhcJTB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbfBROJN (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391108AbfBROJK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813E421901;
        Mon, 18 Feb 2019 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498950;
        bh=mH2l9aAGj6Ly+flAAVJ26qd6dRAZ8A9DxURwmQYB37A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxKGr7oaW3A4URxUuhn5URSTc+7AkbMuor91JfAqstz1bIsGvADcsATQkHIIqPybf
         zKoWWSyfzO83ujxe1sz4msQ+icUYoltuYCNY3QjYlIOk+shDPJofh5N82+AmXT5PPG
         nszyci5hQP8ZBYoMG1yHAFRgJjt6IeTTk44Lu3PU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Song Liu <songliubraving@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 021/108] mips: bpf: fix encoding bug for mm_srlv32_op
Date:   Mon, 18 Feb 2019 14:43:17 +0100
Message-Id: <20190218133520.493782313@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 17f6c83fb5ebf7db4fcc94a5be4c22d5a7bfe428 ]

For micro-mips, srlv inside POOL32A encoding space should use 0x50
sub-opcode, NOT 0x90.

Some early version ISA doc describes the encoding as 0x90 for both srlv and
srav, this looks to me was a typo. I checked Binutils libopcode
implementation which is using 0x50 for srlv and 0x90 for srav.

v1->v2:
  - Keep mm_srlv32_op sorted by value.

Fixes: f31318fdf324 ("MIPS: uasm: Add srlv uasm instruction")
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/uapi/asm/inst.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 4bfdb9d4c186..3eb4d6177266 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -262,8 +262,8 @@ enum mm_32a_minor_op {
 	mm_ext_op = 0x02c,
 	mm_pool32axf_op = 0x03c,
 	mm_srl32_op = 0x040,
+	mm_srlv32_op = 0x050,
 	mm_sra_op = 0x080,
-	mm_srlv32_op = 0x090,
 	mm_rotr_op = 0x0c0,
 	mm_lwxs_op = 0x118,
 	mm_addu32_op = 0x150,
-- 
2.19.1



