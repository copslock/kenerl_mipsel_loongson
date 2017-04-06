Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:54:22 +0200 (CEST)
Received: from mail-pg0-x232.google.com ([IPv6:2607:f8b0:400e:c05::232]:34486
        "EHLO mail-pg0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993909AbdDFNwoDRaIx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:52:44 +0200
Received: by mail-pg0-x232.google.com with SMTP id 21so37155265pgg.1
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkEK7Hz/6Jx2FI/7DJ9OkhDFntzd88aX40uGZLyfgX4=;
        b=GeQ4hc6544uhC+TcFnGcbjvchdKTgrEp7mCZdU9z2kk9a1E8cga3XTXMroisDYiNnz
         WsoulwzA/ZcafUarQFvkWN4TbEExeWD4o0iBFOl5IkCY6XZeqCwBfm963Wc3C5CJfRWL
         FyUaHRbb3QT/EdGLqBL7kCyR27MhyscprOLNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkEK7Hz/6Jx2FI/7DJ9OkhDFntzd88aX40uGZLyfgX4=;
        b=Y02hSJGUG82nh4rGRFdMbTSY5MUL7imbGx+TS2QzqAYRM/73SQcJz2yNdk8IwPQ+Gr
         wTkQHxEqNJjzbOK/w2mW4T5NLpas5s2JhVZiTSfw5rP+jyfJeoYbZ9XZnAr+NR8QcWx2
         /RP5l8l42+IVSg3XRYasWkG2/wN1a2jtSv/xT5ih5guNpeBK0IKh1PQDPAocXLyBrAbz
         GYQuK6n0gb/N/xgAkmGS56ueEBk8iFcrzzHzmw8tYWOKXmljgsQ4+yGuKgTcsuC0uXhu
         g878IIuyWLruvuDmUnkzbg+fv6560GaTlFBIYGgJMnH+4x73jRSfAiYOmZvO3BSkXr+7
         KX+g==
X-Gm-Message-State: AFeK/H0kDQJfvJKco6THiQGaVe38F7V6vs5otDJH4kBLMSw2E020/YtwtvPrxXqRnBD7RaWY
X-Received: by 10.84.253.15 with SMTP id z15mr43617839pll.142.1491486758263;
        Thu, 06 Apr 2017 06:52:38 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id v11sm4187210pfi.50.2017.04.06.06.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:52:37 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.10 5/6] MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Thu,  6 Apr 2017 19:22:13 +0530
Message-Id: <1491486734-15668-6-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
References: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57605
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
