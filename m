Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:16:46 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:65496 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007483AbaH2WOyXnA6p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:54 +0200
Received: by mail-oi0-f74.google.com with SMTP id v63so558209oia.3
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ItzDQFLq/PeDpXkaUiT82mNd6dAFGockTRkV0XjrhSo=;
        b=CUhjXdXVt3F2cjlAt/AMd4RtcP2ZPYIxXzScmMskWHLvvCWVzPPTxUs5FYYrVigU4K
         FGvu5A4b9D4z/mravBPRXC3jWM+i30+/JlZfimz/XTuyAWAC6k+wjkt6wHUFZVB3+5Qm
         lMHILxLjeDmg/h/70pult7E1wcfYZ2AdQ43nIG7bUmHlmEyyqvLQ9c6WNfGcl9LWv+RO
         Kvo8z8iTi09K+mfKubtv6WlFGUbjh2i3G+VOOVWuiHwGzXaC+PQFENA71N43Eb4VOwiS
         w4KoR4MqHTG/7nZt8VloH0MTwbtep0SHsM6PJcY9trSI2cZ79eZZekGwYp5LoiokRXpF
         JI3w==
X-Gm-Message-State: ALoCoQn3CmMkG8lDV0U9xOz4BCLM/40TMr8ugZxAN/pSYOvcFLKVo9A8GnDsUF07VGErpQdSMzfy
X-Received: by 10.50.117.10 with SMTP id ka10mr3681886igb.1.1409350488512;
        Fri, 29 Aug 2014 15:14:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id e55si824yhb.3.2014.08.29.15.14.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:48 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DB7705A43E8;
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 9E1C6221060; Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] MIPS: GIC: Fix gic_set_affinity() return value
Date:   Fri, 29 Aug 2014 15:14:36 -0700
Message-Id: <1409350479-19108-10-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42330
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
---
 arch/mips/kernel/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 1764b01..4ee3ad8 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -319,7 +319,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
-		return -1;
+		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
 	spin_lock_irqsave(&gic_lock, flags);
-- 
2.1.0.rc2.206.gedb03e5
