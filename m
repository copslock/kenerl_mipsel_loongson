Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 19:53:14 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35740 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012170AbbD1RxNAP-6n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 19:53:13 +0200
Received: by iejt8 with SMTP id t8so24365485iej.2
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 10:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ldgHteZR+plMhrMSfkzOdgG5ljxAs0DlLmhvO4XncXc=;
        b=h4U0GV54xNVeC3WwGHhBHAjjQukIwzj5OhYIvve9sk+XGZgBoDJQWOlXLuU4225oC6
         fmh6tDUht1iymQ95bKRUj5i+K4rgOXOBObqteERb5BaF08fWsUHZ9g0aLn3Bvy9V6+85
         YOX7izBlU/Qv7C4IvCcf/Zr/ikRTXFm8qqb0p/2IJmvlstzAtZa+X1wiwPL5reXUbpId
         t8xPg30AFlR2XRbITKm4WENaAcEaQ+HKxSUTjQlcW9IE1sSI+8tUP0SFgKNZlGR0wayX
         G+NElRDK2kvxNUtLIu6j5aEcy3VgVJxMwn4PfeCFqQzB5PLB2W4Lwc35Es1WB2SNY0WR
         FLKg==
X-Gm-Message-State: ALoCoQkrfaYW5PYczhPvKcWe+qL/NsoXln5z4ZH5l0wyPRN63muZ8ufafYkEaxDfp+BBc2bwlguB
X-Received: by 10.42.119.142 with SMTP id b14mr19572316icr.29.1430243588945;
        Tue, 28 Apr 2015 10:53:08 -0700 (PDT)
Received: from kcl.mtv.corp.google.com ([172.22.66.15])
        by mx.google.com with ESMTPSA id e69sm15171662ioe.11.2015.04.28.10.53.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Apr 2015 10:53:07 -0700 (PDT)
From:   Kevin Cernekee <cernekee@chromium.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, valentinrothberg@gmail.com,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Subject: [PATCH] MIPS: BMIPS: Delete unused Kconfig symbol
Date:   Tue, 28 Apr 2015 10:52:50 -0700
Message-Id: <1430243570-6143-1-git-send-email-cernekee@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <cernekee@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@chromium.org
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

This was left over from an earlier iteration of the BMIPS irqchip changes.
It doesn't actually have an effect, so let's nuke it.

Reported-by: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
---


Ralf - could you please pull this for 4.1?


 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f5016656494f..19e5d40fdf40 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -147,7 +147,6 @@ config BMIPS_GENERIC
 	select BCM7120_L2_IRQ
 	select BRCMSTB_L2_IRQ
 	select IRQ_CPU
-	select RAW_IRQ_ACCESSORS
 	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-- 
2.2.0.rc0.207.ga3a616c
