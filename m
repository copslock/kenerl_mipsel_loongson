Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:33:07 +0200 (CEST)
Received: from mail-yk0-f202.google.com ([209.85.160.202]:54010 "EHLO
        mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008219AbaIERakcPnWK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:40 +0200
Received: by mail-yk0-f202.google.com with SMTP id 9so132077ykp.3
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRmJTC2m0DMFhj5nVFcMqp3IaWb76UENx8+ljhlFq/g=;
        b=bsVFGWofh/+S/6IAgN/I8KndpnoYo1eOij8lQCl9lOMweGVON5+mhvKdXj1vc0LhAI
         ujxR5IGX/4C5qKdEQAhssf5YIruU30PbMJup41D4nxCmkHc3mqx1I6NWhbPJYqOw15B7
         7anvMe3gsxFohkRI5Y8FDS0/oPwByAon2MS/HyMBy9G+xNhG61ejSys54wAvMclkiJck
         BQkW3FtOA714KwBOuno87BB+NscB3hS13suoSQJWoGnplJ85SjPZuTUMKVE18IFC7edM
         C50+v9yeL5orzJthkUFfxvh+pAO9k1QcPl8gzeg8VBhdTCbS06etEdFtrZlOoSlIoLJa
         VfwA==
X-Gm-Message-State: ALoCoQnTn7IhDUYHSkPHu0R53203arRS682g9CXk3s6qBEeXbbfKf6NBWcTlMLc02re59w6sa6in
X-Received: by 10.52.116.241 with SMTP id jz17mr7616844vdb.9.1409938234804;
        Fri, 05 Sep 2014 10:30:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id d7si508227yho.2.2014.09.05.10.30.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:34 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9566A5A427D;
        Fri,  5 Sep 2014 10:30:34 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 5A5102209EA; Fri,  5 Sep 2014 10:30:34 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/16] irqchip: mips-gic: Fix gic_set_affinity() return value
Date:   Fri,  5 Sep 2014 10:30:11 -0700
Message-Id: <1409938218-9026-10-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42438
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
No changes from v1.
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 0549768..c0ff749 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -316,7 +316,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
-		return -1;
+		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
 	spin_lock_irqsave(&gic_lock, flags);
-- 
2.1.0.rc2.206.gedb03e5
