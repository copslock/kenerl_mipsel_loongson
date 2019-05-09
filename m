Return-Path: <SRS0=ZxMT=TJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E412C04AB1
	for <linux-mips@archiver.kernel.org>; Thu,  9 May 2019 19:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FF72089E
	for <linux-mips@archiver.kernel.org>; Thu,  9 May 2019 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428727;
	bh=n6R/SMkEDuB4xZ6Ddy+01pQ8t9J5hnVCEn33UDP+TM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTL1NnOEtZhNkqoO+k97/Wq72e2HDjWqc72mDySdTW5wfoM/hjF3YZudvDKKbhuC8
	 Zbpg8TLZ/CYYGeBTCMoj++2XVYvoUX8HCOjDfk8cQM8cOTBE8s8Wef9t7rfFJ9gB5Z
	 asTEgZxwZNf3ZB0lmzdcMM3nZUgjQRea5eQbEJhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfEITFV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 9 May 2019 15:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfEISrt (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 9 May 2019 14:47:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9533217D7;
        Thu,  9 May 2019 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427668;
        bh=n6R/SMkEDuB4xZ6Ddy+01pQ8t9J5hnVCEn33UDP+TM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0gSLRpLGzlrygrgVLNoX274O9PD91rfrNNcTYUjanFjJAHmyMBlFUz6z9MwPIsVP
         zfRSV3f9Bt8yIfA9N1Y7M/Hi2Sk8qaoMwWAOkp1gw+CWxzWUgs8+Lc5fqJZma+4TXR
         RBGtGtt65FQ9MAGUw8qHEhRwj/KENUjLL/zXmGdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chong Qiao <qiaochong@loongson.cn>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/66] MIPS: KGDB: fix kgdb support for SMP platforms.
Date:   Thu,  9 May 2019 20:42:01 +0200
Message-Id: <20190509181304.656350630@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

[ Upstream commit ab8a6d821179ab9bea1a9179f535ccba6330c1ed ]

KGDB_call_nmi_hook is called by other cpu through smp call.
MIPS smp call is processed in ipi irq handler and regs is saved in
 handle_int.
So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
 to kgdb_cpu_enter.

Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: QiaoChong <qiaochong@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/kgdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index eb6c0d582626b..2c1e30ca7ee4e 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -33,6 +33,7 @@
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <linux/uaccess.h>
+#include <asm/irq_regs.h>
 
 static struct hard_trap_info {
 	unsigned char tt;	/* Trap type code for MIPS R3xxx and R4xxx */
@@ -214,7 +215,7 @@ static void kgdb_call_nmi_hook(void *ignored)
 	old_fs = get_fs();
 	set_fs(get_ds());
 
-	kgdb_nmicallback(raw_smp_processor_id(), NULL);
+	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 
 	set_fs(old_fs);
 }
-- 
2.20.1



