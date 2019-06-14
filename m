Return-Path: <SRS0=Ffnl=UN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD43AC31E4E
	for <linux-mips@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B1B21841
	for <linux-mips@archiver.kernel.org>; Fri, 14 Jun 2019 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544293;
	bh=F+anLLuCwXvo7UdHUf2b8qxkr5pxdKd/+T5t+Wh0p2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TsG6bVuiFh37INKYNAbwqTCMbZTpV/Jo9dPFwX42rNDfi3Gx/56fnNrpgUBg2DzRf
	 LYcIlufVB042D6wLeX4N7sHwQSj/0FRhkI9jsijEpESY3m3MgMbzL+WCKINv3dVtIC
	 pffMR8FFvhNe4qhsHoleJdKBzG/jhf+LjHmEES1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfFNUaw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfFNUaw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:52 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8A7217F9;
        Fri, 14 Jun 2019 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544251;
        bh=F+anLLuCwXvo7UdHUf2b8qxkr5pxdKd/+T5t+Wh0p2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCv/8t90kbpCsFsemava6/k66xUUgdqWSaHND//1zHUwOqUvFQn8wZOBaA1OetMKb
         YdDL5jyb275VvR76UJDLf6kxcoOuhp+9SY48YtmjWlGmCzdHFiEuD5b33JC4SfwzZm
         7s0UvlqqjC3/0A//MNEsYju1f9jrC+MXoqih68YY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        jhogan@kernel.org, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 04/10] MIPS: uprobes: remove set but not used variable 'epc'
Date:   Fri, 14 Jun 2019 16:30:40 -0400
Message-Id: <20190614203046.28077-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614203046.28077-1-sashal@kernel.org>
References: <20190614203046.28077-1-sashal@kernel.org>
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
index 4e7b89f2e244..1363d705cc8c 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -164,9 +164,6 @@ int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs)
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

