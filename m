Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 14:51:37 +0200 (CEST)
Received: from mail-pg0-x230.google.com ([IPv6:2607:f8b0:400e:c05::230]:34999
        "EHLO mail-pg0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993886AbdDFMtdQ-sri (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 14:49:33 +0200
Received: by mail-pg0-x230.google.com with SMTP id 81so35573279pgh.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M+Wr0/kRCYW9Om41/J32EQp75b0fi0lar4DBSBzLHkA=;
        b=NlW9hbLvIaH0v+XTCNJ5GVOkkhOn4/NC3CtTSNwP1OcXmxop7ddKz3yu3DHKHqVKTB
         JJsNBDmnjV9mnzGpwthrc9q2H9/lN2tPVc9n8QlWmk4ztD0F0Tg/m2Z9G5HeoGGkFEma
         L/sInwYDRqDSE225bexbhnTxMv+/DQEr9kNtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M+Wr0/kRCYW9Om41/J32EQp75b0fi0lar4DBSBzLHkA=;
        b=UGs1n+iSwaNNgOBUtSD+VMO1S3me5FASJ7xahMmgnrTc4qfx4tEEx67N5G43FYAJIV
         9CNN2IX/yxZc2B3ncglaq4cWRliDof0lmbZy2xDdhBxuS8fErdb1db4x06QWKr59FaZ6
         OQNGcbWugxFth94+7uezSqxXkx2wsZE6tdDh1Krf0XSGJDWtTt5Yf/WHigQ/7kD8Lw3G
         QXz017zqkWxHlrC+tjAqmYVE+tccROSPcZjt7Y5GqSCV2pl/2YSgW74F82F3tUBsfKOd
         xFunZEDxaM6l5d3cP2OHNKtsL/+uZuJDg/k3VAUWY2zqRO3O21yRrqtyCq8sR2U8Hszn
         kxWg==
X-Gm-Message-State: AFeK/H0gRNP6pOEtq3anWOZM4JWE+xWd2hDobAlRuhVI+tBtg2H9fhL9Uv8i+b76gD10yFbI
X-Received: by 10.99.185.1 with SMTP id z1mr36339195pge.165.1491482967439;
        Thu, 06 Apr 2017 05:49:27 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id n7sm3892564pfn.0.2017.04.06.05.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 05:49:26 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH for-4.4 6/7] MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch
Date:   Thu,  6 Apr 2017 18:18:59 +0530
Message-Id: <1491482940-1163-7-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

Commit dda45f701c9d ("MIPS: Switch to the irq_stack in interrupts")
changed both the normal and vectored interrupt handlers. Unfortunately
the vectored version, "except_vec_vi_handler", was incorrectly modified
to unconditionally jal to plat_irq_dispatch, rather than doing a jalr to
the vectored handler that has been set up. This is ok for many platforms
which set the vectored handler to plat_irq_dispatch anyway, but will
cause problems with platforms that use other handlers.

Fixes: dda45f701c9d ("MIPS: Switch to the irq_stack in interrupts")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15110/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
(cherry picked from commit c25f8064c1d5731a2ce5664def890140dcdd3e5c)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/kernel/genex.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 2c7cd62..619e30e 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -330,7 +330,7 @@ NESTED(except_vec_vi_handler, 0, sp)
 	PTR_ADD sp, t0, t1
 
 2:
-	jal	plat_irq_dispatch
+	jalr	v0
 
 	/* Restore sp */
 	move	sp, s1
-- 
2.7.4
