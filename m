Return-Path: <SRS0=+lB5=UX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEB4C43613
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 10:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877C2213F2
	for <linux-mips@archiver.kernel.org>; Mon, 24 Jun 2019 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370663;
	bh=/LuzipxlxcA01dUG2PDDkaVnU54GDF4QMOE/ETs3E9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ndVR+6x1vmAgVkIU8D4UnDIjKWVgR2MeJSGwF28YtmNqiRA8W6O/fLtFB57q2MLUu
	 iMaogTUqPOPL5kNcZzdR8TtbpalQLaluo9kwkpXdTOZdVF5Z4GQ3P8rtM2O+6UNn5P
	 D34agKvAeGKiiDp1wLKDhXhmCK21+hdqWv2kUMyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfFXKEW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfFXKEV (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 24 Jun 2019 06:04:21 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C92205ED;
        Mon, 24 Jun 2019 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370660;
        bh=/LuzipxlxcA01dUG2PDDkaVnU54GDF4QMOE/ETs3E9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLAT9J7Oryy947lYGzwpSGibothfgkSPZpvNDXp1UJt2iEUJeivwTWJHhmMO9m9k3
         Yq8cGGUwPevVALyCXWBEN8LMxr22lB2whl491FyMQlyHav62Is7s8dS/KhwqGsJOlo
         5INlj5pBuLhi69nz4rWTHgmH+K9j3e+gPPxD2r0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        jhogan@kernel.org, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 43/90] MIPS: uprobes: remove set but not used variable epc
Date:   Mon, 24 Jun 2019 17:56:33 +0800
Message-Id: <20190624092317.105339061@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

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



