Return-Path: <SRS0=hL8I=UH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFBC28CC5
	for <linux-mips@archiver.kernel.org>; Sat,  8 Jun 2019 20:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89240208E3
	for <linux-mips@archiver.kernel.org>; Sat,  8 Jun 2019 20:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDyQTtv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfFHUsl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 8 Jun 2019 16:48:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56149 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfFHUsl (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 8 Jun 2019 16:48:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so5105705wmj.5
        for <linux-mips@vger.kernel.org>; Sat, 08 Jun 2019 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtD9LqGAYakgNOjMfkfswsTmJIWlE3YoJFMFCxDn+fg=;
        b=LDyQTtv5EX1Jn09YLEnjGaoibpxNYmVNs/c6Or9AmgA5psWHn25QarpfOu70U057TW
         /WmeEQbB34fTdxXVibQuU7mNbx6W8bFpf7GmXRBr3LwCeLkwvcPULSgYQVg7M6h9vaZ7
         upk0Y/8WPgi3TCRwZ/H/qAacNisisuIc+QWr1Bc5wUU7WqWMdoPiuch3g0MpUH/zYPF1
         FmwOGrug8CMSrn1PLZiFq5WzofHAlMdD9JBrO9Qu/Q5UiE4mZZjS6oNl/RSV2CUBJGG6
         LiG3oBQfnPoM642DFemNgBaTDkHUrFOv2mFmeLg294GU8N+4eexVk2lgUEFdOxhHbUrl
         sTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtD9LqGAYakgNOjMfkfswsTmJIWlE3YoJFMFCxDn+fg=;
        b=W44tbHjqPyBkuHZ5/u/lkRkvFDfMPXT/MK+3WCRa1ralhY3Kls/BwPjRIFBr6b6wvV
         wK6MpA7ERrRKR0PdG6fLNJXHuD2FHSUvbaeewrhQJDxhBIYs66VKDJvGozGtMeIhF8EW
         6Tmq+tV7OlZoVi3OkjF7uOUMU1dAklTUeiOO2ehJadulzwFwaahexfIMQpzBrAQMHokh
         kPpfdSPd8U9OvBIVrlxPlJkE0O+fhnaA0mF7ErvXqmqhRfHeounIml7/7AKb1cj634ok
         QPgqM3xyV57Nfh5jWKVgeRRzDMCSL0xr37FPZAM+v0wN00A1TCy5gAJfSouQ3/mRAeuF
         lOaA==
X-Gm-Message-State: APjAAAU1/tsKL0nggQ6Pa2k3KWGThV0IMqFJQucLQPdJhAOiAh0qpXnN
        RFLI++G91VTKmT9LMuT4UKg=
X-Google-Smtp-Source: APXvYqxA4kIf6JyrcOnsgnkTGYhGsoMyGre6NzWlKmmX+BmpB1xJ+k/RiPFrNwwsEkKRMXiCtCJ6Mw==
X-Received: by 2002:a1c:c8:: with SMTP id 191mr8109727wma.6.1560026919473;
        Sat, 08 Jun 2019 13:48:39 -0700 (PDT)
Received: from kontron.lan (2001-1ae9-0ff1-f191-359a-8d64-e90a-f663.ip6.tmcz.cz. [2001:1ae9:ff1:f191:359a:8d64:e90a:f663])
        by smtp.gmail.com with ESMTPSA id f204sm4986394wme.18.2019.06.08.13.48.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 13:48:39 -0700 (PDT)
From:   petrcvekcz@gmail.com
X-Google-Original-From: petrcvekcz.gmail.com
To:     hauke@hauke-m.de, john@phrozen.org
Cc:     Petr Cvek <petrcvekcz@gmail.com>, linux-mips@vger.kernel.org,
        openwrt-devel@lists.openwrt.org, pakahmar@hotmail.com
Subject: [PATCH v1 1/7] MIPS: lantiq: Move macro directly to iomem function
Date:   Sat,  8 Jun 2019 22:48:04 +0200
Message-Id: <e3ef5e9ca51ae3169b42d8da5b2f9c623ba53278.1560024463.git.petrcvekcz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560024463.git.petrcvekcz@gmail.com>
References: <cover.1560024463.git.petrcvekcz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Petr Cvek <petrcvekcz@gmail.com>

Using the variable as a temporary holder for the macro of the register
offset value is not necessary. Move it directly to the IOMEM read/write
call.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
---
 arch/mips/lantiq/irq.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 6549499eb202..fb3e1cc2cf6b 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -77,44 +77,42 @@ int ltq_eiu_get_irq(int exin)
 
 void ltq_disable_irq(struct irq_data *d)
 {
-	u32 ier = LTQ_ICU_IM0_IER;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 	int im = offset / INT_NUM_IM_OFFSET;
 
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(im, ltq_icu_r32(im, ier) & ~BIT(offset), ier);
+	ltq_icu_w32(im, ltq_icu_r32(im, LTQ_ICU_IM0_IER) & ~BIT(offset),
+		    LTQ_ICU_IM0_IER);
 }
 
 void ltq_mask_and_ack_irq(struct irq_data *d)
 {
-	u32 ier = LTQ_ICU_IM0_IER;
-	u32 isr = LTQ_ICU_IM0_ISR;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 	int im = offset / INT_NUM_IM_OFFSET;
 
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(im, ltq_icu_r32(im, ier) & ~BIT(offset), ier);
-	ltq_icu_w32(im, BIT(offset), isr);
+	ltq_icu_w32(im, ltq_icu_r32(im, LTQ_ICU_IM0_IER) & ~BIT(offset),
+		    LTQ_ICU_IM0_IER);
+	ltq_icu_w32(im, BIT(offset), LTQ_ICU_IM0_ISR);
 }
 
 static void ltq_ack_irq(struct irq_data *d)
 {
-	u32 isr = LTQ_ICU_IM0_ISR;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 	int im = offset / INT_NUM_IM_OFFSET;
 
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(im, BIT(offset), isr);
+	ltq_icu_w32(im, BIT(offset), LTQ_ICU_IM0_ISR);
 }
 
 void ltq_enable_irq(struct irq_data *d)
 {
-	u32 ier = LTQ_ICU_IM0_IER;
 	int offset = d->hwirq - MIPS_CPU_IRQ_CASCADE;
 	int im = offset / INT_NUM_IM_OFFSET;
 
 	offset %= INT_NUM_IM_OFFSET;
-	ltq_icu_w32(im, ltq_icu_r32(im, ier) | BIT(offset), ier);
+	ltq_icu_w32(im, ltq_icu_r32(im, LTQ_ICU_IM0_IER) | BIT(offset),
+		    LTQ_ICU_IM0_IER);
 }
 
 static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
-- 
2.21.0

