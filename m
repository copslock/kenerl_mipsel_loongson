Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:52:37 +0200 (CEST)
Received: from mail-qc0-f202.google.com ([209.85.216.202]:64343 "EHLO
        mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009255AbaIRVruaLawg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:50 +0200
Received: by mail-qc0-f202.google.com with SMTP id r5so96947qcx.3
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xv1Zqor+dHwlpcO5yVKf0e0V+bscBMHDdPyOMgzmq1M=;
        b=HQjyLAIIhe4QSjRAHCA3ZMgONaCetuWtlwj6wE1ek1/u7Iy2FYtkiX2G0EXpHBzk5S
         qzF+Z9JEWUYp47cfdT9o0Yg8IxZ1vKin5YIqUi37rS7qBotMsCj4y3yUblf0ktzfx/xi
         Uq6oq+Rp8nS4Umxl7a+8Omi5RKJ7ktMmxIaelICKZF8tyPKdtkzxurJQ1YCoAIYJ8SOH
         cKqGDolhRaBQFuzXNLyZxN6XcgVAGN408N8jyJ71NlL6vYGxUiASIQo0T3HuyOJrN6CD
         j4v+jSh4y1hQchNQLkOqxg63kVkDIe+6p2Yc0tyhQG1FYNF/kdgtoAb8pEwpW+vGgo4T
         dyCg==
X-Gm-Message-State: ALoCoQl3ck7f8K1IrhbqzDq3XQykwca/G87L/azWleCrVI/4giQ5qxWuaYUsKsU54KbYmEuC2t2X
X-Received: by 10.52.182.66 with SMTP id ec2mr6397790vdc.0.1411076864090;
        Thu, 18 Sep 2014 14:47:44 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id m14si1185yhm.7.2014.09.18.14.47.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:44 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id xE8T9pn4.4; Thu, 18 Sep 2014 14:47:44 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id EEB56220B91; Thu, 18 Sep 2014 14:47:42 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 16/24] irqchip: mips-gic: Fix gic_set_affinity() return value
Date:   Thu, 18 Sep 2014 14:47:22 -0700
Message-Id: <1411076851-28242-17-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

If the online CPU check in gic_set_affinity() fails, return a proper
errno value instead of -1.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index e9abb08..5e12777 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -309,7 +309,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
-		return -1;
+		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
 	spin_lock_irqsave(&gic_lock, flags);
-- 
2.1.0.rc2.206.gedb03e5
