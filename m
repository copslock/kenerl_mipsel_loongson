Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:15:57 +0200 (CEST)
Received: from mail-qc0-f202.google.com ([209.85.216.202]:33641 "EHLO
        mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007478AbaH2WOxZdV7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:53 +0200
Received: by mail-qc0-f202.google.com with SMTP id r5so418205qcx.5
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nCu/ySSqRMOxS2XJVbt3aUG4JZtJdi70ziZvoUUbHR4=;
        b=KbCi6D074+pmj6qAQjNs+wehltn+yaftO5zooF9zcneAmItTH0WKKZgm3hkDCfJKgh
         HrzTkL/2fnUIZ79vjZCLkN8mACHgSa6yc8OgWSm/WKiOm97hXY8wvGYqgzMeBrmfPopt
         L/RGQz8Qg6yjjrNfBDpvnmF8TgtnM6oGPxdoQJc1G/gTLI+3Iky+fPdnA6iAg5aec2jr
         DaqWB5ApHEERAb+OLJq1lpna6Bo3wMQ+tWDoNYRMLc+zwd4qfCrnQwEJKWTk3+dV2rcE
         7DJk/6w8XvyWvZyJjGmOb6yUeqOhNz1R+4d9O8ArEYrWLYPKF3zyJTYdfY4wLIp36An3
         TVWA==
X-Gm-Message-State: ALoCoQniJPitRoRig38C8RO5iVNfsIos/qzQ6L1BmElxbRgX6B3V9NkApbhUfOaF/T3QWkaW7EHB
X-Received: by 10.236.191.37 with SMTP id f25mr7216343yhn.44.1409350487306;
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h24si65yhb.6.2014.08.29.15.14.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2869231C516;
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id DF075221060; Fri, 29 Aug 2014 15:14:46 -0700 (PDT)
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
Subject: [PATCH 08/12] MIPS: GIC: Implement generic irq_ack/irq_eoi callbacks
Date:   Fri, 29 Aug 2014 15:14:35 -0700
Message-Id: <1409350479-19108-9-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42327
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

Implement a default gic_irq_ack() and gic_finish_irq().  These are
suitable for handling IPIs on Malta and the upcoming Danube board.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/kernel/irq-gic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 01fcc28..1764b01 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -242,6 +242,20 @@ static void gic_unmask_irq(struct irq_data *d)
 	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
 }
 
+void __weak gic_irq_ack(struct irq_data *d)
+{
+	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
+
+	/* Clear edge detector */
+	if (gic_irq_flags[d->irq - gic_irq_base] & GIC_TRIG_EDGE)
+		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), d->irq - gic_irq_base);
+}
+
+void __weak gic_finish_irq(struct irq_data *d)
+{
+	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
+}
+
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int irq = d->irq - gic_irq_base;
-- 
2.1.0.rc2.206.gedb03e5
