Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 14:51:14 +0200 (CEST)
Received: from mail-pg0-x229.google.com ([IPv6:2607:f8b0:400e:c05::229]:36737
        "EHLO mail-pg0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993411AbdDFMtaMKtWi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 14:49:30 +0200
Received: by mail-pg0-x229.google.com with SMTP id g2so34898745pge.3
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e03TW3BP961XJONVeVWf/niRaGgsgHEGaj12azHxk40=;
        b=b5xCCUcz0qgxQMkybBkakyWPXnRoNzYsOVkuM0Wv8bF4fK+HRotn+DCQhUShmjCZlJ
         j9FrwyO/DtrIrOda140yyfiBIzuh+2qbpQuzw5o5snGEccwjC3UaJ3CdbgrDAL9dXpdU
         zM9AprpqHyoUacj57kwu/fNjdbs+/2ImbgtTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e03TW3BP961XJONVeVWf/niRaGgsgHEGaj12azHxk40=;
        b=WGMYhgxGH6K4IowDcpo/1y/uApbzZden204maoc9RDhpzjyjZeBY9fdHS79IORyRmr
         1YgR4y3Quhsb+7LilJYYzGoCStIjxao3SsCRPZrueBFRE8m14ZfJvVRFiUPAEBjzKGO/
         fgsTm7Kt/lbXW5PnYL7HyVuZFkhscd0vHCt/X5grGsUdMdkb3+RVOomPJYpyHaoxufLn
         XFASL8QT41dFec/DP81BQRnjWSjW0K3IWSg9EnBBplQJpEH1WyeZGK86aL+2eDeThk1O
         DtSrfew5uuJ9ovTgnmcF9gKosp460WcsgQnPrcG+vK7chqN66sKVQh4JwE+v9H49WcNl
         1k8Q==
X-Gm-Message-State: AFeK/H3rqt7+bAfZDGnHOoQa5NS2BtAGVormmf6iMzcZgRLlfBGnu+WlOoT4EInmXqPOvP/n
X-Received: by 10.99.101.135 with SMTP id z129mr23193663pgb.164.1491482964400;
        Thu, 06 Apr 2017 05:49:24 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id n7sm3892564pfn.0.2017.04.06.05.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 05:49:23 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 5/7] MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Thu,  6 Apr 2017 18:18:58 +0530
Message-Id: <1491482940-1163-6-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57589
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

Since do_IRQ is now invoked on a separate IRQ stack, we select
HAVE_IRQ_EXIT_ON_IRQ_STACK so that softirq's may be invoked directly
from irq_exit(), rather than requiring do_softirq_own_stack.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Acked-by: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14744/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit 3cc3434fd6307d06b53b98ce83e76bf9807689b9)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db45961..49c276c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
-- 
2.7.4
