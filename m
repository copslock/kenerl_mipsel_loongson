Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:32:34 +0200 (CEST)
Received: from mail-oa0-f73.google.com ([209.85.219.73]:35693 "EHLO
        mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025899AbaIERakQF6e5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:40 +0200
Received: by mail-oa0-f73.google.com with SMTP id g18so2084479oah.0
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZQTKO2bMqQUBA0agHgKTC3AIljN5CR3QQRPHLqiNhjE=;
        b=FCvGY8d5/qGgFJjC8uvF0iLuhgBzPHnx10WAjAaDfCRdFmecI0niReVvgstLe6WWDl
         dEf289lpGdbOdNrqW8tWSwMcHz8mM/GbzmyDAO73z8YMs7bVzySiCyaGEp/xnuGY1ELE
         uGB5fTqeboH/RXEXw8dp3IePnr5f1DAMJ+8ud3yRL8zoTLgpMrpG6ENRBtLEj/GMVJb8
         G7xC0anT7j0XbBsdipBc5xOWEDanGkWLwZCVCqwqPxUxjtmdul1YshNM8EhCsdA0hSgX
         kS2ote+nXXDAk26Ba0aCE+1BG2+wuLGJFZIe9odZqll859J1UTFUCUNF4oZwU7w91nPZ
         P9Lw==
X-Gm-Message-State: ALoCoQlCuo/EKe8bIlsMlfbXkLNJlsNbZzeO5ZtTBqcF7J+gt5JIB0sqQfN9bl5CqAk7dQKlY+Eo
X-Received: by 10.182.56.200 with SMTP id c8mr7853699obq.7.1409938233896;
        Fri, 05 Sep 2014 10:30:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id d7si508223yho.2.2014.09.05.10.30.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:33 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ADDAC5A427D;
        Fri,  5 Sep 2014 10:30:33 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 728D62209EA; Fri,  5 Sep 2014 10:30:33 -0700 (PDT)
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
Subject: [PATCH v2 08/16] irqchip: mips-gic: Implement generic irq_ack/irq_eoi callbacks
Date:   Fri,  5 Sep 2014 10:30:10 -0700
Message-Id: <1409938218-9026-9-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42436
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
No changes from v1.
---
 drivers/irqchip/irq-mips-gic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index f29bb4e..0549768 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -239,6 +239,20 @@ static void gic_unmask_irq(struct irq_data *d)
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
