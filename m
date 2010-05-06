Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:00:07 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:44922 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492638Ab0EFRAE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:00:04 +0200
Received: by pxi1 with SMTP id 1so74341pxi.36
        for <multiple recipients>; Thu, 06 May 2010 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fB0VCW2T/eWzDsCgRdD1nNCFLN0bOymoswRH3XKTjQc=;
        b=hyRVsLSMlLjHbwL/i39etADTlHuucyVjP1vCuUfLW74q+A07/TUtP31xMKpg++QAhw
         C2uI4V2pOVDo+ehVDr4qQmTgBSWe7OZkR7Sz5fBL7OevQllgQG6HH1nDhwOMFqM5FMr2
         SO5EA24kUD0YzcdUBuMtJzidVUzR4MpJDAijE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rPcmfsubAwDaAuoM4VZhxnuQn86qqL9MGuP6sKyJd0hlKwjmnZ9Qdl6qDmsrpc2l1d
         uKOWQBaRALUiVvmPW5dpRk14IxlMslGvIqMnMxPAHOAq5C57vVQayuaFeRCn+EHtW3sI
         Q1iecRGgpbcU39V0hq3ppEdTU/QzRFL9NsvXs=
Received: by 10.115.113.5 with SMTP id q5mr9527689wam.67.1273165196331;
        Thu, 06 May 2010 09:59:56 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id d20sm5142109waa.15.2010.05.06.09.59.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 09:59:55 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Oprofile: Loongson: Fixup of irq handler
Date:   Fri,  7 May 2010 00:59:46 +0800
Message-Id: <1273165186-29153-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The interrupt enable bit of performance counters of Loongson is in the
control register($24), not in the counter register, so, in
loongson2_perfcount_handler(), we need to use

	enabled = read_c0_perfctrl() & LOONGSON2_PERFCNT_INT_EN;

instead of

	enabled = read_c0_perfcnt() & LOONGSON2_PERFCNT_INT_EN;

Reported-by: Xu Hengyang <hengyang@mail.ustc.edu.cn>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 29e2326..fa3bf66 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -122,7 +122,7 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	 */
 
 	/* Check whether the irq belongs to me */
-	enabled = read_c0_perfcnt() & LOONGSON2_PERFCNT_INT_EN;
+	enabled = read_c0_perfctrl() & LOONGSON2_PERFCNT_INT_EN;
 	if (!enabled)
 		return IRQ_NONE;
 	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
-- 
1.7.0
