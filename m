Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:18:16 +0200 (CEST)
Received: from mail-pg0-x236.google.com ([IPv6:2607:f8b0:400e:c05::236]:36466
        "EHLO mail-pg0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993886AbdDFNQlqQtui (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:16:41 +0200
Received: by mail-pg0-x236.google.com with SMTP id g2so35554922pge.3
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkEK7Hz/6Jx2FI/7DJ9OkhDFntzd88aX40uGZLyfgX4=;
        b=YiDoRxmOsJqupK0Wln6lL4Kd4/LV9WMWHKD4aXOzKjJabOHP8bNzD534Yp3IBaZqAj
         qXvezbRmGNfmURvzcXtMYHfUv0cb9uBZsa4mEao2V98mCtKsFx210BPAARZuRZrGNiYo
         A88mT257R33I6d27lcDPzZl48bCO76Nday43Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkEK7Hz/6Jx2FI/7DJ9OkhDFntzd88aX40uGZLyfgX4=;
        b=KkuYwGpjGUbJ9Y5I66sPNaLcykqpYfsk3VdLfUf7oMpZsjjnzYIhErBLx+KwM/15lS
         Q/U8MVh/xvUI8cUBANO0IrsIJhcjM5rX7ka12TSIDtv6UKx/VwEAQN+P6UHNvLvHouhs
         uLQTPArfSrKKt/PGKIKnIuVH2qfra6fnmrz/T9la5qnSfSUCUWkZKUoc7QJTFrpD22oZ
         Ba4dcdSAqVq4Hq7db006XLoeratzuq/y6jznCO+yVwpJjfWjMS/Szk6PNQ5rZEn0cucJ
         gGceOyzPS/EelXouWhe7598IHCtCVlj/Zrfuw4xx1RQCAWBB8hfq50JbZTtAxkjKN3jG
         tHMA==
X-Gm-Message-State: AFeK/H3Lf7UMVcXbqGYoVHN5vQHVCn5wicSCrRFObrhAdR/0nCgtrzaPv3I7p7NRA1Ojx0nG
X-Received: by 10.98.68.199 with SMTP id m68mr34806899pfi.31.1491484595899;
        Thu, 06 Apr 2017 06:16:35 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id y6sm4018940pgc.40.2017.04.06.06.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:16:35 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.9 5/7] MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Thu,  6 Apr 2017 18:46:11 +0530
Message-Id: <1491484573-6228-6-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491484573-6228-1-git-send-email-amit.pundir@linaro.org>
References: <1491484573-6228-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57596
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
index b3c5bde..80832aa 100644
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
