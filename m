Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:23:38 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:37113 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492622Ab0GXBWg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:22:36 +0200
Received: by pxi13 with SMTP id 13so4832379pxi.36
        for <multiple recipients>; Fri, 23 Jul 2010 18:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=aaZAFYyvbR3oyX93jFqXAbbliXwj3N5qfTPlifkmzgE=;
        b=sJwXQZNunXdXxL8LMjIz4oH6m0kbZ2KmDDdPmLzw6SkS2U3OmBEVN5hPanP1/omQKg
         4KTBAmfRnFW8zMnfdxUVrldkbbG1rX3d1c7p31RvyS4ep33hFp0gUxxfdVa95mEUuIeC
         E7dxLXVtQKZRZqlK7GbVLq+YcmDONcbl0CFVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DhQl5+8r/9q9Gz8TL+dErmkhTEh7UbQbmakvoiMVHpfnxoKebFr4cIUE+GDGM5xhuv
         BDcbWQZ9GJjAQfHLiZvbU0NlqduKh65k8H/v3AkU1QjoWqfm0+vxJTkNBcaOho0C1Wv9
         p1IVxjV/lSPDrzuNDRZr0Mm9aumXc5gv21EYw=
Received: by 10.142.174.4 with SMTP id w4mr5082419wfe.264.1279934549945;
        Fri, 23 Jul 2010 18:22:29 -0700 (PDT)
Received: from localhost.localdomain ([182.18.29.11])
        by mx.google.com with ESMTPS id f2sm936892wfp.11.2010.07.23.18.22.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 18:22:29 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 3/3] MIPS: Loongson: Lemote-2F: remove un-used macro LOONGSON_PERFCNT_IRQ
Date:   Sat, 24 Jul 2010 09:22:15 +0800
Message-Id: <d137959989824a24d9166a3e776c2c7a35049344.1279934355.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <881c93ee3de32e7809f5ac05d0086bc525af57a9.1279934355.git.wuzhangjin@gmail.com>
References: <881c93ee3de32e7809f5ac05d0086bc525af57a9.1279934355.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1279934355.git.wuzhangjin@gmail.com>
References: <cover.1279934355.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

LOONGSON2_PERFCNT_IRQ is used for the irq number of the performance
overflow interrupt, LOONGSON_PERFCNT_IRQ is not used, just remove it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/irq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index 71347d7..081db10 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -19,7 +19,6 @@
 #include <machine.h>
 
 #define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
-#define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* cpu perf counter */
 #define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
 #define LOONGSON_UART_IRQ	(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port */
 #define LOONGSON_SOUTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)	/* i8259 */
-- 
1.7.0.4
