Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:18:40 +0200 (CEST)
Received: from mail-pg0-x233.google.com ([IPv6:2607:f8b0:400e:c05::233]:34828
        "EHLO mail-pg0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993905AbdDFNQoVDKTi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:16:44 +0200
Received: by mail-pg0-x233.google.com with SMTP id 81so36236626pgh.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iuvPjq2NXkmKqRP2BZ1DmT9HI2WCfJmxi+d3PpC3NE=;
        b=BxNMu/0F6n33curQFFtLZoknm6Pjs1p4aFu4evV7Y19dT9U4h2ezWL4P3JHVYGVPsy
         l2G+woUVoEEVHXoy5eCOvSYzSVqZT4gyCH7Lo9sHq2FYQiI9vV75lTMblrBViDFN/sj5
         hR2TcH/dD1pb+mpu5+1c6pveA0ZAW3Gs27RsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6iuvPjq2NXkmKqRP2BZ1DmT9HI2WCfJmxi+d3PpC3NE=;
        b=PlH9jEJPM+fSkgkufbDABFEIegj8neajXEIP0nlwrubJmwgHco+41vjltTaYvUFXeP
         tpNeODGNyfZid4pxgIyBVqf71udOZWDkt8xf9c+Xf0bhCdAx4BYCOIJ2EdceUWT4NrQ2
         QBBAcqjij1dGpF+QwvlRvcsRw1yVv78o9dmYngp2BgLhDPOMxfgxT7qCIJ/PF8Tp2GMF
         yImaU7ptPZ+bnMXZs1rGlnO4c7px0/ATzWtNcuVZ9H41NsLwntSypoh3F6s35Lm4Ov4q
         Lh7kjjWLY1V6OVACCexCOuZ6+R2hZyZjqy8Olmlq8dwgpJblKrzou+buDjCAGfGx/fsk
         9M9w==
X-Gm-Message-State: AFeK/H11C4M2tcf0wVgYRpfnk09F2+Ighw7JRuVVuPylzaduqBPvndlbeTdGu081AimkUPCk
X-Received: by 10.98.76.140 with SMTP id e12mr34742844pfj.82.1491484598502;
        Thu, 06 Apr 2017 06:16:38 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id y6sm4018940pgc.40.2017.04.06.06.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:16:38 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH for-4.9 6/7] MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch
Date:   Thu,  6 Apr 2017 18:46:12 +0530
Message-Id: <1491484573-6228-7-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491484573-6228-1-git-send-email-amit.pundir@linaro.org>
References: <1491484573-6228-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57597
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
index 0a7ba4b..7ec9612 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -329,7 +329,7 @@ NESTED(except_vec_vi_handler, 0, sp)
 	PTR_ADD sp, t0, t1
 
 2:
-	jal	plat_irq_dispatch
+	jalr	v0
 
 	/* Restore sp */
 	move	sp, s1
-- 
2.7.4
