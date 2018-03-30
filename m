Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 11:05:50 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:43697
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeC3JFnjHuzQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2018 11:05:43 +0200
Received: by mail-pf0-x241.google.com with SMTP id j2so5085001pff.10
        for <linux-mips@linux-mips.org>; Fri, 30 Mar 2018 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VObpv6uuQfP0kCPesATlK1oHbHc/hZRhaVdDIP/DaJM=;
        b=dp15STGfB/pyqlGdQdx8nco/UTNUSDbkV5eOzp365HaGTFXTWX4ndVHAUxoAO3SKLh
         zw0dQOBA2LZvbl5NdOB2Y5Tw4kK+bWMcYXQUIpkoDVnTRpkiG9ZBojxsqPtVgsb4rE0K
         JIKjDZXPnyyTdRaGDnKj/SeZbAGO2qKdMu1IREx3DayuhKN584H1z+mIJVD7MiAeb5ot
         3am/v2LrePiKv+DH+i/ocgTM7RLkYFaF80H4IYW+O5/fgxnLxUR8AKJU/1MOSUZZsGvt
         SzhNwkw8MpQ2tkY8DkXA4jKjdn2gB6hjkBFtNrSx9QUgCah0M3ktVzXa1hOxuoaAKbuC
         iIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VObpv6uuQfP0kCPesATlK1oHbHc/hZRhaVdDIP/DaJM=;
        b=QVRro7OasZ3HdMSKs4wIWAlIdjtakFC56IdSdqtqc4dbdHTzOIsfBv6KjHGMG0xKuw
         qrgo+0MWEI+jqgI8zq8KRKKS0KMP+ZlL3RaojMLt5XGtp259swaVfJZTxoMzSEEn5wLk
         9tSp8LIiIgpjV933bogcNZQLC7Pif/U8WBWwjuZ6/DUBSm6nNdfKkqF8MN1dYaSv0+JA
         MXx5AodmPXmf9/PRxoBuybrdPvciawpx/EVKL0y0qcYp92avyFkWMEt/gTn6raioflud
         wyBkAkvYpLkm00AWyGNrFFGed7+F7PqfwRJ3zhq5TD+dPhZS8f5WfAK4+aWtg85n8Z/v
         l0qQ==
X-Gm-Message-State: AElRT7E9H0lG0+0Lz1iiHMaNj+uF0zE7HI41ghy8LvtGv/ECMuvNE3B7
        dPwlt+Eix61/mwDbpklIDI/oaw==
X-Google-Smtp-Source: AIpwx483xQu3jhkla/t3Arb19Uaqxy2xwSG+MrkMrZylSD/qR80MwGPzR0Az2bnRFHOuIwmaf9nnHQ==
X-Received: by 10.98.17.210 with SMTP id 79mr9211479pfr.65.1522400736026;
        Fri, 30 Mar 2018 02:05:36 -0700 (PDT)
Received: from localhost.localdomain ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id c62sm17560685pfk.179.2018.03.30.02.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Mar 2018 02:05:34 -0700 (PDT)
From:   r@hev.cc
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Heiher <r@hev.cc>
Subject: [PATCH] MIPS: Fix ejtag handler on SMP
Date:   Fri, 30 Mar 2018 17:05:15 +0800
Message-Id: <20180330090515.11399-1-r@hev.cc>
X-Mailer: git-send-email 2.16.3
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r@hev.cc
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Heiher <r@hev.cc>

Signed-off-by: Heiher <r@hev.cc>
---
 arch/mips/kernel/genex.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37b9383eacd3..9e0857fbe281 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -354,6 +354,17 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
 	sll	k0, k0, 30	# Check for SDBBP.
 	bgez	k0, ejtag_return
 
+#ifdef CONFIG_SMP
+	PTR_LA	k0, ejtag_debug_buffer
+1:	sync
+	ll	k0, LONGSIZE(k0)
+	bnez	k0, 1b
+	PTR_LA	k0, ejtag_debug_buffer
+	sc	k0, LONGSIZE(k0)
+	beqz	k0, 1b
+	sync
+#endif
+
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_S	k1, 0(k0)
 	SAVE_ALL
@@ -363,6 +374,11 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_L	k1, 0(k0)
 
+#ifdef CONFIG_SMP
+	sw	zero, LONGSIZE(k0)
+	sync
+#endif
+
 ejtag_return:
 	MFC0	k0, CP0_DESAVE
 	.set	mips32
@@ -377,6 +393,9 @@ ejtag_return:
 	.data
 EXPORT(ejtag_debug_buffer)
 	.fill	LONGSIZE
+#ifdef CONFIG_SMP
+	.fill	LONGSIZE
+#endif
 	.previous
 
 	__INIT
-- 
2.16.3
