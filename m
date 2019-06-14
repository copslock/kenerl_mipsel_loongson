Return-Path: <SRS0=Ffnl=UN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3305C31E4E
	for <linux-mips@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906DB21473
	for <linux-mips@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544687;
	bh=JcfqUTP6x4yGsT+rMP4Hw8NWJSGWT2N9YWh0L6aHju8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FItpd2pgPIBZTqnE1O2xF+CA2E1bLc3ZdkSgRtelAbLUwBuQYgJejY/ZIFG2BEIVn
	 BW4qdGMm3p/6QYjVb+V4M+EsAcHwXACmkRp54GIND1hz0XFBVdpYaVwG91lCiphcq+
	 0i1KLPM5V37oyGhtRErDtPDt4JfKyfry3H0UMhTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfFNUh6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfFNU3F (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Jun 2019 16:29:05 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8035B2184D;
        Fri, 14 Jun 2019 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544144;
        bh=JcfqUTP6x4yGsT+rMP4Hw8NWJSGWT2N9YWh0L6aHju8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AycFfBCoOGVUm55nn3t6nEhvx7WfRKONxYFPxnDoyg2mMe229CUPiRuTBuaQFvl8O
         JuqrEjD7LVQ7FtNTg8sfIOi1WNdnFfWKT36o/h8nB+czHpP+hXjyoTAr0BB0tNXFr8
         lX9sa0DQx+VJ9hlUqYTWwgDFJaAIG2nL9wMqq7w0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        jhogan@kernel.org, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 25/59] MIPS: uprobes: remove set but not used variable 'epc'
Date:   Fri, 14 Jun 2019 16:28:09 -0400
Message-Id: <20190614202843.26941-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit f532beeeff0c0a3586cc15538bc52d249eb19e7c ]

Fixes gcc '-Wunused-but-set-variable' warning:

arch/mips/kernel/uprobes.c: In function 'arch_uprobe_pre_xol':
arch/mips/kernel/uprobes.c:115:17: warning: variable 'epc' set but not used [-Wunused-but-set-variable]

It's never used since introduction in
commit 40e084a506eb ("MIPS: Add uprobes support.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: <ralf@linux-mips.org>
Cc: <jhogan@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-mips@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/uprobes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 4aaff3b3175c..6dbe4eab0a0e 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -112,9 +112,6 @@ int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs)
 	 */
 	aup->resume_epc = regs->cp0_epc + 4;
 	if (insn_has_delay_slot((union mips_instruction) aup->insn[0])) {
-		unsigned long epc;
-
-		epc = regs->cp0_epc;
 		__compute_return_epc_for_insn(regs,
 			(union mips_instruction) aup->insn[0]);
 		aup->resume_epc = regs->cp0_epc;
-- 
2.20.1

